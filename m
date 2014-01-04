From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND PATCH v1 2/2] i2c: Add bus driver for for OSIF USB i2c
 device.
Date: Sat, 4 Jan 2014 23:28:42 +0100
Message-ID: <20140104222842.GF3150@katana>
References: <1387312308-2222-1-git-send-email-andrew@lunn.ch>
 <1387312308-2222-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387312308-2222-2-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>, Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, thanks for the submission...


> +#define DRIVER_AUTHOR  "Barry Carter <barry.carter-hIwygO75nSHCXR85Y8Hu3Q@public.gmane.org>,"	\
> +	"Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>"
> +#define DRIVER_DESC    "OSIF driver"

No defines, use directly.

> +static int usb_read(struct i2c_adapter *adapter, int cmd,
> +		    int value, int index, void *data, int len);
> +
> +static int usb_write(struct i2c_adapter *adapter, int cmd,
> +		     int value, int index, void *data, int len);

With a bit of reshuffling, these can be skipped.

> +	dev_dbg(&adapter->dev, "master xfer %d messages:\n", num);

Skip. This info is available with I2C core debug messages.

> +	pstatus = kmalloc(sizeof(*pstatus), GFP_KERNEL);
> +	if (!pstatus)
> +		return -ENOMEM;

Does it really make sense to allocate this every time?

> +		dev_dbg(&adapter->dev,
> +			"  %d: %s (flags %d) %d bytes to 0x%02x\n",
> +			i, pmsg->flags & I2C_M_RD ? "read" : "write",
> +			pmsg->flags, pmsg->len, pmsg->addr);

This is also available with i2c core debug messages.

> +/* Structure to hold all of our device specific stuff */
> +struct priv {
> +	struct usb_device *usb_dev; /* the usb device for this device */
> +	struct usb_interface *interface; /* the interface for this device */
> +	struct i2c_adapter adapter; /* i2c related things */
> +};

Remove comments, too obvious IMO.

> +static int usb_read(struct i2c_adapter *adapter, int cmd,
> +		    int value, int index, void *data, int len)
> +{
> +	struct priv *priv = (struct priv *)adapter->algo_data;
> +
> +	/* do control transfer */

ditto.

> +	return usb_control_msg(priv->usb_dev, usb_rcvctrlpipe(priv->usb_dev, 0),
> +			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
> +			       USB_DIR_IN, value, index, data, len, 2000);
> +}
> +
> +static int usb_write(struct i2c_adapter *adapter, int cmd,
> +		    int value, int index, void *data, int len)
> +{
> +
> +	struct priv *priv = (struct priv *)adapter->algo_data;
> +
> +	/* do control transfer */

ditto.

> +	return usb_control_msg(priv->usb_dev, usb_sndctrlpipe(priv->usb_dev, 0),
> +			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +			       value, index, data, len, 2000);
> +}
> +
> +static void osif_free(struct priv *priv)
> +{
> +	usb_put_dev(priv->usb_dev);
> +}

Not sure if this is worth a seperate function, but well...

> +static int osif_probe(struct usb_interface *interface,
> +			     const struct usb_device_id *id)
> +{
> +	struct priv *priv = NULL;

Unneeded assignment.

> +	int retval = -ENOMEM;
> +	u16 version;
> +
> +	dev_dbg(&interface->dev, "probing usb device");

This is available via driver core debug messages.

> +	/* inform user about successful attachment to i2c layer */
> +	dev_info(&priv->adapter.dev, "connected OSIF device\n");

I think this message should be merged with the "version xx found"
message above.

> +MODULE_LICENSE("GPL");

"GPL v2" according to header.


--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSyIsaAAoJEBQN5MwUoCm20TQP/jaKhqr+v6uwdFyxdmEcBsiM
XV0AYsj8JiT4imkyVbzSzHnO6lAyzkQFQDol8Fnzria8/r+y3iktXoo2P7mZUjPg
Tfm0nm5C/duQlcTS5jrW/8HkjHi+IJETjY061RrNFjetDt7MKVaK2/uBKRRyulBb
i7fssPSFzCb5uXpYKUJdWWlCq41kfA8jLpz7DFCg4dTGpxUObSX7rzegLg1NOCMS
vGZ3Yyx+SZ/IIbUVRw/8DdyDQ1E3ZtX+S/soMDkctb7Lftt4CJTqhuE/QVXftf09
mKKr5i3W1bPrAXRogWKJqlRAYw9o/ZLeoKviWSibYdf9AX6Kp81u021BwwyAGr9M
72Esb1FNxVUZGVne+P3TQCptNmi3aG+Vlv1m/YN/nTHAwXRgnaKpiGadqWpQTkOc
3UHhw0Blqf+XRLjQEgAg+RGgFHtJkPs0XdL6ExRD00e02I8hONtjE02I9FwmsFeM
VkQSVYn18IlKFoS1IOsfJgHqmcKXF+BgpIa6nlGVBpmDekMRuO6eM65apKf1xrm/
OqrrUDOjd3hTB6DeqKaOc5H2e8Elhq8U5Wbk0WuvwOpGjM1/VXGmvRBannQa1vV6
9NuKyNZ5PZr0zZGATNHyo/LX9zl4edlKdxWfCFWdlcILCXEQE0zGlXA6P3/7wsDx
KULvTr1AUIwK2ZPZC7lG
=S87j
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
