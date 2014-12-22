From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Remove support for legacy PM
Date: Mon, 22 Dec 2014 20:10:57 +0100
Message-ID: <20141222191057.GB1014@katana>
References: <1417366352-22356-1-git-send-email-lars@metafoo.de>
 <1417366352-22356-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417366352-22356-2-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2014 at 05:52:32PM +0100, Lars-Peter Clausen wrote:
> There haven't been any I2C driver that use the legacy suspend/resume
> callbacks for a while now and new drivers are supposed to use PM ops. So
> remove support for legacy suspend/resume for I2C drivers.
>=20
> Since there aren't any special bus specific things to do during
> suspend/resume and since the PM core will automatically fallback directly=
 to
> using the device's PM ops if no bus PM ops are specified there is no need=
 to
> have any I2C bus PM ops.
>=20
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

Happily applied to for-next, thanks! :)


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmGzBAAoJEBQN5MwUoCm2yf0QAJENNvpojE4xSlmieIJQeJUW
y8Ft1ss2vwDONGnq/1tiyJGWORY9ViqdRqvrN17y4kHxhGMIIFLByQb7OifIt4u1
biRHccK1r8vULUKHAPqFw3DXDL7yoCbgcso018R4415Atw67e3Z1dBPGgR9tjimf
4k3kzb63wAe5MysJRkSkwY+W2+dSHLojew0Sqmn8xszEYFrM+x7O9ZbdVA+GN/+H
Z5Ml/9DNFE5tHBPI6HlgbiIosa7HOb6mZpj361jsYlHMl6TBpLrwgPboBVy/Kc/i
0/8NZ6+CI0ORXWGADOAPhLWZMYNG/SlGe2jzhPiJP+1ZS54e798Hu+VmHyopo/8o
XCB9xPc8Y2jzIWZiT7En9Fn1w2OZ5e6cqN+kR/pRhSwwPVAEtyNH7kNNbd+kcCjE
2oFz2arX/OoXxv8uF1WIyZNV8MTyZOAn+LF4I2aIxeWhGdfuV37+GWS7+cyPQlRR
KoqMriyV/FFCIvzL/V/FRDEPIzQh0LIi52a4Yc1MtdlsvZakvproahBAVLSuD/c2
CE1cOEs/Tu41QepJU3uZhAF1uoUS39lVneQ5r1qPlPPpOd8RBbuI9Pj7w/uP5oAG
gXWRiVZCXF75hBPsX49J4X+xkOefhAT9oS4gHg1fDOOGlHWOXVLuTei5KYrXhCRF
FdOXXfUuVA6G75RuzXFu
=X8Ah
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
