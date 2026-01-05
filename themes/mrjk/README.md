# MrJK theme

This is a reimplementation in omb of my favorite prompt.

Features:
* Single line prompt
* SCM support (new)
* Failed return code
* Dynamic path size and status
* Dynamic user color depending root, user or system user
* Automatic kill switch when prompt is slow to answer
* sudo indicator
* chroot indicator
* jobs display

Todo:
* change @ color if ssh_keys are unlocked, especially usefull on ssh HOST -A
* clean whole code
* make the code portable outside of omb, especially scm part
* dynamic random host color, to differentiate servers
* fix slow mode implementation
* make an init function
* clean colors and remove duplicate code
* battery support
