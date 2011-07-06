From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Wed, 6 Jul 2011 17:05:31 +0200
Message-ID: <20110706170531.2f3bed19@endymion.delvare>
References: <20110706090347.44bd4bbe@endymion.delvare>
	<20432649.84.1309963215499.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20432649.84.1309963215499.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 6 Jul 2011 09:40:15 -0500 (CDT), Tim Nelson wrote:
> ----- Original Message -----
> > Hi Tim,
> >=20
> > On Tue, 5 Jul 2011 12:06:13 -0500 (CDT), Tim Nelson wrote:
> > > I've done that:
> > >
> > > root@aaa:~# lsmod | grep i2c
> > > i2c_dev 3382 0
> > > i2c_core 12703 1 i2c_dev
> > >
> > > But, nothing of interest in dmesg other than:
> > >
> > > [108414.944722] i2c /dev entries driver
> > >
> > > and running i2cdetect still turns up nothing:
> > >
> > > root@aaa:~# i2cdetect -l
> > >
> > > Any thoughts? Does this specific Winbond chip require a device
> > > specific kernel module to operate such as those found in
> > > /lib/modules/2.6.32-5-486/kernel/drivers/i2c/busses ?
> >=20
> > As I understand it, the W83L604G is a GPIO expander on I2C/SMBus, s=
o
> > what it needs is a driver in drivers/gpio. We don't seem to have
> > support
> > for it yet, unless it is 100% compatible with another device we
> > already
> > support.
> >=20
> > On top of that, you need a driver for the I2C/SMBus controller on y=
our
> > mainboard, to which the W83L604G is connected. Without it, you won'=
t
> > even be able to talk to the W83L604G. You did not tell us anything
> > about your system so we can't tell you which driver that would be -=
 if
> > we have a driver at all. Does lspci say anything about SMBus? If no=
t,
> > what is your system based on?
> >=20
>=20
> Greetings Jean-
>=20
> The board is running an AMD Geode LX CPU with the CS5536 companion ch=
ip. Here is the output of lspci:
>=20
> root@aaa:~# lspci
> 00:01.0 Host bridge: Advanced Micro Devices [AMD] CS5536 [Geode compa=
nion] Host Bridge (rev 33)
> 00:01.1 VGA compatible controller: Advanced Micro Devices [AMD] Geode=
 LX Video
> 00:01.2 Entertainment encryption device: Advanced Micro Devices [AMD]=
 Geode LX AES Security Block
> 00:0e.0 Ethernet controller: VIA Technologies, Inc. VT6105M [Rhine-II=
I] (rev 96)
> 00:0f.0 Ethernet controller: VIA Technologies, Inc. VT6105M [Rhine-II=
I] (rev 96)
> 00:12.0 Communication controller: Tiger Jet Network Inc. Tiger3XX Mod=
em/ISDN interface
> 00:13.0 ISA bridge: Advanced Micro Devices [AMD] CS5536 [Geode compan=
ion] ISA (rev 03)
> 00:13.2 IDE interface: Advanced Micro Devices [AMD] CS5536 [Geode com=
panion] IDE (rev 01)
> 00:13.4 USB Controller: Advanced Micro Devices [AMD] CS5536 [Geode co=
mpanion] OHC (rev 02)
> 00:13.5 USB Controller: Advanced Micro Devices [AMD] CS5536 [Geode co=
mpanion] EHC (rev 02)
>=20
> There are no SMBus controllers listed. However, The datasheet[1] for =
the CS5536 notes there is an SMB controller within this chip. Details f=
rom the datasheet:
>=20
> "System Management Bus (SMB) Controller:
> =E2=80=94 Compatible with Intel System Management Bus,=20
> Industry Standard Two-wire interface, and=20
> ACCESS.bus
> =E2=80=94 Bus master and slave operation"

Correct, and we have support for this device. Driver is named
scx200_acb. Load it and then "i2cdetect -l" should list the SMBus.

--=20
Jean Delvare
