From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: prevent early stop on TX FIFO empty
Date: Wed, 19 Nov 2014 10:21:22 +0100
Message-ID: <20141119092122.GC1439@katana>
References: <545CB6C4.8010201@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <545CB6C4.8010201-5wv7dgnIgG8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2014 at 12:10:44PM +0000, Andrew Jackson wrote:
> If the Designware core is configured with IC_EMPTYFIFO_HOLD_MASTER_EN
> set to zero, allowing the TX FIFO to become empty causes a STOP
> condition to be generated on the I2C bus. If the transmit FIFO
> threshold is set too high, an erroneous STOP condition can be
> generated on long transfers - particularly where the interrupt
> latency is extended.
>=20
> Signed-off-by: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>

So, what do other designware users think of this change (nice CC list
BTW, Andrew). Adding Mika, too.

> ---
>  drivers/i2c/busses/i2c-designware-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busse=
s/i2c-designware-core.c
> index 3c20e4b..e070edd 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -363,7 +363,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	}
> =20
>  	/* Configure Tx/Rx FIFO threshold levels */
> -	dw_writel(dev, dev->tx_fifo_depth - 1, DW_IC_TX_TL);
> +	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
>  	dw_writel(dev, 0, DW_IC_RX_TL);
> =20
>  	/* configure the i2c master */
> --=20
> 1.7.1
>=20

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJUbGESAAoJEBQN5MwUoCm2bjYP+Ie4QLkVvrtwxxKd4S0GR2Al
UnSMQoeq5yFZOKk+eO+7RdK7G5CWuMXYG/GIIpmx94X0XOGOi5AwX76TTY2nhsZf
Sq0CcsQ7dnspJ9lpr+KfYo8PmbQft13+qnzFZwlWwOECs2qmFryYK9c9R1b87zaE
mbz0DJtRiAWYroSKhpDXrFYp6u+qDGepxhuRgSo6ufgCNPm6axrNoM7ivoxw9ORK
v3fEBWbB7KN+UbwrRIWFD3jSZyQVN6MuHB1OLH1IedJR5K2Xrd+f/uA5tkcxOnQY
Wd2b//AMMrgSoWyNG7HF0cFeb996kOLshVz0zlxe+kmdkmN/n3hqJffLMrS8W+y0
F6w1bH45yQfc03vjihIOaJxb+XPi8TrZ/bEglpSAwn7X3atMgKgz4K8VI4NV+Vu+
pc4WYLh++HSMMyqK27ikVmckQ0VbMc2w6ZevEVrpBgS0yfC0KLQn7CY0CLn9LeFp
99KUkCLbhvv1EycXKfnlHyMh6GdYIFa04jGLhr/+EP7MFOPUIR72ZuFt+bAcBlEK
4hf0OegU0K6ICq9mkTAZKng6Kx6hehN6oA/L0jb4vwzCTGFrkDD+oVJr6giVTPz2
g/io4l+a8tkolpqsAbcIoRwQ8mEG9qbidytCKLmdrEwiM7DM1TpZSoxlVteFM7jZ
3GwRq80JDitC2BlvAHc=
=j73i
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
