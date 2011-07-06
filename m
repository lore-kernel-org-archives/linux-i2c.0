From: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Wed, 6 Jul 2011 10:10:25 -0500 (CDT)
Message-ID: <29201825.112.1309965025512.JavaMail.root@zmail.rockbochs.com>
References: <20110706170531.2f3bed19@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110706170531.2f3bed19-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

----- Original Message -----
> On Wed, 6 Jul 2011 09:40:15 -0500 (CDT), Tim Nelson wrote:
> > ----- Original Message -----
> > > Hi Tim,
> > >
> > > On Tue, 5 Jul 2011 12:06:13 -0500 (CDT), Tim Nelson wrote:
> > > > I've done that:
> > > >
> > > > root@aaa:~# lsmod | grep i2c
> > > > i2c_dev 3382 0
> > > > i2c_core 12703 1 i2c_dev
> > > >
> > > > But, nothing of interest in dmesg other than:
> > > >
> > > > [108414.944722] i2c /dev entries driver
> > > >
> > > > and running i2cdetect still turns up nothing:
> > > >
> > > > root@aaa:~# i2cdetect -l
> > > >
> > > > Any thoughts? Does this specific Winbond chip require a device
> > > > specific kernel module to operate such as those found in
> > > > /lib/modules/2.6.32-5-486/kernel/drivers/i2c/busses ?
> > >
> > > As I understand it, the W83L604G is a GPIO expander on I2C/SMBus,
> > > so
> > > what it needs is a driver in drivers/gpio. We don't seem to have
> > > support
> > > for it yet, unless it is 100% compatible with another device we
> > > already
> > > support.
> > >
> > > On top of that, you need a driver for the I2C/SMBus controller on
> > > your
> > > mainboard, to which the W83L604G is connected. Without it, you
> > > won't
> > > even be able to talk to the W83L604G. You did not tell us anythin=
g
> > > about your system so we can't tell you which driver that would be
> > > - if
> > > we have a driver at all. Does lspci say anything about SMBus? If
> > > not,
> > > what is your system based on?
> > >
> >
> > Greetings Jean-
> >
> > The board is running an AMD Geode LX CPU with the CS5536 companion
> > chip. Here is the output of lspci:
> >
> > root@aaa:~# lspci
> > 00:01.0 Host bridge: Advanced Micro Devices [AMD] CS5536 [Geode
> > companion] Host Bridge (rev 33)
> > 00:01.1 VGA compatible controller: Advanced Micro Devices [AMD]
> > Geode LX Video
> > 00:01.2 Entertainment encryption device: Advanced Micro Devices
> > [AMD] Geode LX AES Security Block
> > 00:0e.0 Ethernet controller: VIA Technologies, Inc. VT6105M
> > [Rhine-III] (rev 96)
> > 00:0f.0 Ethernet controller: VIA Technologies, Inc. VT6105M
> > [Rhine-III] (rev 96)
> > 00:12.0 Communication controller: Tiger Jet Network Inc. Tiger3XX
> > Modem/ISDN interface
> > 00:13.0 ISA bridge: Advanced Micro Devices [AMD] CS5536 [Geode
> > companion] ISA (rev 03)
> > 00:13.2 IDE interface: Advanced Micro Devices [AMD] CS5536 [Geode
> > companion] IDE (rev 01)
> > 00:13.4 USB Controller: Advanced Micro Devices [AMD] CS5536 [Geode
> > companion] OHC (rev 02)
> > 00:13.5 USB Controller: Advanced Micro Devices [AMD] CS5536 [Geode
> > companion] EHC (rev 02)
> >
> > There are no SMBus controllers listed. However, The datasheet[1] fo=
r
> > the CS5536 notes there is an SMB controller within this chip.
> > Details from the datasheet:
> >
> > "System Management Bus (SMB) Controller:
> > =E2=80=94 Compatible with Intel System Management Bus,
> > Industry Standard Two-wire interface, and
> > ACCESS.bus
> > =E2=80=94 Bus master and slave operation"
>=20
> Correct, and we have support for this device. Driver is named
> scx200_acb. Load it and then "i2cdetect -l" should list the SMBus.
>=20

YES! The SMBus is now detected. I'll continue working with the i2c tool=
set further.

Thank you for the pointer!

--Tim
