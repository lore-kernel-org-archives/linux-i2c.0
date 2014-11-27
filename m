From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Freeze of mouse and keyboard after suspend due to i2c-designware
Date: Thu, 27 Nov 2014 16:49:13 +0200
Message-ID: <20141127144913.GE1304@lahna.fi.intel.com>
References: <54724D46.6040501@bluewin.ch>
 <54772BA0.200@bluewin.ch>
 <20141127142942.GD3230@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141127142942.GD3230@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Prof. H.-M. Hoogewoud" <hhoogewoud-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tan, Raymond" <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 27, 2014 at 03:29:46PM +0100, Wolfram Sang wrote:
> Hi,
>=20
> > I would like to know if my bug report is OK. It is the first time I=
 report a
> > (?) kernel bug. Do you need more info?
>=20
> I never got the original message, but this one came through. I will a=
dd
> some more people to CC which have been working with this driver latel=
y,
> they should know more about suspend/resume issues.

The included log does not seem to have any I2C related error messages
but I suppose it crashes during resume which results all the failures
you are seeing.

BTW, are you suspending to disk or to mem?

I'll try to reproduce the problem here.

> Thanks,
>=20
>    Wolfram
>=20
> >=20
> > Thank you!
> >=20
> > kind regards
> >=20
> > H.-M. Hoogewoud
> >=20
> >=20
> > Le 23. 11. 14 22:10, Prof. H.-M. Hoogewoud a =E9crit :
> > >Every time I resume from suspend, I have a freeze of my mouse, key=
board,
> > >touchpad, and touchscreen. Capslock does not work. I have tried di=
fferent
> > >kernel from 3.13, 3.14, 3.15, 3.16 and 3.17. 3.18 rc5.
> > > The problem is systematically reproducible.
> > >
> > >*************
> > >WORKAROUND:
> > >
> > >when I blacklist the following in /etc/modprobe.d/blacklist.conf m=
y system
> > >resumes perfectly:
> > >blacklist i2c_designware_platform
> > >blacklist i2c_designware_core
> > >
> > >or when I use two scripts :
> > >in /etc/pm/sleep.d a script named 99i2csleep containing:
> > >#!/bin/sh
> > >
> > ># Remove ic2 module prior to suspend
> > >rmmod i2c_designware_platform
> > >rmmod i2c_designware_core
> > >
> > >in /etc/pm/power.d a script named 99i2power containing:
> > >#!/bin/sh
> > ># install ic2 module prior to wakeup
> > >modprobe i2c_designware_platform
> > >modprobe i2c_designware_core
> > >
> > >************************3
> > >
> > >These two modules are for the use of my touchpad and my touchscree=
n
> > >
> > >
> > >cat /proc/version
> > >Linux version 3.18.0-031800rc5-generic (apw@gomeisa) (gcc version =
4.6.3
> > >(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201411162035 SMP Mon Nov 17 01:3=
6:34 UTC
> > >2014
> > >
> > >syslog
> > >
> > >Nov 23 08:04:10 VAIOHMH anacron[5562]: Job `cron.daily' terminated
> > >Nov 23 08:04:10 VAIOHMH anacron[5562]: Job `cron.weekly' started
> > >Nov 23 08:04:10 VAIOHMH anacron[6026]: Updated timestamp for job
> > >`cron.weekly' to 2014-11-23
> > >Nov 23 08:04:14 VAIOHMH anacron[5562]: Job `cron.weekly' terminate=
d
> > >Nov 23 08:04:14 VAIOHMH anacron[5562]: Job `test.daily' started
> > >Nov 23 08:04:14 VAIOHMH anacron[5562]: Job `test.daily' terminated
> > >Nov 23 08:04:14 VAIOHMH anacron[5562]: Normal exit (3 jobs run)
> > >Nov 23 08:04:17 VAIOHMH kernel: [52160.065694] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:04:17 VAIOHMH kernel: [52160.070182] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:06:23 VAIOHMH kernel: [52285.431595] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:06:23 VAIOHMH kernel: [52285.436076] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:08:28 VAIOHMH kernel: [52410.797485] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:08:28 VAIOHMH kernel: [52410.801951] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:10:34 VAIOHMH kernel: [52536.163369] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:10:34 VAIOHMH kernel: [52536.163504] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:12:39 VAIOHMH kernel: [52661.529299] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:12:39 VAIOHMH kernel: [52661.530176] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:14:44 VAIOHMH kernel: [52786.895226] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:14:44 VAIOHMH kernel: [52786.899754] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:16:50 VAIOHMH kernel: [52912.261185] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:16:50 VAIOHMH kernel: [52912.265658] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:17:01 VAIOHMH CRON[6240]: (root) CMD (   cd / && run-par=
ts
> > >--report /etc/cron.hourly)
> > >Nov 23 08:18:55 VAIOHMH kernel: [53037.626972] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:18:55 VAIOHMH kernel: [53037.631422] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:20:21 VAIOHMH dbus[799]: [system] Activating service
> > >name=3D'org.freedesktop.hostname1' (using servicehelper)
> > >Nov 23 08:20:21 VAIOHMH dbus[799]: [system] Successfully activated=
 service
> > >'org.freedesktop.hostname1'
> > >Nov 23 08:21:01 VAIOHMH kernel: [53162.992862] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:21:01 VAIOHMH kernel: [53162.997321] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:21:31 VAIOHMH NetworkManager[934]: <info> sleep requeste=
d
> > >(sleeping: no  enabled: yes)
> > >Nov 23 08:21:31 VAIOHMH NetworkManager[934]: <info> sleeping or
> > >disabling...
> > >Nov 23 08:21:31 VAIOHMH NetworkManager[934]: <info> (wlan2): devic=
e state
> > >change: activated -> unmanaged (reason 'sleeping') [100 10 37]
> > >Nov 23 08:21:31 VAIOHMH NetworkManager[934]: <info> (wlan2): deact=
ivating
> > >device (reason 'sleeping') [37]
> > >Nov 23 08:21:32 VAIOHMH NetworkManager[934]: <info> (wlan2): cance=
led DHCP
> > >transaction, DHCP client pid 3316
> > >Nov 23 08:18:39 VAIOHMH wpa_supplicant[1961]: message repeated 88 =
times: [
> > >wlan2: WPA: Group rekeying completed with bc:8c:cd:c0:b5:28 [GTK=3D=
TKIP]]
> > >Nov 23 08:21:32 VAIOHMH wpa_supplicant[1961]: wlan2:
> > >CTRL-EVENT-DISCONNECTED bssid=3Dbc:8c:cd:c0:b5:28 reason=3D3
> > >locally_generated=3D1
> > >Nov 23 08:21:32 VAIOHMH kernel: [53193.729979] rtw_wx_set_mlme
> > >Nov 23 08:21:32 VAIOHMH kernel: [53193.729983] rtw_wx_set_mlme, cm=
d=3D0,
> > >reason=3D3
> > >Nov 23 08:21:32 VAIOHMH avahi-daemon[946]: Withdrawing address rec=
ord for
> > >192.168.123.63 on wlan2.
> > >Nov 23 08:21:32 VAIOHMH avahi-daemon[946]: Leaving mDNS multicast =
group on
> > >interface wlan2.IPv4 with address 192.168.123.63.
> > >Nov 23 08:21:32 VAIOHMH avahi-daemon[946]: Interface wlan2.IPv4 no=
 longer
> > >relevant for mDNS.
> > >Nov 23 08:21:32 VAIOHMH NetworkManager[934]: <warn> DNS: plugin dn=
smasq
> > >update failed
> > >Nov 23 08:21:32 VAIOHMH NetworkManager[934]: <info> Removing DNS
> > >information from /sbin/resolvconf
> > >Nov 23 08:21:32 VAIOHMH dnsmasq[3319]: configuration des serveurs =
amonts =E0
> > >partir de DBus
> > >Nov 23 08:21:32 VAIOHMH NetworkManager[934]: <info> (wlan2): clean=
ing
> > >up...
> > >Nov 23 08:21:32 VAIOHMH NetworkManager[934]: <info> (wlan2): takin=
g down
> > >device.
> > >Nov 23 08:21:32 VAIOHMH avahi-daemon[946]: Interface wlan2.IPv6 no=
 longer
> > >relevant for mDNS.
> > >Nov 23 08:21:32 VAIOHMH avahi-daemon[946]: Leaving mDNS multicast =
group on
> > >interface wlan2.IPv6 with address fe80::287:35ff:fe1e:1bd.
> > >Nov 23 08:21:32 VAIOHMH avahi-daemon[946]: Withdrawing address rec=
ord for
> > >fe80::287:35ff:fe1e:1bd on wlan2.
> > >Nov 23 08:21:32 VAIOHMH NetworkManager[934]: <info> NetworkManager=
 state
> > >is now ASLEEP
> > >Nov 23 08:21:32 VAIOHMH dbus[799]: [system] Activating service
> > >name=3D'org.freedesktop.nm_dispatcher' (using servicehelper)
> > >Nov 23 08:21:32 VAIOHMH dbus[799]: [system] Activating service
> > >name=3D'org.freedesktop.systemd1' (using servicehelper)
> > >Nov 23 08:21:32 VAIOHMH dbus[799]: [system] Successfully activated=
 service
> > >'org.freedesktop.nm_dispatcher'
> > >Nov 23 08:21:32 VAIOHMH dbus[799]: [system] Successfully activated=
 service
> > >'org.freedesktop.systemd1'
> > >Nov 23 08:21:32 VAIOHMH anacron[6495]: Anacron 2.3 started on 2014=
-11-23
> > >Nov 23 08:21:32 VAIOHMH anacron[6495]: Normal exit (0 jobs run)
> > >Nov 23 08:22:17 VAIOHMH rsyslogd: [origin software=3D"rsyslogd"
> > >swVersion=3D"7.4.4" x-pid=3D"591" x-info=3D"http://www.rsyslog.com=
"] start
> > >Nov 23 08:22:17 VAIOHMH rsyslogd: rsyslogd's groupid changed to 10=
4
> > >Nov 23 08:22:17 VAIOHMH rsyslogd: rsyslogd's userid changed to 101
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Initializing cgroup=
 subsys
> > >cpuset
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Initializing cgroup=
 subsys
> > >cpu
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Initializing cgroup=
 subsys
> > >cpuacct
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Linux version
> > >3.18.0-031800rc5-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/=
Linaro
> > >4.6.3-1ubuntu5) ) #201411162035 SMP Mon Nov 17 01:36:34 UTC 2014
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Command line:
> > >BOOT_IMAGE=3D/boot/vmlinuz-3.18.0-031800rc5-generic
> > >root=3DUUID=3Da64e9e85-bc3d-47ff-b8c2-16c1bdb9cec0 ro acpi_sleep=3D=
nonvs quiet
> > >splash i8042.nopnp vt.handoff=3D7
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] KERNEL supported cp=
us:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   Intel GenuineInte=
l
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   AMD AuthenticAMD
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   Centaur CentaurHa=
uls
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] e820: BIOS-provided
> > >physical RAM map:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x0000000000000000-0x000000000006efff] usable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x000000000006f000-0x000000000006ffff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x0000000000070000-0x0000000000087fff] usable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x0000000000088000-0x00000000000bffff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x0000000000100000-0x0000000093a36fff] usable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x0000000093a37000-0x0000000094eaffff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x0000000094eb0000-0x000000009b6befff] usable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x000000009b6bf000-0x000000009b8befff] type 20
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x000000009b8bf000-0x000000009bebefff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x000000009bebf000-0x000000009bfbefff] ACPI NVS
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x000000009bfbf000-0x000000009bffefff] ACPI data
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x000000009bfff000-0x000000009bffffff] usable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x000000009c000000-0x000000009f9fffff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x00000000e0000000-0x00000000efffffff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x00000000fe101000-0x00000000fe112fff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x00000000feb00000-0x00000000feb0ffff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x00000000fec00000-0x00000000fec00fff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x00000000fed00000-0x00000000fee00fff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x00000000ffc00000-0x00000000ffffffff] reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BIOS-e820: [mem
> > >0x0000000100000000-0x000000025f5fffff] usable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] NX (Execute Disable=
)
> > >protection: active
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: EFI v2.31 by I=
NSYDE
> > >Corp.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: ACPI=3D0x9bffe=
000  ACPI
> > >2.0=3D0x9bffe014  SMBIOS=3D0x9bebef98
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem00: [Boot C=
ode
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000000000000-0x0000000000001000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem01: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000000001000-0x000000000006f000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem02: [Reserv=
ed
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000000006f000-0x0000000000070000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem03: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000000070000-0x0000000000088000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem04: [Runtim=
e Data
> > >|RUN|  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000000088000-0x000000000009f000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem05: [Reserv=
ed
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000000009f000-0x00000000000a0000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem06: [Loader=
 Data
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000000100000-0x00000000014c0000) (19MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem07: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000014c0000-0x0000000002000000) (11MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem08: [Loader=
 Data
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000002000000-0x00000000033c0000) (19MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem09: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000033c0000-0x00000000359f6000) (806MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem10: [Loader=
 Data
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000359f6000-0x0000000036cf3000) (18MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem11: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000036cf3000-0x000000006c827000) (859MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem12: [Loader=
 Data
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000006c827000-0x0000000091ec0000) (598MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem13: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000091ec0000-0x0000000091ee0000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem14: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000091ee0000-0x0000000092be2000) (13MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem15: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000092be2000-0x0000000093a37000) (14MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem16: [Reserv=
ed
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000093a37000-0x0000000094eb0000) (20MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem17: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000094eb0000-0x00000000950a1000) (1MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem18: [Loader=
 Code
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000950a1000-0x00000000950bf000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem19: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000950bf000-0x0000000097b9d000) (42MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem20: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000097b9d000-0x00000000992af000) (23MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem21: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000992af000-0x00000000992b2000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem22: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000992b2000-0x00000000992dd000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem23: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000992dd000-0x00000000992df000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem24: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x00000000992df000-0x0000000099424000) (1MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem25: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099424000-0x0000000099427000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem26: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099427000-0x000000009942a000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem27: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009942a000-0x000000009942f000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem28: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009942f000-0x0000000099430000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem29: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099430000-0x0000000099431000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem30: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099431000-0x0000000099435000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem31: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099435000-0x0000000099436000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem32: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099436000-0x0000000099475000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem33: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099475000-0x0000000099477000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem34: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099477000-0x000000009947e000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem35: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009947e000-0x000000009947f000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem36: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009947f000-0x0000000099484000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem37: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099484000-0x0000000099487000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem38: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099487000-0x0000000099488000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem39: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099488000-0x0000000099489000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem40: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000099489000-0x000000009948a000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem41: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009948a000-0x000000009948c000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem42: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009948c000-0x000000009b0bf000) (28MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem43: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009b0bf000-0x000000009b376000) (2MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem44: [Loader=
 Data
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009b376000-0x000000009b380000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem45: [Boot C=
ode
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009b380000-0x000000009b6bf000) (3MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem46: [Runtim=
e Code
> > >|RUN|  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009b6bf000-0x000000009b8bf000) (2MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem47: [Runtim=
e Data
> > >|RUN|  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009b8bf000-0x000000009babf000) (2MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem48: [Reserv=
ed
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009babf000-0x000000009bebf000) (4MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem49: [ACPI M=
emory
> > >NVS    |   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009bebf000-0x000000009bfbf000) (1MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem50: [ACPI R=
eclaim
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009bfbf000-0x000000009bfff000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem51: [Boot D=
ata
> > >|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x000000009bfff000-0x000000009c000000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem52: [Conven=
tional
> > >Memory|   |  |  |  |   |WB|WT|WC|UC]
> > >range=3D[0x0000000100000000-0x000000025f600000) (5622MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem53: [Reserv=
ed
> > >|   |  |  |  |   |  |  |  |  ]
> > >range=3D[0x00000000000a0000-0x00000000000c0000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem54: [Reserv=
ed
> > >|   |  |  |  |   |  |  |  |  ]
> > >range=3D[0x000000009c000000-0x000000009fa00000) (58MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem55: [Memory=
 Mapped
> > >I/O  |RUN|  |  |  |   |  |  |  |UC]
> > >range=3D[0x00000000e0000000-0x00000000f0000000) (256MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem56: [Reserv=
ed
> > >|   |  |  |  |   |  |  |  |  ]
> > >range=3D[0x00000000fe101000-0x00000000fe113000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem57: [Memory=
 Mapped
> > >I/O  |RUN|  |  |  |   |  |  |  |UC]
> > >range=3D[0x00000000feb00000-0x00000000feb10000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem58: [Memory=
 Mapped
> > >I/O  |RUN|  |  |  |   |  |  |  |UC]
> > >range=3D[0x00000000fec00000-0x00000000fec01000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem59: [Memory=
 Mapped
> > >I/O  |RUN|  |  |  |   |  |  |  |UC]
> > >range=3D[0x00000000fed00000-0x00000000fed1c000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem60: [Memory=
 Mapped
> > >I/O  |RUN|  |  |  |   |  |  |  |  ]
> > >range=3D[0x00000000fed1c000-0x00000000fed20000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem61: [Memory=
 Mapped
> > >I/O  |RUN|  |  |  |   |  |  |  |UC]
> > >range=3D[0x00000000fed20000-0x00000000fee01000) (0MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] efi: mem62: [Memory=
 Mapped
> > >I/O  |RUN|  |  |  |   |  |  |  |  ]
> > >range=3D[0x00000000ffc00000-0x0000000100000000) (4MB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] SMBIOS 2.7 present.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] DMI: Sony Corporati=
on
> > >SVD1323Y9EB/VAIO, BIOS R1080S7 09/13/2013
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] e820: update [mem
> > >0x00000000-0x00000fff] usable =3D=3D> reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] e820: remove [mem
> > >0x000a0000-0x000fffff] usable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] AGP: No AGP bridge =
found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] e820: last_pfn =3D =
0x25f600
> > >max_arch_pfn =3D 0x400000000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] MTRR default type:
> > >uncachable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] MTRR fixed ranges e=
nabled:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   00000-9FFFF write=
-back
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   A0000-BFFFF uncac=
hable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   C0000-E7FFF write=
-protect
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   E8000-EFFFF
> > >write-combining
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   F0000-FFFFF write=
-protect
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] MTRR variable range=
s
> > >enabled:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   0 base 0000000000=
 mask
> > >7F80000000 write-back
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   1 base 0080000000=
 mask
> > >7FE0000000 write-back
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   2 base 009C000000=
 mask
> > >7FFC000000 uncachable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   3 base 00FFC00000=
 mask
> > >7FFFC00000 write-protect
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   4 base 0100000000=
 mask
> > >7F00000000 write-back
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   5 base 0200000000=
 mask
> > >7F80000000 write-back
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   6 base 025F600000=
 mask
> > >7FFFE00000 uncachable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   7 base 025F800000=
 mask
> > >7FFF800000 uncachable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   8 base 0260000000=
 mask
> > >7FE0000000 uncachable
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   9 disabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] x86 PAT enabled: cp=
u 0, old
> > >0x7040600070406, new 0x7010600070106
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] e820: last_pfn =3D =
0x9c000
> > >max_arch_pfn =3D 0x400000000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Scanning 1 areas fo=
r low
> > >memory corruption
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Base memory trampol=
ine at
> > >[ffff88000007e000] 7e000 size 24576
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Using GB pages for =
direct
> > >mapping
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x00000000-0x000fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x00000000-0x000fffff] page 4k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BRK [0x02fca000,
> > >0x02fcafff] PGTABLE
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BRK [0x02fcb000,
> > >0x02fcbfff] PGTABLE
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BRK [0x02fcc000,
> > >0x02fccfff] PGTABLE
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x25f400000-0x25f5fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x25f400000-0x25f5fffff] page 2M
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BRK [0x02fcd000,
> > >0x02fcdfff] PGTABLE
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x25c000000-0x25f3fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x25c000000-0x25f3fffff] page 2M
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x200000000-0x25bffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x200000000-0x23fffffff] page 1G
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x240000000-0x25bffffff] page 2M
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x00100000-0x93a36fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x00100000-0x001fffff] page 4k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x00200000-0x3fffffff] page 2M
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x40000000-0x7fffffff] page 1G
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x80000000-0x939fffff] page 2M
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x93a00000-0x93a36fff] page 4k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x94eb0000-0x9b6befff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x94eb0000-0x94ffffff] page 4k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x95000000-0x9b5fffff] page 2M
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x9b600000-0x9b6befff] page 4k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BRK [0x02fce000,
> > >0x02fcefff] PGTABLE
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] BRK [0x02fcf000,
> > >0x02fcffff] PGTABLE
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x9bfff000-0x9bffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x9bfff000-0x9bffffff] page 4k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] init_memory_mapping=
: [mem
> > >0x100000000-0x1ffffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]  [mem
> > >0x100000000-0x1ffffffff] page 1G
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] RAMDISK: [mem
> > >0x359f6000-0x36cf2fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: Early table c=
hecksum
> > >verification disabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: RSDP
> > >0x000000009BFFE014 000024 (v02 Sony  )
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: XSDT
> > >0x000000009BFFE210 000104 (v01 Sony   VAIO     20130913 01000013)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: FACP
> > >0x000000009BFF5000 00010C (v05 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: DSDT
> > >0x000000009BFE6000 00B95B (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: FACS
> > >0x000000009BFB9000 000040
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: UEFI
> > >0x000000009BFFD000 000236 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: FPDT
> > >0x000000009BFFB000 000044 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: MSDM
> > >0x000000009BFFA000 000055 (v03 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFF9000 000496 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFF8000 00004A (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: TPM2
> > >0x000000009BFF7000 000038 (v03 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: ASF!
> > >0x000000009BFF6000 0000A5 (v32 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: HPET
> > >0x000000009BFF4000 000038 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: APIC
> > >0x000000009BFF3000 00008C (v03 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: MCFG
> > >0x000000009BFF2000 00003C (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFE5000 0007F9 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: BOOT
> > >0x000000009BFE4000 000028 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LPIT
> > >0x000000009BFE3000 00005C (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: ASPT
> > >0x000000009BFE2000 000034 (v07 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: DBGP
> > >0x000000009BFE1000 000034 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFDF000 001302 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFDE000 000200 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFDD000 000494 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFDC000 000AD8 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFDB000 000421 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFD8000 002E79 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFD7000 000393 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: PCCT
> > >0x000000009BFD6000 00006E (v05 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: SSDT
> > >0x000000009BFD5000 000AC4 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: CSRT
> > >0x000000009BFD3000 0000C4 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: BGRT
> > >0x000000009BFD4000 000038 (v01 Sony   VAIO     20130913 ACPI 00040=
000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: CSRT
> > >0x000000009BFD2000 0000C4 (v01 INTL   HSWULT-R 00000001 INTL 20100=
528)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: Local APIC ad=
dress
> > >0xfee00000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] No NUMA configurati=
on found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Faking a node at [m=
em
> > >0x0000000000000000-0x000000025f5fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] NODE_DATA(0) alloca=
ted [mem
> > >0x25f5f8000-0x25f5fcfff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]
> > >[ffffea0000000000-ffffea00097fffff] PMD ->
> > >[ffff880256c00000-ffff88025ebfffff] on node 0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Zone ranges:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   DMA      [mem
> > >0x00001000-0x00ffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   DMA32    [mem
> > >0x01000000-0xffffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   Normal   [mem
> > >0x100000000-0x25f5fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Movable zone start =
for each
> > >node
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Early memory node r=
anges
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   node   0: [mem
> > >0x00001000-0x0006efff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   node   0: [mem
> > >0x00070000-0x00087fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   node   0: [mem
> > >0x00100000-0x93a36fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   node   0: [mem
> > >0x94eb0000-0x9b6befff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   node   0: [mem
> > >0x9bfff000-0x9bffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   node   0: [mem
> > >0x100000000-0x25f5fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Initmem setup node =
0 [mem
> > >0x00001000-0x25f5fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] On node 0 totalpage=
s:
> > >2070477
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   DMA zone: 64 page=
s used
> > >for memmap
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   DMA zone: 22 page=
s
> > >reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   DMA zone: 3974 pa=
ges,
> > >LIFO batch:0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   DMA32 zone: 9802 =
pages
> > >used for memmap
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   DMA32 zone: 62727=
1 pages,
> > >LIFO batch:31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   Normal zone: 2248=
8 pages
> > >used for memmap
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]   Normal zone: 1439=
232
> > >pages, LIFO batch:31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Reserving Intel gra=
phics
> > >stolen memory at 0x9da00000-0x9f9fffff
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: PM-Timer IO P=
ort:
> > >0x1808
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: Local APIC ad=
dress
> > >0xfee00000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x01]
> > >lapic_id[0x00] enabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x02]
> > >lapic_id[0x01] enabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x03]
> > >lapic_id[0x02] enabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x04]
> > >lapic_id[0x03] enabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x05]
> > >lapic_id[0x00] disabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x06]
> > >lapic_id[0x00] disabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x07]
> > >lapic_id[0x00] disabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: LAPIC (acpi_i=
d[0x08]
> > >lapic_id[0x00] disabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: IOAPIC (id[0x=
02]
> > >address[0xfec00000] gsi_base[0])
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] IOAPIC[0]: apic_id =
2,
> > >version 32, address 0xfec00000, GSI 0-39
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: INT_SRC_OVR (=
bus 0
> > >bus_irq 0 global_irq 2 dfl dfl)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: INT_SRC_OVR (=
bus 0
> > >bus_irq 9 global_irq 9 high level)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: IRQ0 used by
> > >override.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: IRQ9 used by
> > >override.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Using ACPI (MADT) f=
or SMP
> > >configuration information
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] ACPI: HPET id: 0x80=
86a201
> > >base: 0xfed00000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] smpboot: Allowing 8=
 CPUs, 4
> > >hotplug CPUs
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x00000000-0x00000fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x0006f000-0x0006ffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x00088000-0x000bffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x000c0000-0x000fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x93a37000-0x94eaffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x9b6bf000-0x9b8befff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x9b8bf000-0x9bebefff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x9bebf000-0x9bfbefff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x9bfbf000-0x9bffefff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x9c000000-0x9f9fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0x9fa00000-0xdfffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xe0000000-0xefffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xf0000000-0xfe100fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfe101000-0xfe112fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfe113000-0xfeafffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfeb00000-0xfeb0ffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfeb10000-0xfebfffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfec00000-0xfec00fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfec01000-0xfecfffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfed00000-0xfee00fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xfee01000-0xffbfffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PM: Registered nosa=
ve
> > >memory: [mem 0xffc00000-0xffffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] e820: [mem
> > >0x9fa00000-0xdfffffff] available for PCI devices
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Booting paravirtual=
ized
> > >kernel on bare hardware
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] setup_percpu: NR_CP=
US:256
> > >nr_cpumask_bits:256 nr_cpu_ids:8 nr_node_ids:1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PERCPU: Embedded 31
> > >pages/cpu @ffff88025f200000 s86976 r8192 d31808 u262144
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] pcpu-alloc: s86976 =
r8192
> > >d31808 u262144 alloc=3D1*2097152
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] pcpu-alloc: [0] 0 1=
 2 3 4 5
> > >6 7
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Built 1 zonelists i=
n Node
> > >order, mobility grouping on.  Total pages: 2038101
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Policy zone: Normal
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Kernel command line=
:
> > >BOOT_IMAGE=3D/boot/vmlinuz-3.18.0-031800rc5-generic
> > >root=3DUUID=3Da64e9e85-bc3d-47ff-b8c2-16c1bdb9cec0 ro acpi_sleep=3D=
nonvs quiet
> > >splash i8042.nopnp vt.handoff=3D7
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] PID hash table entr=
ies:
> > >4096 (order: 3, 32768 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] xsave: enabled xsta=
te_bv
> > >0x7, cntxt size 0x340 using standard form
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] AGP: Checking apert=
ure...
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] AGP: No AGP bridge =
found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Calgary: detecting =
Calgary
> > >via BIOS EBDA area
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Calgary: Unable to =
locate
> > >Rio Grande table in EBDA - bailing!
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Memory: 7975340K/82=
81908K
> > >available (7880K kernel code, 1127K rwdata, 3780K rodata, 1396K in=
it,
> > >1316K bss, 306568K reserved)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] SLUB: HWalign=3D64,
> > >Order=3D0-3, MinObjects=3D0, CPUs=3D8, Nodes=3D1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Hierarchical RCU
> > >implementation.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]     RCU dyntick-idl=
e
> > >grace-period acceleration is enabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]     RCU restricting=
 CPUs
> > >from NR_CPUS=3D256 to nr_cpu_ids=3D8.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] RCU: Adjusting geom=
etry for
> > >rcu_fanout_leaf=3D16, nr_cpu_ids=3D8
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] NR_IRQS:16640 nr_ir=
qs:760 0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]     Offload RCU cal=
lbacks
> > >from all CPUs
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000]     Offload RCU cal=
lbacks
> > >from CPUs: 0-7.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] Console: colour dum=
my
> > >device 80x25
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] console [tty0] enab=
led
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] allocated 33554432 =
bytes of
> > >page_cgroup
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] please try
> > >'cgroup_disable=3Dmemory' option if you don't want memory cgroups
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] hpet clockevent reg=
istered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] tsc: Fast TSC calib=
ration
> > >failed
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] tsc: PIT calibratio=
n
> > >matches HPET. 1 loops
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000000] tsc: Detected 2294.=
682 MHz
> > >processor
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000042] Calibrating delay l=
oop
> > >(skipped), value calculated using timer frequency.. 4589.36 BogoMI=
PS
> > >(lpj=3D9178728)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000046] pid_max: default: 3=
2768
> > >minimum: 301
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.000055] ACPI: Core revision
> > >20140926
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.020384] ACPI: All ACPI Tabl=
es
> > >successfully acquired
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.040292] Security Framework
> > >initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.040309] AppArmor: AppArmor
> > >initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.040311] Yama: becoming mind=
ful.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.041106] Dentry cache hash t=
able
> > >entries: 1048576 (order: 11, 8388608 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.043063] Inode-cache hash ta=
ble
> > >entries: 524288 (order: 10, 4194304 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.043888] Mount-cache hash ta=
ble
> > >entries: 16384 (order: 5, 131072 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.043902] Mountpoint-cache ha=
sh table
> > >entries: 16384 (order: 5, 131072 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044157] Initializing cgroup=
 subsys
