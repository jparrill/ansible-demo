# Ansible Demo Notes

## Aim
To show Ansible's features and possibilities including Tower.

## Target audience
Technical people who want to see Ansible Tower in action with certain examples.

## related gits
- https://github.com/liquidat/ansible-demo-oraclejdk
- https://github.com/liquidat/ansible-demo-apache-simple

## concepts
- Ansible is automation - and thus about saving time
- Ansible is simple - integrates seamless into existing infrastructure
- Ansible is powerful - from system management to application development
- Ansible is agentless - no further software needed
- Ansible is engine: triggered via command line or via web interface/API
- Ansible is language of "playbooks": set of "tasks", working steps which need to be run
- Ansible is enterprise framework: Tower can deliver RBAC, single centralized place, user friendly GUI, shows results
- Automation:
  - executing tasks across multiple machines
  - talking in the language of the domain
  - executing multiple tasks in a row
  - separating tasks from rights
  - integration with surrounding infrastructure
- tasks can be either generic cli commands
- or simplified by parametrized modules
- no client needed: uses present operating system remote management technology
- any machine: Ansible itself runs anywhere, like an admin laptop, configuring others
- push!

## Questions :question:
- What is your largest pain right now?
- What takes most manual work?
- What is not integrated with each other right now but seems simple to connect?

## Start: command line [skip if presentation or forknowledge]
- :question: Do you often access multiple machines via command line?
- :question: Do you know dancing/dstributed shell?
- :question: Can you talk in the language of the problem, instead of generic commands?
- example: on command line
- target machines: identified via inventory
- inventory: can be static file or executed script; think of existing CMDB or Satellite or anything
- here: static
- show inventory: clients, groups, additional options; highlight connection type
- back to CLI
- easiest way to contact: ping a machine, shows that is alive - and Ansible works!
- ping Linux clients
- simple task via raw `ansible helium -m command -a "uname -a"`
- this was direct command - now show parametrized modules
- simple task via module `ansible helium -m yum -a "name=httpd state=present" -s`
- complex task via simple module `ansible unix -m user -a "name=rwolters state=present"`
- windows: hsa own modules, like win_ping
- where to get info about module parameters: `ansible-doc yum`, and `ansible-doc -s yum`
- raw echo command on all: `ansible all -m raw -a "uname -a;get-host;echo 0"`
- :white_check_mark: Ansible can contact multiple nodes at the same time
- :white_check_mark: commands can already be distribution agnostic, even OS agnostic
- :white_check_mark: use case: instant execution of single tasks across server landscapes
- :white_check_mark: example: get state of all running servers right away
- :white_check_mark: example: deploy OpenSSL update on all relevant machines right away
- :white_check_mark: can save time already compared to plain ssh or even dsh
- :white_check_mark: missing yet: stacks of tasks, describing entire setups
- :clapper: Emergency update of all productive systems in controlled manner.
- :clapper: Launch a statistics script on all database servers.
- :clapper: Restart failed web daemon on development machines.

## Playbooks
- :question: Do you already write your own automation scripts?
- :question: Take your average shell script - how long is it, how easy to read/understand?
- :question: Can you use variables, from differenct sources?
- open `~/Gits/github/ansible-demo-apache-simple`, `apache-setup.yml`
- highlight become
- show that tasks are stacked, are executed in order
- go through tasks, highlight different modules
- mention: tasks can be serialized to be only applied to sets of a specific group (load balancers, etc.)
- highlight conditionals, mention variables
- execute playbook
- highlight the skipping due to conditionals
- :white_check_mark: easy to read
- :white_check_mark: tasks can be stacked
- :white_check_mark: playbooks script automation
- :white_check_mark: can be run on demand, multiple times
- :white_check_mark: can save even more time compared to the need to write scripts yourself
- :white_check_mark: But what are variables, where do they come from?

## interlude: variables [skip if no time]
- :question: How to map small differences between setups?
- :question: Aspects about a system - where to get them from?
- :question: External information stores - how to incorporate them?
- variables can replace values in playbooks
- or in file templates
- either manually defined, or from the machine or from external sources
- show setup command for single host
- show filter
- highlight `ansible_os_family`
- show another, static source for variables: vars file
- back to playbook
- :white_check_mark: variables are a great way to gain more flexibility
- :white_check_mark: many are predefined, manual addition possible
- :white_check_mark: manual either in playbooks, inventory, local on the machine, or via files
- :white_check_mark: variables from other machines can also be accessed
- :white_check_mark: variables make playbooks much more re-usable, saves even more time

## Playbooks
- show different playbook, `oraclejdk-setup`
- highlight include statement, they can be stacked as well
- show rhel playbook, highlight generic approach
- can distribute any kind of software, not only packaged
- show windows playbook, highlight raw installer with options
- show windows destroy - highlight scripting and template
- head to logs - show log entries, each module is executed once
- show handlers, explain links/connections with tasks
- verify correct playbook with ansible-lint
- :white_check_mark: multi OS, multi host, multi distribution
- :white_check_mark: tasks can not only be stacked, but also grouped
- :white_check_mark: in combination with variables very flexible
- :white_check_mark: templates add another level - either for configuration files or even for scripts
- :white_check_mark: entire setups can be described in Playbooks
- :white_check_mark: use case: complex tasks, especially orchestration of interdependent servers
- :white_check_mark: example: access LB, deactivate host, access monitoring, deactivate host, access host, stop service, update software, start service, check log files, activate host in monitoring, activate in LB
- :white_check_mark: can save time by automating even complex interconnected tasks, regular or not
- :white_check_mark: missing yet: not central place, no tracking what was executed when and by whom
- :clapper: Trigger build on Jenkins, get build, copy to staging, deactivate in load balancer, pause in monitoring, stop service, remove old version, deploy new version, start service, run tests; then unpause monitoring, active in load balancer, send mail to team

