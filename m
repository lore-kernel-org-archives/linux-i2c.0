From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-algo-bit.c
Date: Mon, 30 Nov 2015 18:26:02 +0100
Message-ID: <20151130172602.GC9554@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-2-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446118467-26453-2-git-send-email-nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 12:34:24PM +0100, Nicola Corna wrote:
> Add I2C_AQ_NO_CLK_STRETCH to drivers/i2c/algos/i2c-algo-bit.c when getscl
> is not available.
>=20
> Signed-off-by: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>

Applied to for-next, thanks! Please check git-log next time to see how
the subsystem likes its prefixes, here "i2c: algo-bit: ...".


--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXIaqAAoJEBQN5MwUoCm2tuAP/0pzu5YvrhrRZQUlF7rFkb9p
4WpOZt/+FKQlQdNmIf7E+q2OabVCz7AgIZUOvJdPkf/CX1IRzTKIlW3uT8GKzbRG
AyCwCmORrTraAcGKswI7KIOT5j9z+uguCPz9mtsbOnIpAnMeQ32NME5VPZyMZO5M
hzx/HF5TYRo4yCbwQTTxwIHLA7kOH3qyb9RQZ/J2m1LHTfklKW9jGmWdjwVezKaH
tEMWnB29IZOv7RRAdb2eCZvoIunyj48CL5I105PpbZMcaWfp8RH5QEd3Ppq/RJTW
cDIYuH7LC2iEJn8CTecXCmTNu5ClrSHSuKiCjM/Gb04x6ZhJ3toxqbKF7RPQTWqr
beRXJDdh7RhooM7AoPnXOCFuHNuG7rR3RotQTJqM5wj9CEdqhdSv1aMa0zAzEvCn
Gf68ub+ErkHBI/RLCmPjitOhVi4izEG+6Ga1nYEsUpUivdzFy6BPkkPZpgizzrSi
ThAMp1VfMgFlKaeJtQB6bVn8+XcpgNkDbmJ3j0ZnENhwlTHDVUDYkQmnhFjo9gbq
hdLv7/mKpAmAci7s5O5JkfRlNXpNe7vUtX0UD6S10PwDzLtdFxfn9giNFLLVoGXw
IXLv4+nS8vrhy0mwOheNA/Q2OZjrlGhtlR0dHocfHi0xOICDjNjdHpWkfrB9zPLQ
Wqbl3VfbO5Zq9wY81SCD
=gbZS
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
