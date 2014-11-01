
FINALIZATION_DEPS = play_finalization.yml

TEMPORARY_DEPS = play_temporary.yml \
  roles/05_temporary/tasks/main.yml \
  roles/05_temporary/files/05.04.binutils-2.24-pass1.sh \
  roles/05_temporary/files/05.05.gcc-4.8.2-pass1.sh \
  roles/05_temporary/files/05.06.linux-3.13.3-api-headers.sh \
  roles/05_temporary/files/05.07.glibc-2.19.sh \
  roles/05_temporary/files/05.08.libstdc++-4.8.2.sh \
  roles/05_temporary/files/05.09.binutils-2.24-pass2.sh \
  roles/05_temporary/files/05.10.gcc-4.8.2-pass2.sh \
  roles/05_temporary/files/05.11.tcl-8.6.1.sh \
  roles/05_temporary/files/05.12.expect-5.45.sh \
  roles/05_temporary/files/05.13.dejagnu-1.5.1.sh \
  roles/05_temporary/files/05.14.check-0.9.12.sh \
  roles/05_temporary/files/05.15.ncurses-5.9.sh \
  roles/05_temporary/files/05.16.bash-4.2.sh \
  roles/05_temporary/files/05.17.bzip2-1.0.6.sh \
  roles/05_temporary/files/05.18.coreutils-8.22.sh \
  roles/05_temporary/files/05.19.diffutils-3.3.sh \
  roles/05_temporary/files/05.20.file-5.17.sh \
  roles/05_temporary/files/05.21.findutils-4.4.2.sh \
  roles/05_temporary/files/05.22.gawk-4.1.0.sh \
  roles/05_temporary/files/05.23.gettext-0.18.3.2.sh \
  roles/05_temporary/files/05.24.grep-2.16.sh \
  roles/05_temporary/files/05.25.gzip-1.6.sh \
  roles/05_temporary/files/05.26.m4-1.4.17.sh \
  roles/05_temporary/files/05.27.make-4.0.sh \
  roles/05_temporary/files/05.28.patch-2.7.1.sh \
  roles/05_temporary/files/05.29.perl-5.18.2.sh \
  roles/05_temporary/files/05.30.sed-4.2.2.sh \
  roles/05_temporary/files/05.31.tar-1.27.1.sh \
  roles/05_temporary/files/05.32.texinfo-5.2.sh \
  roles/05_temporary/files/05.33.util-linux-2.24.1.sh \
  roles/05_temporary/files/05.34.xz-5.0.5.sh \
  roles/05_temporary/files/05.35.stripping.sh \
  roles/05_temporary/files/.bashrc \
  roles/05_temporary/files/.bash_profile \
  files/authorized_keys

PREPARATION_DEPS = play_preparation.yml \
  roles/00_prerequesites/tasks/main.yml \
  roles/02_partitioning/tasks/main.yml \
  roles/03_packages/tasks/main.yml \
  roles/04_preparations/tasks/main.yml \
  roles/04_preparations/files/.bashrc \
  roles/04_preparations/files/.bash_profile \
  files/authorized_keys

