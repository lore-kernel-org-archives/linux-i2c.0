From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-i801 hangs indefinitely on IBM x3550
Date: Fri, 01 Jul 2016 15:05:49 +0200
Message-ID: <1467378349.11332.5.camel@chaos.suse>
References: <alpine.SOC.1.00.1309241438110.29702@math.ut.ee>
	 <20160701115330.1ff19621@endymion>
	 <alpine.LRH.2.20.1607011455120.12974@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41738 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbcGANFy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 09:05:54 -0400
In-Reply-To: <alpine.LRH.2.20.1607011455120.12974@math.ut.ee>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi Meelis,

Thanks for the quick reply.

On ven., 2016-07-01 at 15:02 +0300, Meelis Roos wrote:
> > > Tried latest Debian kernel (3.10-3-amd64) and latest upstream ker=
nel=20
> > > (3.12-rc2) on a decommisioned IBM x3550 server. i2c-i801 is autol=
oaded=20
> > > but all access to it seems to wait forever, including stopping re=
boot=20
> > > from happening because modprobe is still running and blocked on t=
his.
> > >=20
> > > 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMB=
us Controller (rev 09)
> > >         Subsystem: IBM Device 02dd
> > >         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoo=
p- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
> > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
> > >         Interrupt: pin B routed to IRQ 20
> > >         Region 4: I/O ports at 0440 [size=3D32]
> > >         Kernel driver in use: i801_smbus
> > >=20
> > >=20
> > > [    3.028771] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
> > > [...]
> > > [  240.172009] INFO: task modprobe:267 blocked for more than 120 =
seconds.
> >=20
> > Most likely SMBus interrupts do not work properly on this machine.
> > Since then a number of improvements have been committed to the i2c-=
i801
> > driver to detect and workaround corner cases in this area. If you s=
till
> > have this machine, you may want to try to upgrade to kernel v3.19 o=
r
> > later and see if it helps.
>=20
> The machine is still alive and kicking with latest 4.7-rc4+. However,=
 I=20
> do not remember the exact scenario  for testing.

Well originally you reported that the machine would hang when the
i2c-i801 driver is loaded. I guess this is no longer the case?

> Ran sensors, this works:
>=20
> $ sensors
> i5k_amb-isa-0000
> Adapter: ISA adapter
> Ch. 0 DIMM 0:  +38.5=C2=B0C  (low  =3D +104.0=C2=B0C, high =3D +124.0=
=C2=B0C)
> Ch. 0 DIMM 1:  +33.0=C2=B0C  (low  =3D +100.0=C2=B0C, high =3D +124.0=
=C2=B0C)
> Ch. 1 DIMM 0:  +42.5=C2=B0C  (low  =3D +101.0=C2=B0C, high =3D +124.0=
=C2=B0C)
> Ch. 1 DIMM 1:  +36.5=C2=B0C  (low  =3D +99.5=C2=B0C, high =3D +124.0=C2=
=B0C)
> Ch. 2 DIMM 0:  +58.0=C2=B0C  (low  =3D +127.5=C2=B0C, high =3D +127.5=
=C2=B0C)
> Ch. 3 DIMM 0:  +18.0=C2=B0C  (low  =3D +127.5=C2=B0C, high =3D +127.5=
=C2=B0C)
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +43.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
> Core 1:       +45.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
>=20
> aem1-isa-0000
> Adapter: ISA adapter
> power1:      188.16 W  (interval =3D   1.00 s)
> energy1:     720.82 MJ
>=20
> aem2-isa-0001
> Adapter: ISA adapter
> temp1:        +31.0=C2=B0C =20
> temp2:        +20.0=C2=B0C =20
> power1:      126.22 W  (interval =3D   1.00 s)
> power2:      200.69 W  (interval =3D   1.00 s)
> power3:       26.00 W =20
> power4:      374.00 W =20
> power5:      347.00 W =20
> power6:      265.40 W =20
> power7:      240.40 W =20
> energy1:     217.21 MJ
> energy2:     720.82 MJ
>=20
> ibmpex-isa-0000
> Adapter: ISA adapter
> temp1:         +0.0=C2=B0C =20
> temp2:         +0.0=C2=B0C =20
> temp3:         +0.0=C2=B0C =20
> temp4:         +0.0=C2=B0C =20
> power1:      131.00 W  (lowest =3D   7.00 W, highest =3D 186.90 W)
> power2:      133.00 W  (lowest =3D   8.50 W, highest =3D 159.10 W)
> power3:      132.60 W  (lowest =3D   8.70 W, highest =3D 155.80 W)
> power4:      132.70 W  (lowest =3D   8.80 W, highest =3D 156.00 W)
> power5:      127.10 W  (lowest =3D   8.80 W, highest =3D 155.00 W)
> power6:      123.90 W  (lowest =3D   8.90 W, highest =3D 151.40 W)
> power7:      123.30 W  (lowest =3D   9.00 W, highest =3D 148.40 W)
> power8:      123.00 W  (lowest =3D   9.30 W, highest =3D 146.40 W)
> power9:      208.00 W  (lowest =3D  67.00 W, highest =3D 267.00 W)
> power10:     206.00 W  (lowest =3D  68.00 W, highest =3D 232.00 W)
> power11:     196.00 W  (lowest =3D  81.00 W, highest =3D 227.00 W)
>
> But the hwmon sensors seem to be prom ohter places than i2c.

Indeed, none of these sensors is on the SMBus.

> mroos@x3550:/sys/bus/i2c/devices$ ls -al
> total 0
> drwxr-xr-x 2 root root 0 Jul  1 14:50 .
> drwxr-xr-x 4 root root 0 Jul  1 14:50 ..
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-0 -> ../../../devices/pci00=
00:00/0000:00:1f.3/i2c-0
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-1 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-1
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-2 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-2
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-3 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-3
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-4 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-4
>=20
> So no i2c client drivers.
>=20
> devices/pci0000:00/0000:00:1f.3/i2c-0 is i801_smbus.

Correct.

> modprobe eeprom + decode-dimms shows not dimm info but here is some i=
2c=20
> device now:
> lrwxrwxrwx 1 root root 0 Jul  1 14:51 1-0050 -> ../../../devices/pci0=
000:00/0000:00:1e.0/0000:01:01.0/i2c-1/1-0050
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-0 -> ../../../devices/pci00=
00:00/0000:00:1f.3/i2c-0
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-1 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-1
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-2 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-2
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-3 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-3
> lrwxrwxrwx 1 root root 0 Jul  1 14:50 i2c-4 -> ../../../devices/pci00=
00:00/0000:00:1e.0/0000:01:01.0/i2c-4

On LGA 2011 Socket systems, the memory sockets have a dedicated SMBus
controller (there was a driver under development for it but I don't
think it ever made it upstream) so it is expected that decode-dimms
doesn't print anything.

> However, this seems to be attached to ATi graphics so probably DDC.

Indeed.

> Reboot is working fine.
>=20
> SO how do I see if os working? Nothing in dmesg, reboot works so seem=
s=20
> OK?

Well, upon loading the i2c-i801 driver should say something about
interrupt use. Either:
  "SMBus using PCI interrupt"
or:
  "SMBus using polling"
and possibly other relevant messages. Can you check your dmesg for thes=
e
messages?

--=20
Jean Delvare
SUSE L3 Support
