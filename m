From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Fix the alignment of the device table
Date: Wed, 16 Jul 2014 19:23:09 +0200
Message-ID: <20140716172309.GD2759@katana>
References: <20140623103658.57df2c14@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140623103658.57df2c14-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2014 at 10:36:58AM +0200, Jean Delvare wrote:
> A long name broke the alignment, shift the columns a bit to fix it and
> make the table look nice again. While we're here, switch to the
> standard comment style to make checkpatch happy.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Hmmm, what about giving the names even more space so we have some buffer fo=
r the
future? And what about replacing spaces with tabs?


--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxrT8AAoJEBQN5MwUoCm2hzIQAJ9QZSX87GsmB0il894FyYnR
hj8QV0PeTI7xzx5toYtDpe9wTLhaHg5B9hJ8huhzXl+uEeOF8aVyL7w3k5g62Jyb
jF5upRrdgo1NLQG9chHcPYjYwmXkCEnyMfZReGPW+7mZHOvTVTdYxsFUUsxwfAan
jJ6noW+xMahXiQRkXn64ZkktKPZrISkOffAS5ntCYwjqAOIh2xBE7pHuAP9ddHM7
+WnQhteO7/zlf4HQJCOcMjkT0bORLrtc+8J9RHb2DSJfitQEDM93kA769/p8NNjb
x6I8rpHXQxVi0M8/pV8903D/D5KkSCM3IYc871+ktYsDAIlhIHNYmy3bQ1vm2TA4
7S7vYKUeyafTk9gJf/9fpTFQrVg3+azjV1Q5T0/TdgXwxa52suL1Ecq1BDIalYc3
scxvxjCrR+gJ30PYO4VCY6zkj3Q2Y/QISuRcBrCgel0oa5XCfpP0utuIoPFpmJAC
D2rC/un1Tr6nJyNLIV4a71D7BdS1OjM00C0rN1dohm05BV1IntnY+p7/B2Dbh0Dy
uyffss7fvGGrz6e4+ItDafV7iZcPlFFMnBtovMh4YgzN2MYgDdlhoqO7G1Du5f2W
9A5T58qC15e3Y7vb1YsaVyZmrzhGQxu1cFOIqP1MBNwnVGvne/8F5uqC/LKQIXaF
X0EW2k7ZByS1ypfginW5
=82XT
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
