From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add bus driver for for OSIF USB i2c device.
Date: Thu, 9 Jan 2014 22:49:30 +0100
Message-ID: <20140109214930.GC3866@katana>
References: <20140104222842.GF3150@katana>
 <1388980536-7588-1-git-send-email-andrew@lunn.ch>
 <1388980536-7588-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388980536-7588-2-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>, Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 04:55:36AM +0100, Andrew Lunn wrote:
> OSIF, Open Source InterFace, is a USB based i2c bus master.  The
> origional design was based on i2c-tiny-usb, but more modern versions
> of the firmware running on the MegaAVR microcontroller use a different
> protocol over the USB. This code is based on Barry Carter
> <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> driver.
>=20
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>

We are getting close...


> +#define OSIFI2C_READ		20 /* Read from i2c bus */
> +#define OSIFI2C_WRITE		21 /* Write to i2c bus */
> +#define OSIFI2C_STOP		22 /* Send stop condition */
> +#define OSIFI2C_STATUS		23 /* Get status from i2c action */
> +#define OSIFI2C_SET_BIT_RATE	24 /* Set the bit rate & prescaler */

Comments could be seen as obvious, too. I'll leave the decision to you.

> +struct priv {

Namespace: 'osif_priv' please.

> +	struct usb_device *usb_dev;
> +	struct usb_interface *interface;
> +	struct i2c_adapter adapter;
> +	unsigned char status;
> +};
> +
> +static int usb_read(struct i2c_adapter *adapter, int cmd,

Namespace: 'osif_usb_read'.

> +		    int value, int index, void *data, int len)
> +{
> +	struct priv *priv =3D (struct priv *)adapter->algo_data;

No need to cast a void*.

> +
> +	return usb_control_msg(priv->usb_dev, usb_rcvctrlpipe(priv->usb_dev, 0),
> +			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
> +			       USB_DIR_IN, value, index, data, len, 2000);
> +}
> +
> +static int usb_write(struct i2c_adapter *adapter, int cmd,

Namespace

> +		    int value, int index, void *data, int len)
> +{
> +
> +	struct priv *priv =3D (struct priv *)adapter->algo_data;

no cast.

> +
> +	return usb_control_msg(priv->usb_dev, usb_sndctrlpipe(priv->usb_dev, 0),
> +			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +			       value, index, data, len, 2000);
> +}
> +
> +static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, i=
nt num)

namespace

> +{
> +	struct priv *priv =3D (struct priv *)adapter->algo_data;

no cast

> +	struct i2c_msg *pmsg;
> +	int ret =3D 0;
> +	int i, cmd;
> +
> +	for (i =3D 0; ret >=3D 0 && i < num; i++) {
> +		pmsg =3D &msgs[i];
> +
> +		if (pmsg->flags & I2C_M_RD) {
> +			cmd =3D OSIFI2C_READ;
> +
> +			ret =3D usb_read(adapter, cmd, pmsg->flags, pmsg->addr,
> +				       pmsg->buf, pmsg->len);
> +			if (ret !=3D pmsg->len) {
> +				dev_err(&adapter->dev,
> +					"failure reading data\n");

One line is more readable IMO. 80 chars is not a hard limit.

> +				return -EREMOTEIO;
> +			}
> +		} else {
> +			cmd =3D OSIFI2C_WRITE;
> +
> +			ret =3D usb_write(adapter, cmd, pmsg->flags, pmsg->addr,
> +					pmsg->buf, pmsg->len);
> +			if (ret !=3D pmsg->len) {
> +				dev_err(&adapter->dev,
> +					"failure writing data\n");

ditto

> +				return -EREMOTEIO;
> +			}
> +		}
> +
> +		ret =3D usb_read(adapter, OSIFI2C_STOP, 0, 0, NULL, 0);
> +		if (ret !=3D 0) {

'if (ret)' is enough

> +			dev_err(&adapter->dev, "failure sending STOP\n");
> +			return -EREMOTEIO;
> +		}
> +
> +		/* read status */
> +		ret =3D usb_read(adapter, OSIFI2C_STATUS, 0, 0, &priv->status, 1);
> +		if (ret !=3D 1) {
> +			dev_err(&adapter->dev, "failure reading status\n");
> +			return -EREMOTEIO;
> +		}
> +
> +		if (priv->status !=3D STATUS_ADDRESS_ACK) {
> +			dev_dbg(&adapter->dev, "status =3D %d\n", priv->status);
> +			return -EREMOTEIO;
> +		}
> +	}
> +
> +	return i;
> +}
> +
> +static u32 usb_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;

Have you tried SMBUS_QUICK by the way?

> +}
> +
> +static struct i2c_algorithm usb_algorithm =3D {
> +	.master_xfer	=3D usb_xfer,
> +	.functionality	=3D usb_func,
> +};
> +
> +#define USB_OSIF_VENDOR_ID	0x1964
> +#define USB_OSIF_PRODUCT_ID	0x0001
> +
> +static struct usb_device_id osif_table[] =3D {
> +	{ USB_DEVICE(USB_OSIF_VENDOR_ID, USB_OSIF_PRODUCT_ID) },
> +	{ }
> +};
> +

Empty line can go.

> +MODULE_DEVICE_TABLE(usb, osif_table);
> +
> +static int osif_probe(struct usb_interface *interface,
> +			     const struct usb_device_id *id)
> +{
> +	int retval;

maybe just 'ret' for consistency? Very minor nit, though...

> +	struct priv *priv;
> +	u16 version;

Rest looks ready to go!


--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzxlqAAoJEBQN5MwUoCm28vwQALBP9KSrcbhA3lRirfHv+MD5
nGICValKl8t0g6A0VPoHHZ9ctQ70ZwCIyWmPIhCjuatNIpnCxL5IjR/GPMvEbz/a
QB9YvS6Tfg3zSxxIzLyH9F6bK/JeegcTzyCcu3Zr8TI4QixOHEkn0n9Kwmb6vw02
tXMT9TSj6MJ02t83izGSLpIaPFZJVJfXrCIJacVa1Sm8FGRb3XyEYYxgS68p8+Mm
cCnQ3o1cCqr33LiN1zt/9E2WCG605Mjmvz8B5a43qgh6eGPcVT67QF2RACpWVzSb
3PfYpiQJeclef87URMMwaaeURQcvipj1rPc5BGZzxJ0jB0eRhM6vmsQpQZKt+9cz
hdBKxPJewKiVRgm6SX0Y1itKSC5zyVWrj3pmu8YBw9RBMZImM8xTVL0+X7TU7aV4
8HSN67SCXV+oXW0AYT5jNKVWjfZxXkkxo97g8/qVbk3KpM6IB1zk2FxXLO22gArq
Vnpm/74W8JqcRnnSZ2bcbO0BvOQXSQDB3IqEAsZGbjl7aMnW8t9b53NrVzw99pC5
APpwoSL1NEESfHSrBcfmBfEKLKJoSXn/Ooi7/dzyb8CBNnNO1mhO075pUqGwTDYC
Ze7AA88KPpQuu3O9b5r9on2oKYWoV2QK4W2uzZRvb0uNjZDXYylskKyPawmSYxtH
C4KKmM4KYMOxWg3gCMH9
=IcTC
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
