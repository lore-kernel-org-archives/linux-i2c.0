From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Poulsbo I2C - /dev/i2c not seen when loading i2c-dev
Date: Fri, 1 Apr 2011 12:10:27 +0200
Message-ID: <20110401121027.49ce012b@endymion.delvare>
References: <fb407773c6a76f3ffef06ff357df2118.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fb407773c6a76f3ffef06ff357df2118.squirrel-N82HvsEaY4mscnXkh+DeetBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 31 Mar 2011 18:07:26 -0400, simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org wrote:
> Hi all,
> I'm hoping that someone here can help. I am trying to get userland ac=
cess
> to the I2C bus(es) on an embedded system, however recent kernels (ie.
> 2.6.38) are not 'loading' any buses when I 'modprobe i2c-dev'.
>=20
> Going back to =E2=80=9C2.6.32=E2=80=9D I am able to see 1 bus, and 'i=
2cdetect 0' shows a

This is a problem on your system and not a general issue with i2c-dev
in kernel 2.6.38. i2c-dev merely creates the device nodes in /dev, it
doesn't create the buses themselves. So, if loading i2c-dev doesn't
create the device nodes, odds are that the i2c buses are missing in the
first place. Check in /sys/bus/i2c.

> single device sitting at address 0x69 (which I believe to EEPROM on t=
he
> wifi card... not confirmed).

Very unlikely. EEPROMs typically live in the 0x50-0x57 address range.
At 0x69 is almost always a clock chip.

> The board is built around the Poulsbo and therefore using the 'i2c-is=
ch'
> driver.

Check for error messages when you load the i2c-isch driver. Note that
in kernel 2.6.34 the structure of the i2c-isch driver was changed, from
a standalone PCI driver to a MFD driver. Please make sure that you have
CONFIG_LPC_SCH installed and driver lpc_sch loaded, otherwise i2c-isch
will never see the platform device it is looking for.

>=20
> Reviewing the schematic I see that there are several buses, each goin=
g to
> individual components:
> IT8516 U5/110+111 -> LTC1760 U6/18+22 [battery charger =E2=80=93 0x1A=
/0x12]
> IT8516 U5/115+116 -> W83L771 U60/8+7 [thermal sensor =E2=80=93 0x18??=
]
> IT8516 U5/117+118 -> LSM303DLH U64/19+20 [accel/compass =E2=80=93 0x1=
9]
> POULSBO U2/G37+H38 -> PCI Express Socket

This suggests that the board uses the SMBus controllers in the ITE IT85=
16
Super-I/O chip rather than the Intel SCH south bridge. Unfortunately we
have no support for the SMBus controllers of the IT8516, and I doubt we
get support anytime soon as I was unable to find a datasheet for the
ITE IT8516.

> I am a little dismayed by the comment in 'i2c-isch.c' which suggest i=
t can
> handle only one i2c bus at any time.
> --
> /*
>    Supports:
> 	Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L)
>    Note: we assume there can only be one device, with one SMBus inter=
face.
> */
> --

This is a limitation due to the driver design. The i2c-i801 driver has
a similar limitation, but is was solved when needed:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D0cd96eb0a74791cacb27ace902b991cfd0e72abe

But according to the information you provided above, this is all
irrelevant anyway, as the Intel SCH SMBus isn't used on your system
(other than for a clock chip you do not care about.)

>=20
> This seems to correlate to these comments:
> http://www.linuxforums.org/forum/programming-scripting/175147-smbus-i=
ntel-sch-us15w.html

I can't see anything interesting in this post.

> Can anyone confirm whether this is actually the case, and whether it =
is
> possible to configure it to use a different controller address. One w=
ould
> expect this to be a module option I guess, however it doesn't seem to=
 take
> any.

A module option to specify an address? Come on, ISA sound cards are
gone! :p

--=20
Jean Delvare
