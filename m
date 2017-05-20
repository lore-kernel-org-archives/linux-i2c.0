From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] i2c: i2c-tiny-usb: fix buffer not being DMA capable
Date: Sat, 20 May 2017 18:09:59 +0200
Message-ID: <20170520160959.bgl4nadqs6xaqi5d@earth>
References: <20170505090650.28412-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5peyjdax6ledksv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbdETQKF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 20 May 2017 12:10:05 -0400
Content-Disposition: inline
In-Reply-To: <20170505090650.28412-1-sebastian.reichel@collabora.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Till Harbaum <till@harbaum.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--l5peyjdax6ledksv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

ping?

This fixes a regression making the driver effectively useless.

-- Sebastian

On Fri, May 05, 2017 at 11:06:50AM +0200, Sebastian Reichel wrote:
> Since v4.9 i2c-tiny-usb generates the below call trace
> and longer works, since it can't communicate with the
> USB device. The reason is, that since v4.9 the USB
> stack checks, that the buffer it should transfer is DMA
> capable. This was a requirement since v2.2 days, but it
> usually worked nevertheless.
>=20
> [   17.504959] ------------[ cut here ]------------
> [   17.505488] WARNING: CPU: 0 PID: 93 at drivers/usb/core/hcd.c:1587 usb=
_hcd_map_urb_for_dma+0x37c/0x570
> [   17.506545] transfer buffer not dma capable
> [   17.507022] Modules linked in:
> [   17.507370] CPU: 0 PID: 93 Comm: i2cdetect Not tainted 4.11.0-rc8+ #10
> [   17.508103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
> [   17.509039] Call Trace:
> [   17.509320]  ? dump_stack+0x5c/0x78
> [   17.509714]  ? __warn+0xbe/0xe0
> [   17.510073]  ? warn_slowpath_fmt+0x5a/0x80
> [   17.510532]  ? nommu_map_sg+0xb0/0xb0
> [   17.510949]  ? usb_hcd_map_urb_for_dma+0x37c/0x570
> [   17.511482]  ? usb_hcd_submit_urb+0x336/0xab0
> [   17.511976]  ? wait_for_completion_timeout+0x12f/0x1a0
> [   17.512549]  ? wait_for_completion_timeout+0x65/0x1a0
> [   17.513125]  ? usb_start_wait_urb+0x65/0x160
> [   17.513604]  ? usb_control_msg+0xdc/0x130
> [   17.514061]  ? usb_xfer+0xa4/0x2a0
> [   17.514445]  ? __i2c_transfer+0x108/0x3c0
> [   17.514899]  ? i2c_transfer+0x57/0xb0
> [   17.515310]  ? i2c_smbus_xfer_emulated+0x12f/0x590
> [   17.515851]  ? _raw_spin_unlock_irqrestore+0x11/0x20
> [   17.516408]  ? i2c_smbus_xfer+0x125/0x330
> [   17.516876]  ? i2c_smbus_xfer+0x125/0x330
> [   17.517329]  ? i2cdev_ioctl_smbus+0x1c1/0x2b0
> [   17.517824]  ? i2cdev_ioctl+0x75/0x1c0
> [   17.518248]  ? do_vfs_ioctl+0x9f/0x600
> [   17.518671]  ? vfs_write+0x144/0x190
> [   17.519078]  ? SyS_ioctl+0x74/0x80
> [   17.519463]  ? entry_SYSCALL_64_fastpath+0x1e/0xad
> [   17.519959] ---[ end trace d047c04982f5ac50 ]---
>=20
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> Changes since PATCHv1:
>  - update patch description, drop # v4.9+ from stable cc
>  - add missing checks for kmemdup/kmalloc
> ---
>  drivers/i2c/busses/i2c-tiny-usb.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-t=
iny-usb.c
> index 0ed77eeff31e..a2e3dd715380 100644
> --- a/drivers/i2c/busses/i2c-tiny-usb.c
> +++ b/drivers/i2c/busses/i2c-tiny-usb.c
> @@ -178,22 +178,39 @@ static int usb_read(struct i2c_adapter *adapter, in=
t cmd,
>  		    int value, int index, void *data, int len)
>  {
>  	struct i2c_tiny_usb *dev =3D (struct i2c_tiny_usb *)adapter->algo_data;
> +	void *dmadata =3D kmalloc(len, GFP_KERNEL);
> +	int ret;
> +
> +	if (!dmadata)
> +		return -ENOMEM;
> =20
>  	/* do control transfer */
> -	return usb_control_msg(dev->usb_dev, usb_rcvctrlpipe(dev->usb_dev, 0),
> +	ret =3D usb_control_msg(dev->usb_dev, usb_rcvctrlpipe(dev->usb_dev, 0),
>  			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
> -			       USB_DIR_IN, value, index, data, len, 2000);
> +			       USB_DIR_IN, value, index, dmadata, len, 2000);
> +
> +	memcpy(data, dmadata, len);
> +	kfree(dmadata);
> +	return ret;
>  }
> =20
>  static int usb_write(struct i2c_adapter *adapter, int cmd,
>  		     int value, int index, void *data, int len)
>  {
>  	struct i2c_tiny_usb *dev =3D (struct i2c_tiny_usb *)adapter->algo_data;
> +	void *dmadata =3D kmemdup(data, len, GFP_KERNEL);
> +	int ret;
> +
> +	if (!dmadata)
> +		return -ENOMEM;
> =20
>  	/* do control transfer */
> -	return usb_control_msg(dev->usb_dev, usb_sndctrlpipe(dev->usb_dev, 0),
> +	ret =3D usb_control_msg(dev->usb_dev, usb_sndctrlpipe(dev->usb_dev, 0),
>  			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> -			       value, index, data, len, 2000);
> +			       value, index, dmadata, len, 2000);
> +
> +	kfree(dmadata);
> +	return ret;
>  }
> =20
>  static void i2c_tiny_usb_free(struct i2c_tiny_usb *dev)
> --=20
> 2.11.0
>=20

--l5peyjdax6ledksv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkgalQACgkQ2O7X88g7
+po3gQ/+KaKFxrJ7W8IvxKxXOD7LjPSPgd7b2jtGWf6LdPDz4Dk3lCVwlFTqb1d0
zChfDwmsGJUY+j/br9yKZVxZ26jECjuhm8wb1o5CDcfl1uQ2C8zYmfS3WCoO2a5s
xCfAxYNgL6LBKXTvFuvQ5NfptBf1FPBaPVUn5iOoKmiu8c+rUfpT0yCjtnt0USGg
bSuGeWRoRzKIqQL8y5sVJ33uT3eP/AYG8DuX+MmBJvTi/jtUxLZAGCgCY/e+gbrr
piXFX3y3+j3t8MSW4CuEgLIzhTJPUXX1jZZ6ALBxPBq7T09HQhs3dYOLOGkTyxBQ
kIMWGnk79S8xtQ+Kdn9C3YAGoI9EYhAyMFQVuPB1Wb0BK/ByNvNDVtvHv9/CyVKT
lOs7J5PxgnFaIp2jp9VadnfAf517ljbfMS8P/1aQGUtzVj81vLxCRXpUf7k95u9H
aY1EX42NkepTZ/RTal9S0gwUoU7uDpWCXnL2r3LVAGRbBRr6HBDRX5PYJdDV1i61
UzV1VQENJ0LpaT/Cnn8waMUZZRNnydN/u8pzJD7Q8hQ33llWmaBtC0Qhc6CmhMym
mZvMeQKgch37/oQY5/9Xn8joTeZSTEPzibxyCkvFvGua8nxmMCTr9kyrnuyNb5Dz
Fk+62mRyZyIgNZBdg5bwe2oKQOEmDyU5Qr+V27oKRUr8GrBKSJw=
=HnAf
-----END PGP SIGNATURE-----

--l5peyjdax6ledksv--
