From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH][i2c-next] i2c-cht-wc: make cht_wc_i2c_adap_driver static
Date: Tue, 29 Aug 2017 12:09:41 +0200
Message-ID: <20170829100941.ipn2zt4or7znee37@ninjato>
References: <20170816091659.10738-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="piib7iadrgtwifmq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816091659.10738-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--piib7iadrgtwifmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 10:16:59AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The structure cht_wc_i2c_adap_driver is local to the source
> and does not need to be in global scope, so make it static.
>=20
> Cleans up sparse warning:
> symbol 'cht_wc_i2c_adap_driver' was not declared. Should it be static?
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-next, thanks!


--piib7iadrgtwifmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlPWQACgkQFA3kzBSg
Kbal1xAAlTydYraexrPmfeFbK/vNn2KQdr7epogoEAuGncU9Wrm0Xb3kCRv0fk/f
oMJHtFAjjnOSkwNuWfcaPcMa4lMSbAExGmiiPTJF0GKSZXBO2Aeb0EnzGmv+BSfB
F8ruJXqhzodzhIL/uGht5kP+kQWGy1jj+nDHwkGBquv2PxqT3/kKP/suG0wL3AA6
jorbWeorWdMasIBxlYp3qfM/0evRejLQUtQ9FBYUyhwjpaNePezA12gf4/5YWA/r
hErTEhGP/rQHw9BqWYOQ1KkKywc+9FBEQlVDqSeWodFIu841ewV5WXktk9hZkniA
OxD8lQUfU0fGowEqq58WQCCKBaey/O/QUdH0onPQJu0t6bN9dDoXkBVDeCqFM0D/
8my2JOn3EgAQ73hmT9GUKXUPV3Zx0oH57yIAHEXZXAZ5r7BmZGNo5Sn9pWVDNlMJ
n36RReruIbiJPlbW7w7jj4zcn7CggPcD5UEoTS972uj1/6q9KokcX6yZTW12qVj1
LzFp80zdXZbDaG/89hzUtKn2cegroXelKp7OezTBdlHEmg6ELNibeRfwwNSfv4gq
Dva27NMsz3BWzaH/AgrjYTdz63QU7xvomWm9Yx8jaH1qw78WtsC5h/P958M/e5Un
Yj5fg0dg6l5iOVftB6D1MSMfOWqcHthGkAI/d1ydMTAB/1HTCH0=
=Tkvv
-----END PGP SIGNATURE-----

--piib7iadrgtwifmq--