> > >memory
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044164] Initializing cgroup=
 subsys
> > >devices
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044167] Initializing cgroup=
 subsys
> > >freezer
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044169] Initializing cgroup=
 subsys
> > >net_cls
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044172] Initializing cgroup=
 subsys
> > >blkio
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044174] Initializing cgroup=
 subsys
> > >perf_event
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044177] Initializing cgroup=
 subsys
> > >net_prio
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044179] Initializing cgroup=
 subsys
> > >hugetlb
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044208] CPU: Physical Proce=
ssor ID:
> > >0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044209] CPU: Processor Core=
 ID: 0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044215] ENERGY_PERF_BIAS: S=
et to
> > >'normal', was 'performance'
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.044215] ENERGY_PERF_BIAS: V=
iew and
> > >update with x86_energy_perf_policy(8)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.045441] mce: CPU supports 7=
 MCE
> > >banks
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.045457] CPU0: Thermal monit=
oring
> > >enabled (TM1)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.045471] Last level iTLB ent=
ries:
> > >4KB 1024, 2MB 1024, 4MB 1024
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.045471] Last level dTLB ent=
ries:
> > >4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.045623] Freeing SMP alterna=
tives
> > >memory: 28K (ffffffff82e78000 - ffffffff82e7f000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.046895] Ignoring BGRT: inva=
lid
> > >status 0 (expected 1)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.049967] ftrace: allocating =
32259
> > >entries in 127 pages
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.069489] ..TIMER: vector=3D0=
x30
> > >apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109154] smpboot: CPU0: Inte=
l(R)
> > >Core(TM) i7-4650U CPU @ 1.70GHz (fam: 06, model: 45, stepping: 01)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109164] TSC deadline timer =
enabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109200] Performance Events:=
 PEBS
> > >fmt2+, 16-deep LBR, Haswell events, full-width counters, Intel PMU=
 driver.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109227] ... version:
> > >3
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109228] ... bit width:
> > >48
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109229] ... generic registe=
rs:
> > >4
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109231] ... value mask:
> > >0000ffffffffffff
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109232] ... max period:
> > >0000ffffffffffff
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109233] ... fixed-purpose e=
vents:
> > >3
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.109235] ... event mask:
> > >000000070000000f
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.111424] x86: Booting SMP
> > >configuration:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.111426] .... node  #0, CPUs=
:
> > >#1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.125935] NMI watchdog: enabl=
ed on
> > >all CPUs, permanently consumes one hw-PMU counter.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.126056]  #2 #3
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.155049] x86: Booted up 1 no=
de, 4
> > >CPUs
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.155053] smpboot: Total of 4
> > >processors activated (18357.45 BogoMIPS)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.161417] devtmpfs: initializ=
ed
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166523] evm: security.selin=
ux
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166525] evm: security.SMACK=
64
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166526] evm: security.SMACK=
64EXEC
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166527] evm:
> > >security.SMACK64TRANSMUTE
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166528] evm: security.SMACK=
64MMAP
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166530] evm: security.ima
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166531] evm: security.capab=
ility
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.166612] PM: Registering ACP=
I NVS
> > >region [mem 0x9bebf000-0x9bfbefff] (1048576 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.167769] pinctrl core: initi=
alized
> > >pinctrl subsystem
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.167858] regulator-dummy: no
> > >parameters
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.167927] RTC time: 8:22:15, =
date:
> > >11/23/14
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.168070] NET: Registered pro=
tocol
> > >family 16
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.169206] cpuidle: using gove=
rnor
> > >ladder
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.173214] cpuidle: using gove=
rnor
> > >menu
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.173300] ACPI FADT declares =
the
> > >system doesn't support PCIe ASPM, so disable it
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.173302] ACPI: bus type PCI
> > >registered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.173304] acpiphp: ACPI Hot P=
lug PCI
> > >Controller Driver version: 0.5
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.173402] PCI: MMCONFIG for d=
omain
> > >0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.173405] PCI: MMCONFIG at [m=
em
> > >0xe0000000-0xefffffff] reserved in E820
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.173820] PCI: Using configur=
ation
> > >type 1 for base access
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.177721] ACPI: Added _OSI(Mo=
dule
> > >Device)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.177724] ACPI: Added _OSI(Pr=
ocessor
> > >Device)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.177725] ACPI: Added _OSI(3.=
0 _SCP
> > >Extensions)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.177727] ACPI: Added _OSI(Pr=
ocessor
> > >Aggregator Device)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.182967] ACPI: Executed 2 bl=
ocks of
> > >module-level executable AML code
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.189242] [Firmware Bug]: ACP=
I: BIOS
> > >_OSI(Linux) query ignored
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.293829] ACPI: Dynamic OEM T=
able
> > >Load:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.293848] ACPI: SSDT
> > >0xFFFF8802535F1000 0003D3 (v01 Sony   VAIO     20130913 INTL 20120=
913)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.297525] ACPI: Dynamic OEM T=
able
> > >Load:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.297542] ACPI: SSDT
> > >0xFFFF880253513800 0005AA (v01 Sony   VAIO     20130913 INTL 20120=
913)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.301335] ACPI: Dynamic OEM T=
able
> > >Load:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.301350] ACPI: SSDT
> > >0xFFFF880253634000 000119 (v01 Sony   VAIO     20130913 INTL 20120=
913)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.309165] ACPI: Interpreter e=
nabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.309178] ACPI Exception:
> > >AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20140926/hwxfa=
ce-580)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.309186] ACPI Exception:
> > >AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20140926/hwxfa=
ce-580)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.309210] ACPI: (supports S0 =
S3 S4
> > >S5)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.309212] ACPI: Using IOAPIC =
for
> > >interrupt routing
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.309253] PCI: Using host bri=
dge
> > >windows from ACPI; if necessary, use "pci=3Dnocrs" and report a bu=
g
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.311788] ACPI: Power Resourc=
e [PX03]
> > >(on)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.312968] ACPI: Power Resourc=
e [PX05]
> > >(on)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.313346] ACPI: Power Resourc=
e [PAUD]
> > >(on)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.313949] ACPI: Power Resourc=
e [PSEN]
> > >(on)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.314028] ACPI: Power Resourc=
e [PXTC]
> > >(on)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.348381] ACPI: PCI Root Brid=
ge
> > >[PCI0] (domain 0000 [bus 00-fe])
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.348389] acpi PNP0A08:00: _O=
SC: OS
> > >supports [ExtendedConfig ASPM ClockPM Segments MSI]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.348751] acpi PNP0A08:00: _O=
SC: OS
> > >now controls [PCIeHotplug PME AER PCIeCapability]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349263] PCI host bridge to =
bus
> > >0000:00
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349267] pci_bus 0000:00: ro=
ot bus
> > >resource [bus 00-fe]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349270] pci_bus 0000:00: ro=
ot bus
> > >resource [io  0x0000-0x0cf7]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349272] pci_bus 0000:00: ro=
ot bus
> > >resource [io  0x0d00-0xffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349274] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000a0000-0x000bffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349276] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000c0000-0x000c3fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349278] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000c4000-0x000c7fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349280] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000c8000-0x000cbfff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349282] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000cc000-0x000cffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349284] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000d0000-0x000d3fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349286] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000d4000-0x000d7fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349288] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000d8000-0x000dbfff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349289] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000dc000-0x000dffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349291] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000e0000-0x000e3fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349293] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000e4000-0x000e7fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349295] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000e8000-0x000ebfff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349297] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000ec000-0x000effff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349299] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x000f0000-0x000fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349301] pci_bus 0000:00: ro=
ot bus
> > >resource [mem 0x9fa00000-0xfeafffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349311] pci 0000:00:00.0:
> > >[8086:0a04] type 00 class 0x060000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349434] pci 0000:00:02.0:
> > >[8086:0a26] type 00 class 0x030000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349450] pci 0000:00:02.0: r=
eg 0x10:
> > >[mem 0xb0000000-0xb03fffff 64bit]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349458] pci 0000:00:02.0: r=
eg 0x18:
> > >[mem 0xa0000000-0xafffffff 64bit pref]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349465] pci 0000:00:02.0: r=
eg 0x20:
> > >[io  0x3000-0x303f]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349580] pci 0000:00:03.0:
> > >[8086:0a0c] type 00 class 0x040300
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349592] pci 0000:00:03.0: r=
eg 0x10:
> > >[mem 0xb0410000-0xb0413fff 64bit]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349768] pci 0000:00:14.0:
> > >[8086:9c31] type 00 class 0x0c0330
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349817] pci 0000:00:14.0: r=
eg 0x10:
> > >[mem 0xb0400000-0xb040ffff 64bit]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.349987] pci 0000:00:14.0: P=
ME#
> > >supported from D3hot D3cold
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350051] pci 0000:00:14.0: S=
ystem
> > >wakeup disabled by ACPI
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350113] pci 0000:00:16.0:
> > >[8086:9c3a] type 00 class 0x078000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350162] pci 0000:00:16.0: r=
eg 0x10:
> > >[mem 0xb041a000-0xb041a01f 64bit]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350330] pci 0000:00:16.0: P=
ME#
> > >supported from D0 D3hot D3cold
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350477] pci 0000:00:1b.0:
> > >[8086:9c20] type 00 class 0x040300
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350518] pci 0000:00:1b.0: r=
eg 0x10:
> > >[mem 0xb0414000-0xb0417fff 64bit]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350712] pci 0000:00:1b.0: P=
ME#
> > >supported from D0 D3hot D3cold
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350781] pci 0000:00:1b.0: S=
ystem
> > >wakeup disabled by ACPI
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.350845] pci 0000:00:1f.0:
> > >[8086:9c43] type 00 class 0x060100
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351186] pci 0000:00:1f.2:
> > >[8086:9c03] type 00 class 0x010601
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351228] pci 0000:00:1f.2: r=
eg 0x10:
> > >[io  0x3088-0x308f]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351247] pci 0000:00:1f.2: r=
eg 0x14:
> > >[io  0x3094-0x3097]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351265] pci 0000:00:1f.2: r=
eg 0x18:
> > >[io  0x3080-0x3087]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351283] pci 0000:00:1f.2: r=
eg 0x1c:
> > >[io  0x3090-0x3093]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351302] pci 0000:00:1f.2: r=
eg 0x20:
> > >[io  0x3060-0x307f]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351320] pci 0000:00:1f.2: r=
eg 0x24:
> > >[mem 0xb041d000-0xb041d7ff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351430] pci 0000:00:1f.2: P=
ME#
> > >supported from D3hot
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351539] pci 0000:00:1f.3:
> > >[8086:9c22] type 00 class 0x0c0500
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351575] pci 0000:00:1f.3: r=
eg 0x10:
> > >[mem 0xb041b000-0xb041b0ff 64bit]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351627] pci 0000:00:1f.3: r=
eg 0x20:
> > >[io  0x3040-0x305f]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.351761] acpi PNP0A08:00: Di=
sabling
> > >ASPM (FADT indicates it is unsupported)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369404] ACPI: PCI Interrupt=
 Link
