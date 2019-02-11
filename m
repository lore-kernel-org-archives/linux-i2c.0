From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/5] i2c:ocores: do not handle IRQ if IF is not set
Date: Mon, 11 Feb 2019 11:24:33 +0100
Message-ID: <20190211102433.6m4s64t3wa63tru7@ninjato>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-3-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6h33aoy6y5djgoxw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211083122.32485-3-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--6h33aoy6y5djgoxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:31:19AM +0100, Federico Vaga wrote:
> If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> - the line can be shared with other devices
> - it can be a spurious interrupt
>=20
> To avoid reading twice the status register, the ocores_process() function
> expects it to be read by the caller.
>=20
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> Acked-by: Peter Korsgaard <peter@korsgaard.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>=20

Applied to for-next, thanks!


--6h33aoy6y5djgoxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhTWEACgkQFA3kzBSg
KbZ8kg/+Pw+/J4w/2Zij3BSKodk5mkEkOzma3nz+bSaPze2w5+KiFcJSav9T3g8Q
LwZSK2Y3LA0e4euctzB0m91ZUrs4/aAQmI80IaOT2214KnZEGzR5VUqAqcb48DvD
gNA8ayksPksDOFZX+gLYBnOqcOOSkSD2rYeeS8ELeL5nJ6X1QrCqlRqW3u+iNUNp
B67tmCyH9exGsbM9Bi+nm0NeSkHjhEsWtop/DHQCrIaIp4FjhgYRfwhKuCUA07im
rq7i2ILqvnGSJE2Se8n0WjCLiVfqAB2VgwgGLSVcCOwmZoXqiD1rHXOtKv5x0bxp
1DozUL8L/HluG6EzsRaj87sqcgG+PEDHv/An8lFmpeEfj1ZGvdrXDKNIt7wn0smE
0mWHUy3E7rBlHKKFPX3wE3MGqHjZFN2CLRY7aa9CBuSRR4R8VNltxMzeTUUbsD6V
pppa0PQUfKzTLtcWVjVtGgMJw+kbchHdPXY92iguidK+39qt2EWPtYvo99xpiYQL
XaTmm5OGXzE2asVfKwpJxWNcn3zGkpiGMTrQB1Trcokn6faiTUe0Zw1RKiNjuyAW
fgouPjTpdRu8RzEwGwWCy12r/om1vC080kOKgn5XpsShbwr557N9tAMqA8lBv1CL
Gjfof5WkltN04H+GXB+ANMygk2iF5W8qjtdG5CXlv9Q9BeALyJI=
=8Ot5
-----END PGP SIGNATURE-----

--6h33aoy6y5djgoxw--
