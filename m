From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
Date: Wed, 23 Jan 2013 13:50:01 +0100
Message-ID: <20130123125001.GG16264@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liu Ying <Ying.Liu@freescale.com>, Arnd Bergmann <arnd@arndb.de>, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, liu.y.victor@gmail.com
List-Id: linux-i2c@vger.kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2013 at 01:24:52PM +0100, Linus Walleij wrote:
> On Wed, Jan 23, 2013 at 7:32 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
>=20
> > This patch adds at24c512b eeprom support.
> > The datasheet of at24c512b can be found at:
> > http://www.alldatasheet.com/datasheet-pdf/pdf/
> > 256958/ATMEL/AT24C512B-TH-B.html
> >
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>=20
> Arnd Bergmann is the misc maintainer, route this by him.

I usually take at24 patches via my I2C tree.

But not this one, though. The 512b can equally use the 512 entry. The
devicetree should contain both entries, the 512 one as a fallback. (And
the vendor is not "at24"!)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlD/3HkACgkQD27XaX1/VRutGACeOEZdhNaa8qR7iPLbpI73cp/+
25sAniEXo4ke4LbYXnHzxXt+iSOB4nyx
=mYaO
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
