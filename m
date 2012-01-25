From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date: Wed, 25 Jan 2012 14:40:55 +0100
Message-ID: <20120125134055.GC4755@pengutronix.de>
References: <1326984171-21209-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326984171-21209-1-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2012 at 08:12:51PM +0530, Jayachandran C. wrote:
> From: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
>=20
> Add support for the intergrated I2C controller on Netlogic
> XLR/XLS MIPS SoC.
>=20
> The changes are to add a new file i2c/buses/i2c-xlr.c, containing the
> i2c bus implementation, and to update i2c/buses/{Kconfig,Makefile} to
> add the CONFIG_I2C_XLR option.
>=20
> Signed-off-by: Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

Please say [PATCH V3] instead of just [PATCH], this helps reviewing.
Also, start a new mail-thread, it might get too messy if 10 different
versions get comments.

> +static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
> +	u8 *buf, u16 addr)
> +{
> +	struct i2c_adapter *adap =3D &priv->adap;
> +	u32 i2c_status;
> +	unsigned long timeout, stoptime;
> +	int pos;
> +	u8 offset, byte;
> +
> +	offset =3D buf[0];
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
> +
> +	timeout =3D usecs_to_jiffies(XLR_I2C_TIMEOUT);
> +	stoptime =3D jiffies + timeout;
> +	pos =3D 1;
> +retry:
> +	if (len =3D=3D 1) {
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +				XLR_I2C_STARTXFR_ND);
> +	} else {
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +				XLR_I2C_STARTXFR_WR);
> +	}
> +
> +	while (1) {

If you get scheduled away here and return after stoptime, you won't have
checked the status even once. Do something like

		checktime =3D jiffies;
		i2c_status =3D ...
		/* check error bits */
		if time_after(checktime, stoptime)
			return -ETIMEDOUT;

An interrupt would be much better, of course.

> +		if (time_after(jiffies, stoptime)) {
> +			dev_err(&adap->dev, "I2C transmit timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		i2c_status =3D xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
> +
> +		if (i2c_status & XLR_I2C_SDOEMPTY) {
> +			pos++;
> +			/* need to do a empty dataout after the last byte */
> +			byte =3D (pos < len) ? buf[pos] : 0;
> +			xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, byte);
> +
> +			/* reset timeout on successful xmit */
> +			stoptime =3D jiffies + timeout;
> +		}
> +
> +		if (i2c_status & XLR_I2C_ARB_STARTERR)
> +			goto retry;
> +
> +		if (i2c_status & XLR_I2C_ACK_ERR)
> +			return -EIO;
> +
> +		if (i2c_status & XLR_I2C_BUS_BUSY)
> +			continue;
> +
> +		if (pos >=3D len)
> +			break;
> +	}
> +
> +	return 0;
> +}

Rest looks okay to me.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8gBmcACgkQD27XaX1/VRsHCACeJkVnIp5l2oZUp7EaH6XS8mZG
xwcAn3QLX0uc7+4CZN1dAuntrIZ25KOb
=yKev
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
