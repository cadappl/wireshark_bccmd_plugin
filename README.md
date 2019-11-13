# Introduction

The plugin was developed because there's no such tool published officially
to decode the specified BlueCore command (BCCMD) and event packets.  The
constants and the packet constructions are from [blueZ] as the public
information.

The reason to choose [GPLv2 license] is because of
http://www.gnu.org/licenses/gpl-faq.html#GPLPluginsInNF. The rule can be
found at [Lua]. And more details can refer to the discussion of [osqa-12371]
and [osqa-40139].

It supports a post-dissector to recognize BCCMD vendor commands and events,
and one menu to dump specific firmware objects from the btsnoop file.

[blueZ]: http://www.bluez.org
[GPLv2 license]: http://www.gnu.org/licenses/gpl-2.0.html
[Lua]: https://wiki.wireshark.org/Lua
[osqa-12371]: https://osqa-ask.wireshark.org/questions/12371/wireshark-plugin-and-gpl-license
[osqa-40139]: https://osqa-ask.wireshark.org/questions/40139/closed-source-wireshark-dissectorsplugins

