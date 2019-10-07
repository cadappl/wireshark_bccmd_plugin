# Introduction

The plugin was developed because there's no such tool published officially
to decode the specified BlueCore command (BCCMD) and event packets.  The
constants and the packet constructions are from [blueZ] as the public
information.

The reason to choose [GPLv2 license] is because of
http://www.gnu.org/licenses/gpl-faq.html#GPLPluginsInNF.

It supports a post-dissector to recognize BCCMD vendor commands and events,
and one menu to dump specific firmware objects from the btsnoop file.

[blueZ]: http://www.bluez.org
[GPLv2 license]: http://www.gnu.org/licenses/gpl-2.0.html
