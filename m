From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver
Date: Thu, 22 Oct 2015 23:06:18 +0200
Message-ID: <20151022210618.GC1516@katana>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
 <1438243942-26401-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438243942-26401-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anders Berg <anders.berg@avagotech.com>, Xudong Chen <xudong.chen@mediatek.com>, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Kamal Dasu <kdasu.kdev@gmail.com>, linux-kernel@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>, Lee Jones <lee.jones@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Sachin Kamat <sachin.kamat@samsung.com>, Ray Jui <rjui@broadcom.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>
List-Id: linux-i2c@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 05:12:21PM +0900, Masahiro Yamada wrote:
> Add support for on-chip I2C controller used on newer UniPhier SoCs
> such as PH1-Pro4, PH1-Pro5, etc.  This adapter is equipped with
> 8-depth TX/RX FIFOs.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Same comments as for the other driver.

And quite some debug messages left. Could you check if you still want
them or if they were mostly useful during development of the driver?

Thanks,

   Wolfram


--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKU/KAAoJEBQN5MwUoCm2m2gP/A+iuBv0Z3TZIFdYsQj8nvFD
Z3QXPImDwxjHRQsS18sWx9QvLB42nAAXZ2OlKI7ZB5K1XVKS3DdBHGBY3HYXj5bF
oe+vaxZdKP/l6lq7vTa1vIL5BaEZInhRnBcbdmz+8HeXYJKVZD/gY+8LsVY8Dhbq
VAuJncmyPbOkeg2FqSq6puRteOgaq1Vlmu0fwZMAJOqAjvXLs5xJEt+d5BroRXg+
tHkRMNWoDXbbb9d+H+nwJk73WvtAlZuCy+AY8b1En9fBBtyblb676bVC/3K36l3c
HCYBJx0xeNJZuAJH8qLoKDvp/uwQadVOg6za2ofIlXt3L1Yg3ojuyAZlK1UjiLVQ
MfzmyfzgNoEXg7XaB5IvoNKy849NuSIDnnIg6rfwTChFFfkWSx/5yJU/EB5y4Nt1
2qMP5ekKi/IeHSMVpVbuynIE83jzK1mplbFl91C3WwReI4H5mJFqF7+4iD1SL3VP
qbwfHFJ704vfWWotUO9Dszu+uAy9ZtR2YEcr93Gkae0zROoeQLpubWUMnfOCQAys
GZsCSp7I4VBmy+mkOBX2tSIox8RPhqD/bCXngzhEk7jRbLMcGwFj30VbfjjT4H1Q
AIKxPjL4AZ3IR8OaQzWTWPeC5SZseDOz26HdQ9Rr4TSigA2Wf4+No0wbIdw6u90c
8M/GP3+JLBwgfknzLeeI
=PVhA
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