> > >[LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369467] ACPI: PCI Interrupt=
 Link
> > >[LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369526] ACPI: PCI Interrupt=
 Link
> > >[LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369586] ACPI: PCI Interrupt=
 Link
> > >[LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369647] ACPI: PCI Interrupt=
 Link
> > >[LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369709] ACPI: PCI Interrupt=
 Link
> > >[LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369766] ACPI: PCI Interrupt=
 Link
> > >[LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.369824] ACPI: PCI Interrupt=
 Link
> > >[LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370380] ACPI: Enabled 4 GPE=
s in
> > >block 00 to 7F
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370439] ACPI : EC: GPE =3D =
0xa, I/O:
> > >command/status =3D 0x66, data =3D 0x62
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370564] vgaarb: setting as =
boot
> > >device: PCI:0000:00:02.0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370566] vgaarb: device adde=
d:
> > >PCI:0000:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370569] vgaarb: loaded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370571] vgaarb: bridge cont=
rol
> > >possible 0000:00:02.0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370882] SCSI subsystem init=
ialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370938] libata version 3.00=
 loaded.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370967] ACPI: bus type USB
> > >registered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370987] usbcore: registered=
 new
> > >interface driver usbfs
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.370998] usbcore: registered=
 new
> > >interface driver hub
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.371020] usbcore: registered=
 new
> > >device driver usb
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.371253] PCI: Using ACPI for=
 IRQ
> > >routing
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390341] PCI: pci_cache_line=
_size
> > >set to 64 bytes
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390386] e820: reserve RAM b=
uffer
> > >[mem 0x0006f000-0x0006ffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390388] e820: reserve RAM b=
uffer
> > >[mem 0x00088000-0x0008ffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390390] e820: reserve RAM b=
uffer
> > >[mem 0x93a37000-0x93ffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390392] e820: reserve RAM b=
uffer
> > >[mem 0x9b6bf000-0x9bffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390394] e820: reserve RAM b=
uffer
> > >[mem 0x25f600000-0x25fffffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390530] NetLabel: Initializ=
ing
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390532] NetLabel:  domain h=
ash size
> > >=3D 128
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390533] NetLabel: protocols=
 =3D
> > >UNLABELED CIPSOv4
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390547] NetLabel: unlabeled=
 traffic
> > >allowed by default
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390652] hpet0: at MMIO 0xfe=
d00000,
> > >IRQs 2, 8, 0, 0, 0, 0, 0, 0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.390658] hpet0: 8 comparator=
s,
> > >64-bit 14.318180 MHz counter
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.392706] Switched to clockso=
urce
> > >hpet
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.399723] AppArmor: AppArmor
> > >Filesystem Enabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.399761] pnp: PnP ACPI init
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400000] system 00:00: [io
> > >0x0680-0x069f] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400004] system 00:00: [io  =
0xffff]
> > >has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400006] system 00:00: [io  =
0xffff]
> > >has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400008] system 00:00: [io  =
0xffff]
> > >has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400011] system 00:00: [io
> > >0x1800-0x18fe] could not be reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400013] system 00:00: [io
> > >0x164e-0x164f] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400015] system 00:00: [io  =
0x2000]
> > >has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400017] system 00:00: [io  =
0x2004]
> > >has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400021] system 00:00: Plug =
and Play
> > >ACPI device, IDs PNP0c02 (active)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400081] pnp 00:01: Plug and=
 Play
> > >ACPI device, IDs PNP0b00 (active)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400134] system 00:02: [io
> > >0x1854-0x1857] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400137] system 00:02: Plug =
and Play
> > >ACPI device, IDs INT3f0d PNP0c02 (active)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400187] pnp 00:03: Plug and=
 Play
> > >ACPI device, IDs SNYa009 PNP030b (active)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400352] system 00:04: [mem
> > >0xfed1c000-0xfed1ffff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400354] system 00:04: [mem
> > >0xfed10000-0xfed17fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400357] system 00:04: [mem
> > >0xfed18000-0xfed18fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400359] system 00:04: [mem
> > >0xfed19000-0xfed19fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400362] system 00:04: [mem
> > >0xe0000000-0xefffffff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400364] system 00:04: [mem
> > >0xfed20000-0xfed3ffff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400366] system 00:04: [mem
> > >0xfed90000-0xfed93fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400369] system 00:04: [mem
> > >0xff000000-0xffffffff] could not be reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400371] system 00:04: [mem
> > >0xfee00000-0xfeefffff] could not be reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400374] system 00:04: [mem
> > >0x9fa20000-0x9fa20fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400376] system 00:04: [mem
> > >0x9fa10000-0x9fa1ffff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.400379] system 00:04: Plug =
and Play
> > >ACPI device, IDs PNP0c02 (active)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404815] system 00:05: [mem
> > >0xb0425000-0xb0425fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404818] system 00:05: [mem
> > >0xfe104000-0xfe104fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404821] system 00:05: [mem
> > >0xfe106000-0xfe106fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404823] system 00:05: [mem
> > >0xb041f000-0xb041ffff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404825] system 00:05: [mem
> > >0xb041e000-0xb041efff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404828] system 00:05: [mem
> > >0xb0419000-0xb0419007] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404830] system 00:05: [mem
> > >0xb0419014-0xb0419fff] has been reserved
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.404833] system 00:05: Plug =
and Play
> > >ACPI device, IDs PNP0c02 (active)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.405725] pnp: PnP ACPI: foun=
d 6
> > >devices
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413333] pci_bus 0000:00: re=
source 4
> > >[io  0x0000-0x0cf7]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413336] pci_bus 0000:00: re=
source 5
> > >[io  0x0d00-0xffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413338] pci_bus 0000:00: re=
source 6
> > >[mem 0x000a0000-0x000bffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413340] pci_bus 0000:00: re=
source 7
> > >[mem 0x000c0000-0x000c3fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413342] pci_bus 0000:00: re=
source 8
> > >[mem 0x000c4000-0x000c7fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413344] pci_bus 0000:00: re=
source 9
> > >[mem 0x000c8000-0x000cbfff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413346] pci_bus 0000:00: re=
source
> > >10 [mem 0x000cc000-0x000cffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413348] pci_bus 0000:00: re=
source
> > >11 [mem 0x000d0000-0x000d3fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413350] pci_bus 0000:00: re=
source
> > >12 [mem 0x000d4000-0x000d7fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413352] pci_bus 0000:00: re=
source
> > >13 [mem 0x000d8000-0x000dbfff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413354] pci_bus 0000:00: re=
source
> > >14 [mem 0x000dc000-0x000dffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413356] pci_bus 0000:00: re=
source
> > >15 [mem 0x000e0000-0x000e3fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413358] pci_bus 0000:00: re=
source
> > >16 [mem 0x000e4000-0x000e7fff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413360] pci_bus 0000:00: re=
source
> > >17 [mem 0x000e8000-0x000ebfff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413362] pci_bus 0000:00: re=
source
> > >18 [mem 0x000ec000-0x000effff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413364] pci_bus 0000:00: re=
source
> > >19 [mem 0x000f0000-0x000fffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413366] pci_bus 0000:00: re=
source
> > >20 [mem 0x9fa00000-0xfeafffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413400] NET: Registered pro=
tocol
> > >family 2
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413631] TCP established has=
h table
> > >entries: 65536 (order: 7, 524288 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413805] TCP bind hash table
> > >entries: 65536 (order: 8, 1048576 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413943] TCP: Hash tables co=
nfigured
> > >(established 65536 bind 65536)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413963] TCP: reno registere=
d
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.413978] UDP hash table entr=
ies:
> > >4096 (order: 5, 131072 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.414012] UDP-Lite hash table
> > >entries: 4096 (order: 5, 131072 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.414088] NET: Registered pro=
tocol
> > >family 1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.414108] pci 0000:00:02.0: V=
ideo
> > >device with shadowed ROM
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.415913] PCI: CLS 64 bytes, =
default
> > >64
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.415976] Trying to unpack ro=
otfs
> > >image as initramfs...
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856490] Freeing initrd memo=
ry:
> > >19444K (ffff8800359f6000 - ffff880036cf3000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856517] PCI-DMA: Using soft=
ware
> > >bounce buffering for IO (SWIOTLB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856521] software IO TLB [me=
m
> > >0x8dec0000-0x91ec0000] (64MB) mapped at
> > >[ffff88008dec0000-ffff880091ebffff]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856603] Simple Boot Flag at=
 0x44
> > >set to 0x1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856799] RAPL PMU detected, =
hw unit
> > >2^-14 Joules, API unit is 2^-32 Joules, 4 fixed counters 655360 ms=
 ovfl
> > >timer
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856856] microcode: CPU0
> > >sig=3D0x40651, pf=3D0x40, revision=3D0x16
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856866] microcode: CPU1
> > >sig=3D0x40651, pf=3D0x40, revision=3D0x16
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856878] microcode: CPU2
> > >sig=3D0x40651, pf=3D0x40, revision=3D0x16
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856891] microcode: CPU3
> > >sig=3D0x40651, pf=3D0x40, revision=3D0x16
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.856979] microcode: Microcod=
e Update
> > >Driver: v2.00 <tigran-ppwZ4lME3+KI6QP4U9MhSdBc4/FLrbF6@public.gmane.org>, Peter Oruba
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.857022] Scanning for low me=
mory
> > >corruption every 60 seconds
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.857520] futex hash table en=
tries:
> > >2048 (order: 5, 131072 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.857549] Initialise system t=
rusted
> > >keyring
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.857575] audit: initializing=
 netlink
> > >subsys (disabled)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.857595] audit: type=3D2000
> > >audit(1416730934.848:1): initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.858023] HugeTLB registered =
2 MB
> > >page size, pre-allocated 0 pages
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.859936] zpool: loaded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.859940] zbud: loaded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.860207] VFS: Disk quotas
> > >dquot_6.5.2
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.860250] Dquot-cache hash ta=
ble
> > >entries: 512 (order 0, 4096 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.860911] fuse init (API vers=
ion
> > >7.23)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.861039] msgmni has been set=
 to
> > >15756
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.861115] Key type big_key re=
gistered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.861963] Key type asymmetric
> > >registered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.861966] Asymmetric key pars=
er
> > >'x509' registered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862012] Block layer SCSI ge=
neric
> > >(bsg) driver version 0.4 loaded (major 252)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862083] io scheduler noop
> > >registered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862087] io scheduler deadli=
ne
> > >registered (default)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862125] io scheduler cfq re=
gistered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862231] pci_hotplug: PCI Ho=
t Plug
> > >PCI Core version: 0.5
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862251] pciehp: PCI Express=
 Hot
> > >Plug Controller Driver version: 0.4
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862320] efifb: probing for =
efifb
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862348] efifb: framebuffer =
at
> > >0xa0000000, mapped to 0xffffc90010f00000, using 8128k, total 8128k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862350] efifb: mode is
> > >1920x1080x32, linelength=3D7680, pages=3D1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862351] efifb: scrolling: r=
edraw
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.862353] efifb: Truecolor:
> > >size=3D8:8:8:8, shift=3D24:16:8:0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.868191] Console: switching =
to
> > >colour frame buffer device 240x67
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.873926] fb0: EFI VGA frame =
buffer
> > >device
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.873952] intel_idle: MWAIT
> > >substates: 0x11142120
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.873953] intel_idle: v0.4 mo=
del 0x45
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.873955] intel_idle:
> > >lapic_timer_reliable_states 0xffffffff
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.874364] ACPI: AC Adapter [A=
DP1]
> > >(on-line)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.874479] input: Power Button=
 as
> > >/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.874484] ACPI: Power Button =
[PWRB]
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.875678] thermal LNXTHERM:00=
:
> > >registered as thermal_zone0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.875681] ACPI: Thermal Zone =
[TZ01]
> > >(45 C)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.876365] thermal LNXTHERM:01=
:
> > >registered as thermal_zone1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.876367] ACPI: Thermal Zone =
[TZ02]
> > >(36 C)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.876414] GHES: HEST is not e=
nabled!
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.876574] Serial: 8250/16550 =
driver,
> > >32 ports, IRQ sharing enabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.881479] Linux agpgart inter=
face
> > >v0.103
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.883472] brd: module loaded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.884535] loop: module loaded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.884814] libphy: Fixed MDIO =
Bus:
> > >probed
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.884817] tun: Universal TUN/=
TAP
> > >device driver, 1.6
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.884818] tun: (C) 1999-2004 =
Max
> > >Krasnyansky <maxk-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.884889] PPP generic driver =
version
> > >2.4.2
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885083] xhci_hcd 0000:00:14=
=2E0: xHCI
> > >Host Controller
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885090] xhci_hcd 0000:00:14=
=2E0: new
> > >USB bus registered, assigned bus number 1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885245] xhci_hcd 0000:00:14=
=2E0:
> > >cache line size of 64 is not supported
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885275] xhci_hcd 0000:00:14=
=2E0: irq
> > >40 for MSI/MSI-X
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885380] usb usb1: New USB d=
evice
> > >found, idVendor=3D1d6b, idProduct=3D0002
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885382] usb usb1: New USB d=
evice
> > >strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885384] usb usb1: Product: =
xHCI
> > >Host Controller
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885386] usb usb1: Manufactu=
rer:
> > >Linux 3.18.0-031800rc5-generic xhci-hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885388] usb usb1: SerialNum=
ber:
> > >0000:00:14.0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885469] ACPI: Battery Slot =
[BAT1]
> > >(battery present)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885565] hub 1-0:1.0: USB hu=
b found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.885593] hub 1-0:1.0: 9 port=
s
> > >detected
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888387] xhci_hcd 0000:00:14=
=2E0: xHCI
> > >Host Controller
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888391] xhci_hcd 0000:00:14=
=2E0: new
> > >USB bus registered, assigned bus number 2
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888479] usb usb2: New USB d=
evice
> > >found, idVendor=3D1d6b, idProduct=3D0003
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888482] usb usb2: New USB d=
evice
> > >strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888484] usb usb2: Product: =
xHCI
> > >Host Controller
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888486] usb usb2: Manufactu=
rer:
> > >Linux 3.18.0-031800rc5-generic xhci-hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888488] usb usb2: SerialNum=
ber:
> > >0000:00:14.0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888634] hub 2-0:1.0: USB hu=
b found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.888650] hub 2-0:1.0: 4 port=
s
> > >detected
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889610] ehci_hcd: USB 2.0
> > >'Enhanced' Host Controller (EHCI) Driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889616] ehci-pci: EHCI PCI =
platform
> > >driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889628] ehci-platform: EHCI=
 generic
> > >platform driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889640] ohci_hcd: USB 1.1 '=
Open'
> > >Host Controller (OHCI) Driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889644] ohci-pci: OHCI PCI =
platform
> > >driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889656] ohci-platform: OHCI=
 generic
> > >platform driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889666] uhci_hcd: USB Unive=
rsal
> > >Host Controller Interface driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.889692] i8042: PNP detectio=
n
> > >disabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.895862] serio: i8042 KBD po=
rt at
> > >0x60,0x64 irq 1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.895868] serio: i8042 AUX po=
rt at
> > >0x60,0x64 irq 12
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.896067] mousedev: PS/2 mous=
e device
> > >common for all mice
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.896285] rtc_cmos 00:01: RTC=
 can
> > >wake from S4
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.896569] rtc_cmos 00:01: rtc=
 core:
> > >registered rtc_cmos as rtc0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.896626] rtc_cmos 00:01: ala=
rms up
> > >to one month, 242 bytes nvram, hpet irqs
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.896718] device-mapper: ueve=
nt:
> > >version 1.0.3
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.896834] device-mapper: ioct=
l:
> > >4.28.0-ioctl (2014-09-17) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.896855] Intel P-state drive=
r
> > >initializing.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.897008] ledtrig-cpu: regist=
ered to
> > >indicate activity on CPUs
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.897014] EFI Variables Facil=
ity
> > >v0.08 2004-May-17
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.918409] input: AT Translate=
d Set 2
> > >keyboard as /devices/platform/i8042/serio0/input/input1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.920704] TCP: cubic register=
ed
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.920781] NET: Registered pro=
tocol
> > >family 10
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.921007] NET: Registered pro=
tocol
> > >family 17
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.921019] Key type dns_resolv=
er
> > >registered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.921401] Loading compiled-in=
 X.509
> > >certificates
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.921911] Loaded X.509 cert
> > >'Magrathea: Glacier signing key: ff2048e0cad0ea3b26c272feb6526b642=
95b5e74'
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.921933] registered taskstat=
s
> > >version 1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.923324] Key type trusted re=
gistered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.924539] Key type encrypted
> > >registered
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.925682] AppArmor: AppArmor =
sha1
> > >policy hashing enabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.925686] ima: No TPM chip fo=
und,
> > >activating TPM-bypass!
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.925713] evm: HMAC attrs: 0x=
1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.925947]   Magic number: 6:4=
29:372
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.926077] rtc_cmos 00:01: set=
ting
> > >system clock to 2014-11-23 08:22:15 UTC (1416730935)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.926132] BIOS EDD facility v=
0.16
> > >2004-Jun-25, 0 devices found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.926133] EDD information not
> > >available.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.926225] PM: Hibernation ima=
ge not
> > >present or could not be loaded.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.927063] Freeing unused kern=
el
> > >memory: 1396K (ffffffff82d1b000 - ffffffff82e78000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.927064] Write protecting th=
e kernel
> > >read-only data: 12288k
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.927713] Freeing unused kern=
el
> > >memory: 300K (ffff8800027b5000 - ffff880002800000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.928268] Freeing unused kern=
el
> > >memory: 316K (ffff880002bb1000 - ffff880002c00000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.939195] systemd-udevd[115]:
> > >starting version 208
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.939651] random: systemd-ude=
vd
> > >urandom read with 5 bits of entropy available
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.950378] sdhci: Secure Digit=
al Host
> > >Controller Interface driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.950381] sdhci: Copyright(c)=
 Pierre
> > >Ossman
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.952252] sdhci-acpi INT33C6:=
00: No
> > >vmmc regulator found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.952254] sdhci-acpi INT33C6:=
00: No
> > >vqmmc regulator found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.955779] mmc0: SDHCI control=
ler on
> > >ACPI [INT33C6:00] using ADMA
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.962355] psmouse: module
> > >verification failed: signature and/or  required key missing - tain=
ting
> > >kernel
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.963391] ahci 0000:00:1f.2: =
version
> > >3.0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.963532] ahci 0000:00:1f.2: =
irq 41
> > >for MSI/MSI-X
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.963591] ahci 0000:00:1f.2: =
AHCI
> > >0001.0300 32 slots 4 ports 6 Gbps 0x1 impl SATA mode
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.963594] ahci 0000:00:1f.2: =
flags:
> > >64bit ncq pm led clo only pio slum part deso sadm sds apst
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.964101] scsi host0: ahci
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.964232] scsi host1: ahci
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.968436] scsi host2: ahci
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.968601] scsi host3: ahci
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.968671] ata1: SATA max UDMA=
/133
> > >abar m2048@0xb041d000 port 0xb041d100 irq 41
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.968673] ata2: DUMMY
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.968674] ata3: DUMMY
> > >Nov 23 08:22:17 VAIOHMH kernel: [    0.968674] ata4: DUMMY
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.021966] mmc0: queuing unkno=
wn CIS
> > >tuple 0x80 (7 bytes)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.099231] mmc0: new high spee=
d SDIO
> > >card at address 0001
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.100931] usb 2-4: new SuperS=
peed USB
> > >device number 2 using xhci_hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.196355] usb 1-1: new low-sp=
eed USB
> > >device number 2 using xhci_hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.211346] usb 2-4: New USB de=
vice
> > >found, idVendor=3D0bda, idProduct=3D58df
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.211351] usb 2-4: New USB de=
vice
> > >strings: Mfr=3D3, Product=3D1, SerialNumber=3D2
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.211353] usb 2-4: Product: R=
ear
> > >Camera
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.211355] usb 2-4: Manufactur=
er:
> > >Generic
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.211357] usb 2-4: SerialNumb=
er:
> > >200901010001
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.288323] ata1: SATA link up =
6.0 Gbps
> > >(SStatus 133 SControl 300)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.290384] ata1.00: ACPI cmd
> > >f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.290433] ata1.00: ACPI cmd
> > >ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.290800] ata1.00: failed to =
get NCQ
> > >Send/Recv Log Emask 0x1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.290804] ata1.00: ATA-9: SAM=
SUNG
> > >MZNTE256HMHP-000SO, EXT25S0Q, max UDMA/133
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.290807] ata1.00: 500118192 =
sectors,
> > >multi 16: LBA48 NCQ (depth 31/32), AA
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.291187] ata1.00: ACPI cmd
> > >f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.291231] ata1.00: ACPI cmd
> > >ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.291583] ata1.00: failed to =
get NCQ
> > >Send/Recv Log Emask 0x1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.291680] ata1.00: configured=
 for
