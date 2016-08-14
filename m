From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: ocores: add missed clk_disable_unprepare() on
 failure paths
Date: Mon, 15 Aug 2016 00:30:43 +0200
Message-ID: <20160814223042.GF10501@katana>
References: <1470267524-14753-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40147 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbcHNWau (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 14 Aug 2016 18:30:50 -0400
Content-Disposition: inline
In-Reply-To: <1470267524-14753-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 04, 2016 at 02:38:44AM +0300, Alexey Khoroshilov wrote:
> clk_disable_unprepare() is missed on failure paths in ocores_i2c_probe().
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied to for-current, thanks!


--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsPESAAoJEBQN5MwUoCm2tasQAK+JtFBEEkdMlQbkIhmaIfrz
ZMp6J2voQ/PFtZwkU5mo+ee4xh+qQ43AKldBxpXTTnOBw6eUCjzdbuscVErdvRSr
OdDDiQ49dUnzMT10uKPVwOCw1HTO4y+hXtMegIWU2YjwAN98pG923QutlFsgSN/P
85WM/0dLvMIqqbP42lLPgdM4tZSZ4vG5yKyHbKccrFkxVMZvsh/HK38STQceekpJ
yTPX0Dp205pq+vkt8zw7o9BlsstQYvLC/LrfYERhaT0DgpgDunyIPlRiy2YxmxhG
5Bf2sWunVjhSe39IkNwwEi2CvfnFIxlDr9SL6esq89nd3eBlek22qUm/V2cg5dTJ
ecarV2eMwF7JknOOaGf9Lzi+tQoWMRM8b0h0oKeGuMaw5orBELEupVNA7KEzLUBZ
y6Mn2WfVXf+rp4iIA0Q6Y+X5QSu2dkxjf7gCJpFuzhV6+KXmpnqNLJcgaCfofV8c
/6yb3ydPLERqHe5yTvdV7cJIXCsgMSCyhLx8Phvpl4aheI76KsuECd32s4gaYenN
NCiIBlb+ZkBw5QBpOTa8Pv2xapZF7ARlRZJORTBmQT/CJ0JWsxgWF5LKUlW8n3J9
crF2a8XvCLO28J/TRVSXFl8IU1JRrhM7bAJ+aDncOkvCoznZ/IMIIXN/rV90JU8X
pwQy+zTHwxDMpoxWUHKH
=LgH4
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
