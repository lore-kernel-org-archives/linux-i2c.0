From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: img-scb: Add runtime PM
Date: Sat, 28 Oct 2017 14:04:31 +0200
Message-ID: <20171028120431.g2eoiri2vbbeddiy@ninjato>
References: <20171028114434.17352-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="htfc57wtwajbpely"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37899 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbdJ1MEf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Oct 2017 08:04:35 -0400
Content-Disposition: inline
In-Reply-To: <20171028114434.17352-1-ed.blake@sondrel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: linux-i2c@vger.kernel.org


--htfc57wtwajbpely
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

oN sAT, oct 28, 2017 at 12:44:34PM +0100, Ed Blake wrote:
> The i2c-img-scb driver already dynamically enables / disables clocks to
> save power, but doesn't use the runtime PM framework. Convert the
> driver to use runtime PM, so that dynamic clock management will be
> disabled when runtime PM is disabled, and so that autosuspend can be
> used to avoid unnecessarily disabling and re-enabling clocks repeatedly
> during a sequence of transactions.
>=20
> Signed-off-by: Ed Blake <ed.blake@sondrel.com>

Applied to for-next, thanks!


--htfc57wtwajbpely
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln0cksACgkQFA3kzBSg
KbaE7w//YKdpaf6eAVs9J0RTP+Pvfq6MEdWpbWQPGe2GGjl24v0HicUvHlbx8DDg
6cMDDWQkvICkSaqoxBO2HL2UGEf9UOz/Fmh7ODuVe1U9Jx7ze5LpCdS7btr/1RrV
uc/Pglz3dh0j57e388tEnYMpmyNeSYf45Rm2YeoKOA+yo8p/ESgJI2pUA8PejmI7
agXZjPBTXTFe9eA0TJMnYUWsvF5ypBT7CM8mKnLd9tneC/PIFrY+V5y0ewQVxiQv
ITlt+zDRGBFjZkCar/SKssaMeM1hUbEIgpk9Z+5cRPKzckgEFN3aHt17TWGdRHQC
tWCOIbkkle8s0kTRrArQ1FW5ghbM1T1AK7Usjy8yC1LQuunaLngGW62JyknuAlcI
vofA/LSk+fzxw2mFK2BxV8U4CHihOKyWuSgXlEFD83l15ChIDN+IDbnrAKhiQ3p1
8LIevo1tDShPcCaSsGwi8vsqA5gtVM4AKSJxw3euehN45bOpvt0qzGdkw1L+uOGy
L974IfZawYmQP9pudf8g13/AS8wl+leRLqRlMvuaCnTMbXtQI3sb3yNzxQ2OmsQn
afM7QsMBSru91vTqi6Y2gtcJFgFioNU7UKtwtf58H61cDkHDofI/eS50F5n054/G
blDemO6P3nIyfbFduZJaZ6nCsw78c1HVQeD2phyJu0suN4uJ2io=
=c0X2
-----END PGP SIGNATURE-----

--htfc57wtwajbpely--
