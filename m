From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mxs: dont print error on NAK
Date: Fri, 19 May 2017 14:44:02 +0200
Message-ID: <20170519124402.4xkaguxjzgyvbwcl@ninjato>
References: <20170518141450.30938-1-michael.thalmeier@hale.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tfkmvdxfhk2i6gc4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170518141450.30938-1-michael.thalmeier@hale.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, michael@thalmeier.at
List-Id: linux-i2c@vger.kernel.org


--tfkmvdxfhk2i6gc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 04:14:50PM +0200, Michael Thalmeier wrote:
> When mxs_i2c_pio_wait_xfer_end returns with a return code of -ENXIO, the
> NO_SLAVE_ACK_IRQ bit is set in CTRL1.
> In this case, do not print an error message, because every NAK would
> otherwise generate a new message.

Why not also for the read case?

Also, I think all the error printing for mxs_i2c_pio_wait_xfer_end()
could go. NAK can happen on the bus as well as timeouts, e.g. EEPROMs
currently erasing a page. Upper layers ought to handle that.

Thanks,

   Wolfram

>=20
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
>  drivers/i2c/busses/i2c-mxs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 5738556..e2dbb9c 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -527,7 +527,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter =
*adap,
> =20
>  			/* Wait for the end of the transfer. */
>  			ret =3D mxs_i2c_pio_wait_xfer_end(i2c);
> -			if (ret) {
> +			if (ret && ret !=3D -ENXIO) {
>  				dev_err(i2c->dev,
>  					"PIO: Failed to finish WRITE cmd!\n");
>  				break;
> --=20
> 2.9.2
>=20

--tfkmvdxfhk2i6gc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlke6JEACgkQFA3kzBSg
KbbuXQ/9GQeD+5Aeq9Li0aTiwgsgK6waeQf84SfDINU4IEZenwxc1FUjQ1//LPnG
MhG6pdYN4apJ2DMQc7gGayLXCT6DO27W9q4RpW6Ewgq/7BQ2I/dXTk+aU1iVQZDu
vovVmwJ9YPRx4JpdtUK8SNjbe+7mh0xoYp620y1tGboEouoALEIOW8wVPwRtW+lP
HzKpYO5fiiqEGC0n/EZSYzAdvLAleh+WXHpHzOsv90fHG8C7WsdsfE/ZZbXu3AAk
C5oH0ijw9sys4CRFSITfgomHZXsybBZz4ybI20tHK12ZFvmY7JbgopPawAyO7fQB
ZWWobGpN9MgUWtOYWmr8j2Y1JPxEUBu398z5wfUQs4SGOPW18mKSC0YVhDh3jOqm
C6/hH4hu7j75peqmFdMvhN0KycQgI3C7iVtkGttruNRft8CD+Al6JQO3ZTKlhHCn
/YaQ94nqAMLJwsPlI53gCNMZLbq1z3ZLuqOLWugE2Zg3vaJ7z9KE6lEtWZJBXl2E
VyJcjP6L3dBqaK/Y/1Zq1/C4UvcYYkD9QoGEvWuu5YxcbUzRUN1DJQHcxaATWyW1
6KDPzOzHLF70WC6YBxtCxrM8oQBLmbV3rn/+ORD28SThWc1Km6a+JsPOKXrQq/NL
gHl166fwvVHKF+XQTjbfJrY10/LHyzjFmWE0t2CAC0AGpR2ippI=
=Ey2X
-----END PGP SIGNATURE-----

--tfkmvdxfhk2i6gc4--
