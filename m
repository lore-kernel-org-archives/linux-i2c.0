From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: imx-lpi2c: add runtime pm support
Date: Wed, 24 Jan 2018 07:21:11 +0100
Message-ID: <20180124062111.vi5zhtkyrdwdjg4z@ninjato>
References: <1514884312-8535-1-git-send-email-fugang.duan@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wghir24fq54uruo4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53911 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbeAXGVN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 Jan 2018 01:21:13 -0500
Content-Disposition: inline
In-Reply-To: <1514884312-8535-1-git-send-email-fugang.duan@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Fugang Duan <fugang.duan@nxp.com>
Cc: linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de, bhumirks@gmail.com, vz@mleia.com


--wghir24fq54uruo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 05:11:52PM +0800, Fugang Duan wrote:
> Add runtime pm support to dynamically manage the clock to avoid enable/di=
sable
> clock in frequently that can improve the i2c bus transfer performance.
>=20
> And use pm_runtime_force_suspend/resume() instead of lpi2c_imx_suspend/re=
sume().
>=20
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>

Applied to for-next, thanks!


--wghir24fq54uruo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpoJdcACgkQFA3kzBSg
KbbXBg//Z8LXoKaS/hdkRJJVKIer2nlBb1/yHrVjBBVWNS/TpQf0gqC4CG+uNvJZ
K+D9M32Z6yogmr8IMsm60Hj+oUaIflW0OzLHbh8/KHsjIfRCMI0XL58alueNhiO+
Y4Lr8V33nkdJSwsFtYXZEeVLRWeKdtqDV3TGcpjcjTplHu7kpbrLDPlVWrjbN7lu
2fqDNAQIC68yuYaf8QMpumSWke0WthuQY6sUGL7BM+22+IrDmTq2eKSWixXZJtlp
9yz6t4SGicGgAZnkLjrk2EbIKxpjdX91jyfXRc2EnsSxvaMOC+P0kSh+Lh8+ZbO7
D1ycn2SDVzky/uPx+6nb3CEOoksNouCy9Be0rqMIww5H78NmnTQeKxMiXdocZhO+
XUnpCOaAlAA999LoAe01AcFwyLcibNHMVDWIBH1Y+H+M7IY6WLrqyeSj1h5n7c9A
oBd9Dni6kswXNnAR3COYiD0ru0oeVoxcVBn+lusdVxrThfX+GKOfNLBONW6na26B
etiLfBPslkhvPCyCMLFaLncVTqhPBaSlO4XXoHvY8RHF1AZVcN6qWsyHrh6FBagG
Lqo0lnEg/88ZhqEYLNPCbHGYGECLmT9EzBLaBpHbmHxRUTgc2qYueMR95rO0jKn+
qR9nGUcH22GkRJXhI01hynK4RwIcP2S86I5CNxEcVVWiJb9WGIE=
=CtS3
-----END PGP SIGNATURE-----

--wghir24fq54uruo4--
