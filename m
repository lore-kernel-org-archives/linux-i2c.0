From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/6] i2c-parport: use new parport device model
Date: Wed, 20 May 2015 17:49:07 +0200
Message-ID: <20150520154907.GB2001@katana>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1432135622-8288-5-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432135622-8288-5-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 08:57:00PM +0530, Sudip Mukherjee wrote:
> Modify i2c-parport driver to use the new parallel port device model.
>=20
> Tested-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---

In general:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

>  static struct parport_driver i2c_parport_driver =3D {
> -	.name	=3D "i2c-parport",
> -	.attach	=3D i2c_parport_attach,
> -	.detach	=3D i2c_parport_detach,
> +	.name		=3D "i2c-parport",
> +	.match_port	=3D i2c_parport_attach,
> +	.detach		=3D i2c_parport_detach,
> +	.devmodel	=3D true,

Minor nit: I prefer to not use tabs but a single space after the struct
member names. Less hazzle in the future and still readable IMO.


--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVXKzzAAoJEBQN5MwUoCm232QP/1my9sLqhb5+WlQvBzR00uX2
Z61CC/qCRCeIk1qi9Mf8XhuNaYPXDIXDFmpzEde7X0k4932ROCYlIteWKgpZ73Nl
KjBHWKNHYG58I/fWgv6r7t2MYnCWjIst0nZTyzybF9jYwMl6LVFtRhZOtmxl81A9
BagLQduchdaSA38Oem5UxIIRKOzsa5uZa1joYUucpkr5mUmfemXHxup/CvYI3nZC
g8GelWHfHZqEK9j4xobqXL3Zi2ducRfe/RuJS+Y1w3mar9xELJ4U2TNYOJYlxnIm
C5YzqeY1KpW4/TQ1NLminjz6L+AZ2udDpFskFjeo/YtnaTK3LI7O/hb/S73VY506
e0diEwO3WNQG+nXJWsFm9ccj0pzthobqE5sJbd7U2BUACqLdsz/SvlvsA7SvyKBT
E+g8Br+JqJA3RxbgjcxBtxB9Z5eY71mLAd2F8+J6ELJsW9+vOJ1hQKXjdQgpX+H3
HDBRcl5F95T1HPlT1yeYjNroY6sVND0J/leRIj9XiNVM3D0e1+2U1S1blXUW3dQo
+JEe1/q2oC+8/zMoqOjIqdNqCLZ/I+J0pgv9woAPTgSRf0KOr0I/z7ci67EQMi5D
Kbwtcoj0XBVNpiX4mNxEKmG+iaMVeBtG/zB7ec9qrixNg4/I8XUqGYZGmQVonvjv
UXb23JDuvIy/m5NpLx+Y
=s2De
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
