
# the LFS version we are currently building against
VERSION=7.5
BOOK=LFS-BOOK-$(VERSION).pdf

ANSIBLE_FLAGS ?=

.PHONY: all clean rebuild

MACHINEDIR=.vagrant/machines/default
MACHINE=$(MACHINEDIR)/virtualbox/id
PREPARATION=$(MACHINEDIR)/.preparation.stamp
TEMPORARY=$(MACHINEDIR)/.temporary.stamp
FINALIZATION=$(MACHINEDIR)/.finalization.stamp

all: $(BOOK) $(FINALIZATION)

# ganeric clean/rebuild targets
clean:
	vagrant destroy -f
	rm -f $(MACHINEDIR)/.*.stamp
rebuild: clean all

include dependencies.d

# run the finalization play
$(FINALIZATION): $(TEMPORARY) $(FINALIZATION_DEPS)
	vagrant snapshot go default temporary_done
	while ! ssh -q admin@192.168.22.22 exit; do sleep 1; done
	ansible-playbook -i inventory play_finalization.yml $(ANSIBLE_FLAGS)
	vagrant snapshot take default finalization_done
	touch $(FINALIZATION)

# run the temporary play
$(TEMPORARY): $(PREPARATION) $(TEMPORARY_DEPS)
	vagrant snapshot go default preparation_done
	while ! ssh -q admin@192.168.22.22 exit; do sleep 1; done
	ansible-playbook -i inventory play_temporary.yml $(ANSIBLE_FLAGS)
	vagrant snapshot take default temporary_done
	touch $(TEMPORARY)

# run the preparation play
$(PREPARATION): $(MACHINE) $(PREPARATION_DEPS)
	vagrant snapshot go default bootstrap_done
	while ! ssh -q admin@192.168.22.22 exit; do sleep 1; done
	ansible-playbook -i inventory play_preparation.yml $(ANSIBLE_FLAGS)
	vagrant snapshot take default preparation_done
	touch $(PREPARATION)

# rebuild the vm from the base box if bootstrap of Vagrantfile changed
$(MACHINE): bootstrap.sh Vagrantfile
	vagrant destroy -f
	vagrant up
	vagrant snapshot take default bootstrap_done

# download the LFS book if not present
$(BOOK):
	wget http://www.linuxfromscratch.org/lfs/downloads/$(VERSION)/$(BOOK)
