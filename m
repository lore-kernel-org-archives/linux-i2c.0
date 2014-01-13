From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 07/13] i2c: pnx: Use devm_*() functions
Date: Mon, 13 Jan 2014 13:29:07 +0100
Message-ID: <20140113122907.GB2586@katana>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002b01cefaf4$fa737d40$ef5a77c0$%han@samsung.com>
 <008b01cf0a88$85df55f0$919e01d0$%han@samsung.com>
 <20140109212422.GB3866@katana>
 <001f01cf0d9b$aba03910$02e0ab30$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001f01cf0d9b$aba03910$02e0ab30$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Vitaly Wool' <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Roland Stigge' <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> Which thing do I have to remove additionally?

Just have a close look at your patches and what you removed. You'll
figure. Hint: It is related to the resource.

> You mean the following?
>=20
> res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> if (!res) {
> 	dev_err(&pdev->dev, "Unable to get mem resource.\n");

That's one thing, there is more.

>=20
> I think that this error message is not necessary. So, I will
> remove it.

Yeah, just have a look at the actual implementation of
devm_ioremap_resource and you will *know* that it is not necessary.

> Please let me know additional things to be remove.

I believe in teaching fishing rather than giving fish.

Regards,

   Wolfram


--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS09wTAAoJEBQN5MwUoCm2eswP/25Iy3wKVsmMuQaFy9v5WLYV
n59HRD+hmm2XhPRjDq69xyncGpt/9+NMhnkUaZ1knvfJECEXXjvkcz17Yp3ajZwk
NCFUK5PrkizPInfcwOEcWuvQH0JO8GpGXMy12ee+pr3EwzFH9oYdPsE3LSouAbA3
zycvxNnUmD1YGsXKLf0BcWvEPNmG6ijIPp8EUfNU2IOPv8ST2md/wVRMoVsHpq1i
EC0wT4tv1xpnibNBNN/Dmm2o8kXHVFfZvYUNneNxBO2qJbIEJVmfrwo11l8FH83G
g9M7fgzc9B98yWBn3Cbz2DoEhD8oGNJNxzsxDtC2C8wa+Z/WWlntU4OUNWtGywB3
qEPd3T4sIwBtkhwueZN1AjBmaMMDXLsQjXjPqWtrVW0ureAEqwiQwWMmTs/BR1Kp
Ky+oHc5oOyULtz4WBD/8/X4wMWAGLS8qE7C60lK+1pGq+VgCDXBFeYtyrHHDn5xL
AZ9qNvBqB85rw1l2ldB0I8lP84XCSroGOaV1sXi1b19tA2t3IWYu/Tecqg/fxjJ4
uT7DWLZjOTfXg6msjzC7bol/2Kwk15aw8GMDSfdGgSCUu1WlCOhXpiuJ4+J+LgcV
i9DjWPTaMtdrIY3HzmKdVCrFUSCd/gReiBFlcSsJ+BA2mZbE5yE4Up9TgVYPZF7/
Muijh1uuE5K7pPllJ1wZ
=7g3A
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
