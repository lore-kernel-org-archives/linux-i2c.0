From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c-s3c2410: Fix pointer type passed to of_match_node()
Date: Fri, 13 Jul 2012 10:32:54 +0200
Message-ID: <20120713083254.GG32184@pengutronix.de>
References: <1338370985-6950-1-git-send-email-k.lewandowsk@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1338370985-6950-1-git-send-email-k.lewandowsk@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Karol Lewandowski <k.lewandowsk@samsung.com>
Cc: m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-i2c@vger.kernel.org


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2012 at 11:43:05AM +0200, Karol Lewandowski wrote:
> This commit fixes warning introduced in 27452498a ("i2c-s3c2410: Rework
> device type handling"):
>=20
>   drivers/i2c/busses/i2c-s3c2410.c: In function 's3c24xx_get_device_quirk=
s':
>   drivers/i2c/busses/i2c-s3c2410.c:125: warning: passing argument 1 of 'o=
f_match_node' from incompatible pointer type
>   include/linux/of.h:245: note: expected 'const struct of_device_id *' bu=
t argument is of type 'const struct of_device_id (*)[4]'
>=20
> Signed-off-by: Karol Lewandowski <k.lewandowsk@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Sorry, this dropped of the pile. Applied to next now.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk//3TYACgkQD27XaX1/VRugLACfVUAabwojHig+20X4BUB83Q8J
GToAoLkwAV+jtwFzDHTkYQX0nLXADoxP
=fhcV
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
