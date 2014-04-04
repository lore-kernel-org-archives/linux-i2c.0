From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: Add driver for Cadence I2C controller
Date: Fri, 4 Apr 2014 16:38:47 +0200
Message-ID: <20140404143847.GA5529@katana>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396547967-19260-2-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396547967-19260-2-git-send-email-soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 10:59:26AM -0700, Soren Brinkmann wrote:
> Add a driver for the Cadence I2C controller. This controller is for
> example found in Xilinx Zynq.
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Tested-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Only minor stuff, but since you resend anyhow because of 400kHz issue...

> +static void cdns_i2c_mrecv(struct cdns_i2c *id)
> +{
> +	unsigned int ctrl_reg;
> +	unsigned int isr_status;
> +
> +	id->p_recv_buf =3D id->p_msg->buf;
> +	id->recv_count =3D id->p_msg->len;
> +
> +	/* Put the controller in master receive mode and clear the FIFO */
> +	ctrl_reg =3D cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
> +	ctrl_reg |=3D CDNS_I2C_CR_RW | CDNS_I2C_CR_CLR_FIFO;
> +
> +	if ((id->p_msg->flags & I2C_M_RECV_LEN) =3D=3D I2C_M_RECV_LEN)

'if (id->p_msg->flags & I2C_M_RECV_LEN)' is enough.

> +		/* Report the other error interrupts to application as EIO */
> +		if (id->err_status & (CDNS_I2C_IXR_RX_UNF |
> +				      CDNS_I2C_IXR_TX_OVF |
> +				      CDNS_I2C_IXR_RX_OVF |
> +				      CDNS_I2C_IXR_NACK)) {
> +			cdns_i2c_master_reset(adap);
> +			return -EIO;
> +		}

NACK is returned as -ENXIO. Check 'Documentation/i2c/fault-codes' for
standard patterns. I'd think the rest is EIO, though.


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTPsP3AAoJEBQN5MwUoCm2WV4P/39bAkxtCvoj8gUKN3f3hLse
ykH+NCPg3/G2UekYs27KtwY/+Zp7d+9a3moLwDJJxgjghav33Aryq1jPLBYoequM
kn9P9vc/QtSWiIOWsHR4c+ZzdXFRfQAD+Xozb26eHup3xOXYmrCJ3I8SK7gzN/F9
fnLUp3OvkRheB0+iM6NNopuNktvfg1xmvReOEQmsAQCO/t6jsONoNXj+XbBAud7E
GpKtflVQEk/pqSGZA6OtIcYt4Zj0nch9g4BGlc19vUjTqN/51B1IEEraTUn+Hjwg
ZIXOztZyT9sBnCRm26XYlKfXeV8c0IGMA99PUxKYbBq4ph8dLH+rylJSLkVIP739
hu8YwRUMQZascv/VOBmEBguKH15BHNn8NXnYsixFb7rJVkS6fUwKLLSU2qb5y1Ny
4Q43Q5aLTrbpNylkk9GzmQnJbptWTy9ZrLwu26dXiR0SiPxRL3HD1y2NkNBK23bF
OBrYosH9GsHbb8s6qOPbC6dT47HBU2wvTf5sCCwQGoqkpsNHfE4z4pdG6c1sY1ij
aXgw6KOQ3tyVLjBL+eWf9+TqM9SB69QfOKAn4WhqeCw0v6SeBWY5+9xxs0VbU5KX
Nept3zeKD5d65PS59KpD+nYlCiNqAtVDw0DCgjIlaQb/DnpobXklPJUC8WnqmsZk
4xcMVytvijLDUqoem3cE
=QQu0
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
