From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: bcm2835: Use devm_ioremap_resource()
Date: Sun, 9 Mar 2014 21:46:34 +0100
Message-ID: <20140309204634.GD2835@katana>
References: <001101cf2729$890d5b10$9b281130$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001101cf2729$890d5b10$9b281130$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, 'Florian Meier' <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2014 at 10:02:36PM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and remove redundant return value check of platform_get_resource()
> because the value is checked by devm_ioremap_resource().
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHNMpAAoJEBQN5MwUoCm2SUQP/2kveP6AgSDWhVqPUkl/tacY
rja772Ugs8mxoaC73nhwuVFjinRO2t0hWSbwH9W9nePk+iXiQ/6s0I8D117cIFcT
+cEs9BvEOZj4D9lzirOygzGBDtOdl65HaSB35GzvsWpUD90DmSN0r/zNcBSyByww
ZJZu7sXaJT9+8a5D/V6I4xCRQNyTfrMHeEm9gHckL39VnM3YPaZgrisprczJG2jX
/hQu9p2aWPvAgvmUs9xY9QI5hfvW5WlAp4awdvD/hPC1/9MHJ5471mbZO1smChWl
iRr21hQveueicnAkymGiOmnsqkFBgvdsEbOWPWBWJab2Nevm7OCli45zm+/XvReI
dW5aJ25phSWuFShwh/zP7ezPZ7hfaiuZ+Aiaw/znrsgSfBFIr8WnkpuSWO8LBCve
yK3Ft5LEbxGcewfs49yxwRDXNuWceCcmErtHblkwnU0YGR1V83TvGp6ZYIr3JIzD
IJQx2mKuwBqHUVy25GuwDUDiK4tcbbrhMQIvuXVwASSSShbahUQMh2e4hbGluVV5
5Wmb8qMpPLyKR+ltVjt4U758mlt8nRNqp1SAdKP5gbpclR09wH2UAMY/2v+IMcGu
oNg7H/yZcH4q4sGabYmZz0sXd4rVEuQig4vCH+1V4ohBfhgwgvIRjiulRGQ3FuFU
65BKzNiczfYJU4Z5SIIx
=DY4E
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
