From: Meelis Roos <mroos@linux.ee>
Subject: Re: i2c-i801 hangs indefinitely on IBM x3550
Date: Fri, 1 Jul 2016 15:02:58 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1607011455120.12974@math.ut.ee>
References: <alpine.SOC.1.00.1309241438110.29702@math.ut.ee> <20160701115330.1ff19621@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:39862 "EHLO smtp1.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbcGAMBZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Jul 2016 08:01:25 -0400
In-Reply-To: <20160701115330.1ff19621@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

> > Tried latest Debian kernel (3.10-3-amd64) and latest upstream kerne=
l=20
> > (3.12-rc2) on a decommisioned IBM x3550 server. i2c-i801 is autoloa=
ded=20
> > but all access to it seems to wait forever, including stopping rebo=
ot=20
> > from happening because modprobe is still running and blocked on thi=
s.
> >=20
> > 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus=
 Controller (rev 09)
> >         Subsystem: IBM Device 02dd
> >         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr+ Stepping- SERR+ FastB2B- DisINTx+
> >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >=
TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
> >         Interrupt: pin B routed to IRQ 20
> >         Region 4: I/O ports at 0440 [size=3D32]
> >         Kernel driver in use: i801_smbus
> >=20
> >=20
> > [    3.028771] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
> > [...]
> > [  240.172009] INFO: task modprobe:267 blocked for more than 120 se=
conds.
>=20
> Most likely SMBus interrupts do not work properly on this machine.
> Since then a number of improvements have been committed to the i2c-i8=
01
> driver to detect and workaround corner cases in this area. If you sti=
ll
> have this machine, you may want to try to upgrade to kernel v3.19 or
> later and see if it helps.

The machine is still alive and kicking with latest 4.7-rc4+. However, I=
=20
do not remember the exact scenario  for testing.

Ran sensors, this works:

$ sensors
i5k_amb-isa-0000
Adapter: ISA adapter
Ch. 0 DIMM 0:  +38.5=B0C  (low  =3D +104.0=B0C, high =3D +124.0=B0C)
Ch. 0 DIMM 1:  +33.0=B0C  (low  =3D +100.0=B0C, high =3D +124.0=B0C)
Ch. 1 DIMM 0:  +42.5=B0C  (low  =3D +101.0=B0C, high =3D +124.0=B0C)
Ch. 1 DIMM 1:  +36.5=B0C  (low  =3D +99.5=B0C, high =3D +124.0=B0C)
Ch. 2 DIMM 0:  +58.0=B0C  (low  =3D +127.5=B0C, high =3D +127.5=B0C)
Ch. 3 DIMM 0:  +18.0=B0C  (low  =3D +127.5=B0C, high =3D +127.5=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +43.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 1:       +45.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

aem1-isa-0000
Adapter: ISA adapter
power1:      188.16 W  (interval =3D   1.00 s)
energy1:     720.82 MJ

aem2-isa-0001
Adapter: ISA adapter
temp1:        +31.0=B0C =20
temp2:        +20.0=B0C =20
power1:      126.22 W  (interval =3D   1.00 s)
power2:      200.69 W  (interval =3D   1.00 s)
power3:       26.00 W =20
power4:      374.00 W =20
power5:      347.00 W =20
power6:      265.40 W =20
power7:      240.40 W =20
energy1:     217.21 MJ
energy2:     720.82 MJ

ibmpex-isa-0000
Adapter: ISA adapter
temp1:         +0.0=B0C =20
temp2:         +0.0=B0C =20
temp3:         +0.0=B0C =20
temp4:         +0.0=B0C =20
power1:      131.00 W  (lowest =3D   7.00 W, highest =3D 186.90 W)
power2:      133.00 W  (lowest =3D   8.50 W, highest =3D 159.10 W)
power3:      132.60 W  (lowest =3D   8.70 W, highest =3D 155.80 W)
power4:      132.70 W  (lowest =3D   8.80 W, highest =3D 156.00 W)
power5:      127.10 W  (lowest =3D   8.80 W, highest =3D 155.00 W)
power6:      123.90 W  (lowest =3D   8.90 W, highest =3D 151.40 W)
power7:      123.30 W  (lowest =3D   9.00 W, highest =3D 148.40 W)
power8:      123.00 W  (lowest =3D   9.30 W, highest =3D 146.40 W)
power9:      208.00 W  (lowest =3D  67.00 W, highest =3D 267.00 W)
power10:     206.00 W  (lowest =3D  68.00 W, highest =3D 232.00 W)
power11:     196.00 W  (lowest =3D  81.00 W, highest =3D 227.00 W)

But the hwmon sensors seem to be prom ohter places than i2c.

mroos@x3550:/sys/bus/i2c/devices$ ls -al
total 0
drwxr-xr-x 2 root root 0 Jul  1 14:50 .
drwxr-xr-x 4 root root 0 Jul  1 14:50 ..
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-0 -> ../../../devices/pci0000=
:00/0000:00:1f.3/i2c-0
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-1 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-1
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-2 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-2
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-3 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-3
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-4 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-4

So no i2c client drivers.

devices/pci0000:00/0000:00:1f.3/i2c-0 is i801_smbus.

modprobe eeprom + decode-dimms shows not dimm info but here is some i2c=
=20
device now:
lrwxrwxrwx 1 root root 0 Jul  1 14:51 1-0050 -> ../../../devices/pci000=
0:00/0000:00:1e.0/0000:01:01.0/i2c-1/1-0050
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-0 -> ../../../devices/pci0000=
:00/0000:00:1f.3/i2c-0
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-1 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-1
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-2 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-2
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-3 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-3
lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-4 -> ../../../devices/pci0000=
:00/0000:00:1e.0/0000:01:01.0/i2c-4

However, this seems to be attached to ATi graphics so probably DDC.

Reboot is working fine.

SO how do I see if os working? Nothing in dmesg, reboot works so seems=20
OK?


--=20
Meelis Roos (mroos@linux.ee)
