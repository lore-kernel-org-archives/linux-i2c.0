From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c-i801: Fix the alignment of the device table
Date: Thu, 17 Jul 2014 19:52:51 +0200
Message-ID: <20140717175251.GF2901@katana>
References: <20140717150324.7f5a27d0@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140717150324.7f5a27d0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 03:03:24PM +0200, Jean Delvare wrote:
> A long name broke the alignment, shift the columns a bit to fix it and
> make the table look nice again. While we're here, switch to the
> standard comment style to make checkpatch happy, and use tabs instead
> of spaces for column alignment.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyA1zAAoJEBQN5MwUoCm2xucP/3Q3sVM5Q4B3pKv6aDI9hR8q
vHCymhAUtGQiraKAql55wLrjzkddDxjAzcTQ+c3jexpi4AdK/z633Ud6f7jZofgh
YE3KUEOWOokPOlKoZTRURzeUOnKxMKwhGqaMhKkOwknOHa5AoiRejRhwimCBBkcH
XyFdgZ3sgmouBW+zpOgKe05AzQ2fYAqXNObhOXERbrEC8qFSV9T/QS1ctGxI58Ze
vN5HJePJqSncEzdTQ34dOD3aw5Wx8uBa+VpucPco6IjPfjuQ7gmB9/Wt8xcCSMhr
jfWSOQIGIeeieT0ZOb4/qKRomGLbaqP4HHbnQ25aAXjvfbpSbBR8ceLBVCeFPbsE
yPfK048dQHvrfKXJQRsJ2dDFewHrrv/iPXj2HeGAyXDcB4W5DwtLqXU0wDi4ky7q
peEYULeSFNcPVampWhKzxLR7usO9FjP6H2TRumrWJlfOhcAKelqHJd3dEQEZrrji
0zgtAqFoENapY2OoIVzWg45ptws2CkZOaFCxBB1EoAdseEoISxy1WBunSfM0F8ML
IbIdQde7ZxXkDlkAKnCaf65AUa6ria74zvzlJ0GyuSTV3T2T7I2QWtt7N0X4ovqB
iwhMbr9Ue16XhTnOo1ckogI6WchW4Ktsl4PnZj9oWPNGwXpts1QxxAw5Go9I9VCA
AVRYDIeAwVm63iU3mstx
=ezHt
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
