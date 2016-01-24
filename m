From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v5 0/3] Support multiplexed main SMBus interface on
 SB800
Date: Sun, 24 Jan 2016 10:16:57 +0100
Message-ID: <20160124101657.7aa42eb9@endymion.delvare>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
	<20160122135040.6db7b66b@endymion.delvare>
	<56A3846F.9000908@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33881 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbcAXJRC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 24 Jan 2016 04:17:02 -0500
In-Reply-To: <56A3846F.9000908@googlemail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: fetzerch <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com

Hi Christian,

On Sat, 23 Jan 2016 14:47:27 +0100, fetzerch wrote:
> On 22.01.2016 13:50, Jean Delvare wrote:
> > On Thu, 19 Nov 2015 20:13:46 +0100, Christian Fetzer wrote:
> >> The patched driver is running stable on the machine, given that ic=
2_piix4 is
> >> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 =
calling
> >> sensors triggers some errors:
> >>     ERROR: Can't get value of subfeature temp1_min_alarm: Can't re=
ad
> >>
> >> While the kernel log shows:
> >>     i2c i2c-1: Transaction (pre): CNT=3D0c, CMD=3D05, ADD=3D31, DA=
T0=3D03, DAT1=3Dc0
> >>     i2c i2c-1: Error: no response!
> >>     i2c i2c-1: Transaction (post): CNT=3D0c, CMD=3D05, ADD=3D31, D=
AT0=3Dff, DAT1=3Dff
> >> Unfortunately I don't know how to tackle this specific issue.
> >=20
> > I think I can explain it. In piix4_setup_sb800() you touch the
> > SB800_PIIX4_SMB_IDX port without first taking the mutex that protec=
ts
> > it. You only take the mutex on transactions (in piix4_access_sb800)=
 not
> > during initialization. If self-probing I2C device drivers such as j=
c42
> > are already loaded before you load i2c-piix4, then as soon as the f=
irst
> > SMBus port is registered, i2c-core will try to attach I2C devices t=
o
> > it, while at the same time i2c-piix4 is registering the second SMBu=
s
> > port. So SB800_PIIX4_SMB_IDX is changed while piix4_access_sb800
> > accesses it and chaos happens.
> >=20
> > I think if we had proper locking in piix4_setup_sb800() then you sh=
ould
> > be able to load jc42 first and then i2c-piix4 and it should work fi=
ne.
>=20
> Since the problem remains even after your patch, I'll try to provide
> more information about the issue.
>=20
> If i2c_piix4 is loaded before jc42 and w83795 things work as they sho=
uld
> and sensors prints values from all modules.
>=20
> If w83795 is loaded before i2c_piix4, the w83795adg is not detected. =
I'm
> not sure though if this is because of i2c_piix4 or just a shortcoming=
 in
> the w83795 module.

The w83795 driver works fine for many users including myself for years.
So definitely this is related to the i2c-piix4 driver.

> If jc42 is loaded before i2c_piix4 then the problem described above
> occurs. It seems that jc42 tries to read from all multiplexed ports.
> This is the full sensors output:
>=20
> jc42-i2c-0-18
> Adapter: SMBus PIIX4 adapter SDA0 at 0b00
> RAM1 Temp:    +26.8=C2=B0C  (low  =3D  +0.0=C2=B0C)
>                        (high =3D +60.0=C2=B0C, hyst =3D +54.0=C2=B0C)
>                        (crit =3D +70.0=C2=B0C, hyst =3D +64.0=C2=B0C)
>=20
> jc42-i2c-0-19
> Adapter: SMBus PIIX4 adapter SDA0 at 0b00
> RAM2 Temp:    +26.5=C2=B0C  (low  =3D  +0.0=C2=B0C)
>                        (high =3D +60.0=C2=B0C, hyst =3D +54.0=C2=B0C)
>                        (crit =3D +70.0=C2=B0C, hyst =3D +64.0=C2=B0C)
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> CPU Temp:     +30.6=C2=B0C  (high =3D +70.0=C2=B0C)
>                        (crit =3D +100.0=C2=B0C, hyst =3D +95.0=C2=B0C=
)
>=20
> jc42-i2c-1-18
> Adapter: SMBus PIIX4 adapter SDA2 at 0b00
> ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_min: Can't read
> ERROR: Can't get value of subfeature temp1_max: Can't read
> ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
> ERROR: Can't get value of subfeature temp1_crit: Can't read
> ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
> temp1:            N/A  (low  =3D  +0.0=C2=B0C)
>                        (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>                        (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>=20
> jc42-i2c-1-19
> Adapter: SMBus PIIX4 adapter SDA2 at 0b00
> ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_min: Can't read
> ERROR: Can't get value of subfeature temp1_max: Can't read
> ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
> ERROR: Can't get value of subfeature temp1_crit: Can't read
> ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
> temp1:            N/A  (low  =3D  +0.0=C2=B0C)
>                        (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>                        (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>=20
> jc42-i2c-2-18
> Adapter: SMBus PIIX4 adapter SDA3 at 0b00
> ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_min: Can't read
> ERROR: Can't get value of subfeature temp1_max: Can't read
> ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
> ERROR: Can't get value of subfeature temp1_crit: Can't read
> ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
> temp1:            N/A  (low  =3D  +0.0=C2=B0C)
>                        (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>                        (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>=20
> jc42-i2c-2-19
> Adapter: SMBus PIIX4 adapter SDA3 at 0b00
> ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_min: Can't read
> ERROR: Can't get value of subfeature temp1_max: Can't read
> ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
> ERROR: Can't get value of subfeature temp1_crit: Can't read
> ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
> temp1:            N/A  (low  =3D  +0.0=C2=B0C)
>                        (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>                        (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>=20
> jc42-i2c-3-18
> Adapter: SMBus PIIX4 adapter SDA4 at 0b00
> ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_min: Can't read
> ERROR: Can't get value of subfeature temp1_max: Can't read
> ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
> ERROR: Can't get value of subfeature temp1_crit: Can't read
> ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
> temp1:            N/A  (low  =3D  +0.0=C2=B0C)
>                        (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>                        (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>=20
> jc42-i2c-3-19
> Adapter: SMBus PIIX4 adapter SDA4 at 0b00
> ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
> ERROR: Can't get value of subfeature temp1_min: Can't read
> ERROR: Can't get value of subfeature temp1_max: Can't read
> ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
> ERROR: Can't get value of subfeature temp1_crit: Can't read
> ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
> temp1:            N/A  (low  =3D  +0.0=C2=B0C)
>                        (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
>                        (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)

It means that the autodetection function of the jc42 driver returned
success, allowing the driver to instantiate jc42 devices on each of
them. This means that SMBus port 0 was selected at that time even
though the kernel believed port 2 then 3 then 4 was selected. Later on
(when you run "sensors") port selection works properly so the jc42
driver returns error as intended for non-existent devices.

Where is the W83795ADG device when it is properly detected?

I looked at the code again but can't see any obvious problem left after
applying my patch.

One thing that bothers me is that pins for SMBus ports may be shared
with other functions. The "AMD SB810/850 Southbridge Databook" document
shows that all SMBus ports are shared with at least GPIOs and port 4
also with PS/2 function. Unfortunately I can't find any document
explaining how to check which function is assigned to each pin.

--=20
Jean Delvare
SUSE L3 Support