## Tower, basics
- :question: Do you know which automated scripts are run right now in your environment? When, and by whom?
- show interface
- explain concepts of projects (playbooks or sets of playbooks), show imported playbooks and projects
- explain inventories, show imported inventories; can be groups of groups; can also be connected to online services or generic scripts
- job templates assign actual playbooks to specific inventories: ready to be executed when needed
- mention surveys and variable requests
- when executed, a job comes up, the job has the results
- execute jobs, show results
- highlight multiple plays in one job, show executing information
- click through plays, highlight changing details
- show cli output
- back to list of jobs, possibility of tracking
- show scheduling in job templates
- also show facts of different machines via the inventory, highlight that this is difference for Enterprise
- show execution of generic modules in inventory
- :white_check_mark: web interface; REST API
- :white_check_mark: central place for all tasks, able to verify and document what was done and when
- :white_check_mark: can perform automation on its own (scheduling)
- :white_check_mark: saves time via central, reusable place for all work
- :white_check_mark: missing yet: Playbooks still require user to have rights on target machines; how to separate?
- :clapper: When user commits code, Jenkins runs build, afterwards Tower is called via REST and software is deployed.
- :clapper: Users run network wide checks nightly from Tower, all can see results.

## Tower, advanced
- :question: How can you run powerful scripts by people who know when to run them, without providing them too many rights?
- show setup module: organizations, teams, users
- show idea of credentials: cannot be looked up, stored in AES 128 in database
- highlight users: dduck and mmaus, belonging to different groups
- show various rights across teams: on inventories, on tasks, with and without module execution
- login as dduck and mmaus - compare to admin login
- highlight that credentials cannot be looked up
- execute task as dduck - show results
- show portal mode
- mention dry runs
- :white_check_mark: separation of rights on machines and rights to execute playbooks is now given
- :white_check_mark: reliable tracking of who is allowed to execute what, and what was executed when by whom
- :white_check_mark: automation can now include teams and users without privileged access to machines
- :white_check_mark: use case: provide playbooks to be executed by developers, but without handing out login data
- :white_check_mark: example: destroy and re-setup development environment: access build server, publish correct branch, access dev - machines, download app from build server, stop old app, remove, deploy new, start, run deployment tests
- :white_check_mark: example: clean redis-cache once in a while
- :white_check_mark: saves time, since self service of automation tasks now possible
- :clapper: Team development executes cache clean script without having actual access rights to the target system.
- :clapper: The facility manager executes the backup script weekly. ;)

## Break out sessions / advanced topics

### roles
- tasks just describe what to do to get to some state - roles describe what needs to be there to have a state
- more abstract; idea is to make them shareable: everyone needs a web server, a database
- everything which describes a role: templates, tasks, variables, default values, etc.
- of course strongly depends on the qualities of the role writer
- there are very abstract, high quality roles out there, even OS agnostic
- ansible galaxy has community repository of roles
- use case: describe environments via re-usable roles
- :white_check_mark: modular approach of assigning tasks to machines
- :white_check_mark: still follows the Ansible way, still easy to write, adopt
- :white_check_mark: use case: standardized components in the data center to build apps (always MySQL, always nginx, etc.)
- :white_check_mark: example: Wordpress server has multiple roles: database, web server, scripting language tuning
- :white_check_mark: save time by reusing work of yourself and others

### push vs pull
- push vs pull essentially depends on the requirements
- to keep in mind: many CM systems require a message bus these days...
- where pull is fixed, and only possibility: clone GIT repo on each machine, execute ansible locally
- there are modules and documentation in place
- :white_check_mark: Ansible pull is possible, but requires some extra work
- :white_check_mark: saves time since local network and policies do not have to be changed

### trouble shooting
- use blocks or ignore_errors and conditionals
- use debug msg to output variables
- do rollback (or for example shutdown) if needed
- `-vvv` on command line for ssh debugging
- `--step`
- `--check`
- `--diff`

### tags
- tags vs conditionals
- limiting to certain tags
- `--skip-tags`

### roles
- go through concept of many roles, one profile
- show apache role: `~/Gits/github/ansible-role-apache`
- discuss features of a role: tasks var defaults  handlers  meta  templates  tests

### CLI details
- `--list-tags` - show all available tags
- `--list-hosts` - list all hosts which would be affected
- `--syntax-check` - check if the syntax is right after all
- `--list-tasks` - list all tasks

### blocks
- block, rescue, always
- can be used to group sets of tasks
- also error/exception handling

### lookup
- can look up generic data from generic sources
- used like a variable
- CSV, DB, DNS, etc.
