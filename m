From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v8 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sat, 7 Feb 2015 18:50:39 +0100
Message-ID: <20150207175039.GB6263@katana>
References: <rjui@broadcom.com>
 <1423272507-18459-1-git-send-email-rjui@broadcom.com>
 <1423272507-18459-3-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423272507-18459-3-git-send-email-rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ray,

On Fri, Feb 06, 2015 at 05:28:26PM -0800, Ray Jui wrote:
> Add initial support to the Broadcom iProc I2C controller found in the
> iProc family of SoCs.
>=20
> The iProc I2C controller has separate internal TX and RX FIFOs, each has
> a size of 64 bytes. The iProc I2C controller supports two bus speeds
> including standard mode (100kHz) and fast mode (400kHz)

Mostly looking good.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>

Please sort the includes.

> +static bool bcm_iproc_i2c_bus_busy(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	if (readl(iproc_i2c->base + M_CMD_OFFSET) &
> +	    (1 << M_CMD_START_BUSY_SHIFT))
> +		return true;
> +	else
> +		return false;
> +}

Minor: return !!(readl(...))? You decide.

> +
> +static int bcm_iproc_i2c_format_addr(struct bcm_iproc_i2c_dev *iproc_i2c,
> +				     struct i2c_msg *msg, u8 *addr)
> +{
> +	*addr =3D msg->addr << 1;
> +
> +	if (msg->flags & I2C_M_RD)
> +		*addr |=3D 1;
> +
> +	return 0;
> +}

I'd suggest a oneliner.

*addr =3D msg->addr << 1 | (msg->flags & I2C_M_RD ? 1 : 0)

Or use !! like above.

Don't do an extra function for that. It is only used once and it also
doesn't need to be int since it can't fail anyhow.

(Note to self: I should make a macro for that in i2c.h)

> +	/* need to reserve one byte in the FIFO for the slave address */
> +	if (msg->len > M_TX_RX_FIFO_SIZE - 1) {
> +		dev_err(iproc_i2c->device,
> +			"only support data length up to %u bytes\n",
> +			M_TX_RX_FIFO_SIZE - 1);
> +		return -EINVAL;

-EOPNOTSUPP

Is it really a HW limitation? Could the driver later be extended to
continue filling the FIFO if a certain threshold is reached?

> +	dev_dbg(iproc_i2c->device, "xfer %c, addr=3D0x%02x, len=3D%d\n",
> +		(msg->flags & I2C_M_RD) ? 'R' : 'W', msg->addr,
> +		msg->len);
> +	dev_dbg(iproc_i2c->device, "*** data: %*ph\n", msg->len, msg->buf);

Not really needed. We have tracing for that.

> +	if (bus_speed < 100000) {
> +		dev_err(iproc_i2c->device, "%d Hz bus speed not supported\n",
> +			bus_speed);
> +		dev_err(iproc_i2c->device,
> +			"valid speeds are 100khz and 400khz\n");
> +		return -EINVAL;
> +	} else if (bus_speed < 400000) {
> +		bus_speed =3D 100000;
> +		speed_bit =3D 0;
> +	} else {
> +		bus_speed =3D 400000;
> +		speed_bit =3D 1;
> +	}
> +
> +	val =3D readl(iproc_i2c->base + TIM_CFG_OFFSET);
> +	val &=3D ~(1 << TIM_CFG_MODE_400_SHIFT);
> +	val |=3D speed_bit << TIM_CFG_MODE_400_SHIFT;

val |=3D (bus_speed =3D=3D 400000) ...

and skip speed_bit? You decide.

> +static void bcm_iproc_i2c_enable(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	u32 val;
> +
> +	val =3D readl(iproc_i2c->base + CFG_OFFSET);
> +	val |=3D 1 << CFG_EN_SHIFT;
> +	writel(val, iproc_i2c->base + CFG_OFFSET);
> +}
> +
> +static void bcm_iproc_i2c_disable(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	u32 val;
> +
> +	val =3D readl(iproc_i2c->base + CFG_OFFSET);
> +	val &=3D ~(1 << CFG_EN_SHIFT);
> +	writel(val, iproc_i2c->base + CFG_OFFSET);
> +}

Extra functions? They are self explaining and only used once. You
decide.

Rest looks fine, thanks!


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1lBvAAoJEBQN5MwUoCm2wroQAJYxctKO7RB+0o4wHtHRBapd
0UrhX+9Csiz912f/k08xP+D9RX+IVYNtlC7KJhgHniERSIWOPU6A8Cq7Ph+rIhW4
Ln7klovQfRsFCKiiYhJ5wpJ8+S/99TQ9vYaMODPKFfMmqAAasKbaHf6b9G8We1VV
8tppgu1ZOeGgTbMVaItjwKh/ND0srSAZxXaBs2dyKV8PRpL9vU3ZbC3vPwe4BcdW
cFhseYWbtHpgR9cN3XW69PV+zNHsGYrm8g/brq4NGUOmE2lV0bvdIO1WciMPirtm
Jdq51AA4NNG1/eju/evr5HHJJyzaTfHLqSn52tHobfnpKB0agV+XgOtA6Ny/kHK7
6EbggzWoss1cW/YTIDYeskecQelAFdcNffsXc3ASOZZ+5kU1w2EdkugObD7ZkOfJ
7mtQSm8IGEGx+3fyHWNAF3RGrs/6Pim6PRNmfhMBg8PebS0gipmzfpSI+yohwXVW
9v+SPz6IhA46YbuXae+wzSQTt/sl5IjXD+HteDPWpYefSuc3BkLymGX7ZvetxzMe
msFriTk5wBb3xLnDoaT5gdAxlsY9VRqqEu7Rh7YhjptcY9mWZq6f+pTyG49RcChE
pkfz1ty9TnELfAcUeqjTTu2inkSTq0bjGppRPnP0uvvIkNDH/j4IjISGhpcT754V
tg5UpDCk5Nc3xFWfo0+z
=iYks
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
