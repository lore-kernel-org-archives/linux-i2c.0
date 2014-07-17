From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-stub: Add support for banked register ranges
Date: Thu, 17 Jul 2014 19:18:49 +0200
Message-ID: <20140717171849.GD2901@katana>
References: <20140710124511.05108894@endymion.delvare>
 <20140710125659.015f1517@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140710125659.015f1517-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 12:56:59PM +0200, Jean Delvare wrote:
> Some chips implement banked register ranges. This allows implementing
> more registers than the limited 8-bit address space originally allows.
> In order to access a register on these chips, you must first select
> the proper bank. Add support for this mechanism to the i2c-stub driver
> so that such chips can be emulated. All the bank settings are passed
> as module parameters.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Applied to for-next, thanks!


--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyAV5AAoJEBQN5MwUoCm2Gz0P/iERr95+5ZA/z72AV1pnfLwF
ZPoDF97tU5CAqX8ai9Sfp/80fgSC8BMxSkzDJEuB/Ep8kFtCadKNJFu9vX3eu+Vf
Tme7AqnTqjVlS/KiAnSGUFsGunyCYEwLMYDBGJcke5ENLzG3TdWjDo4pwDwHseoj
otzNZkhpVfHtV/nf4+QHEtAECEixuZNlCZVQjDvdnA5RbXBgu+4m8wSa8T1xaXn6
0HyQQyFbRvoIr71rqdSsF5fLXf7YN0ayU7iHWGjNVGS4ew9h7Avf9v5w40ig0SJ0
oXc2G3CSeZ5ViEVRbs+I/Kqa/Q/NFzkVWAFajuhyeXX//VRZMdF7f2vOibL9qiaf
e/fb2XTYSfcP6Ip90Kw/kzEQGnMuDqNeM1roLL8ewpNnepJDQdsSX19uzgUGGZ/q
AvUY6iDZdvw5jk/vsaRZ8Fsa5FGsO0Hp84ZttSg9Q59RpvDIo0BFJpEFew0guEZ1
0nuGHRZsk1D9zlGS+E+xzWhLCxBq3gz0gQblvDE6BTxHqvpJB+wa7KCf6VEttSSg
1lcHWW52N7X8baSKYWYI1uiTbWKxp0wa8njbM2hRI1ETFlxSR4KhXzY3yoKhM3DF
LZTIQe53F0tniot79GYTxZA/aG9h9FgnlQ5Ke2uawvkDOCaYK+yhVK/LckPYtcGn
K1fnQNnCY/ojb0RATJQ/
=PcDy
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--
