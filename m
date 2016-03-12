From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 02/14] i2c-octeon: Cleanup i2c-octeon driver
Date: Sat, 12 Mar 2016 16:35:00 +0100
Message-ID: <20160312153459.GD1661@katana>
References: <cover.1457362545.git.jglauber@cavium.com>
 <aea2307d9ff5295a0041d3a129dd3e95bf3bd04c.1457362545.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50337 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbcCLPfE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Mar 2016 10:35:04 -0500
Content-Disposition: inline
In-Reply-To: <aea2307d9ff5295a0041d3a129dd3e95bf3bd04c.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 04:10:45PM +0100, Jan Glauber wrote:
> Cleanup only without functional change.

I like most of the changes, but there are still some functional changes
left.

> -static int octeon_i2c_stop(struct octeon_i2c *i2c)
> +/* send STOP to the bus */
> +static void octeon_i2c_stop(struct octeon_i2c *i2c)
>  {
>  	u8 data;
> =20
> @@ -266,11 +259,8 @@ static int octeon_i2c_stop(struct octeon_i2c *i2c)
> =20
>  	data =3D octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
> =20
> -	if (data !=3D STAT_IDLE) {
> +	if (data !=3D STAT_IDLE)
>  		dev_err(i2c->dev, "%s: bad status(0x%x)\n", __func__, data);
> -		return -EIO;
> -	}
> -	return 0;

Why this change? I don't know what SW_TWSI_EOP_TWSI_STAT tells, but this
is surely not a cleanup.

>  	octeon_i2c_stop(i2c);
> =20
> -	return (ret !=3D 0) ? ret : num;
> +	return ret ? -EAGAIN : num;

This is also not a cleanup and looks wrong. -EAGAIN is for lost
arbitration only.

> =20
> -static struct of_device_id octeon_i2c_match[] =3D {
> -	{
> -		.compatible =3D "cavium,octeon-3860-twsi",
> -	},
> +static const struct of_device_id octeon_i2c_match[] =3D {
> +	{	.compatible =3D "cavium,octeon-3860-twsi",	},

Nit: I'd prefer no tabs within the curly braces.

Thanks,

   Wolfram


--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5DcjAAoJEBQN5MwUoCm2GJQP/jSHH13doQtq+kf+f86c+tsn
ddktMuVh8Udh08zGbsYQCTigfTpFTY6SonFpnyZs4zXdmkbIdMdNfPfIJq6dyEgC
/dFOwZpzuFtvPIREBbEGZ1bk1vphOX2mE+2rgLVz6iNGDPDT7KItNbBaIS6DjGXL
7F6sN8HioBmg4rIABY6k+w1fdkT8H+DV+2RpJdjW2OJk32gvTcbe1E+TU8h/Yokr
Rh533kVVJg9N1BgNB5nQTXm3eVO4aenTUwSLVKtXG6+uUhh3ef1hO94E2kNB4FFp
UeS58nVLAaoRqzgcpYXtazWAmnppkM7gzCPLe+sUrWTk807uu5gBxbD6/qU1jAT1
/FRMztQuT/5Q01FAppnDj+U0wVYwfHQv4I/eCZmZk0EEIVLuo5tGhvMn3A8UQLeh
2FjPItSmP2dSIKTsE2r9kCxDMJpkAB7oLLxH3wTL2THpvckTyakPrs+Aof6GwJFM
h6hgfEiyOjxIEvW8U04vMLpFSPMfpxMKQvO/FQ4TJrQ1jOYeoXCYk5jA5rnOCV9i
nH1XM3NNvo3wZnIGJuAOFaqSBiONzH6cWb0ouI9ykLJsojT6ToEIfglOL/6eNei0
mbzkiCDGw1u9fzjekMtM9P34GGDTaAUTYa1e2fRnB4MxeVxYFyEp32fmtvcXkFAT
MyTxZe4J9iwsp0fQT5GK
=+nRT
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
