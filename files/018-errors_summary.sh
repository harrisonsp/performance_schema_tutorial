#!/bin/bash
DESCRIPTION="Find all occasions of statements with errors"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
sql_users="set sql_mode=''; create user dummy@localhost identified by 'dummy'; grant all on test.* to dummy@localhost; create user web@localhost identified by 'web'; grant all on test.* to web@localhost;"
my sql -uroot -e "$sql_users" &>errors_summary.err
use test < /home/vagrant/tutorial/018-errors_summary.setup.sql &>errors_summary.err
my sql -u web -pweb < /home/vagrant/tutorial/018-errors_summary_t1.sql &>>errors_summary.err &
my sql -u web -pweb < /home/vagrant/tutorial/018-errors_summary_t2.sql &>>errors_summary.err &
my sql -u dummy -pdummy < /home/vagrant/tutorial/018-errors_summary_t3.sql &>>errors_summary.err
/usr/bin/clear
tmux new-session -n mysql /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" my sql --prompt='mysql> ' -t test
cleanup