> > >UDMA/133
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.296351] scsi 0:0:0:0: Direc=
t-Access
> > >ATA      SAMSUNG MZNTE256 5S0Q PQ: 0 ANSI: 5
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.296543] sd 0:0:0:0: [sda] 5=
00118192
> > >512-byte logical blocks: (256 GB/238 GiB)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.296583] sd 0:0:0:0: [sda] W=
rite
> > >Protect is off
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.296586] sd 0:0:0:0: [sda] M=
ode
> > >Sense: 00 3a 00 00
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.296594] sd 0:0:0:0: [sda] W=
rite
> > >cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.296623] sd 0:0:0:0: Attache=
d scsi
> > >generic sg0 type 0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.299021]  sda: sda1 sda2 sda=
3 sda4
> > >sda5 sda6 sda7 sda8 sda9
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.299733] sd 0:0:0:0: [sda] A=
ttached
> > >SCSI disk
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.329888] usb 1-1: New USB de=
vice
> > >found, idVendor=3D046d, idProduct=3Dc521
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.329894] usb 1-1: New USB de=
vice
> > >strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.329897] usb 1-1: Product: U=
SB
> > >Receiver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.329901] usb 1-1: Manufactur=
er:
> > >Logitech
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.330098] usb 1-1: ep 0x81 - =
rounding
> > >interval to 64 microframes, ep desc says 80 microframes
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.330103] usb 1-1: ep 0x82 - =
rounding
> > >interval to 64 microframes, ep desc says 80 microframes
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.336067] hidraw: raw HID eve=
nts
> > >driver (C) Jiri Kosina
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.344714] usbcore: registered=
 new
> > >interface driver usbhid
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.344717] usbhid: USB HID cor=
e driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.346962] input: Logitech USB
> > >Receiver as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003=
:046D:C521.0001/input/input4
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.347089] hid-generic
> > >0003:046D:C521.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech =
USB
> > >Receiver] on usb-0000:00:14.0-1/input0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.349517] input: Logitech USB
> > >Receiver as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003=
:046D:C521.0002/input/input5
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.349719] hid-generic
> > >0003:046D:C521.0002: input,hiddev0,hidraw1: USB HID v1.11 Device [=
Logitech
> > >USB Receiver] on usb-0000:00:14.0-1/input1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.421765] EXT4-fs (sda6): INF=
O:
> > >recovery required on readonly filesystem
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.421768] EXT4-fs (sda6): wri=
te
> > >access will be enabled during recovery
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.444187] usb 1-2: new high-s=
peed USB
> > >device number 3 using xhci_hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.481044] EXT4-fs (sda6): orp=
han
> > >cleanup on readonly fs
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.486911] EXT4-fs (sda6): 18 =
orphan
> > >inodes deleted
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.486914] EXT4-fs (sda6): rec=
overy
> > >complete
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.497574] EXT4-fs (sda6): mou=
nted
> > >filesystem with ordered data mode. Opts: (null)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.581375] usb 1-2: New USB de=
vice
> > >found, idVendor=3D0bda, idProduct=3D8178
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.581381] usb 1-2: New USB de=
vice
> > >strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.581384] usb 1-2: Product: 8=
02.11n
> > >WLAN Adapter
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.581387] usb 1-2: Manufactur=
er:
> > >Realtek
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.581388] usb 1-2: SerialNumb=
er:
> > >00e04c000001
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.623994] init:
> > >plymouth-upstart-bridge main process (186) terminated with status =
1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.624006] init:
> > >plymouth-upstart-bridge main process ended, respawning
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.625348] init:
> > >plymouth-upstart-bridge main process (200) terminated with status =
1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.625355] init:
> > >plymouth-upstart-bridge main process ended, respawning
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.626994] init:
> > >plymouth-upstart-bridge main process (202) terminated with status =
1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.627006] init:
> > >plymouth-upstart-bridge main process ended, respawning
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.737378] EXT4-fs (sda6): re-=
mounted.
> > >Opts: discard,errors=3Dremount-ro
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.748013] usb 1-3: new high-s=
peed USB
> > >device number 4 using xhci_hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.855925] tsc: Refined TSC
> > >clocksource calibration: 2294.688 MHz
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.870841] systemd-udevd[368]:
> > >starting version 208
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.895105] random: nonblocking=
 pool is
> > >initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.941508] lp: driver loaded b=
ut no
> > >devices found
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.952042] usb 1-3: New USB de=
vice
> > >found, idVendor=3D0bda, idProduct=3D5722
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.952046] usb 1-3: New USB de=
vice
> > >strings: Mfr=3D3, Product=3D1, SerialNumber=3D2
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.952049] usb 1-3: Product: F=
ront
> > >Camera
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.952051] usb 1-3: Manufactur=
er:
> > >1458700210EP61K8
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.952052] usb 1-3: SerialNumb=
er:
> > >200901010001
> > >Nov 23 08:22:17 VAIOHMH kernel: [    1.961707] ppdev: user-space p=
arallel
> > >port driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.067812] usb 1-4: new high-s=
peed USB
> > >device number 5 using xhci_hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.108910] dw-apb-uart INT33C5=
:00:
> > >ttyS4 at MMIO 0xb0420000 (irq =3D 13, base_baud =3D 6250000) is a =
16550A
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.143985] input: Sony Vaio Ke=
ys as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/SNY5001:00/=
input/input6
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.144151] input: Sony Vaio Jo=
gdial as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/SNY5001:=
00/input/input7
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.144901] dw_dmac INTL9C60:00=
:
> > >DesignWare DMA Controller, 8 channels
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.147426] sony_laptop: bright=
ness
> > >ignored, must be controlled by ACPI video driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.147436] sony_laptop: SNC se=
tup
> > >done.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.191016] [drm] Initialized d=
rm 1.1.0
> > >20060810
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.206568] usb 1-4: New USB de=
vice
> > >found, idVendor=3D12d1, idProduct=3D1573
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.206571] usb 1-4: New USB de=
vice
> > >strings: Mfr=3D2, Product=3D3, SerialNumber=3D4
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.206573] usb 1-4: Product: H=
UAWEI
> > >Mobile
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.206574] usb 1-4: Manufactur=
er:
> > >HUAWEI Technology
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.206575] usb 1-4: SerialNumb=
er:
> > >0123456789ABCDEF
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.233309] EXT4-fs (sda7): mou=
nted
> > >filesystem with ordered data mode. Opts: (null)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.259910] mei_me 0000:00:16.0=
: irq 42
> > >for MSI/MSI-X
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.267282] [drm] Memory usable=
 by
> > >graphics device =3D 2048M
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.267285] [drm] Replacing VGA=
 console
> > >driver
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.267289] checking generic (a=
0000000
> > >7f0000) vs hw (a0000000 10000000)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.267291] fb: switching to in=
teldrmfb
> > >from EFI VGA
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.267312] Console: switching =
to
> > >colour dummy device 80x25
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.282797] mei_me 0000:00:16.0=
: NFC
> > >MEI VERSION: IVN 0x1 Vendor ID 0x1 Type 0x1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.295906] FS-Cache: Loaded
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.310062] RPC: Registered nam=
ed UNIX
> > >socket transport module.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.310066] RPC: Registered udp
> > >transport module.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.310071] RPC: Registered tcp
> > >transport module.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.310072] RPC: Registered tcp=
 NFSv4.1
> > >backchannel transport module.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.316363] i915 0000:00:02.0: =
irq 43
> > >for MSI/MSI-X
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.316638] [drm] Supports vbla=
nk
> > >timestamp caching Rev 2 (21.10.2013).
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.316640] [drm] Driver suppor=
ts
> > >precise vblank timestamp query.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.317118] vgaarb: device chan=
ged
> > >decodes: PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dio+mem:own=
s=3Dio+mem
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.333793] FS-Cache: Netfs 'nf=
s'
> > >registered for caching
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.355879] Installing knfsd (c=
opyright
> > >(C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.385801] fbcon: inteldrmfb (=
fb0) is
> > >primary device
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.405196] init: patchram pre-=
start
> > >process (551) terminated with status 1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.423731] usb 1-8: new high-s=
peed USB
> > >device number 6 using xhci_hcd
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.425241] ACPI: Video Device =
[GFX0]
> > >(multi-head: yes  rom: no  post: no)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.425312] input: Video Bus as
> > >/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/inpu=
t8
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.425424] [drm] Initialized i=
915
> > >1.6.0 20140905 for 0000:00:02.0 on minor 0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.425474] init: idmapd main p=
rocess
> > >(575) terminated with status 1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.425483] init: idmapd main p=
rocess
> > >ended, respawning
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.425560] snd_hda_intel 0000:=
00:03.0:
> > >irq 44 for MSI/MSI-X
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.425805] snd_hda_intel 0000:=
00:1b.0:
> > >irq 45 for MSI/MSI-X
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.440414] input: HDA Intel HD=
MI
> > >HDMI/DP,pcm=3D3 as /devices/pci0000:00/0000:00:03.0/sound/card0/in=
put9
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.448307] media: Linux media
> > >interface: v0.10
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.451946] sound hdaudioC1D0: =
ALC282:
> > >SKU not ready 0x411111f0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.452653] sound hdaudioC1D0:
> > >autoconfig: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.452655] sound hdaudioC1D0:
> > >speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.452656] sound hdaudioC1D0:
> > >hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.452657] sound hdaudioC1D0: =
   mono:
> > >mono_out=3D0x0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.452657] sound hdaudioC1D0:
> > >inputs:
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.452659] sound hdaudioC1D0:
> > >Mic=3D0x18
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.452660] sound hdaudioC1D0:
> > >Internal Mic=3D0x12
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Bluetooth daemon 4.101
> > >Nov 23 08:22:17 VAIOHMH rsyslogd-2039: Could no open output pipe
> > >'/dev/xconsole': No such file or directory [try
> > >http://www.rsyslog.com/e/2039 ]
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Starting SDP server
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: Found user 'avahi' (UID=
 111)
> > >and group 'avahi' (GID 117).
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: Successfully dropped ro=
ot
> > >privileges.
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: avahi-daemon 0.6.31 sta=
rting
> > >up.
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: Successfully called chr=
oot().
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: Successfully dropped re=
maining
> > >capabilities.
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: DIS cannot start: GATT is
> > >disabled
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Failed to init deviceinfo=
 plugin
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Failed to init proximity =
plugin
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Failed to init time plugi=
n
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Failed to init alert plug=
in
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Failed to init thermomete=
r plugin
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: No service file found i=
n
> > >/etc/avahi/services.
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: Network interface enume=
ration
> > >completed.
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: Registering HINFO recor=
d with
> > >values 'X86_64'/'LINUX'.
> > >Nov 23 08:22:17 VAIOHMH avahi-daemon[609]: Server startup complete=
=2E Host
> > >name is VAIOHMH.local. Local service cookie is 3378907154.
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Failed to init gatt_examp=
le
> > >plugin
> > >Nov 23 08:22:17 VAIOHMH bluetoothd[593]: Bluetooth Management inte=
rface
> > >initialized
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: checking bus 1, device 2:
> > >"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1"
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: bus: 1, device: 2 was not an MT=
P device
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: checking bus 1, device 3:
> > >"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-2"
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: bus: 1, device: 3 was not an MT=
P device
> > >Nov 23 08:22:17 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.ColorManager' (using servicehelper)
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: checking bus 1, device 4:
> > >"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-3"
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: bus: 1, device: 4 was not an MT=
P device
> > >Nov 23 08:22:17 VAIOHMH colord: Using mapping database file
> > >/var/lib/colord/mapping.db
> > >Nov 23 08:22:17 VAIOHMH colord: Using device database file
> > >/var/lib/colord/storage.db
> > >Nov 23 08:22:17 VAIOHMH colord: Using profile database file
> > >/var/lib/colord/storage.db
> > >Nov 23 08:22:17 VAIOHMH colord: loaded plugin libcd_plugin_scanner=
=2Eso
> > >Nov 23 08:22:17 VAIOHMH colord: loaded plugin libcd_plugin_sane.so
> > >Nov 23 08:22:17 VAIOHMH colord: loaded plugin libcd_plugin_camera.=
so
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: checking bus 1, device 5:
> > >"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4"
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: checking bus 1, device 6:
> > >"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-8"
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: bus: 1, device: 6 was not an MT=
P device
> > >Nov 23 08:22:17 VAIOHMH colord: Daemon ready for requests
> > >Nov 23 08:22:17 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.ColorManager'
> > >Nov 23 08:22:17 VAIOHMH mtp-probe: bus: 1, device: 5 was not an MT=
P device
> > >Nov 23 08:22:17 VAIOHMH colord: Profile added:
> > >Hewlett-Packard-HP-LaserJet-P2055dn-Gray..
> > >Nov 23 08:22:17 VAIOHMH colord: Device added:
> > >cups-Hewlett-Packard-HP-LaserJet-P2055dn
> > >Nov 23 08:22:17 VAIOHMH colord: Profile added: HP-LaserJet-1320-Gr=
ay..
> > >Nov 23 08:22:17 VAIOHMH colord: Device added: cups-HP-LaserJet-132=
0
> > >Nov 23 08:22:17 VAIOHMH colord: Profile added: RICOH-Aficio-MP-C30=
0-Gray..
> > >Nov 23 08:22:17 VAIOHMH colord: Profile added: RICOH-Aficio-MP-C30=
0-CMYK..
> > >Nov 23 08:22:17 VAIOHMH colord: Device added: cups-RICOH-Aficio-MP=
-C300
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.463505] Linux video capture
> > >interface: v2.00
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.474791] input: HDA Intel PC=
H Mic as
> > >/devices/pci0000:00/0000:00:1b.0/sound/card1/input10
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.474903] input: HDA Intel PC=
H
> > >Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input11
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.493411] Bluetooth: Core ver=
 2.19
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.493427] NET: Registered pro=
tocol
> > >family 31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.493428] Bluetooth: HCI devi=
ce and
> > >connection manager initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.493437] Bluetooth: HCI sock=
et layer
> > >initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.493438] Bluetooth: L2CAP so=
cket
> > >layer initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.493445] Bluetooth: SCO sock=
et layer
> > >initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.510935] uvcvideo: Found UVC=
 1.00
> > >device Rear Camera (0bda:58df)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.520957] input: Rear Camera =
as
> > >/devices/pci0000:00/0000:00:14.0/usb2/2-4/2-4:1.0/input/input12
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.521486] uvcvideo: Found UVC=
 1.00
> > >device Front Camera (0bda:5722)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.524986] Bluetooth: BNEP (Et=
hernet
> > >Emulation) ver 1.3
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.524987] Bluetooth: BNEP fil=
ters:
> > >protocol multicast
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.524994] Bluetooth: BNEP soc=
ket
> > >layer initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.531845] input: Front Camera=
 as
> > >/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/input/input13
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.533375] usbcore: registered=
 new
> > >interface driver uvcvideo
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.533376] USB Video Class dri=
ver
> > >(1.1.1)
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.534277] Bluetooth: RFCOMM T=
TY layer
> > >initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.534286] Bluetooth: RFCOMM s=
ocket
> > >layer initialized
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.534293] Bluetooth: RFCOMM v=
er 1.11
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.535490] init: avahi-cups-re=
load
> > >main process (612) terminated with status 1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.616406] usb 1-8: New USB de=
vice
> > >found, idVendor=3D0bda, idProduct=3D0176
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.616408] usb 1-8: New USB de=
vice
> > >strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.616409] usb 1-8: Product:
> > >USB2.0-CRW
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.616410] usb 1-8: Manufactur=
er:
> > >Generic
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.616411] usb 1-8: SerialNumb=
er:
> > >20120926571200000
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.819667] audit: type=3D1400
> > >audit(1416727337.394:2): apparmor=3D"STATUS" operation=3D"profile_=
load"
> > >name=3D"/usr/lib/cups/backend/cups-pdf" pid=3D589 comm=3D"apparmor=
_parser"
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.820029] audit: type=3D1400
> > >audit(1416727337.394:3): apparmor=3D"STATUS" operation=3D"profile_=
load"
> > >name=3D"/usr/sbin/cupsd" pid=3D589 comm=3D"apparmor_parser"
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.820114] audit: type=3D1400
> > >audit(1416727337.394:4): apparmor=3D"STATUS" operation=3D"profile_=
load"
> > >name=3D"third_party" pid=3D589 comm=3D"apparmor_parser"
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.829635] AVX2 version of gcm=
_enc/dec
> > >engaged.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.829636] AES CTR mode by8
> > >optimization enabled
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.875362] Switched to clockso=
urce tsc
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.897907] kvm: disabled by bi=
os
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.910523] intel_rapl: Found R=
APL
> > >domain package
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.910524] intel_rapl: Found R=
APL
> > >domain core
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.910525] intel_rapl: Found R=
APL
> > >domain uncore
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.910526] intel_rapl: Found R=
APL
> > >domain dram
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.925483] nfc: nfc_init: NFC =
Core ver
> > >0.1
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.925502] NET: Registered pro=
tocol
> > >family 39
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.932233] Probing NFC pn544
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.957854] usb-storage 1-8:1.0=
: USB
> > >Mass Storage device detected
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.958083] scsi host4: usb-sto=
rage
> > >1-8:1.0
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.958304] usbcore: registered=
 new
> > >interface driver usb-storage
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.960709] usbcore: registered=
 new
> > >interface driver uas
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.983284] hid-rmi
> > >0018:06CB:0001.0005: Scanning PDT...
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.985889] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:9 / ret_size:31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.988383] hid-rmi
> > >0018:06CB:0001.0005: Found F34 on page 0x00
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.989258] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:5 / ret_size:31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.992387] hid-rmi
> > >0018:06CB:0001.0005: Found F01 on page 0x00
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.993311] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:5 / ret_size:259
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.995934] hid-rmi
> > >0018:06CB:0001.0005: Found F11 on page 0x00
> > >Nov 23 08:22:17 VAIOHMH kernel: [    2.997013] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:8 / ret_size:259
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.000749] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:15 / ret_size:259
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.018703] hid-rmi
> > >0018:06CB:0001.0005: Found F54 on page 0x01
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.019544] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:4 / ret_size:31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.032554] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:63 / ret_size:31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.035138] hid-rmi
> > >0018:06CB:0001.0005: Found F55 on page 0x02
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.035962] i2c_hid i2c-NTRG0F0=
1:00:
> > >error in i2c_hid_init_report size:7 / ret_size:31
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.036102] input: NTRG0F01:00
> > >1B96:0F01 Pen as /devices/pci0000:00/INT33C3:00/i2c-1/i2c-NTRG0F01=
:00/0018:1B96:0F01.0004/input/input15
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.036328] input: NTRG0F01:00
> > >1B96:0F01 as /devices/pci0000:00/INT33C3:00/i2c-1/i2c-NTRG0F01:00/=
0018:1B96:0F01.0004/input/input16
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.036456] hid-multitouch
> > >0018:1B96:0F01.0004: input,hidraw2: <UNKNOWN> HID v1.00 Mouse [NTR=
G0F01:00
> > >1B96:0F01] on
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.043026] hid-rmi
> > >0018:06CB:0001.0005: Found F51 on page 0x03
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.046087] hid-rmi
> > >0018:06CB:0001.0005: Found F30 on page 0x03
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.053433] hid-rmi
> > >0018:06CB:0001.0005: rmi_scan_pdt: Done with PDT scan.
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.053948] usbcore: registered=
 new
> > >interface driver cdc_wdm
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.056846] qmi_wwan 1-4:1.4: c=
dc-wdm1:
> > >USB WDM device
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.057128] qmi_wwan 1-4:1.4 ww=
an0:
> > >register 'qmi_wwan' at usb-0000:00:14.0-4, WWAN/QMI device,
> > >06:58:4b:ce:ea:d5
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.057258] usbcore: registered=
 new
> > >interface driver qmi_wwan
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.070349] hid-rmi
> > >0018:06CB:0001.0005: rmi_populate_f11: size in mm: 78 x 23
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.079293] input: SONY0001:00
> > >06CB:0001 as /devices/pci0000:00/INT33C3:00/i2c-1/i2c-SONY0001:00/=
0018:06CB:0001.0005/input/input14
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.079616] hid-rmi
> > >0018:06CB:0001.0005: input,hidraw3: <UNKNOWN> HID v1.00 Pointer
> > >[SONY0001:00 06CB:0001] on
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.415080] Console: switching =
to
> > >colour frame buffer device 240x67
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.422770] i915 0000:00:02.0: =
fb0:
> > >inteldrmfb frame buffer device
> > >Nov 23 08:22:17 VAIOHMH kernel: [    3.422771] i915 0000:00:02.0:
> > >registered panic notifier
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.434488] usbcore: registered=
 new
