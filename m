From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Date: Fri, 15 Feb 2019 10:18:47 +0100
Message-ID: <20190215091847.pkagndsndjzumzwd@ninjato>
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
 <20190115224351.rtbqaqro5pl3dvov@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qchyiiv27q5ypmam"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115224351.rtbqaqro5pl3dvov@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, Juergen Fitschen <jfi@ssv-embedded.de>
List-Id: linux-i2c@vger.kernel.org


--qchyiiv27q5ypmam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:43:51PM +0100, Wolfram Sang wrote:
>=20
> > All errors (new ones prefixed by >>):
> >=20
> > >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] un=
defined!
> > >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undef=
ined!
>=20
> That needs to be fixed. Rest looks good to me!

Ludovic, do you have time to fix it? I would really like to apply this
series for the next merge window.


--qchyiiv27q5ypmam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmg/MACgkQFA3kzBSg
Kbaxtg/9EujPwpdjaYtxYjWa2I4ETfR0dHWnklKyaTbLIDlAi1HZnfhQ656dWaat
h+FpC6m9SubOr3DeJxG7XVBsygDvn8AnWS0UJPxzYlBSuOl+XAPoDdpiBwMugpEL
mKBOyBiLUQ8M7L1LzGHvgnm5Bm3r4xBirPVBYckHc5S2kMGqgarQYopILiwrC62D
6b+eyKYWbcmpESEIwPz7Sl6KbcOb1WzEJbdmxNCFDmzQhV4K15fMl/BsrRSb0OLa
9qwhzQ+suUHXk6plDkXg49qvzxEZmPEPg0fDLFAdDHKUVNnLitgj+2DzSdAxSv5c
PpQaWv82b4CxxAyMi4Zm35CsfwiLb4fhMnfflZh0AaCoRBQit9/R/ROPCFmMVkSG
2LJ3ap6eENveUXifYjqNV4aoucOtvcQrn0u2Dt2WhaVrlImVoq7hW7+JirzTZxUd
VpPdsB9Zx7yU/6EgeuzvXaeH780vuWkGezw7GgnQMA9as1KQXOyAsw9KwKEgHnBI
MlHxZrpv0uYAKKVXV/5gvYmQF5TpkhhWfe4iSkMXGuHKqXFBZ095XAagt6roP58I
hOQ4eGbKyE9kiIbR2Ie8fQwSK/PpBTDxxcF2ZUk/F2DbPRyh9j1yHLnqWPs11TTo
fftCDKNQAV44g5TveOVZ7eQUWM9lL/UoSyrrjS8yGZs7LIXKvPI=
=PYSp
-----END PGP SIGNATURE-----

--qchyiiv27q5ypmam--
