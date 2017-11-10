From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Fri, 10 Nov 2017 15:50:38 +0100
Message-ID: <20171110145038.i4jnqsctdzkfmoe5@ninjato>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="juvuuhnqneeo2yem"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42942 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752522AbdKJOuk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Nov 2017 09:50:40 -0500
Content-Disposition: inline
In-Reply-To: <20171107201857.5752-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>


--juvuuhnqneeo2yem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 09:18:57PM +0100, Linus Walleij wrote:
> Arnd reported the following build bug bug:
>=20
> In file included from arch/arm/mach-sa1100/simpad.c:20:0:
> arch/arm/mach-sa1100/include/mach/SA-1100.h:1118:18: error: large
> integer implicitly truncated to unsigned type [-Werror=3Doverflow]
>                       (0x00000001 << (Nb))
>                       ^
> include/linux/gpio/machine.h:56:16: note: in definition of macro
> 'GPIO_LOOKUP_IDX'
> .chip_hwnum =3D _chip_hwnum,
>               ^~~~~~~~~~~
> arch/arm/mach-sa1100/include/mach/SA-1100.h:1140:21: note: in
> expansion of macro 'GPIO_GPIO'
>                     ^~~~~~~~~
> arch/arm/mach-sa1100/simpad.c:331:27: note: in expansion of
> macro 'GPIO_GPIO21'
>   GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0,
>=20
> This is what happened:
>=20
> commit b2e63555592f81331c8da3afaa607d8cf83e8138
> "i2c: gpio: Convert to use descriptors"
> commit 4d0ce62c0a02e41a65cfdcfe277f5be430edc371
> "i2c: gpio: Augment all boardfiles to use open drain"
> together uncovered an old bug in the Simpad board
> file: as theGPIO_LOOKUP_IDX() encodes GPIO offsets
> on gpiochips in an u16 (see <linux/gpio/machine.h>)
> these GPIO "numbers" does not fit, since in
> arch/arm/mach-sa1100/include/mach/SA-1100.h it is
> defined as:
>=20
>   #define GPIO_GPIO(Nb) (0x00000001 << (Nb))
>   (...)
>   #define GPIO_GPIO21 GPIO_GPIO(21) /* GPIO [21] */
>=20
> This is however provably wrong, since the i2c-gpio
> driver uses proper GPIO numbers, albeit earlier from
> the global number space, whereas this GPIO_GPIO21
> is the local line offset in the GPIO register, which
> is used in other code but certainly not in the
> gpiolib GPIO driver in drivers/gpio/gpio-sa1100.c, which
> has code like this:
>=20
> static void sa1100_gpio_set(struct gpio_chip *chip,
>                             unsigned offset, int value)
> {
>     int reg =3D value ? R_GPSR : R_GPCR;
>=20
>     writel_relaxed(BIT(offset),
>         sa1100_gpio_chip(chip)->membase + reg);
> }
>=20
> So far everything however compiled fine as an unsigned
> int was used to pass the GPIO numbers in
> struct i2c_gpio_platform_data. We can trace the actual error
> back to
>=20
> commit dbd406f9d0a1d33a1303eb75cbe3f9435513d339
> "ARM: 7025/1: simpad: add GPIO based device definitions."
> This added the i2c_gpio with the wrong offsets.
>=20
> This commit was before the SA1100 was converted to use
> the gpiolib, but as can be seen from the contemporary
> gpio.c in mach-sa1100, it was already using:
>=20
> static int sa1100_gpio_get(struct gpio_chip *chip,
>                            unsigned offset)
> {
>         return GPLR & GPIO_GPIO(offset);
> }
>=20
> And GPIO_GPIO() is essentially the BIT() macro.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Jochen Friedrich <jochen@scram.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next, thanks!

This from checkpatch makes sense to me:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> =
("<title line>")' - ie: 'commit b2e63555592f ("i2c: gpio: Convert to use de=
scriptors")'
#21:=20
commit b2e63555592f81331c8da3afaa607d8cf83e8138


--juvuuhnqneeo2yem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloFvLoACgkQFA3kzBSg
KbbyVw//QBsv11+BvXF+GmBpmbDj+sa0CZUbIBd1/7m0jN/P8KE2DanxxB+BPjPd
6HZhIZof/R2AJH6D2cBNC7wmPcW3RzYrdT48jkTn0a0KFEFTq2rRtUJWIA/axgxH
qhWx/3vfMVJPa1xoddsOu0S2lL/rwAsDeJG0uRsriJEfLJ+Bfg3rE8VUIYcC8Cyz
xV4mIZSo4YXJSJ3wkO3lzUx8lg6JoAZepNTabU4RP5d8muUemqMxLFy1Q6mTL02d
mJviPzOZtgJb9HUGnndBy00vvPHImqr0G4ingPZEzO85zYzauXb6hz27Ss7CNhnm
mYMekdhHzltNH1oZFC5m6zTMeR37rxLC7nn4/W11RUEIiqXK4pqevuQCL6Ph2ehB
+zFb9fBfDl+oh8uia4X0VItbGSXRuKxPn4KrV51S5PdOxEgHInSOgOAd1DDXmCov
U/flKjHik7THnf795CPB+MwQw4sq2lKTNTjoViSLtm4lk93GASoIffefZ0r2f9pJ
L/EN8qTl0CyrHcnLOeJ3aLFJxb32Ri/oPY7KCEaaqGw6gE+Q/mV5U2EJfOiUp68k
7HWILLZV/hRtcZ5u4qgp2h4CnrlJT69+cYo/q/EZmHz2QtFuGH45o5Gb0x1DmRX8
cbr3etZHtraBcp+IRP2zvg6Y/3YdMfxtt/OR+zpGE4ymoB9pOZo=
=2SCJ
-----END PGP SIGNATURE-----

--juvuuhnqneeo2yem--
