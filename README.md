# promptly
Some commands are not automation/script friendly. They force the user to manually enter values. Some good example of such comamnds are ssh, installation scripts etc. Promptly solves it all and allows you to automate all such commands. It support rule-based prompt entry. In simple words, you can tell promptly what to enter depending on the text of the prompt. This feature is helpful when the sequence of prompts is not fixed.

## Installation
You first need to clone this repo.

```
> git clone git@github.com:justcli/promptly.git
```
Then go to the local repo directory and run the install script. You will need to run it as sudo.

```
> cd promptly
> sudo ./install.sh
promptyl installed in /usr/local/bin
```

## Usage
`promptly <prompting command> <command arg1> ...`
promptly needs two pieces of information, the command you would like to run and the rules. The command to run goes as argument to promptly. The prompt entryt rules are passed over the stdin of this tools. The rules need to be newline seperated. A rule tells promptly what to enter when a matching prompt is presented to it.

A simple example would be to automatically enter password to ssh. 

```
> printf mypassword=Password|ssh myname@hostname
```
#### Examples
**Automating adduser command**

Let's say you want to create a new user using script. WHile creating user, the adduser command presents many prompts like password for the new user, Full name of the user, verification of the user details etc. Depending on the argument you pass to the adduser command, some prompts may not present themselves at all. With promptly, you just need to list all prompts and the text that you want to enter on the prompt. You can add a regular expression as well. If you pattern matched a prompt, it will be handled. Some of the prompts that the adduser needs throws are -

password for <username>: (sudo password):

New password:

Retype new password:

Full Name[]:

...


The rule for this command would look like

mysudopassword1=password

newuserpassword123=New pass

newuserpassword123=Rety*

Automated User=Full Name

.....

Y=information correct*

The command will look like
```
> promptly sudo adduser myuser1 <<END
> mysudopassword1=password for
newuserpassword123=New pass
newuserpassword123=Rety*
Automated User=Full Name
.....
Y=information correct*
END
```

The return code of promptly is same as that of the command under it. This can be used to check the status of the command being scripted.


