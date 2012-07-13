From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 5/8 v2] i2c:i2c-bfin-twi: TWI fails to restart next
 transfer in high system load.
Date: Fri, 13 Jul 2012 08:38:38 +0200
Message-ID: <20120713063838.GC32184@pengutronix.de>
References: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
 <1339575767-22985-5-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1339575767-22985-5-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 04:22:44PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> Current driver was developed based on BF537 0.2 HRM. In high system load,=
 BUFRDERR error
> interrupt may be raised if XMTSERV interrupt of last TX byte is not serve=
d in time
> (set RSTART bit), which breaks restart tranfer as expected.
>=20
> "Buffer Read Error (BUFRDERR)" description in Blackfin HRM only applys to=
 BF537
> rev. < 0.3. In later rev. and later announced Blackfin chips, such as BF5=
27 and
> BF548, a new TWI master feature "Clock Stretching" is added into the TWI =
controller,
> BUFRDERR interrupt is not triggered after TX FIFO is empty.
>=20
> This patch sets RSTART bit at the beginning of the first transfer. The SC=
L and SDA
> is hold till XMTSERV interrupt of last TX byte is served. Restart transfe=
r is not broken
> in high system load.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |   23 +++++++++++++----------
>  1 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-b=
fin-twi.c
> index 2e59bbd..e75ee91 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -99,7 +99,7 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_i=
face *iface,
>  		 */
>  		else if (iface->cur_mode =3D=3D TWI_I2C_MODE_COMBINED)
>  			write_MASTER_CTL(iface,
> -				read_MASTER_CTL(iface) | MDIR | RSTART);
> +				read_MASTER_CTL(iface) | MDIR);
>  		else if (iface->manual_stop)
>  			write_MASTER_CTL(iface,
>  				read_MASTER_CTL(iface) | STOP);
> @@ -107,10 +107,10 @@ static void bfin_twi_handle_interrupt(struct bfin_t=
wi_iface *iface,
>  		         iface->cur_msg + 1 < iface->msg_num) {
>  			if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
>  				write_MASTER_CTL(iface,
> -					read_MASTER_CTL(iface) | RSTART | MDIR);
> +					read_MASTER_CTL(iface) | MDIR);
>  			else
>  				write_MASTER_CTL(iface,
> -					(read_MASTER_CTL(iface) | RSTART) & ~MDIR);
> +					read_MASTER_CTL(iface) & ~MDIR);
>  		}
>  	}
>  	if (twi_int_status & RCVSERV) {
> @@ -144,10 +144,10 @@ static void bfin_twi_handle_interrupt(struct bfin_t=
wi_iface *iface,
>  					iface->cur_msg + 1 < iface->msg_num) {
>  				if (iface->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
>  					write_MASTER_CTL(iface,
> -						read_MASTER_CTL(iface) | RSTART | MDIR);
> +						read_MASTER_CTL(iface) | MDIR);
>  				else
>  					write_MASTER_CTL(iface,
> -						(read_MASTER_CTL(iface) | RSTART) & ~MDIR);
> +						read_MASTER_CTL(iface) & ~MDIR);
>  			}
>  		}
>  	}
> @@ -262,9 +262,10 @@ static void bfin_twi_handle_interrupt(struct bfin_tw=
i_iface *iface,
>  					(0xff << 6)));
>  				iface->manual_stop =3D 1;
>  			}
> -			/* remove restart bit and enable master receive */
> -			write_MASTER_CTL(iface,
> -				read_MASTER_CTL(iface) & ~RSTART);
> +			/* remove restart bit before last message */
> +			if (iface->cur_msg+1 =3D=3D iface->msg_num)

Spaces around operators. I fixed it for you.

> +				write_MASTER_CTL(iface,
> +					read_MASTER_CTL(iface) & ~RSTART);
>  		} else {
>  			iface->result =3D 1;
>  			write_INT_MASK(iface, 0);
> @@ -321,7 +322,8 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter=
 *adap,
>  		return -EINVAL;
>  	}
> =20
> -	iface->cur_mode =3D TWI_I2C_MODE_REPEAT;
> +	if (iface->msg_num > 1)
> +		iface->cur_mode =3D TWI_I2C_MODE_REPEAT;
>  	iface->manual_stop =3D 0;
>  	iface->transPtr =3D pmsg->buf;
>  	iface->writeNum =3D iface->readNum =3D pmsg->len;
> @@ -366,6 +368,7 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter=
 *adap,
> =20
>  	/* Master enable */
>  	write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
> +		(iface->msg_num > 1 ? RSTART : 0) |
>  		((iface->read_write =3D=3D I2C_SMBUS_READ) ? MDIR : 0) |
>  		((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 100) ? FAST : 0));
>  	SSYNC();
> @@ -530,7 +533,7 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, =
u16 addr,
>  		else
>  			write_MASTER_CTL(iface, 0x1 << 6);
>  		/* Master enable */
> -		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
> +		write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN | RSTART |
>  			((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ>100) ? FAST : 0));
>  		break;
>  	default:
> --=20
> 1.7.0.4
>=20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk//wm4ACgkQD27XaX1/VRsqMgCeOJ4AVkW+Ja85GVD1NF0KZ+Qk
HdYAoI+wdCb20o6D7ZlCZkugaz7hL2eo
=aJ9i
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
