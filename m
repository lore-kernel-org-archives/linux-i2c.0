From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND, 1/4] i2c: mpc: get MPC8xxx I2C clock prescaler before
 using it in calculations
Date: Mon, 15 Jan 2018 19:21:45 +0100
Message-ID: <20180115182145.vfic2xo6cyx5etl5@ninjato>
References: <20171207102003.23496-2-asolokha@kb.kras.ru>
 <20171230181814.4ppgyqg6mcfahkdh@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="434jjmcjaccae2qk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40952 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeAOSVr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 13:21:47 -0500
Content-Disposition: inline
In-Reply-To: <20171230181814.4ppgyqg6mcfahkdh@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>


--434jjmcjaccae2qk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2017 at 07:18:14PM +0100, Wolfram Sang wrote:
> On Thu, Dec 07, 2017 at 05:20:00PM +0700, Arseny Solokha wrote:
> > Obtaining the actual I2C clock prescaler value in mpc_i2c_setup_8xxx() =
only
> > happens when the clock parameter is set to something other than
> > MPC_I2C_CLOCK_LEGACY. When the clock parameter is exactly
> > MPC_I2C_CLOCK_LEGACY, the prescaler parameter is used in arithmetic
> > division as provided by the caller, resulting in a division by zero
> > for the majority of processors supported by the module.
> >=20
> > Avoid division by zero by obtaining the actual I2C clock prescaler
> > in mpc_i2c_setup_8xxx() unconditionally regardless of the passed clock
> > value.
> >=20
> > Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
>=20
> Applied to for-current, thanks!

Reconsidered and moved to for-next.



--434jjmcjaccae2qk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc8TkACgkQFA3kzBSg
KbaOPQ/+J9VAJztN3VH0yWqHHl1Lxps5CmwlIx61iclEVVugB+4TlsvSZi//58pI
Nl2ZAy7hqPOwdNW34xJebef7m9UNSgFjOehj8W2Hkeo9KQSFiceN8HHRrwnL79Kf
Jno3g6x51gypdWHLUHG/N95+Y+vp69gtRdee4gvDRhvmOIj+LkvusgSd6LBd+MEI
WK3XOl4Yb+rpYmaH13snllvFJ6KZxCTIabzZbyDUYE+VJQhUG6zgqp10WIWyWyft
n95tmuTY3C/qrMnP3D0GyPpAZRoznIx1U6EVQqokeuJy4qA32Fm0VyUvQb+9YzJI
5wF8lqdCvnVzfHotiDEvK0nxrdUtmrNCF9fhwWlcNwXJDBM+yqQS8tkxWCtopiSO
tvj/VlqU4XBYI0NLCM6pvE6n0m6iK4FDW2pwwlwVBqUOxa/FWAqSoQLtrCl84hF1
Oh/q+IeF/TC07j1g0nbXNnJTOIIqyZSImATfV0YTGuLsxlMzsRsJxqrO2n96wcOx
HLL+OXDFHyRVuutvVPtDyT053jxsFDrEGn3ZDPNhiHz750vQVipd3EePnE51PlI/
RWA9dhZA77enIliW3FwO9crmCCJLb4n9dAyp/J16zo4BDkbz1aDZBamQpaWaL9rK
c+U+uUnryMrMmeZufotkOoCeSWcxGYcXe1TiyNMUpElf6ez3FJY=
=eRsM
-----END PGP SIGNATURE-----

--434jjmcjaccae2qk--
