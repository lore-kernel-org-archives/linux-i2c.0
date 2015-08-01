From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: designware-pci: use IRQF_COND_SUSPEND flag
Date: Sat, 1 Aug 2015 12:13:40 +0200
Message-ID: <20150801101340.GC4379@katana>
References: <1436350536-99102-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436350536-99102-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 01:15:36PM +0300, Andy Shevchenko wrote:
> The mentioned flag fixes a warning on Intel Edison board since one of the=
 I2C
> controller shares IRQ line with watchdog timer.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvJvUAAoJEBQN5MwUoCm2Wj0P+waL5pgtiH1p26dNZt52jAsa
br7MT8MpKOGjM4x3zfVYmND9AfxO3SOl4AHOf5EBRAjlacutRm5g19y8xyLNFc8T
sF4ZomNLgnHL2ji4eQuQVKfdkr78O9BAMorlvD7a5Wgy3AKl6d+0CWgY4zrsoV1z
TPy9PFCfDYR8388w8iqSBL8XwuslRFS3oznUvw3VrXSf9PtMXF+ouicBfwz3lJlU
0Xp2GXpQnqjaWRZKaxQ8z7JMOc/LQ6d6XricTeWV5/IVeSkllU8Q01S/LyBBQr3c
TdyQIbJck30vsTl3vyJpCrDYdl6v+Xbhu5y0CBbvNX0NIhqswfAU9lMMciZm8gh9
U0zej2GyS/5MnTidvIspGYlcLQAmThCaOXQwX/FB5IOaVBn3wojBeC3iqZUAosYw
4Sq6rwGyVr9htCD2/GLAJSvQzhbIY2yDAQw/z7alvPJZcNppVW1L22P0tCIIuggA
b0jk9WWXfvpgtwv1A6r892X7KKfGsUxJFdf9GkLexO0vXo2kUgMCjxt9P1iXBvKv
YT4+eIn7xVNHk7tSwPdcfQdf2P8+4k7VT9UKvrJ+3EUipfMRLszw2jJeKKsLIZ8R
V2Mwl2ZKh9kvXy7prTV0ATrkrl9xjwj32LdlLyyFjus8RnroZ40rWGLX1NtiWHLT
h0JIcst+231SjHek5bJI
=g/8b
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
