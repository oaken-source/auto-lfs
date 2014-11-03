
import os
import datetime

class CallbackModule(object):

  def __init__(self):
    self.last = datetime.datetime.utcnow()

  def playbook_on_task_start(self, name, is_conditional):
    self.last = datetime.datetime.utcnow()

  def runner_on_ok(self, host, res):
    diff = datetime.datetime.utcnow() - self.last
    print " ** took %s" % diff
    self.last = datetime.datetime.utcnow()
