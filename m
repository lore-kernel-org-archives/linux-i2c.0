From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [v7,1/1] i2c: add master driver for mellanox systems
Date: Thu, 17 Nov 2016 23:15:22 +0100
Message-ID: <20161117221522.GA10875@katana>
References: <1479388708-37054-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:46268 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbcKQWP0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 17:15:26 -0500
Content-Disposition: inline
In-Reply-To: <1479388708-37054-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the patch and the prompt reworks. Also thank you to Vladimir
for initial reviews!

> Device supports:
>  - Master mode
>  - One physical bus
>  - Polling mode

Out of interest: is there any interrupt at all?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 411e3b8..26d05f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7881,6 +7881,14 @@ W:	http://www.mellanox.com
>  Q:	http://patchwork.ozlabs.org/project/netdev/list/
>  F:	drivers/net/ethernet/mellanox/mlxsw/
> =20
> +MELLANOX MLXCPLD I2C DRIVER
> +M:	Vadim Pasternak <vadimp@mellanox.com>
> +M:	Michael Shych <michaelsh@mellanox.com>
> +L:	linux-i2c@vger.kernel.org
> +S:	Supported
> +F:	drivers/i2c/busses/i2c-mlxcpld.c
> +F:	Documentation/i2c/busses/i2c-mlxcpld
> +

No need to change right now, but I think you could simplify all your
drivers in one entry with

F: *mlxcpld*

or something similar to keep MAINTAINERS compact.

> +/**
> + * struct  mlxcpld_i2c_curr_xfer - current transaction parameters:
> + * @cmd: command;
> + * @addr_width: address width;
> + * @data_len: data length;
> + * @cmd: command register;
> + * @msg_num: message number;
> + * @msg: pointer to message buffer;
> + */

While I value effort to describe struct members, this is so
self-explaining that I think it could be left out.

> +/**
> + * struct mlxcpld_i2c_priv - private controller data:
> + * @adap: i2c adapter;
> + * @base_addr: base IO address;
> + * @lock: bus access lock;
> + * @xfer: current i2c transfer block;
> + * @dev: device handle;
> + */

ditto

> +/*
> + * Check validity of current i2c message and all transfer.
> + * Calculate also common length of all i2c messages in transfer.
> + */
> +static int mlxcpld_i2c_invalid_len(struct mlxcpld_i2c_priv *priv,
> +				   const struct i2c_msg *msg, u8 *comm_len)
> +{
> +	u8 max_len =3D msg->flags =3D=3D I2C_M_RD ? MLXCPLD_I2C_DATA_REG_SZ -
> +		     MLXCPLD_I2C_MAX_ADDR_LEN : MLXCPLD_I2C_DATA_REG_SZ;
> +
> +	if (msg->len > max_len)
> +		return -EINVAL;

If you populate a 'struct i2c_adapter_quirks' the core will do this
check for you.

> +	*comm_len +=3D msg->len;
> +	if (*comm_len > MLXCPLD_I2C_DATA_REG_SZ)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * Check validity of received i2c messages parameters.
> + * Returns 0 if OK, other - in case of invalid parameters
> + * or common length of data that should be passed to CPLD
> + */
> +static int mlxcpld_i2c_check_msg_params(struct mlxcpld_i2c_priv *priv,
> +					struct i2c_msg *msgs, int num,
> +					u8 *comm_len)
> +{
> +	int i;
> +
> +	if (!num) {
> +		dev_err(priv->dev, "Incorrect 0 num of messages\n");
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(msgs[0].addr > 0x7f)) {
> +		dev_err(priv->dev, "Invalid address 0x%03x\n",
> +			msgs[0].addr);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < num; ++i) {
> +		if (unlikely(!msgs[i].buf)) {
> +			dev_err(priv->dev, "Invalid buf in msg[%d]\n",
> +				i);
> +			return -EINVAL;
> +		}

I was about to write "the core will check this for you", but wow, we are
not good at this... I will try to come up with some patches soon. No
need for you to changes this right now.

=2E..

> +	case MLXCPLD_LPCI2C_ACK_IND:
> +		if (priv->xfer.cmd !=3D I2C_M_RD)
> +			return (priv->xfer.addr_width + priv->xfer.data_len);
> +
> +		if (priv->xfer.msg_num =3D=3D 1)
> +			i =3D 0;
> +		else
> +			i =3D 1;
> +
> +		if (!priv->xfer.msg[i].buf)
> +			return -EINVAL;
> +
> +		/*
> +		 * Actual read data len will be always the same as
> +		 * requested len. 0xff (line pull-up) will be returned
> +		 * if slave has no data to return. Thus don't read
> +		 * MLXCPLD_LPCI2C_NUM_DAT_REG reg from CPLD.
> +		 */
> +		datalen =3D priv->xfer.data_len;
> +
> +		mlxcpld_i2c_read_comm(priv, MLXCPLD_LPCI2C_DATA_REG,
> +				      priv->xfer.msg[i].buf, datalen);
> +
> +		return datalen;
> +
> +	case MLXCPLD_LPCI2C_NACK_IND:
> +		return -EAGAIN;

-EAGAIN is for arbitration lost. -ENXIO is for NACK. See
Documentation/i2c/fault-codes.

What kind of testing have you done with the driver?

Thanks,

   Wolfram

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLiv6AAoJEBQN5MwUoCm25EgP/2Jwotbaw52M1voUxGJ7dAIM
mAzju7hGef145u4ex2TGhxnEkFYgm0HQf2M5orlf6jAOXXwQMa/pK/2TBASRPGzJ
BrD+t2KwzshnakMbzCUCvp8Xe/1GgaW/HSsjAsr6aIeNUzdFGpUwF+MluGzgDzg4
AXxT1/KKCKzQqKrIaUejuGkTBCDK4ZlTWvTj+xgk1MyfRnOVH6HrchfCiYi2H/Wh
5cR3AkC5UP9Lh2lt5DqNXFf/shR5clQhN18S3Dz4S78wuzA4cH4h7zZiBzm2ZL5s
MJizXWO1wsisY1bL07BrYmCDQOHOO9q2CX20YrZ9HJ2J2E8WPtFu4moMaT5x74pG
bAHB8ouWjBziWLQUib/k1JAsxeN+bdkfSBvaBX2lYCbfMGtytAiMS9747lamZ4Hi
V7t7EMG9uUV6r0foTH3AAyuh2f4XKwf0MDVTjDP7rymE5oVdHsYVt4q5uKM33tU0
hpIQ1z/h2m/DzUci8x9yDOwgMc/pg4No72g0okYhCPGvnpvrc3ZzhBO1S0GzEzn4
qVLkDyVCl8WfrXISzpb/sLK5gkrdNuTtyGYA3on/jNDt0dkpTr/dGeamdrY03rtD
gbBQsDmeZH/3JhN3NRuYqFXymxFbMMP3lPrBTBwWSvkjj/LMRI7i7HEXwJPaLaEN
JSlMkTyxYvG/Ae8KrNTr
=N+OQ
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
