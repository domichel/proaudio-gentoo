# proaudio-gentoo

This is the mew generation proaudio overlay. It is based
on the old proaudio overlay on tuxfamily.org:

`svn://svn.tuxfamily.org/svnroot/proaudio/proaudio/trunk/overlays/proaudio`

You can find that new repository at
    https://github.com/domichel/proaudio-gentoo

Pro Audio on Gentoo
===================
We have several repositories we can use. The first one is
the main tree (::gentoo).

The second one is audio-overlay at
    https://github.com/gentoo-audio/audio-overlay

The third one is the overlay of decibel Linux at
    https://github.com/Gentoo-Music-and-Audio-Technology/gentoostudio

Another one is os-gentoo-overlay which provide LADI
related stuffs for use on gentoo:
    https://github.com/LADI/os-gentoo-overlay

Last but not least is this one at
    https://github.com/domichel/proaudio-gentoo

That proaudio-gentoo overlay is the only one that provide a solution
to media-sound/ladish blocking media-sound/lash. Lash is
in the main tree and all the other audio related overlays
do have blockings in the form of variations of
    `lash? ( !media-sound/lash )`
That imply they will block all the lash related software from
the main tree.

Installation of the overlays
============================
audio-overlay and proaudio-gentoo can be installed via eselect:
```
# eselect repository list
# eselect repository enable proaudio-gentoo
```

Proaudio-gentoo provide a fake media-sound/lash ebuild that
install nothing but only depend on media-sound/ladish, That
terrible hack solve these blockings. It also contain other 
ladish related ebuilds that doesn't conflict with the main
tree lash ebuild. In order to take profit of that, a simple way is
just to give proaudio-gentoo a higher piority than the main tree
and the overlays with ladish blocking lash, as example in
```
# /etc/portage/repos.conf/eselect-repo.conf

[audio-overlay]
location = /var/db/repos/audio-overlay
sync-type = git
sync-uri = https://github.com/gentoo-mirror/audio-overlay.git
priority = 800

[GenCool]
location = /var/db/repos/GenCool
sync-type = git
sync-uri = https://github.com/domichel/GenCool.git
priority = 950

[proaudio-gentoo]
location = /var/db/repos/proaudio-gentoo
sync-type = git
sync-uri = https://github.com/domichel/proaudio-gentoo.git
priority = 900
```
Another solution is to give the overlays the priorities you want
based on any criteria You may choose, and to block ladish when
a blocking conflict exist with lash.
Use `emerge -av ...` to see which overlay provokes the conflict and,
as example, in `/etc/portage/package.mask`:
```
media-sound/ladish::ladi51
```

Amoung other goodies, proaudio-gentoo contain many ebuilds related
to sound engineering.

As example the jkmeter and the new ebumeter which are the best
tools of today to do the mastering. They was build from the
ideas of Bob Katz, the best mastering expert in exercise.
Visit his blog or read his book "Mastering Audio - the art
and the science third edition". End of the pub, but trust me,
to really master the process of digital recording and
mastering, more technical knowledge is needed than with the
analog technology, and Bob Katz master and explain every
bit of it.

It is also an attic with working ebuilds (at the time
of their import) from the original pro-audio overlay.
I just don't have the time or the feeling to maintain them,
or they are historical stuffs:
https://github.com/domichel/proaudio-attic

Enjoy!

P.S.: It is a personnal overlay, GenCool, where I maintain a
special version of the guitarix ebuild that install dk-builder,
a tool that will be best used with some knowledge into electronics.
Its main purpose is the development of guitarix and LV2 plugins.
See https://github.com/domichel/GenCool.git
