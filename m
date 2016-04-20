From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 07/19] i2c: octeon: Use i2c recovery framework
Date: Wed, 20 Apr 2016 23:31:21 +0200
Message-ID: <20160420213121.GC1546@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <ab24627b5928f23967633243639b431d2113dbe1.1460387640.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45825 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbcDTVb2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Apr 2016 17:31:28 -0400
Content-Disposition: inline
In-Reply-To: <ab24627b5928f23967633243639b431d2113dbe1.1460387640.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 05:28:38PM +0200, Jan Glauber wrote:
> Switch to the i2c bus recovery framework using generic SCL recovery.
> If this fails try to reset the hardware. The recovery is triggered
> during START on timeout of the interrupt or failure to reach
> the START / repeated-START condition.
>=20
> The START function is moved to xfer and while at it:
> - removed xfer debug message (i2c core already provides debugging)
> - removed length is zero check
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/i2c/busses/i2c-octeon.c | 178 +++++++++++++++++++++++++---------=
------
>  1 file changed, 111 insertions(+), 67 deletions(-)

Interesting, it got larger...

>=20
> +/**
> + * octeon_i2c_write_int - read the TWSI_INT register

read_int

> +	int ret, retries =3D 2;

I don't think 'retries' makes sense here. On failure, you return
-EAGAIN, so the core will retry 'adapter->retries' times anyhow.

> -	if (length < 1)
> -		return -EINVAL;

So, the adapter support 0-length messages now? Or why was it there? I
have the feeling this is a seperate patch.

> +static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
> +{
> +	struct octeon_i2c *i2c =3D i2c_get_adapdata(adap);
> +
> +	/*
> +	 * The stop resets the state machine, does not _transmit_ STOP unless
> +	 * engine was active.
> +	 */
> +	octeon_i2c_stop(i2c);
> +
> +	octeon_i2c_write_int(i2c, 0);

Maybe a comment why the delay?

> +	udelay(5);
> +}

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXF/UpAAoJEBQN5MwUoCm2BnQP/3bv1kp/lzoCXS9FNmaEcDAn
UiLh0j27oqCJO1Z0p2W9SeCOTv6t1/oJlNr3P+66jJlSM2//zUBiI2QOEb2leu/x
TnFmY2JpkSImw1GGirNnAjoDfMNFzrBH0OeYXDwlcxpAWX9yYzSpk+3D7z7jI19D
B2a9gxxf17JQbEimtrhveeRXe/XaKkXl0L6ahmKKyMzAV6giRtcnkNJCIgjAacIr
EyQ+pnFO6bp6vv7nu10OYRdVPLCWhfYSYYfI52gYptiU77XfUQaLpZ9lRPgkO1fq
5FQ/LidZFmBp5S8xHI1d/PeKox/4nSFYzZJz7lBTmyRLrZJl3Nri1qajHpRwqWo1
K73ZyGzQAM/wpVo85fx097XSupJaaKIoKb2DMQ+QQz449VEpkjuG4TK/7Ul6hf+j
Km+0lWDj17N+2+kNX4/Nxj+SafFeuiShijKTmIBZbH0cVS9n7APJTx96hNweuVOd
hc7epwi1HIHGLww/S6GoRgvQKj/VE0min5gtg2t/HGr3LxIH+CHB2k3pXbQIfOLR
U2CCj1sAEKF/uGU/cTvvvb5Uq98SPZkHEdS1QIAyIXq4x6ncO2MNSPYJb94zbOCt
ZN90rcqSezsejc3SHQb9QT01b3hwTdCLqaNytqJF/axpe15qpj35Ev2L/GSDT/bZ
gzoMKNvz9ZCQ2xisEQez
=afKG
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
