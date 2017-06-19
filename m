From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xlp9xx: Enable HWMON class probing for xlp9xx
Date: Mon, 19 Jun 2017 16:23:12 +0200
Message-ID: <20170619142312.ednr6dgudhniq5og@ninjato>
References: <1495712535-30712-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uhk2sih4h2ca6pv4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53430 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdFSOXO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 10:23:14 -0400
Content-Disposition: inline
In-Reply-To: <1495712535-30712-1-git-send-email-george.cherian@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--uhk2sih4h2ca6pv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2017 at 11:42:15AM +0000, George Cherian wrote:
> Set I2C_CLASS_HWMON for xlp9xx to enable automatic probing of BMC
> devices by the ipmi-ssif driver.
>=20
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Applied to for-next, thanks!


--uhk2sih4h2ca6pv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH3lAACgkQFA3kzBSg
Kbayow//eYTqI++GhfUtdnLiwOD13YHpplyviF+rcQGVVKeOH9/BN7nxLCVWQAvj
qI8Y4hLtwWarwO1NzZ1vWSsHKVddDzTzwqxyjyRc+jTxnJzcmTd55m+jETFT1sbl
c1DfJYYZk5bOxM2HrIZaJHeQJ/HjLirL06f6dKWNAapnX6o7iFdUm3lqiUvYsqXv
2KEusNnpTUhhR89mWHzlu+Nh+TFXv89NxMYEDd5iaUrdet9KIxNB61dAMyrbBwyY
Uise+p5xuQEoI91tt7rrZgLbBuQsQYfPbDbkH4YvehEJ2f53KyEESfF5njN0KAsq
zXjOsvVjhCmGA5sFhFHdZkTx+Jy5KEgL5/5RHA3nTLH7HuUVR7cexGYLBdlg0B0x
ww2R8TQMO7CZ+metKuyneciqSvWUf1PRPvSbdA03kFP75VdoBx7GkDk8/bBcL0UW
USSLJH/zXsSAQmui80P5qOhjBRU7RZU464ORgyjRO28YqiTeHDUd4AYVPv08xQVR
4CDhygjjc9RdAF2ybWMUGFVuShJOBT1yuKkGJ0Z56ChPhJtWppfKQQcybrrLKWi7
c4dvMCxxKA8tDHualv/Lu+3DKMr5CfrHNwCHjm/j9gRfC52Zd06D0G/iAiSfr5HE
mPpKFGkIVmf47CNsatGg0RHTDtN2mXTm96r+T4GigTtwSDBG9GU=
=SNyw
-----END PGP SIGNATURE-----

--uhk2sih4h2ca6pv4--
