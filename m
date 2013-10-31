From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [patch] i2c-scmi: remove some bogus NULL checks
Date: Thu, 31 Oct 2013 12:57:49 +0100
Message-ID: <20131031115749.GC3431@katana>
References: <20131019084622.GA9312@longonot.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131019084622.GA9312@longonot.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Toshi Kani <toshi.kani@hp.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2013 at 11:46:22AM +0300, Dan Carpenter wrote:
> "obj" can't be NULL here.
>=20
> We already know that "pkg->package.elements" gives us a valid pointer
> so the next pointer after that is also non-NULL.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to for-next, thanks!


--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSckW8AAoJEBQN5MwUoCm2zb8P/ja1eD7gaDcs9zslq1ndaZXe
vB/mz7ZKvyCxCmI35jz1zJxARS7/yGXEFGqptn99PcXizVXkVlDBLxJTw20sYAUD
o20aJuqs7tzt3ksgjBnfAUzxczIGUxHtvIZ1idUx0u4Uklm0sIJ9PYgqWqNVTO58
1WBZ+gZgF4lzVcUFECOa/Lj6PjLHVblF3JatgpXOAS0Pw3mQFxqLsmBzmshYBspX
znjvPAgGPpT64HgNhrMoFUv+NUKnFP0o1oBpeKrd0/bHxY2S8kfcAO0mVnM4IP59
MWAUKC/imRai5Gy5Ln4zbyYSFrh5HLEOxT0YMZSoa15eWG6Uyzt6ABxWqlZ41WGX
9PFjDetkmtdhZqQJYrgn6a6TvvuZngBjBNRmHfIV7cg0136VhI9T+OKulysar968
654QWniAsS+9ktdadgLOfWwblolRkBl5GA38/KBIRvDlLwNH7tVK2U4BKxqgPqPn
GgdgF0lB5WKdRSYEJUoONRZgdYLrsKwAd6GaPRM59W56XLsVe0pzGM42EDTwbril
odtuCwOcgwnljBte26x8arfnioW/JttqKEa9rJtEnuaymFHOgrkcoFq9FdD37P7r
zES4eNFt31jJhh1c6JMSRRXBAeo4p701Th8qAR8HVmgGU9OB4PfjAVgZhgiCLWAI
ZWRQMlLGmWRqlbBf7b3g
=P6HC
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