> > >interface driver usbserial
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.434503] usbcore: registered=
 new
> > >interface driver usbserial_generic
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.434516] usbserial: USB Seri=
al
> > >support registered for generic
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.445524] ip_tables: (C) 2000=
-2006
> > >Netfilter Core Team
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.450700] usbcore: registered=
 new
> > >interface driver option
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.450719] usbserial: USB Seri=
al
> > >support registered for GSM modem (1-port)
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.450822] option 1-4:1.0: GSM=
 modem
> > >(1-port) converter detected
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.451437] usb 1-4: GSM modem =
(1-port)
> > >converter now attached to ttyUSB0
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.451456] option 1-4:1.1: GSM=
 modem
> > >(1-port) converter detected
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.451585] usb 1-4: GSM modem =
(1-port)
> > >converter now attached to ttyUSB1
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.451598] option 1-4:1.2: GSM=
 modem
> > >(1-port) converter detected
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.451720] usb 1-4: GSM modem =
(1-port)
> > >converter now attached to ttyUSB2
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.451757] option 1-4:1.5: GSM=
 modem
> > >(1-port) converter detected
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.451869] usb 1-4: GSM modem =
(1-port)
> > >converter now attached to ttyUSB3
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.472047] nf_conntrack versio=
n 0.5.0
> > >(16384 buckets, 65536 max)
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.495294] ip6_tables: (C) 200=
0-2006
> > >Netfilter Core Team
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.717531] audit: type=3D1400
> > >audit(1416727338.286:5): apparmor=3D"STATUS" operation=3D"profile_=
load"
> > >name=3D"/usr/sbin/cups-browsed" pid=3D786 comm=3D"apparmor_parser"
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.735777] usbcore: registered=
 new
> > >interface driver rtl8192cu
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.736838] rtl8192cu 1-2:1.0 w=
lan2:
> > >renamed from wlan0
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.770084] audit: type=3D1400
> > >audit(1416727338.338:6): apparmor=3D"STATUS" operation=3D"profile_=
load"
> > >name=3D"/sbin/dhclient" pid=3D746 comm=3D"apparmor_parser"
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.770226] audit: type=3D1400
> > >audit(1416727338.338:7): apparmor=3D"STATUS" operation=3D"profile_=
load"
> > >name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D746
> > >comm=3D"apparmor_parser"
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.770364] audit: type=3D1400
> > >audit(1416727338.338:8): apparmor=3D"STATUS" operation=3D"profile_=
load"
> > >name=3D"/usr/lib/connman/scripts/dhclient-script" pid=3D746
> > >comm=3D"apparmor_parser"
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.783211] systemd-udevd[709]:=
 renamed
> > >network interface wlan0 to wlan2
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.861700] audit: type=3D1400
> > >audit(1416727338.430:9): apparmor=3D"STATUS" operation=3D"profile_=
replace"
> > >name=3D"/sbin/dhclient" pid=3D874 comm=3D"apparmor_parser"
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.861708] audit: type=3D1400
> > >audit(1416727338.430:10): apparmor=3D"STATUS" operation=3D"profile=
_replace"
> > >name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D874
> > >comm=3D"apparmor_parser"
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.959537] scsi 4:0:0:0: Direc=
t-Access
> > >Generic- SD/MMC/MS PRO    1.00 PQ: 0 ANSI: 4
> > >Nov 23 08:22:18 VAIOHMH kernel: [    3.960146] sd 4:0:0:0: Attache=
d scsi
> > >generic sg1 type 0
> > >Nov 23 08:22:18 VAIOHMH failsafe: Failsafe of 120 seconds reached.
> > >Nov 23 08:22:18 VAIOHMH kernel: [    4.162269] init: samba-ad-dc m=
ain
> > >process (953) terminated with status 1
> > >Nov 23 08:22:18 VAIOHMH kernel: [    4.203953] init: failsafe main=
 process
> > >(889) killed by TERM signal
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: <info> ModemManager (v=
ersion
> > >1.2.0) starting...
> > >Nov 23 08:22:18 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.PolicyKit1' (using servicehelper)
> > >Nov 23 08:22:18 VAIOHMH polkitd[1032]: started daemon version 0.10=
5 using
> > >authority implementation `local' version `0.105'
> > >Nov 23 08:22:18 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.PolicyKit1'
> > >Nov 23 08:22:18 VAIOHMH kernel: [    4.248757] init: Failed to obt=
ain
> > >startpar-bridge instance: Unknown parameter: INSTANCE
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: <warn> (ttyUSB0): port
> > >attributes not fully set
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: <warn> (ttyUSB1): port
> > >attributes not fully set
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: <warn> (ttyUSB2): port
> > >attributes not fully set
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: <warn> (ttyUSB3): port
> > >attributes not fully set
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Openin=
g device
> > >with flags 'version-info, proxy'...
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: cannot connect to prox=
y: Could
> > >not connect: Connection refused
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: spawning new qmi-proxy=
 (try
> > >1)...
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> NetworkManage=
r
> > >(version 0.9.8.8) is starting...
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> Read config f=
ile
> > >/etc/NetworkManager/NetworkManager.conf
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> WEXT support =
is
> > >enabled
> > >Nov 23 08:22:18 VAIOHMH ntpdate[1131]: Can't find host
> > >0.ubuntu.pool.ntp.org: Name or service not known (-2)
> > >Nov 23 08:22:18 VAIOHMH ntpdate[1131]: Can't find host
> > >1.ubuntu.pool.ntp.org: Name or service not known (-2)
> > >Nov 23 08:22:18 VAIOHMH ntpdate[1131]: Can't find host
> > >2.ubuntu.pool.ntp.org: Name or service not known (-2)
> > >Nov 23 08:22:18 VAIOHMH ntpdate[1131]: Can't find host
> > >3.ubuntu.pool.ntp.org: Name or service not known (-2)
> > >Nov 23 08:22:18 VAIOHMH ntpdate[1131]: Can't find host ntp.ubuntu.=
com:
> > >Name or service not known (-2)
> > >Nov 23 08:22:18 VAIOHMH ntpdate[1131]: no servers can be used, exi=
ting
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> VPN: loaded
> > >org.freedesktop.NetworkManager.openvpn
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> VPN: loaded
> > >org.freedesktop.NetworkManager.pptp
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> VPN: loaded
> > >org.freedesktop.NetworkManager.vpnc
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> DNS: loaded p=
lugin
> > >dnsmasq
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: i=
nit!
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown:
> > >update_system_hostname
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: interface-parser: pa=
rsing
> > >file /etc/network/interfaces
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: interface-parser: fi=
nished
> > >parsing file /etc/network/interfaces
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPluginIfupdown: ma=
nagement
> > >mode: unmanaged
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: d=
evices
> > >added (path:
> > >/sys/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/net/wlan2, i=
face:
> > >wlan2)
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: d=
evice
> > >added (path:
> > >/sys/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/net/wlan2, i=
face:
> > >wlan2): no ifupdown configuration found.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: d=
evices
> > >added (path:
> > >/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.4/net/wwan0, i=
face:
> > >wwan0)
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: d=
evice
> > >added (path:
> > >/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.4/net/wwan0, i=
face:
> > >wwan0): no ifupdown configuration found.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: d=
evices
> > >added (path: /sys/devices/virtual/net/lo, iface: lo)
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: d=
evice
> > >added (path: /sys/devices/virtual/net/lo, iface: lo): no ifupdown
> > >configuration found.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown: e=
nd
> > >_init.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> Loaded plugin
> > >ifupdown: (C) 2008 Canonical Ltd.  To report bugs please use the
> > >NetworkManager mailing list.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> Loaded plugin
> > >keyfile: (c) 2007 - 2010 Red Hat, Inc.  To report bugs please use =
the
> > >NetworkManager mailing list.
> > >Nov 23 08:22:18 VAIOHMH ntpd[1176]: ntpd 4.2.6p5@1.2349-o Wed Oct =
 9
> > >19:08:06 UTC 2013 (1)
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    SCPlugin-Ofono: A=
cquired
> > >D-Bus service com.canonical.NMOfono
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    SCPlugin-Ofono: i=
nit!
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    SCPlugin-Ofono: e=
nd
> > >_init.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: <info> Loaded plugin=
 (null):
> > >(null)
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    Ifupdown: get unm=
anaged
> > >devices count: 0
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown:
> > >(11661072) ... get_connections.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]: SCPlugin-Ifupdown:
> > >(11661072) ... get_connections (managed=3Dfalse): return empty lis=
t.
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
HNET ...
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: proto: precision =3D 0.116 use=
c
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: ntp_io: estimated max descript=
ors:
> > >1024, initial socket boundary: 16
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Listen and drop on 0 v4wildcar=
d
> > >0.0.0.0 UDP 123
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Checki=
ng
> > >version info (10 retries)...
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Listen and drop on 1 v6wildcar=
d :: UDP
> > >123
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Listen normally on 2 lo 127.0.=
0.1 UDP
> > >123
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Listen normally on 3 lo ::1 UD=
P 123
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: peers refreshed
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Listening on routing socket on=
 fd #20
> > >for interface updates
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Deferring DNS for
> > >0.ubuntu.pool.ntp.org 1
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Deferring DNS for
> > >1.ubuntu.pool.ntp.org 1
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Deferring DNS for
> > >2.ubuntu.pool.ntp.org 1
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Deferring DNS for
> > >3.ubuntu.pool.ntp.org 1
> > >Nov 23 08:22:18 VAIOHMH ntpd[1178]: Deferring DNS for ntp.ubuntu.c=
om 1
> > >Nov 23 08:22:18 VAIOHMH ntpd[1181]: signal_no_reset: signal 17 had=
 flags
> > >4000000
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'HNET'
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >3ComDaJuFlo 2 ...
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'3ComDaJuFlo 2'
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >WIFI-SCHWEIZERHOF 1 ...
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'WIFI-SCHWEIZERHOF 1'
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
yantra-r
> > >...
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] QMI De=
vice
> > >supports 27 services:
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] ctl (1=
=2E5)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] wds (1=
=2E23)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] dms (1=
=2E13)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] nas (1=
=2E25)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] qos (1=
=2E3)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] wms (1=
=2E10)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] auth (=
1.2)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] at (1.=
2)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] voice =
(2.1)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] cat2 (=
2.11)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] uim (1=
=2E23)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] pbm (1=
=2E4)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] test (=
1.0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] loc (2=
=2E0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] sar (1=
=2E0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] ims (1=
=2E0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] ts (1.=
0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] tmd (1=
=2E0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] wda (1=
=2E3)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] csvt (=
1.0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] imsp (=
1.0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] imsvt =
(1.0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] imsa (=
1.0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] coex (=
1.0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] pdc (1=
=2E0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] unknow=
n [0xe3]
> > >(0.0)
> > >Nov 23 08:22:18 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] unknow=
n [0xe5]
> > >(0.0)
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'yantra-r'
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >Kempinski HGA ...
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'Kempinski HGA'
> > >Nov 23 08:22:18 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >MONTAUBERT ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'MONTAUBERT'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >Livebox-b88c ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'Livebox-b88c'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
Nessebar
> > >Resort Palace  ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'Nessebar Resort Palace '
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >WIFI-SCHWEIZERHOF ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'WIFI-SCHWEIZERHOF'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
JFR 2014
> > >...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'JFR 2014'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
yantra-2
> > >...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'yantra-2'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >Princess-fl.3-1 ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'Princess-fl.3-1'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
AS ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'AS'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
Hopital
> > >...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: keyfile: ipv4.addres=
s1:
> > >address 172.27.50.10/24 gateway 172.27.50.1
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'Hopital'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
HNET 1
> > >...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'HNET 1'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >MPH-level11-south ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'MPH-level11-south'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >BellaTolla ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'BellaTolla'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing =
maison
> > >...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'maison'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >3ComDaJuFlo 1 ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'3ComDaJuFlo 1'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >3ComDaJuFlo ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'3ComDaJuFlo'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >xqy-88207 ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'xqy-88207'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >Hotel_Bedford ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'Hotel_Bedford'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: parsing
> > >UPC245509453 ...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    keyfile: read con=
nection
> > >'UPC245509453'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    SCPlugin-Ofono:
> > >(11467120) ... get_connections.
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    SCPlugin-Ofono:
> > >(11467120) connections count: 0
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]:    Ifupdown: get unm=
anaged
> > >devices count: 0
> > >Nov 23 08:22:19 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.login1' (using servicehelper)
> > >Nov 23 08:22:19 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.systemd1' (using servicehelper)
> > >Nov 23 08:22:19 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.systemd1'
> > >Nov 23 08:22:19 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.login1'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> monitoring ke=
rnel
> > >firmware directory '/lib/firmware'.
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> WiFi enabled =
by radio
> > >killswitch; enabled by state file
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> WWAN enabled =
by radio
> > >killswitch; disabled by state file
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> WiMAX enabled=
 by
> > >radio killswitch; enabled by state file
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> Networking is=
 enabled
> > >by state file
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <warn> failed to all=
ocate
> > >link cache: (-26) Protocol mismatch
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.656256] cfg80211: Calling C=
RDA to
> > >update world regulatory domain
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): driv=
er
> > >supports SSID scans (scan_capa 0x3F).
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): usin=
g WEXT
> > >for WiFi device control
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): new =
802.11
> > >WiFi device (driver: 'rtl8192cu' ifindex: 3)
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): expo=
rted as
> > >/org/freedesktop/NetworkManager/Devices/0
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: unmanaged -> unavailable (reason 'managed') [10 20 2]
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): brin=
ging up
> > >device.
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674560] cfg80211: World reg=
ulatory
> > >domain updated:
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674565] cfg80211:  DFS Mast=
er
> > >region: unset
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674567] cfg80211: (start_fr=
eq -
> > >end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time=
)
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674570] cfg80211: (2402000 =
KHz -
> > >2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674572] cfg80211: (2457000 =
KHz -
> > >2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674574] cfg80211: (2474000 =
KHz -
> > >2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm), (N/A)
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674576] cfg80211: (5170000 =
KHz -
> > >5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.674578] cfg80211: (5735000 =
KHz -
> > >5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.687603] sd 4:0:0:0: [sdb] 6=
2333952
> > >512-byte logical blocks: (31.9 GB/29.7 GiB)
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.687957] sd 4:0:0:0: [sdb] W=
rite
> > >Protect is off
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.687959] sd 4:0:0:0: [sdb] M=
ode
> > >Sense: 2f 00 00 00
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.688248] sd 4:0:0:0: [sdb] W=
rite
> > >cache: disabled, read cache: enabled, doesn't support DPO or FUA
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.690948]  sdb: sdb1
> > >Nov 23 08:22:19 VAIOHMH kernel: [    4.692005] sd 4:0:0:0: [sdb] A=
ttached
> > >SCSI removable disk
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): prep=
aring
> > >device.
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): deac=
tivating
> > >device (reason 'managed') [2]
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): taki=
ng down
> > >device.
> > >Nov 23 08:22:19 VAIOHMH kernel: [    5.095935] IPv6: ADDRCONF(NETD=
EV_UP):
> > >wlan2: link is not ready
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): brin=
ging up
> > >device.
> > >Nov 23 08:22:19 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'fi.w1.wpa_supplicant1' (using servicehelper)
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <warn>
> > >/sys/devices/virtual/net/lo: couldn't determine device driver; ign=
oring...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <warn>
> > >/sys/devices/virtual/net/lo: couldn't determine device driver; ign=
oring...
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> urfkill disap=
peared
> > >from the bus
> > >Nov 23 08:22:19 VAIOHMH kernel: [    5.099230] IPv6: ADDRCONF(NETD=
EV_UP):
> > >wlan2: link is not ready
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> ModemManager
> > >available in the bus
> > >Nov 23 08:22:19 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'fi.w1.wpa_supplicant1'
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> wpa_supplican=
t
> > >started
> > >Nov 23 08:22:19 VAIOHMH wpa_supplicant[1272]: Successfully initial=
ized
> > >wpa_supplicant
> > >Nov 23 08:22:19 VAIOHMH wpa_supplicant[1273]: nl80211: Driver does=
 not
> > >support authentication/association or connect commands
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2) suppo=
rts 1
> > >scan SSIDs
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <warn> Trying to rem=
ove a
> > >non-existant call id.
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): supp=
licant
> > >interface state: starting -> ready
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: unavailable -> disconnected (reason 'supplicant-available'=
) [20 30
> > >42]
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): supp=
licant
> > >interface state: ready -> disconnected
> > >Nov 23 08:22:19 VAIOHMH NetworkManager[1094]: <info> (wlan2) suppo=
rts 1
> > >scan SSIDs
> > >Nov 23 08:22:20 VAIOHMH ModemManager[1002]: <warn> Couldn't find s=
upport
> > >for device at '/sys/devices/pci0000:00/0000:00:14.0/usb1/1-2': not
> > >supported by any plugin
> > >Nov 23 08:22:20 VAIOHMH ntpd_intres[1181]: host name not found:
> > >0.ubuntu.pool.ntp.org
> > >Nov 23 08:22:20 VAIOHMH ntpd_intres[1181]: host name not found:
> > >1.ubuntu.pool.ntp.org
> > >Nov 23 08:22:20 VAIOHMH ntpd_intres[1181]: host name not found:
> > >2.ubuntu.pool.ntp.org
> > >Nov 23 08:22:20 VAIOHMH ntpd_intres[1181]: host name not found:
> > >3.ubuntu.pool.ntp.org
> > >Nov 23 08:22:20 VAIOHMH ntpd_intres[1181]: host name not found:
> > >ntp.ubuntu.com
> > >Nov 23 08:22:21 VAIOHMH NetworkManager[1094]: <info> (wlan2): supp=
licant
> > >interface state: disconnected -> inactive
> > >Nov 23 08:22:21 VAIOHMH kernel: [    6.795529] audit_printk_skb: 3=
6
> > >callbacks suppressed
> > >Nov 23 08:22:21 VAIOHMH kernel: [    6.795532] audit: type=3D1400
> > >audit(1416727341.366:23): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"/usr/bin/evince" pid=3D1144 comm=3D"apparmor_parser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    6.795810] audit: type=3D1400
> > >audit(1416727341.366:24): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"sanitized_helper" pid=3D1144 comm=3D"apparmor_parser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    6.796178] audit: type=3D1400
> > >audit(1416727341.366:25): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"/usr/bin/evince-previewer" pid=3D1144 comm=3D"apparmor_par=
ser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    6.796299] audit: type=3D1400
> > >audit(1416727341.366:26): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"sanitized_helper" pid=3D1144 comm=3D"apparmor_parser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    6.796616] audit: type=3D1400
> > >audit(1416727341.366:27): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"/usr/bin/evince-thumbnailer" pid=3D1144 comm=3D"apparmor_p=
arser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    6.796724] audit: type=3D1400
> > >audit(1416727341.366:28): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"sanitized_helper" pid=3D1144 comm=3D"apparmor_parser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    7.187710] audit: type=3D1400
> > >audit(1416727341.758:29): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"/usr/lib/telepathy/mission-control-5" pid=3D1144
> > >comm=3D"apparmor_parser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    7.187911] audit: type=3D1400
> > >audit(1416727341.758:30): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"/usr/lib/telepathy/telepathy-*" pid=3D1144 comm=3D"apparmo=
r_parser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    7.188060] audit: type=3D1400
> > >audit(1416727341.758:31): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"pxgsettings" pid=3D1144 comm=3D"apparmor_parser"
> > >Nov 23 08:22:21 VAIOHMH kernel: [    7.188130] audit: type=3D1400
> > >audit(1416727341.758:32): apparmor=3D"STATUS" operation=3D"profile=
_load"
> > >name=3D"sanitized_helper" pid=3D1144 comm=3D"apparmor_parser"
> > >Nov 23 08:22:22 VAIOHMH cron[1476]: (CRON) INFO (pidfile fd =3D 3)
> > >Nov 23 08:22:22 VAIOHMH cron[1494]: (CRON) STARTUP (fork ok)
> > >Nov 23 08:22:22 VAIOHMH cron[1494]: (CRON) INFO (Running @reboot j=
obs)
> > >Nov 23 08:22:22 VAIOHMH anacron[1495]: Anacron 2.3 started on 2014=
-11-23
> > >Nov 23 08:22:22 VAIOHMH anacron[1495]: Normal exit (0 jobs run)
> > >Nov 23 08:22:22 VAIOHMH kernel: [    7.670467] init: alsa-restore =
main
> > >process (1541) terminated with status 99
> > >Nov 23 08:22:22 VAIOHMH kernel: [    7.723390] init: kdm main proc=
ess
> > >(1484) killed by TERM signal
> > >Nov 23 08:22:22 VAIOHMH cntlm: Starting cntlm version 0.92.3 for L=
ITTLE
> > >endian
> > >Nov 23 08:22:22 VAIOHMH cntlm: Proxy listening on 127.0.0.1:5865
> > >Nov 23 08:22:22 VAIOHMH cntlm: Workstation name used: VAIOHMH
> > >Nov 23 08:22:22 VAIOHMH cntlm: Using following NTLM hashes: NTLMv2=
(1)
> > >NT(0) LM(0)
> > >Nov 23 08:22:22 VAIOHMH cntlm[1736]: Daemon ready
> > >Nov 23 08:22:22 VAIOHMH cntlm[1736]: Changing uid:gid to 119:65534=
 -
