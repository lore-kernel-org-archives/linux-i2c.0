From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: update i2c clock divider for each transaction
Date: Mon, 2 Jun 2014 18:03:45 +0200
Message-ID: <20140602160345.GE2654@katana>
References: <1400552505-22954-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400552505-22954-1-git-send-email-b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fugang Duan <b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 10:21:45AM +0800, Fugang Duan wrote:
> Since IMX serial SOCs support low bus freq mode, some clocks freq
> may change to save power. I2C needs to check the clock source and
> update the divider.
>=20
> For example:
> i.MX6SL I2C clk is from IPG_PERCLK which is sourced from IPG_CLK.
> Under normal operation, IPG_CLK is 66MHz, ipg_perclk is at 22MHz.
> In low bus freq mode, IPG_CLK is at 12MHz and IPG_PERCLK is down
> to 4MHz. So the I2C driver must update the divider register for
> each transaction when the current IPG_PERCLK is not equal to the
> clock of previous transaction.
>=20
> Signed-off-by: Fugang Duan  <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---

Applied to for-next, thanks!

One change, though:

> +	/* dev_dbg() can't be used, because adapter is not yet registered */

This comment is outdated. I removed it and the __func__ printout.


--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjKBhAAoJEBQN5MwUoCm25i4QAI23fxBasDFHb7nDW84YT1LD
v5y5Ro5bDrWWkGwRyEmbIImnZ7K7VqSHx6LzSYtNgDRcEWqPpdbDRoW0Fw/BYFzN
7hBrkLLOoNFgtVvXur00yXdEkpnfjwU5dyJrEHRKuP2ReqsGwLCNdrk1OhGzNJ1k
1gJeMHPd4jJ6OUJ7K3ViXQgY3LQF01eDYvukEtZxr7JeRXzoS7UsvgYB1j7IHo6S
pM1v/OvA3i1Akti2Km7XC+vifSMnBkzdXuBxS433Iquy/G1MXOF75lS6EiUubLvB
Kr8t11+kYclK1JHfLbdT5UNiHkLmKdz5F0cZuNiNACzk42nw/6B2LkGvUUk69Ee3
lp7xBMOVy4MDcnWHeKGePre41hSwOivPXs2+ocAYZQEornbYlUVCxSWK1nRzIR1/
HHHVgVTKM8Qq6TuBpJwAYHv5nIx+mnYREDm4cp2XpU34Z5ibKvO7yv6F9v2izO8x
tvOaxBFNBlJjzJun2xMXVv0M5o6L663BdKqUYM9wfCvminFNp6du89+/wwKXXdaU
UdgYjhIrgIGps1fJ8Fpm3mQDKTuPr1l3UDFcNcklB7amr5h4oRf0s4zAjcnvAocU
kV/Sd4eZPj54W2I+8mvx4IfNohTDuxrynpnkIX2q9JHjXLpn5llvdbzUVcJrJB52
VUUsi8rdUayXlJCAuCkG
=Mj0v
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
