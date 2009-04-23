From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/1] I2C: I2C controller driver for Intel Moorestown
 platform
Date: Thu, 23 Apr 2009 13:22:24 +0200
Message-ID: <20090423132224.25553a5b@hyperion.delvare>
References: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
	<20090416111436.296cdd12@hyperion.delvare>
	<0A882F4D99BBF6449D58E61AAFD7EDD6136779F1@pdsmsx502.ccr.corp.intel.com>
	<20090423112935.306ba11a@hyperion.delvare>
	<0A882F4D99BBF6449D58E61AAFD7EDD613677A5B@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD613677A5B-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Apr 2009 17:55:42 +0800, Wang, Wen W wrote:
> Hi Jean,
>=20
> >-----Original Message-----
> >From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> >Sent: 2009=E5=B9=B44=E6=9C=8823=E6=97=A5 17:30
> >To: Wang, Wen W
> >Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >Subject: Re: [PATCH 0/1] I2C: I2C controller driver for Intel Moores=
town platform
> >
> >Hi Wen,
> >
> >On Thu, 23 Apr 2009 17:00:56 +0800, Wang, Wen W wrote:
> >> Hi Jean,
> >>
> >> This is a description for the patch:
> >> 1. Patch for I2C controller driver for Intel low power platform "M=
oorestown".
> >> 2. The driver depends on a GPIO driver for Intel Moorestown platfo=
rm.
> >> 3. The patch will:
> >> 	a. Add i2c_mrst.c and i2c_mrst.h to kernel directory "drivers/i2c=
/busses"
> >
> >Why such a cryptic name? You know, this isn't MS-DOS, names can be
> >longer than 8 characters ;)
>=20
> :-) I can change the name to i2c_moorestown.c

Yes, please.

> >> 	b. Add items into kernel files "drivers/i2c/busses/Kconfig" and
> >"drivers/i2c/Makefile".
> >> 	c. Modify i2c-boardinfo.c to export i2c_register_board_info() fun=
ction and add
> >code to detect if a device is already in i2c_board_list.
> >
> >This last item should go to a separate patch, so that it can be
>=20
> I will separate the patch into two.

Thanks.

> >discussed. It is not clear to me why you would need to export functi=
ons
> >nobody else needed to export. It will be easier to review and merge
> >your code if the bus driver itself is in one patch and any required
> >integration changes are in another.
>=20
> This is because:
> 1. The I2C driver need to call i2c_register_board_info() to register =
I2C device info table when loaded.
> 2. To support loadable module, I made such change to i2c_register_boa=
rd_info().
>=20
> I know it=E2=80=99s quite ugly there, but I really can't find a way t=
o do so. Please feel free to teach me.

Which I2C devices are present on the bus, depends on the platform /
system. This really shouldn't go in the bus driver itself, but rather
somewhere in arch/. This is what all other platforms are doing. Just
grep the kernel source tree for "i2c_register_board_info" and you'll
see.

Now I would need to know more about the Moorestown platform.
Traditionally, PC platforms never registered I2C devices at the
platform level because it all depended on the vendor and specific
mainboard model and there were simply too many out there to list them
all. There are a few exceptions to this rule but generally we have been
relying on detection for most I2C devices (EEPROM and hardware
monitoring chips, mainly) on PC SMBus. This approach has its problems
(I2C doesn't have any official detection/identification mechanism) but
overall it works fine.

I would like to understand what makes you believe that the Moorestown
platform is so different from other Intel-based PC systems, that we
should list the I2C devices on all of them and add this knowledge to
the I2C bus driver (or somewhere else in the kernel).

Would Intel be willing to send me one of these Moorestown systems, so
that I can help more with the reviewing/testing of the i2c-moorestown
driver and the implementation of any infrastructure change possibly
required for this platform? This would speed up things a lot, I believe=
=2E

--=20
Jean Delvare