> > >Success
> > >Nov 23 08:22:22 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.Accounts' (using servicehelper)
> > >Nov 23 08:22:22 VAIOHMH accounts-daemon[1756]: started daemon vers=
ion
> > >0.6.37
> > >Nov 23 08:22:22 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.Accounts'
> > >Nov 23 08:22:22 VAIOHMH acpid: starting up with netlink and the in=
put
> > >layer
> > >Nov 23 08:22:22 VAIOHMH ModemManager[1002]: <warn> (ttyUSB1): port
> > >attributes not fully set
> > >Nov 23 08:22:22 VAIOHMH ModemManager[1002]: <warn> (ttyUSB2): port
> > >attributes not fully set
> > >Nov 23 08:22:22 VAIOHMH ModemManager[1002]: <warn> (ttyUSB3): port
> > >attributes not fully set
> > >Nov 23 08:22:22 VAIOHMH acpid: 9 rules loaded
> > >Nov 23 08:22:22 VAIOHMH acpid: waiting for events: event logging i=
s off
> > >Nov 23 08:22:22 VAIOHMH kernel: [    8.037597] NFSD: Using
> > >/var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> > >Nov 23 08:22:22 VAIOHMH kernel: [    8.037728] NFSD: starting 90-s=
econd
> > >grace period (net ffffffff82cd1480)
> > >Nov 23 08:22:22 VAIOHMH rpc.mountd[1962]: Version 1.2.8 starting
> > >Nov 23 08:22:22 VAIOHMH kernel: [    8.190813] init:
> > >plymouth-upstart-bridge main process ended, respawning
> > >Nov 23 08:22:22 VAIOHMH kernel: [    8.198076] init:
> > >plymouth-upstart-bridge main process (2007) terminated with status=
 1
> > >Nov 23 08:22:23 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.RealtimeKit1' (using servicehelper)
> > >Nov 23 08:22:23 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.RealtimeKit1'
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully called ch=
root.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully dropped
> > >privileges.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully limited
> > >resources.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Running.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Watchdog thread runnin=
g.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Canary thread running.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2141
> > >of process 2141 (n/a) owned by '112' high priority at nice level -=
11.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Supervising 1 threads =
of 1
> > >processes of 1 users.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2155
> > >of process 2141 (n/a) owned by '112' RT at priority 5.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Supervising 2 threads =
of 1
> > >processes of 1 users.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2166
> > >of process 2141 (n/a) owned by '112' RT at priority 5.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Supervising 3 threads =
of 1
> > >processes of 1 users.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2167
> > >of process 2141 (n/a) owned by '112' RT at priority 5.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Supervising 4 threads =
of 1
> > >processes of 1 users.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2169
> > >of process 2169 (n/a) owned by '112' high priority at nice level -=
11.
> > >Nov 23 08:22:23 VAIOHMH rtkit-daemon[2143]: Supervising 5 threads =
of 2
> > >processes of 1 users.
> > >Nov 23 08:22:23 VAIOHMH pulseaudio[2169]: [pulseaudio] pid.c: Daem=
on
> > >already running.
> > >Nov 23 08:22:23 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.UPower' (using servicehelper)
> > >Nov 23 08:22:23 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.UPower'
> > >Nov 23 08:22:23 VAIOHMH colord: Device added: xrandr-Panasonic Ind=
ustry
> > >Company-VVY13F001G00
> > >Nov 23 08:22:23 VAIOHMH anacron[2334]: Anacron 2.3 started on 2014=
-11-23
> > >Nov 23 08:22:23 VAIOHMH anacron[2334]: Normal exit (0 jobs run)
> > >Nov 23 08:22:23 VAIOHMH colord: Automatic metadata add
> > >icc-dc30aa6ea38e77a0087ceb172286a425 to xrandr-Panasonic Industry
> > >Company-VVY13F001G00
> > >Nov 23 08:22:23 VAIOHMH colord: Profile added:
> > >icc-dc30aa6ea38e77a0087ceb172286a425
> > >Nov 23 08:22:29 VAIOHMH NetworkManager[1094]: <info> WiFi hardware=
 radio
> > >set enabled
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: <info> Creating modem =
with
> > >plugin 'Huawei' and '6' ports
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: <warn>  Could not grab=
 port
> > >(tty/ttyUSB3): 'Cannot add port 'tty/ttyUSB3', unhandled serial ty=
pe'
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: <warn>  Could not grab=
 port
> > >(tty/ttyUSB1): 'Cannot add port 'tty/ttyUSB1', unhandled serial ty=
pe'
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: <info>  Modem for devi=
ce at
> > >'/sys/devices/pci0000:00/0000:00:14.0/usb1/1-4' successfully creat=
ed
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Openin=
g device
> > >with flags 'version-info, net-802-3, net-no-qos-header, proxy'...
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Checki=
ng
> > >version info (10 retries)...
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] QMI De=
vice
> > >supports 27 services:
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] ctl (1=
=2E5)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] wds (1=
=2E23)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] dms (1=
=2E13)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] nas (1=
=2E25)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] qos (1=
=2E3)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] wms (1=
=2E10)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] auth (=
1.2)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] at (1.=
2)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] voice =
(2.1)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] cat2 (=
2.11)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] uim (1=
=2E23)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] pbm (1=
=2E4)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] test (=
1.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] loc (2=
=2E0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] sar (1=
=2E0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] ims (1=
=2E0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] ts (1.=
0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] tmd (1=
=2E0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] wda (1=
=2E3)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] csvt (=
1.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] imsp (=
1.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] imsvt =
(1.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] imsa (=
1.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] coex (=
1.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] pdc (1=
=2E0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] unknow=
n [0xe3]
> > >(0.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] unknow=
n [0xe5]
> > >(0.0)
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Settin=
g
> > >network port data format...
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Networ=
k port
> > >data format operation finished
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Alloca=
ting new
> > >client ID...
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Regist=
ered
> > >'dms' (version 1.13) client with ID '1'
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Alloca=
ting new
> > >client ID...
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Regist=
ered
> > >'nas' (version 1.25) client with ID '1'
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Alloca=
ting new
> > >client ID...
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: [/dev/cdc-wdm1] Regist=
ered
> > >'wms' (version 1.10) client with ID '1'
> > >Nov 23 08:22:38 VAIOHMH ModemManager[1002]: <warn> (ttyUSB0): port
> > >attributes not fully set
> > >Nov 23 08:22:39 VAIOHMH ModemManager[1002]: <warn>  Modem couldn't=
 be
> > >initialized: Couldn't check unlock status: SIM failure: QMI protoc=
ol error
> > >(37): 'UimUninitialized'
> > >Nov 23 08:22:39 VAIOHMH ModemManager[1002]: <info>  Modem: state c=
hanged
> > >(unknown -> failed)
> > >Nov 23 08:22:39 VAIOHMH NetworkManager[1094]: <warn> (cdc-wdm1): u=
nusable
> > >modem detected
> > >Nov 23 08:22:56 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.systemd1' (using servicehelper)
> > >Nov 23 08:22:56 VAIOHMH colord: device removed: xrandr-Panasonic I=
ndustry
> > >Company-VVY13F001G00
> > >Nov 23 08:22:56 VAIOHMH colord: Profile removed:
> > >icc-dc30aa6ea38e77a0087ceb172286a425
> > >Nov 23 08:22:56 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.systemd1'
> > >Nov 23 08:22:59 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.UDisks2' (using servicehelper)
> > >Nov 23 08:22:59 VAIOHMH udisksd[2870]: udisks daemon version 2.1.3
> > >starting
> > >Nov 23 08:22:59 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.UDisks2'
> > >Nov 23 08:22:59 VAIOHMH udisksd[2870]: Acquired the name
> > >org.freedesktop.UDisks2 on the system message bus
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2939
> > >of process 2939 (n/a) owned by '1000' high priority at nice level =
-11.
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Supervising 5 threads =
of 2
> > >processes of 2 users.
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2941
> > >of process 2939 (n/a) owned by '1000' RT at priority 5.
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Supervising 6 threads =
of 2
> > >processes of 2 users.
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2942
> > >of process 2939 (n/a) owned by '1000' RT at priority 5.
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Supervising 7 threads =
of 2
> > >processes of 2 users.
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Successfully made thre=
ad 2943
> > >of process 2939 (n/a) owned by '1000' RT at priority 5.
> > >Nov 23 08:23:02 VAIOHMH rtkit-daemon[2143]: Supervising 8 threads =
of 2
> > >processes of 2 users.
> > >Nov 23 08:23:04 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.hostname1' (using servicehelper)
> > >Nov 23 08:23:04 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.hostname1'
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >starting connection 'UPC245509453'
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: disconnected -> prepare (reason 'none') [30 40 0]
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> NetworkManage=
r state
> > >is now CONNECTING
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 1 of 5 (Device Prepare) scheduled...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 1 of 5 (Device Prepare) started...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 2 of 5 (Device Configure) scheduled...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 1 of 5 (Device Prepare) complete.
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 2 of 5 (Device Configure) starting...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: prepare -> config (reason 'none') [40 50 0]
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation
> > >(wlan2/wireless): access point 'UPC245509453' has security, but se=
crets
> > >are required.
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: config -> need-auth (reason 'none') [50 60 0]
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 2 of 5 (Device Configure) complete.
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: get_secret_flags: as=
sertion
> > >'is_secret_prop (setting, secret_name, error)' failed
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 1 of 5 (Device Prepare) scheduled...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 1 of 5 (Device Prepare) started...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: need-auth -> prepare (reason 'none') [60 40 0]
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 2 of 5 (Device Configure) scheduled...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 1 of 5 (Device Prepare) complete.
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 2 of 5 (Device Configure) starting...
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: prepare -> config (reason 'none') [40 50 0]
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation
> > >(wlan2/wireless): connection 'UPC245509453' has security, and secr=
ets
> > >exist.  No new secrets needed.
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Config: added=
 'ssid'
> > >value 'UPC245509453'
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Config: added
> > >'scan_ssid' value '1'
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Config: added
> > >'key_mgmt' value 'WPA-PSK'
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Config: added=
 'psk'
> > >value '<omitted>'
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 2 of 5 (Device Configure) complete.
> > >Nov 23 08:23:16 VAIOHMH NetworkManager[1094]: <info> Config: set i=
nterface
> > >ap_scan to 1
> > >Nov 23 08:23:17 VAIOHMH wpa_supplicant[1273]: wlan2: Trying to ass=
ociate
> > >with bc:8c:cd:c0:b5:28 (SSID=3D'UPC245509453' freq=3D2462 MHz)
> > >Nov 23 08:23:17 VAIOHMH wpa_supplicant[1273]: wlan2: Association r=
equest
> > >to the driver failed
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> (wlan2): supp=
licant
> > >interface state: inactive -> associating
> > >Nov 23 08:23:17 VAIOHMH kernel: [   62.747660] IPv6:
> > >ADDRCONF(NETDEV_CHANGE): wlan2: link becomes ready
> > >Nov 23 08:23:17 VAIOHMH wpa_supplicant[1273]: wlan2: Associated wi=
th
> > >bc:8c:cd:c0:b5:28
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> (wlan2): supp=
licant
> > >interface state: associating -> associated
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> (wlan2): supp=
licant
> > >interface state: associated -> 4-way handshake
> > >Nov 23 08:23:17 VAIOHMH wpa_supplicant[1273]: wlan2: WPA: Key nego=
tiation
> > >completed with bc:8c:cd:c0:b5:28 [PTK=3DCCMP GTK=3DTKIP]
> > >Nov 23 08:23:17 VAIOHMH wpa_supplicant[1273]: wlan2: CTRL-EVENT-CO=
NNECTED
> > >- Connection to bc:8c:cd:c0:b5:28 completed [id=3D0 id_str=3D]
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> (wlan2): supp=
licant
> > >interface state: 4-way handshake -> completed
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> Activation
> > >(wlan2/wireless) Stage 2 of 5 (Device Configure) successful.  Conn=
ected to
> > >wireless network 'UPC245509453'.
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 3 of 5 (IP Configure Start) scheduled.
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 3 of 5 (IP Configure Start) started...
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: config -> ip-config (reason 'none') [50 70 0]
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Beginning DHCPv4 transaction (timeout in 45 seconds)
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> dhclient star=
ted with
> > >pid 3309
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Beginning IP6 addrconf.
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 3 of 5 (IP Configure Start) complete.
> > >Nov 23 08:23:17 VAIOHMH dhclient: Internet Systems Consortium DHCP=
 Client
> > >4.2.4
> > >Nov 23 08:23:17 VAIOHMH dhclient: Copyright 2004-2012 Internet Sys=
tems
> > >Consortium.
> > >Nov 23 08:23:17 VAIOHMH dhclient: All rights reserved.
> > >Nov 23 08:23:17 VAIOHMH dhclient: For info, please visit
> > >https://www.isc.org/software/dhcp/
> > >Nov 23 08:23:17 VAIOHMH dhclient:
> > >Nov 23 08:23:17 VAIOHMH NetworkManager[1094]: <info> (wlan2): DHCP=
v4 state
> > >changed nbi -> preinit
> > >Nov 23 08:23:17 VAIOHMH dhclient: Listening on LPF/wlan2/00:87:35:=
1e:01:bd
> > >Nov 23 08:23:17 VAIOHMH dhclient: Sending on LPF/wlan2/00:87:35:1e=
:01:bd
> > >Nov 23 08:23:17 VAIOHMH dhclient: Sending on   Socket/fallback
> > >Nov 23 08:23:17 VAIOHMH dhclient: DHCPREQUEST of 192.168.123.63 on=
 wlan2
> > >to 255.255.255.255 port 67 (xid=3D0x5b19949a)
> > >Nov 23 08:23:18 VAIOHMH dhclient: DHCPACK of 192.168.123.63 from
> > >192.168.123.1
> > >Nov 23 08:23:18 VAIOHMH dhclient: bound to 192.168.123.63 -- renew=
al in
> > >35224 seconds.
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> (wlan2): DHCP=
v4 state
> > >changed preinit -> reboot
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> address
> > >192.168.123.63
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> prefix 24
> > >(255.255.255.0)
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> gateway 192.1=
68.123.1
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> nameserver
> > >'192.168.123.1'
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> domain name '=
net'
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 5 of 5 (IPv4 Configure Commit) scheduled...
> > >Nov 23 08:23:18 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 5 of 5 (IPv4 Commit) started...
> > >Nov 23 08:23:18 VAIOHMH avahi-daemon[609]: Joining mDNS multicast =
group on
> > >interface wlan2.IPv4 with address 192.168.123.63.
> > >Nov 23 08:23:18 VAIOHMH avahi-daemon[609]: New relevant interface
> > >wlan2.IPv4 for mDNS.
> > >Nov 23 08:23:18 VAIOHMH avahi-daemon[609]: Registering new address=
 record
> > >for 192.168.123.63 on wlan2.IPv4.
> > >Nov 23 08:23:18 VAIOHMH kernel: [   63.602053] nf_conntrack: autom=
atic
> > >helper assignment is deprecated and it will be removed soon. Use t=
he
> > >iptables CT target to attach helpers instead.
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: ip-config -> secondaries (reason 'none') [70 90 0]
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 5 of 5 (IPv4 Commit) complete.
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <info> (wlan2): devi=
ce state
> > >change: secondaries -> activated (reason 'none') [90 100 0]
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <info> NetworkManage=
r state
> > >is now CONNECTED_GLOBAL
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <info> Policy set
> > >'UPC245509453' (wlan2) as default for IPv4 routing and DNS.
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <info> DNS: starting
> > >dnsmasq...
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <warn> dnsmasq not a=
vailable
> > >on the bus, can't update servers.
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <error> [1416727399.=
93036]
> > >[nm-dns-dnsmasq.c:396] update(): dnsmasq owner not found on bus: C=
ould not
> > >get owner of name 'org.freedesktop.NetworkManager.dnsmasq': no suc=
h name
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <warn> DNS: plugin d=
nsmasq
> > >update failed
> > >Nov 23 08:23:19 VAIOHMH NetworkManager[1094]: <info> Writing DNS
> > >information to /sbin/resolvconf
> > >Nov 23 08:23:19 VAIOHMH dnsmasq[3313]: d=E9marrage avec le cache d=
=E9sactiv=E9
> > >(version 2.71)
> > >Nov 23 08:23:19 VAIOHMH dnsmasq[3313]: options =E0 la compilation =
: IPv6
> > >GNU-getopt DBus i18n IDN DHCP DHCPv6 no-Lua TFTP conntrack ipset a=
uth
> > >DNSSEC
> > >Nov 23 08:23:19 VAIOHMH dnsmasq[3313]: Support DBus autoris=E9 : c=
onnect=E9 au
> > >bus syst=E8me
> > >Nov 23 08:23:19 VAIOHMH dnsmasq[3313]: attention : aucun serveur a=
mont
> > >n'est configur=E9
> > >Nov 23 08:23:19 VAIOHMH avahi-daemon[609]: Joining mDNS multicast =
group on
> > >interface wlan2.IPv6 with address fe80::287:35ff:fe1e:1bd.
> > >Nov 23 08:23:19 VAIOHMH avahi-daemon[609]: New relevant interface
> > >wlan2.IPv6 for mDNS.
> > >Nov 23 08:23:19 VAIOHMH avahi-daemon[609]: Registering new address=
 record
> > >for fe80::287:35ff:fe1e:1bd on wlan2.*.
> > >Nov 23 08:23:20 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >successful, device activated.
> > >Nov 23 08:23:20 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.nm_dispatcher' (using servicehelper)
> > >Nov 23 08:23:20 VAIOHMH NetworkManager[1094]: <warn> dnsmasq appea=
red on
> > >DBus: :1.79
> > >Nov 23 08:23:20 VAIOHMH NetworkManager[1094]: <info> Writing DNS
> > >information to /sbin/resolvconf
> > >Nov 23 08:23:20 VAIOHMH dnsmasq[3313]: configuration des serveurs =
amonts =E0
> > >partir de DBus
> > >Nov 23 08:23:20 VAIOHMH dnsmasq[3313]: utilise le serveur de nom
> > >192.168.123.1#53
> > >Nov 23 08:23:20 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.nm_dispatcher'
> > >Nov 23 08:23:20 VAIOHMH ntpd[1178]: ntpd exiting on signal 15
> > >Nov 23 08:23:21 VAIOHMH ntpd_intres[1181]: parent died before we f=
inished,
> > >exiting
> > >Nov 23 08:23:31 VAIOHMH ntpdate[3485]: adjust time server 192.33.9=
6.102
> > >offset 0.438398 sec
> > >Nov 23 08:23:31 VAIOHMH ntpd[3546]: ntpd 4.2.6p5@1.2349-o Wed Oct =
 9
> > >19:08:06 UTC 2013 (1)
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: proto: precision =3D 0.137 use=
c
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: ntp_io: estimated max descript=
ors:
> > >2144, initial socket boundary: 16
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: Listen and drop on 0 v4wildcar=
d
> > >0.0.0.0 UDP 123
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: Listen and drop on 1 v6wildcar=
d :: UDP
> > >123
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: Listen normally on 2 lo 127.0.=
0.1 UDP
> > >123
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: Listen normally on 3 wlan2
> > >192.168.123.63 UDP 123
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: Listen normally on 4 lo ::1 UD=
P 123
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: Listen normally on 5 wlan2
> > >fe80::287:35ff:fe1e:1bd UDP 123
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: peers refreshed
> > >Nov 23 08:23:31 VAIOHMH ntpd[3547]: Listening on routing socket on=
 fd #22
