From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers
 driver
Date: Thu, 16 Feb 2012 15:45:04 +0100
Message-ID: <20120216144504.GC2541@pengutronix.de>
References: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328714915-12287-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2012 at 11:28:35PM +0800, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>=20
> SiRFprimaII is the latest generation application processor from CSR=E2=80=
=99s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
> There are two I2C controllers on primaII, features include:
> * Two I2C controller modules are on chip
> * RISC I/O bus read write register
> * Up to 16 bytes data buffer for issuing commands and writing data
>   at the same time
> * Up to 16 commands, and receiving read data 16 bytes at a time
> * Error INT report (ACK check)
> * No-ACK bus protocols (SCCB bus protocols)
>=20
> Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

I am fine with it. Personally, I would have violated the 80 char limit
a few times to keep stuff more readable, but this is taste, I guess.

Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Ben, will you handle it?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk89FnAACgkQD27XaX1/VRvzlgCfbDIxooIlb4Yqp91Sjw1b8kuB
RBQAoJtB6ZN6uQ0HLqcNR5nsj91CBgjZ
=0xzh
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