> > >for interface updates
> > >Nov 23 08:23:38 VAIOHMH NetworkManager[1094]: <info> (wlan2): IP6 =
addrconf
> > >timed out or failed.
> > >Nov 23 08:23:38 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 4 of 5 (IPv6 Configure Timeout) scheduled...
> > >Nov 23 08:23:38 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 4 of 5 (IPv6 Configure Timeout) started...
> > >Nov 23 08:23:38 VAIOHMH NetworkManager[1094]: <info> Activation (w=
lan2)
> > >Stage 4 of 5 (IPv6 Configure Timeout) complete.
> > >Nov 23 08:25:11 VAIOHMH kernel: [  177.051929] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:25:11 VAIOHMH kernel: [  177.056368] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:25:22 VAIOHMH kernel: [  187.388278] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D24076=
 PROTO=3DUDP SPT=3D51429
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:25:43 VAIOHMH kernel: [  208.576947] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D18073=
 PROTO=3DUDP SPT=3D61224
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:25:50 VAIOHMH kernel: [  215.634002] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D45177=
 PROTO=3DUDP SPT=3D60438
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:25:57 VAIOHMH kernel: [  222.797819] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D2451 =
PROTO=3DUDP SPT=3D63774
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:26:04 VAIOHMH kernel: [  229.859176] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D17749=
 PROTO=3DUDP SPT=3D59250
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:26:11 VAIOHMH kernel: [  236.925581] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D41400=
 PROTO=3DUDP SPT=3D64470
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:26:18 VAIOHMH kernel: [  244.084308] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D49434=
 PROTO=3DUDP SPT=3D56312
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:26:25 VAIOHMH kernel: [  251.145755] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D58233=
 PROTO=3DUDP SPT=3D62550
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:26:40 VAIOHMH kernel: [  265.370964] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D17511=
 PROTO=3DUDP SPT=3D60373
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:26:47 VAIOHMH kernel: [  272.432382] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D26419=
 PROTO=3DUDP SPT=3D49577
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:26:54 VAIOHMH kernel: [  279.596198] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D5766 =
PROTO=3DUDP SPT=3D53948
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:27:01 VAIOHMH kernel: [  286.657615] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D27611=
 PROTO=3DUDP SPT=3D53348
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:27:16 VAIOHMH kernel: [  300.882883] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D53240=
 PROTO=3DUDP SPT=3D55576
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:27:22 VAIOHMH kernel: [  306.920898] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D4180 =
PROTO=3DUDP SPT=3D65367
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:27:29 VAIOHMH kernel: [  314.084646] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D51659=
 PROTO=3DUDP SPT=3D58286
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:27:36 VAIOHMH kernel: [  321.146084] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D37395=
 PROTO=3DUDP SPT=3D53652
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:27:57 VAIOHMH kernel: [  342.432719] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D13804=
 PROTO=3DUDP SPT=3D51215
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:28:18 VAIOHMH kernel: [  363.719216] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D15013=
 PROTO=3DUDP SPT=3D58371
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:28:32 VAIOHMH kernel: [  376.921052] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D17833=
 PROTO=3DUDP SPT=3D53706
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:28:40 VAIOHMH wpa_supplicant[1273]: wlan2: WPA: Group re=
keying
> > >completed with bc:8c:cd:c0:b5:28 [GTK=3DTKIP]
> > >Nov 23 08:28:53 VAIOHMH kernel: [  398.207752] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D28928=
 PROTO=3DUDP SPT=3D52163
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:29:21 VAIOHMH kernel: [  426.658135] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D22151=
 PROTO=3DUDP SPT=3D61386
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:29:22 VAIOHMH kernel: [  427.681648] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:29:36 VAIOHMH kernel: [  440.883251] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D3113 =
PROTO=3DUDP SPT=3D55244
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:29:57 VAIOHMH kernel: [  462.169871] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D1033 =
PROTO=3DUDP SPT=3D51487
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:30:18 VAIOHMH kernel: [  483.456438] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D56447=
 PROTO=3DUDP SPT=3D55553
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:30:32 VAIOHMH kernel: [  497.681669] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D18983=
 PROTO=3DUDP SPT=3D51048
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:30:54 VAIOHMH kernel: [  518.968299] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:e0:f8:47:43:37:34:08:00 SRC=3D192.168.123.=
54
> > >DST=3D224.0.0.1 LEN=3D44 TOS=3D0x00 PREC=3D0x00 TTL=3D1 ID=3D5836 =
PROTO=3DUDP SPT=3D59761
> > >DPT=3D8612 LEN=3D24
> > >Nov 23 08:31:28 VAIOHMH kernel: [  553.047382] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:31:28 VAIOHMH kernel: [  553.051940] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:33:33 VAIOHMH kernel: [  678.413292] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:33:33 VAIOHMH kernel: [  678.417781] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:35:39 VAIOHMH kernel: [  803.779229] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:35:39 VAIOHMH kernel: [  803.783720] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:37:44 VAIOHMH kernel: [  929.145114] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:37:44 VAIOHMH kernel: [  929.145298] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:39:50 VAIOHMH kernel: [ 1054.511066] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:39:50 VAIOHMH kernel: [ 1054.515543] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:41:55 VAIOHMH kernel: [ 1179.876872] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:41:55 VAIOHMH kernel: [ 1179.876953] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:44:01 VAIOHMH kernel: [ 1305.242899] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:44:01 VAIOHMH kernel: [ 1305.243031] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:46:06 VAIOHMH kernel: [ 1430.608715] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D01:00:5e:00:00:01:20:d5:bf:bf:86:69:08:00 SRC=3D0.0.0.0 DST=3D=
224.0.0.1
> > >LEN=3D32 TOS=3D0x00 PREC=3D0xC0 TTL=3D1 ID=3D0 DF PROTO=3D2
> > >Nov 23 08:46:06 VAIOHMH kernel: [ 1430.613112] [UFW BLOCK] IN=3Dwl=
an2 OUT=3D
> > >MAC=3D33:33:00:00:00:00:20:d5:bf:bf:86:69:86:dd
> > >SRC=3D0000:0000:0000:0000:0000:0000:0000:0000
> > >DST=3Dff02:0000:0000:0000:0000:0000:0000:0001 LEN=3D72 TC=3D0 HOPL=
IMIT=3D1
> > >FLOWLBL=3D0 PROTO=3DICMPv6 TYPE=3D130 CODE=3D0
> > >Nov 23 08:46:39 VAIOHMH dbus[533]: [system] Activating service
> > >name=3D'org.freedesktop.hostname1' (using servicehelper)
> > >Nov 23 08:46:39 VAIOHMH dbus[533]: [system] Successfully activated=
 service
> > >'org.freedesktop.hostname1'
> > >
> > >
> > >lsb_release -rd
> > >Description:    Ubuntu 14.10
> > >Release:        14.10
> > >
> > >
> > >./ver_linux
> > >If some fields are empty or look unusual you may have an old versi=
on.
> > >Compare to the current minimal requirements in Documentation/Chang=
es.
> > >
> > >Linux VAIOHMH 3.18.0-031800rc5-generic #201411162035 SMP Mon Nov 1=
7
> > >01:36:34 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
> > >
> > >Gnu C                  4.9.1
> > >Gnu make               4.0
> > >binutils               2.24.90.20141014
> > >util-linux             2.25.1
> > >mount                  debug
> > >module-init-tools      18
> > >e2fsprogs              1.42.10
> > >pcmciautils            018
> > >PPP                    2.4.5
> > >Linux C Library        2.19
> > >Dynamic linker (ldd)   2.19
> > >Procps                 3.3.9
> > >Net-tools              1.60
> > >Kbd                    1.15.5
> > >Sh-utils               8.23
> > >wireless-tools         30
> > >Modules Loaded         cfg80211 ip6t_REJECT nf_reject_ipv6 nf_log_=
ipv6
> > >xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_rejec=
t_ipv4
> > >8192cu nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_tcpudp xt_addr=
type
> > >nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack ip6table_filter ip6_=
tables
> > >nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp nf_nat
> > >nf_conntrack_ftp nf_conntrack iptable_filter option ip_tables x_ta=
bles
> > >usb_wwan qmi_wwan cdc_wdm usbnet mii usbserial hid_sensor_als
> > >hid_sensor_magn_3d hid_sensor_incl_3d hid_sensor_rotation
> > >hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_trigger
> > >industrialio_triggered_buffer kfifo_buf industrialio hid_sensor_ii=
o_common
> > >hid_multitouch hid_rmi uas usb_storage pn544_mei mei_phy pn544
> > >hid_sensor_hub hci nfc intel_rapl x86_pkg_temp_thermal intel_power=
clamp
> > >coretemp kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aes=
ni_intel
> > >aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd joydev bnep=
 rfcomm
> > >uvcvideo videobuf2_vmalloc bluetooth videobuf2_memops videobuf2_co=
re
> > >v4l2_common videodev snd_hda_codec_realtek media snd_hda_codec_gen=
eric
> > >snd_hda_codec_hdmi nfsd auth_rpcgss nfs_acl nfs lockd grace snd_hd=
a_intel
> > >sunrpc snd_soc_rt5640 snd_hda_controller snd_soc_rl6231 snd_hda_co=
dec
> > >snd_soc_core fscache snd_compress snd_pcm_dmaengine snd_hwdep snd_=
pcm
> > >snd_seq_midi snd_seq_midi_event snd_rawmidi i915 snd_seq snd_seq_d=
evice
> > >mei_me mei snd_timer lpc_ich drm_kms_helper i2c_hid drm snd serio_=
raw
> > >i2c_algo_bit soundcore mac_hid nls_iso8859_1 sony_laptop dw_dmac
> > >dw_dmac_core i2c_designware_platform soc_button_array video 8250_d=
w
> > >i2c_designware_core spi_pxa2xx_platform parport_pc ppdev lp parpor=
t
> > >hid_generic usbhid hid mmc_block ahci psmouse libahci sdhci_acpi s=
dhci
> > >
> > >cat /proc/cpuinfo
> > >processor       : 0
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 936.082
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 0
> > >cpu cores       : 2
> > >apicid          : 0
> > >initial apicid  : 0
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >processor       : 1
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 1868.570
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 0
> > >cpu cores       : 2
> > >apicid          : 1
> > >initial apicid  : 1
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >processor       : 2
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 1002.386
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 1
> > >cpu cores       : 2
> > >apicid          : 2
> > >initial apicid  : 2
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >processor       : 3
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 801.316
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 1
> > >cpu cores       : 2
> > >apicid          : 3
> > >initial apicid  : 3
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >hoogadmin@VAIOHMH:/usr/src/linux-headers-3.18.0-031800rc5/scripts$=
 cat
> > >/proc/cpuinfo
> > >processor       : 0
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 1400.125
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 0
> > >cpu cores       : 2
> > >apicid          : 0
> > >initial apicid  : 0
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >processor       : 1
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 1398.148
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 0
> > >cpu cores       : 2
> > >apicid          : 1
> > >initial apicid  : 1
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >processor       : 2
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 1156.917
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 1
> > >cpu cores       : 2
> > >apicid          : 2
> > >initial apicid  : 2
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >processor       : 3
> > >vendor_id       : GenuineIntel
> > >cpu family      : 6
> > >model           : 69
> > >model name      : Intel(R) Core(TM) i7-4650U CPU @ 1.70GHz
> > >stepping        : 1
> > >microcode       : 0x16
> > >cpu MHz         : 1076.597
> > >cache size      : 4096 KB
> > >physical id     : 0
> > >siblings        : 4
> > >core id         : 1
> > >cpu cores       : 2
> > >apicid          : 3
> > >initial apicid  : 3
> > >fpu             : yes
> > >fpu_exception   : yes
> > >cpuid level     : 13
> > >wp              : yes
> > >flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca
> > >cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx
> > >pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> > >xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 mon=
itor
> > >ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2=
 x2apic
> > >movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm =
abm ida
> > >arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgs=
base
> > >tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm xsaveopt
> > >bugs            :
> > >bogomips        : 4589.36
> > >clflush size    : 64
> > >cache_alignment : 64
> > >address sizes   : 39 bits physical, 48 bits virtual
> > >power management:
> > >
> > >cat /proc/modules
> > >cfg80211 520257 0 - Live 0x0000000000000000
> > >ip6t_REJECT 12625 1 - Live 0x0000000000000000
> > >nf_reject_ipv6 13523 1 ip6t_REJECT, Live 0x0000000000000000
> > >nf_log_ipv6 12778 5 - Live 0x0000000000000000
> > >xt_hl 12521 6 - Live 0x0000000000000000
> > >ip6t_rt 13537 3 - Live 0x0000000000000000
> > >nf_conntrack_ipv6 18946 8 - Live 0x0000000000000000
> > >nf_defrag_ipv6 35007 1 nf_conntrack_ipv6, Live 0x0000000000000000
> > >ipt_REJECT 12541 1 - Live 0x0000000000000000
> > >nf_reject_ipv4 13183 1 ipt_REJECT, Live 0x0000000000000000
> > >8192cu 531395 0 - Live 0x0000000000000000 (OE)
> > >nf_log_ipv4 12819 5 - Live 0x0000000000000000
> > >nf_log_common 13425 2 nf_log_ipv6,nf_log_ipv4, Live 0x000000000000=
0000
> > >xt_LOG 12690 10 - Live 0x0000000000000000
> > >xt_limit 12711 13 - Live 0x0000000000000000
> > >xt_tcpudp 12924 18 - Live 0x0000000000000000
> > >xt_addrtype 12713 4 - Live 0x0000000000000000
> > >nf_conntrack_ipv4 18953 8 - Live 0x0000000000000000
> > >nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0x0000000000000000
> > >xt_conntrack 12760 16 - Live 0x0000000000000000
> > >ip6table_filter 12815 1 - Live 0x0000000000000000
> > >ip6_tables 27504 1 ip6table_filter, Live 0x0000000000000000
> > >nf_conntrack_netbios_ns 12665 0 - Live 0x0000000000000000
> > >nf_conntrack_broadcast 12589 1 nf_conntrack_netbios_ns, Live
> > >0x0000000000000000
> > >nf_nat_ftp 12825 0 - Live 0x0000000000000000
> > >nf_nat 26308 1 nf_nat_ftp, Live 0x0000000000000000
> > >nf_conntrack_ftp 18715 1 nf_nat_ftp, Live 0x0000000000000000
> > >nf_conntrack 105636 8 nf_conntrack_ipv6,nf_conntrack_ipv4,xt_connt=
rack,nf_conntrack_netbios_ns,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,n=
f_conntrack_ftp,
> > >Live 0x0000000000000000
> > >iptable_filter 12810 1 - Live 0x0000000000000000
> > >option 46794 0 - Live 0x0000000000000000
> > >ip_tables 27718 1 iptable_filter, Live 0x0000000000000000
> > >x_tables 34102 13 ip6t_REJECT,xt_hl,ip6t_rt,ipt_REJECT,xt_LOG,xt_l=
imit,xt_tcpudp,xt_addrtype,xt_conntrack,ip6table_filter,ip6_tables,ipta=
ble_filter,ip_tables,
> > >Live 0x0000000000000000
> > >usb_wwan 19914 1 option, Live 0x0000000000000000
> > >qmi_wwan 21810 0 - Live 0x0000000000000000
> > >cdc_wdm 23209 2 qmi_wwan, Live 0x0000000000000000
> > >usbnet 44043 1 qmi_wwan, Live 0x0000000000000000
> > >mii 13981 1 usbnet, Live 0x0000000000000000
> > >usbserial 45363 2 option,usb_wwan, Live 0x0000000000000000
> > >hid_sensor_als 13230 0 - Live 0x0000000000000000
> > >hid_sensor_magn_3d 13406 0 - Live 0x0000000000000000
> > >hid_sensor_incl_3d 13324 0 - Live 0x0000000000000000
> > >hid_sensor_rotation 13444 0 - Live 0x0000000000000000
> > >hid_sensor_accel_3d 13338 0 - Live 0x0000000000000000
> > >hid_sensor_gyro_3d 13324 0 - Live 0x0000000000000000
> > >hid_sensor_trigger 13134 12 hid_sensor_als,hid_sensor_magn_3d,hid_=
sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,hid_sensor_gyro_=
3d,
> > >Live 0x0000000000000000
> > >industrialio_triggered_buffer 12882 6 hid_sensor_als,hid_sensor_ma=
gn_3d,hid_sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,hid_se=
nsor_gyro_3d,
> > >Live 0x0000000000000000
> > >kfifo_buf 13432 1 industrialio_triggered_buffer, Live 0x0000000000=
000000
> > >industrialio 55454 9 hid_sensor_als,hid_sensor_magn_3d,hid_sensor_=
incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,hid_sensor_gyro_3d,hid_=
sensor_trigger,industrialio_triggered_buffer,kfifo_buf,
> > >Live 0x0000000000000000
> > >hid_sensor_iio_common 14349 6 hid_sensor_als,hid_sensor_magn_3d,hi=
d_sensor_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,hid_sensor_gyr=
o_3d,
> > >Live 0x0000000000000000
> > >hid_multitouch 17657 0 - Live 0x0000000000000000
> > >hid_rmi 18060 0 - Live 0x0000000000000000
> > >uas 22673 0 - Live 0x0000000000000000
> > >usb_storage 67010 1 uas, Live 0x0000000000000000
> > >pn544_mei 12802 0 - Live 0x0000000000000000
> > >mei_phy 13929 1 pn544_mei, Live 0x0000000000000000
> > >pn544 18174 1 pn544_mei, Live 0x0000000000000000
> > >hid_sensor_hub 19877 8 hid_sensor_als,hid_sensor_magn_3d,hid_senso=
r_incl_3d,hid_sensor_rotation,hid_sensor_accel_3d,hid_sensor_gyro_3d,hi=
d_sensor_trigger,hid_sensor_iio_common,
> > >Live 0x0000000000000000
> > >hci 44774 2 mei_phy,pn544, Live 0x0000000000000000
> > >nfc 100009 2 pn544,hci, Live 0x0000000000000000
> > >intel_rapl 19196 0 - Live 0x0000000000000000
> > >x86_pkg_temp_thermal 14312 0 - Live 0x0000000000000000
> > >intel_powerclamp 19099 0 - Live 0x0000000000000000
> > >coretemp 13638 0 - Live 0x0000000000000000
> > >kvm 475233 0 - Live 0x0000000000000000
> > >crct10dif_pclmul 14268 0 - Live 0x0000000000000000
> > >crc32_pclmul 13180 0 - Live 0x0000000000000000
> > >ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
> > >aesni_intel 169686 0 - Live 0x0000000000000000
> > >aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> > >lrw 13323 1 aesni_intel, Live 0x0000000000000000
> > >gf128mul 14951 1 lrw, Live 0x0000000000000000
> > >glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
> > >ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> > >cryptd 20531 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> > >0x0000000000000000
> > >joydev 17587 0 - Live 0x0000000000000000
> > >bnep 23980 2 - Live 0x0000000000000000
> > >rfcomm 75066 0 - Live 0x0000000000000000
> > >uvcvideo 86723 0 - Live 0x0000000000000000
> > >videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
> > >bluetooth 486890 10 bnep,rfcomm, Live 0x0000000000000000
> > >videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x000000000000000=
0
> > >videobuf2_core 51547 1 uvcvideo, Live 0x0000000000000000
> > >v4l2_common 15715 1 videobuf2_core, Live 0x0000000000000000
> > >videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live
> > >0x0000000000000000
> > >snd_hda_codec_realtek 80420 1 - Live 0x0000000000000000
> > >media 22008 2 uvcvideo,videodev, Live 0x0000000000000000
> > >snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live
> > >0x0000000000000000
> > >snd_hda_codec_hdmi 52670 1 - Live 0x0000000000000000
> > >nfsd 302377 13 - Live 0x0000000000000000
> > >auth_rpcgss 60078 1 nfsd, Live 0x0000000000000000
> > >nfs_acl 12883 1 nfsd, Live 0x0000000000000000
> > >nfs 249550 0 - Live 0x0000000000000000
> > >lockd 94786 2 nfsd,nfs, Live 0x0000000000000000
> > >grace 13295 2 nfsd,lockd, Live 0x0000000000000000
> > >snd_hda_intel 30783 5 - Live 0x0000000000000000
> > >sunrpc 302693 19 nfsd,auth_rpcgss,nfs_acl,nfs,lockd, Live
> > >0x0000000000000000
> > >snd_soc_rt5640 93325 0 - Live 0x0000000000000000
> > >snd_hda_controller 32234 1 snd_hda_intel, Live 0x0000000000000000
> > >snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0x0000000000000000
> > >snd_hda_codec 144641 5 snd_hda_codec_realtek,snd_hda_codec_generic=
,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,
> > >Live 0x0000000000000000
> > >snd_soc_core 207596 1 snd_soc_rt5640, Live 0x0000000000000000
> > >fscache 64236 1 nfs, Live 0x0000000000000000
> > >snd_compress 19395 1 snd_soc_core, Live 0x0000000000000000
> > >snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0x0000000000000000
> > >snd_hwdep 17709 1 snd_hda_codec, Live 0x0000000000000000
> > >snd_pcm 106273 7 snd_hda_codec_hdmi,snd_hda_intel,snd_soc_rt5640,s=
nd_hda_controller,snd_hda_codec,snd_soc_core,snd_pcm_dmaengine,
> > >Live 0x0000000000000000
> > >snd_seq_midi 13564 0 - Live 0x0000000000000000
> > >snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> > >snd_rawmidi 31197 1 snd_seq_midi, Live 0x0000000000000000
> > >i915 1031996 5 - Live 0x0000000000000000
> > >snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000=
000000
> > >snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
> > >0x0000000000000000
> > >mei_me 19565 0 - Live 0x0000000000000000
> > >mei 88473 3 pn544_mei,mei_phy,mei_me, Live 0x0000000000000000
> > >snd_timer 30118 2 snd_pcm,snd_seq, Live 0x0000000000000000
> > >lpc_ich 21176 0 - Live 0x0000000000000000
> > >drm_kms_helper 99802 1 i915, Live 0x0000000000000000
> > >i2c_hid 19065 0 - Live 0x0000000000000000
> > >drm 323675 4 i915,drm_kms_helper, Live 0x0000000000000000
> > >snd 84025 23 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_c=
odec_hdmi,snd_hda_intel,snd_hda_codec,snd_soc_core,snd_compress,snd_hwd=
ep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
> > >Live 0x0000000000000000
> > >serio_raw 13483 0 - Live 0x0000000000000000
> > >i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> > >soundcore 15091 2 snd_hda_codec,snd, Live 0x0000000000000000
> > >mac_hid 13275 0 - Live 0x0000000000000000
> > >nls_iso8859_1 12713 1 - Live 0x0000000000000000
> > >sony_laptop 59776 0 - Live 0x0000000000000000
> > >dw_dmac 12835 0 - Live 0x0000000000000000
> > >dw_dmac_core 28558 1 dw_dmac, Live 0x0000000000000000
> > >i2c_designware_platform 13025 0 - Live 0x0000000000000000
> > >soc_button_array 12771 0 - Live 0x0000000000000000
> > >video 20649 1 i915, Live 0x0000000000000000
> > >8250_dw 13474 0 - Live 0x0000000000000000
> > >i2c_designware_core 14990 1 i2c_designware_platform, Live
> > >0x0000000000000000
> > >spi_pxa2xx_platform 23256 0 - Live 0x0000000000000000
> > >parport_pc 32909 0 - Live 0x0000000000000000
> > >ppdev 17711 0 - Live 0x0000000000000000
> > >lp 17799 0 - Live 0x0000000000000000
> > >parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> > >hid_generic 12559 0 - Live 0x0000000000000000
> > >usbhid 53155 0 - Live 0x0000000000000000
> > >hid 110572 6
> > >hid_multitouch,hid_rmi,hid_sensor_hub,i2c_hid,hid_generic,usbhid, =
Live
> > >0x0000000000000000
> > >mmc_block 36596 0 - Live 0x0000000000000000
> > >ahci 34220 5 - Live 0x0000000000000000
> > >psmouse 101903 0 - Live 0x0000000000000000 (OE)
> > >libahci 32353 1 ahci, Live 0x0000000000000000
> > >sdhci_acpi 13502 0 - Live 0x0000000000000000
> > >sdhci 43929 1 sdhci_acpi, Live 0x0000000000000000
> > >
> > >cat /proc/ioports
> > >0000-0cf7 : PCI Bus 0000:00
> > >  0000-001f : dma1
> > >  0020-0021 : pic1
> > >  0040-0043 : timer0
> > >  0050-0053 : timer1
> > >  0060-0060 : keyboard
> > >  0062-0062 : PNP0C09:00
> > >    0062-0062 : EC data
> > >  0064-0064 : keyboard
> > >  0066-0066 : PNP0C09:00
> > >    0066-0066 : EC cmd
> > >  0070-0077 : rtc0
> > >  0080-008f : dma page reg
> > >  00a0-00a1 : pic2
> > >  00c0-00df : dma2
> > >  00f0-00ff : fpu
> > >  0680-069f : pnp 00:00
> > >  0800-0bff : INT33C7:00
> > >    0800-0bff : lp-gpio
> > >0cf8-0cff : PCI conf1
> > >0d00-ffff : PCI Bus 0000:00
> > >  164e-164f : pnp 00:00
> > >  1800-1803 : ACPI PM1a_EVT_BLK
> > >  1804-1805 : ACPI PM1a_CNT_BLK
> > >  1808-180b : ACPI PM_TMR
> > >  1810-1815 : ACPI CPU throttle
> > >  1830-1833 : iTCO_wdt
> > >  1850-1850 : ACPI PM2_CNT_BLK
> > >  1854-1857 : pnp 00:02
> > >  1860-187f : iTCO_wdt
> > >  1880-189f : ACPI GPE0_BLK
> > >  2000-2000 : pnp 00:00
> > >  2004-2004 : pnp 00:00
> > >  3000-303f : 0000:00:02.0
> > >  3040-305f : 0000:00:1f.3
> > >  3060-307f : 0000:00:1f.2
> > >    3060-307f : ahci
> > >  3080-3087 : 0000:00:1f.2
> > >    3080-3087 : ahci
> > >  3088-308f : 0000:00:1f.2
> > >    3088-308f : ahci
> > >  3090-3093 : 0000:00:1f.2
> > >    3090-3093 : ahci
> > >  3094-3097 : 0000:00:1f.2
> > >    3094-3097 : ahci
> > >  ffff-ffff : pnp 00:00
> > >    ffff-ffff : pnp 00:00
> > >      ffff-ffff : pnp 00:00
> > >
> > >cat /proc/iomem
> > >00000000-00000fff : reserved
> > >00001000-0006efff : System RAM
> > >0006f000-0006ffff : reserved
> > >00070000-00087fff : System RAM
> > >00088000-000bffff : reserved
> > >  000a0000-000bffff : PCI Bus 0000:00
> > >000c0000-000c3fff : PCI Bus 0000:00
> > >000c4000-000c7fff : PCI Bus 0000:00
> > >000c8000-000cbfff : PCI Bus 0000:00
> > >000cc000-000cffff : PCI Bus 0000:00
> > >000d0000-000d3fff : PCI Bus 0000:00
> > >000d4000-000d7fff : PCI Bus 0000:00
> > >000d8000-000dbfff : PCI Bus 0000:00
> > >000dc000-000dffff : PCI Bus 0000:00
> > >000e0000-000e3fff : PCI Bus 0000:00
> > >000e4000-000e7fff : PCI Bus 0000:00
> > >000e8000-000ebfff : PCI Bus 0000:00
> > >000ec000-000effff : PCI Bus 0000:00
> > >000f0000-000fffff : PCI Bus 0000:00
> > >  000f0000-000fffff : System ROM
> > >00100000-93a36fff : System RAM
> > >  02000000-027b2497 : Kernel code
> > >  027b2498-02d19c7f : Kernel data
> > >  02e80000-02fc8fff : Kernel bss
> > >93a37000-94eaffff : reserved
> > >94eb0000-9b6befff : System RAM
> > >9b6bf000-9b8befff : reserved
> > >9b8bf000-9bebefff : reserved
> > >9bebf000-9bfbefff : ACPI Non-volatile Storage
> > >9bfbf000-9bffefff : ACPI Tables
> > >9bfff000-9bffffff : System RAM
> > >9c000000-9f9fffff : reserved
> > >  9cfff000-9cffffff : MSFT0101:00
> > >  9da00000-9f9fffff : Graphics Stolen Memory
> > >9fa00000-feafffff : PCI Bus 0000:00
> > >  9fa10000-9fa1ffff : pnp 00:04
> > >  9fa20000-9fa20fff : pnp 00:04
> > >  a0000000-afffffff : 0000:00:02.0
> > >  b0000000-b03fffff : 0000:00:02.0
> > >  b0400000-b040ffff : 0000:00:14.0
> > >    b0400000-b040ffff : xhci-hcd
> > >  b0410000-b0413fff : 0000:00:03.0
> > >    b0410000-b0413fff : ICH HD audio
> > >  b0414000-b0417fff : 0000:00:1b.0
> > >    b0414000-b0417fff : ICH HD audio
> > >  b0418000-b0418fff : INT33C6:00
> > >    b0418000-b0418fff : INT33C6:00
> > >  b0419000-b0419007 : pnp 00:05
> > >  b0419014-b0419fff : pnp 00:05
> > >  b041a000-b041a01f : 0000:00:16.0
> > >    b041a000-b041a01f : mei_me
> > >  b041b000-b041b0ff : 0000:00:1f.3
> > >  b041d000-b041d7ff : 0000:00:1f.2
> > >    b041d000-b041d7ff : ahci
> > >  b041e000-b041efff : pnp 00:05
> > >  b041f000-b041ffff : pnp 00:05
> > >  b0420000-b0420fff : INT33C5:00
> > >    b0420000-b042001f : serial
> > >  b0425000-b0425fff : pnp 00:05
> > >  b0426000-b0426fff : INTL9C60:00
> > >    b0426000-b0426fff : INTL9C60:00
> > >  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
> > >    e0000000-efffffff : reserved
> > >      e0000000-efffffff : pnp 00:04
> > >  fe101000-fe112fff : reserved
> > >    fe103000-fe103fff : INT33C2:00
> > >      fe103000-fe103fff : INT33C2:00
> > >    fe104000-fe104fff : pnp 00:05
> > >    fe105000-fe105fff : INT33C3:00
> > >      fe105000-fe105fff : INT33C3:00
> > >    fe106000-fe106fff : pnp 00:05
> > >feb00000-feb0ffff : reserved
> > >fec00000-fec00fff : reserved
> > >  fec00000-fec003ff : IOAPIC 0
> > >fed00000-fee00fff : reserved
> > >  fed00000-fed003ff : HPET 0
> > >    fed00000-fed003ff : PNP0103:00
> > >  fed10000-fed17fff : pnp 00:04
> > >  fed18000-fed18fff : pnp 00:04
> > >  fed19000-fed19fff : pnp 00:04
> > >  fed1c000-fed1ffff : pnp 00:04
> > >    fed1f410-fed1f414 : iTCO_wdt
> > >  fed20000-fed3ffff : pnp 00:04
> > >  fed70000-fed70fff : MSFT0101:00
> > >  fed90000-fed93fff : pnp 00:04
> > >  fee00000-fee00fff : Local APIC
> > >ff000000-ffffffff : INT0800:00
> > >  ffc00000-ffffffff : reserved
> > >100000000-25f5fffff : System RAM
> > >25f600000-25fffffff : RAM buffer
> > >
> > >
> > >lspci -vvv
> > >[sudo] password for hoogadmin:
> > >00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller=
 (rev
> > >09)
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >T=
Abort-
> > ><TAbort- <MAbort+ >SERR- <PERR- INTx-
> > >        Latency: 0
> > >        Capabilities: [e0] Vendor Specific Information: Len=3D0c <=
?>
> > >
> > >00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT
> > >Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controlle=
r])
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >T=
Abort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Latency: 0
> > >        Interrupt: pin A routed to IRQ 43
> > >        Region 0: Memory at b0000000 (64-bit, non-prefetchable) [s=
ize=3D4M]
> > >        Region 2: Memory at a0000000 (64-bit, prefetchable) [size=3D=
256M]
> > >        Region 4: I/O ports at 3000 [size=3D64]
> > >        Expansion ROM at <unassigned> [disabled]
> > >        Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
> > >                Address: fee0f00c  Data: 41e1
> > >        Capabilities: [d0] Power Management version 2
> > >                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
> > >PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > >                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
> > >        Capabilities: [a4] PCI Advanced Features
> > >                AFCap: TP+ FLR+
> > >                AFCtrl: FLR-
> > >                AFStatus: TP-
> > >        Kernel driver in use: i915
> > >
> > >00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Contr=
oller
> > >(rev 09)
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >T=
Abort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Latency: 0, Cache Line Size: 64 bytes
> > >        Interrupt: pin A routed to IRQ 44
> > >        Region 0: Memory at b0410000 (64-bit, non-prefetchable) [s=
ize=3D16K]
> > >        Capabilities: [50] Power Management version 2
> > >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > >PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > >                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
> > >        Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
> > >                Address: fee0f00c  Data: 4122
> > >        Capabilities: [70] Express (v1) Root Complex Integrated En=
dpoint,
> > >MSI 00
> > >                DevCap: MaxPayload 128 bytes, PhantFunc 0
> > >                        ExtTag- RBE-
> > >                DevCtl: Report errors: Correctable- Non-Fatal- Fat=
al-
> > >Unsupported-
> > >                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
> > >                        MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- A=
uxPwr-
> > >TransPend-
> > >        Kernel driver in use: snd_hda_intel
> > >
> > >00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (re=
v 04)
> > >(prog-if 30 [XHCI])
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Latency: 0
> > >        Interrupt: pin A routed to IRQ 40
> > >        Region 0: Memory at b0400000 (64-bit, non-prefetchable) [s=
ize=3D64K]
> > >        Capabilities: [70] Power Management version 2
> > >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
> > >PME(D0-,D1-,D2-,D3hot+,D3cold+)
> > >                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
> > >        Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bi=
t+
> > >                Address: 00000000fee0c00c  Data: 4171
> > >        Kernel driver in use: xhci_hcd
> > >
> > >00:16.0 Communication controller: Intel Corporation 8 Series HECI =
#0 (rev
> > >04)
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >T=
Abort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Latency: 0
> > >        Interrupt: pin A routed to IRQ 42
> > >        Region 0: Memory at b041a000 (64-bit, non-prefetchable) [s=
ize=3D32]
> > >        Capabilities: [50] Power Management version 3
> > >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > >PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
> > >        Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
> > >                Address: 00000000fee0f00c  Data: 41d1
> > >        Kernel driver in use: mei_me
> > >
> > >00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controll=
er (rev
> > >04)
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >T=
Abort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Latency: 0, Cache Line Size: 64 bytes
> > >        Interrupt: pin A routed to IRQ 45
> > >        Region 0: Memory at b0414000 (64-bit, non-prefetchable) [s=
ize=3D16K]
> > >        Capabilities: [50] Power Management version 3
> > >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
> > >PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D=
0 PME-
> > >        Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
> > >                Address: 00000000fee0f00c  Data: 4142
> > >        Capabilities: [70] Express (v1) Root Complex Integrated En=
dpoint,
> > >MSI 00
> > >                DevCap: MaxPayload 128 bytes, PhantFunc 0
> > >                        ExtTag- RBE-
> > >                DevCtl: Report errors: Correctable- Non-Fatal- Fat=
al-
> > >Unsupported-
> > >                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoo=
p-
> > >                        MaxPayload 128 bytes, MaxReadReq 128 bytes
> > >                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- A=
uxPwr+
> > >TransPend-
> > >        Capabilities: [100 v1] Virtual Channel
> > >                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> > >                Arb:    Fixed- WRR32- WRR64- WRR128-
> > >                Ctrl:   ArbSelect=3DFixed
> > >                Status: InProgress-
> > >                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 Re=
jSnoopTrans-
> > >                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR1=
28-
> > >WRR256-
> > >                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed T=
C/VC=3Dff
> > >                        Status: NegoPending- InProgress-
> > >                VC1:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 Re=
jSnoopTrans-
> > >                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR1=
28-
> > >WRR256-
> > >                        Ctrl:   Enable- ID=3D0 ArbSelect=3DFixed T=
C/VC=3D00
> > >                        Status: NegoPending- InProgress-
> > >        Kernel driver in use: snd_hda_intel
> > >
> > >00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev=
 04)
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium =
>TAbort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Latency: 0
> > >        Capabilities: [e0] Vendor Specific Information: Len=3D0c <=
?>
> > >        Kernel driver in use: lpc_ich
> > >
> > >00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controlle=
r 1
> > >[AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Latency: 0
> > >        Interrupt: pin B routed to IRQ 41
> > >        Region 0: I/O ports at 3088 [size=3D8]
> > >        Region 1: I/O ports at 3094 [size=3D4]
> > >        Region 2: I/O ports at 3080 [size=3D8]
> > >        Region 3: I/O ports at 3090 [size=3D4]
> > >        Region 4: I/O ports at 3060 [size=3D32]
> > >        Region 5: Memory at b041d000 (32-bit, non-prefetchable) [s=
ize=3D2K]
> > >        Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t-
> > >                Address: fee0300c  Data: 4191
> > >        Capabilities: [70] Power Management version 3
> > >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > >PME(D0-,D1-,D2-,D3hot+,D3cold-)
> > >                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D=
0 PME-
> > >        Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
> > >        Kernel driver in use: ahci
> > >
> > >00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04=
)
> > >        Subsystem: Sony Corporation Device 90b1
> > >        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop=
-
> > >ParErr- Stepping- SERR- FastB2B- DisINTx-
> > >        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort-
> > ><TAbort- <MAbort- >SERR- <PERR- INTx-
> > >        Interrupt: pin C routed to IRQ 0
> > >        Region 0: Memory at b041b000 (64-bit, non-prefetchable) [s=
ize=3D256]
> > >        Region 4: I/O ports at 3040 [size=3D32]
> > >
> > >
> > >cat /proc/scsi/scsi
> > >Attached devices:
> > >Host: scsi0 Channel: 00 Id: 00 Lun: 00
> > >  Vendor: ATA      Model: SAMSUNG MZNTE256 Rev: 5S0Q
> > >  Type:   Direct-Access                    ANSI  SCSI revision: 05
> > >Host: scsi4 Channel: 00 Id: 00 Lun: 00
> > >  Vendor: Generic- Model: SD/MMC/MS PRO    Rev: 1.00
> > >  Type:   Direct-Access                    ANSI  SCSI revision: 04
> > >
> > >
> > >/proc
> > >1     145   1538  1838  1953  22    2611  2850  2944  3000 3116  3=
484
> > >3824  46   583  703        cpuinfo key-users     scsi           zo=
neinfo
> > >10    146   1543  1871  1954  24    2614  2855  2946  3001 3117  3=
494  384
> > >47   591  704        crypto kmsg          self
> > >1002  1466  158   1877  1955  2451  2653  2867  2947  3003 3120  3=
5
> > >3891  471  593  8          devices kpagecount    slabinfo
> > >1032  147   16    1885  1956  2454  2671  2870  2949  3014 3122  3=
547
> > >3894  474  600  841        diskstats kpageflags    softirqs
> > >1061  1471  1604  1891  1957  2455  2672  2875  2950  3016 3127  3=
549  39
> > >48   609  9          dma loadavg       stat
> > >1094  1472  166   1897  1958  25    2673  2876  2951  3041 3129  3=
596
> > >3910  5    611  90         driver locks         swaps
> > >11    1479  167   19    1959  2513  2674  2887  2952  3052 3131  3=
6
> > >3932  50   617  91         execdomains mdstat        sys
> > >1153  148   1679  1900  1962  2523  2689  2892  2953  3064 3133  3=
631  40
> > >503  623  933        fb meminfo       sysrq-trigger
> > >1190  1481  168   1902  1998  2524  27    2897  2962  3077 3144  3=
65
> > >4040  52   640  951        filesystems misc          sysvipc
> > >12    1487  169   1906  2     2535  279   29    2963  3082 3162  3=
68
> > >4044  530  651  965        fs modules       thread-self
> > >1262  149   1698  1912  20    2548  28    2900  2965  31 32    37 =
   4053
> > >533  653  acpi       interrupts mounts        timer_list
> > >1270  1494  17    1924  2018  2550  2802  2902  2967  3103 3224  3=
706  407
> > >534  68   asound     iomem mtrr          timer_stats
> > >1273  15    1736  1928  2078  2558  281   2904  2975  3104 3296  3=
747  41
> > >537  687  buddyinfo  ioports net           tty
> > >13    150   1752  1947  21    2563  2833  2934  2982  3105 33    3=
785  42
> > >54   69   bus        irq pagetypeinfo  uptime
> > >14    151   1756  1948  2143  2566  2835  2935  2991  3106 3309  3=
796  43
> > >55   7    cgroups    kallsyms partitions    version
> > >142   152   1759  1949  218   2568  2845  2939  2997  3108 3313  3=
8    44
> > >56   70   cmdline    kcore sched_debug   vmallocinfo
> > >144   1537  18    1952  2181  26    285   2940  3     3115 34    3=
822  45
> > >580  702  consoles   keys schedstat     vmstat
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c=
" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
