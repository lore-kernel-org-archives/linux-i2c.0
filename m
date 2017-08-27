From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Sun, 27 Aug 2017 16:37:55 +0200
Message-ID: <20170827143755.zpb7l7kuk4hf2pjt@ninjato>
References: <20170818160128.21228-1-radu.rendec@gmail.com>
 <20170818160128.21228-2-radu.rendec@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6olf2u2z7d4iphmr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37396 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdH0Oh7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 27 Aug 2017 10:37:59 -0400
Content-Disposition: inline
In-Reply-To: <20170818160128.21228-2-radu.rendec@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Radu Rendec <radu.rendec@gmail.com>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>
Cc: linux-i2c@vger.kernel.org


--6olf2u2z7d4iphmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 05:01:27PM +0100, Radu Rendec wrote:
> Use only a portion of the data buffer for DMA transfers, which is always
> 16-byte aligned. This makes the DMA buffer address 16-byte aligned and
> compensates for spurious hardware parity errors that may appear when the
> DMA buffer address is not 16-byte aligned.
>=20
> The data buffer is enlarged in order to accommodate any possible 16-byte
> alignment offset and changes the DMA code to only use a portion of the
> data buffer, which is 16-byte aligned.
>=20
> The symptom of the hardware issue is the same as the one addressed in
> v3.12-rc2-5-gbf41691 and manifests by transfers failing with EIO, with
> bit 9 being set in the ERRSTS register.
>=20
> Signed-off-by: Radu Rendec <radu.rendec@gmail.com>

Please use scripts/get_maintainers.pl as cc-cmd of git-send-email. This
would have added Seth and Neil (driver maintainers) to CC automatically.
I have done so now.

> ---
>  drivers/i2c/busses/i2c-ismt.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> index e98e44e..ccce0ca 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -172,7 +172,7 @@ struct ismt_priv {
>  	dma_addr_t io_rng_dma;			/* descriptor HW base addr */
>  	u8 head;				/* ring buffer head pointer */
>  	struct completion cmp;			/* interrupt completion */
> -	u8 dma_buffer[I2C_SMBUS_BLOCK_MAX + 1];	/* temp R/W data buffer */
> +	u8 buffer[I2C_SMBUS_BLOCK_MAX + 16];	/* temp R/W data buffer */

The IIO subsystems uses ____cacheline_aligned. I have never looked into
this closely, but it probably is cleaner than working with ALIGN on an
oversized buffer? Dunno why ____cacheline_aligned has four underscores
at the beginning, though...

>  };
> =20
>  /**
> @@ -320,7 +320,7 @@ static int ismt_process_desc(const struct ismt_desc *=
desc,
>  			     struct ismt_priv *priv, int size,
>  			     char read_write)
>  {
> -	u8 *dma_buffer =3D priv->dma_buffer;
> +	u8 *dma_buffer =3D (u8*)ALIGN((unsigned long)&priv->buffer[0], 16);

The fixed value here might not work on all (future?) generations?


> =20
>  	dev_dbg(&priv->pci_dev->dev, "Processing completed descriptor\n");
>  	__ismt_desc_dump(&priv->pci_dev->dev, desc);
> @@ -388,11 +388,12 @@ static int ismt_access(struct i2c_adapter *adap, u1=
6 addr,
>  	struct ismt_desc *desc;
>  	struct ismt_priv *priv =3D i2c_get_adapdata(adap);
>  	struct device *dev =3D &priv->pci_dev->dev;
> +	u8 *dma_buffer =3D (u8*)ALIGN((unsigned long)&priv->buffer[0], 16);
> =20
>  	desc =3D &priv->hw[priv->head];
> =20
>  	/* Initialize the DMA buffer */
> -	memset(priv->dma_buffer, 0, sizeof(priv->dma_buffer));
> +	memset(priv->buffer, 0, sizeof(priv->buffer));
> =20
>  	/* Initialize the descriptor */
>  	memset(desc, 0, sizeof(struct ismt_desc));
> @@ -441,8 +442,8 @@ static int ismt_access(struct i2c_adapter *adap, u16 =
addr,
>  			desc->wr_len_cmd =3D 2;
>  			dma_size =3D 2;
>  			dma_direction =3D DMA_TO_DEVICE;
> -			priv->dma_buffer[0] =3D command;
> -			priv->dma_buffer[1] =3D data->byte;
> +			dma_buffer[0] =3D command;
> +			dma_buffer[1] =3D data->byte;
>  		} else {
>  			/* Read Byte */
>  			dev_dbg(dev, "I2C_SMBUS_BYTE_DATA:  READ\n");
> @@ -461,9 +462,9 @@ static int ismt_access(struct i2c_adapter *adap, u16 =
addr,
>  			desc->wr_len_cmd =3D 3;
>  			dma_size =3D 3;
>  			dma_direction =3D DMA_TO_DEVICE;
> -			priv->dma_buffer[0] =3D command;
> -			priv->dma_buffer[1] =3D data->word & 0xff;
> -			priv->dma_buffer[2] =3D data->word >> 8;
> +			dma_buffer[0] =3D command;
> +			dma_buffer[1] =3D data->word & 0xff;
> +			dma_buffer[2] =3D data->word >> 8;
>  		} else {
>  			/* Read Word */
>  			dev_dbg(dev, "I2C_SMBUS_WORD_DATA:  READ\n");
> @@ -481,9 +482,9 @@ static int ismt_access(struct i2c_adapter *adap, u16 =
addr,
>  		desc->rd_len =3D 2;
>  		dma_size =3D 3;
>  		dma_direction =3D DMA_BIDIRECTIONAL;
> -		priv->dma_buffer[0] =3D command;
> -		priv->dma_buffer[1] =3D data->word & 0xff;
> -		priv->dma_buffer[2] =3D data->word >> 8;
> +		dma_buffer[0] =3D command;
> +		dma_buffer[1] =3D data->word & 0xff;
> +		dma_buffer[2] =3D data->word >> 8;
>  		break;
> =20
>  	case I2C_SMBUS_BLOCK_DATA:
> @@ -494,8 +495,8 @@ static int ismt_access(struct i2c_adapter *adap, u16 =
addr,
>  			dma_direction =3D DMA_TO_DEVICE;
>  			desc->wr_len_cmd =3D dma_size;
>  			desc->control |=3D ISMT_DESC_BLK;
> -			priv->dma_buffer[0] =3D command;
> -			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size - 1);
> +			dma_buffer[0] =3D command;
> +			memcpy(&dma_buffer[1], &data->block[1], dma_size - 1);
>  		} else {
>  			/* Block Read */
>  			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
> @@ -522,8 +523,8 @@ static int ismt_access(struct i2c_adapter *adap, u16 =
addr,
>  			dma_direction =3D DMA_TO_DEVICE;
>  			desc->wr_len_cmd =3D dma_size;
>  			desc->control |=3D ISMT_DESC_I2C;
> -			priv->dma_buffer[0] =3D command;
> -			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size - 1);
> +			dma_buffer[0] =3D command;
> +			memcpy(&dma_buffer[1], &data->block[1], dma_size - 1);
>  		} else {
>  			/* i2c Block Read */
>  			dev_dbg(dev, "I2C_SMBUS_I2C_BLOCK_DATA:  READ\n");
> @@ -552,18 +553,18 @@ static int ismt_access(struct i2c_adapter *adap, u1=
6 addr,
>  	if (dma_size !=3D 0) {
>  		dev_dbg(dev, " dev=3D%p\n", dev);
>  		dev_dbg(dev, " data=3D%p\n", data);
> -		dev_dbg(dev, " dma_buffer=3D%p\n", priv->dma_buffer);
> +		dev_dbg(dev, " dma_buffer=3D%p\n", dma_buffer);
>  		dev_dbg(dev, " dma_size=3D%d\n", dma_size);
>  		dev_dbg(dev, " dma_direction=3D%d\n", dma_direction);
> =20
>  		dma_addr =3D dma_map_single(dev,
> -				      priv->dma_buffer,
> +				      dma_buffer,
>  				      dma_size,
>  				      dma_direction);
> =20
>  		if (dma_mapping_error(dev, dma_addr)) {
>  			dev_err(dev, "Error in mapping dma buffer %p\n",
> -				priv->dma_buffer);
> +				dma_buffer);
>  			return -EIO;
>  		}
> =20
> --=20
> 2.9.5
>=20

--6olf2u2z7d4iphmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmi2T8ACgkQFA3kzBSg
KbZ48A/8C43QGt1qBS0tBu/ZDN+NJS/0YoOanhBvu0OeGU7MVo133237O52u3WdE
swdmg0c50Yx0xIksgE8gkNV5Yd6nqW2l//ok3DQv9Nxaewyt4BhFNjCre2fHUfPl
6uRwhH2Nf8in+LD9+Ev07EFQMzzG3wx9GJAsffoUyEnDO1OcjkgCjwHiGNek3ROv
3IhBOC76EKRmzVzvtCKXqXTKLuBqk+WqNcCYZQ1kzte5FaJiDUyGJrhtRtiDuy7K
xb4ph05wG+qGE2154QAWZIrmrIBY7mCVgi5VE+nB1KVdUBqhNMpEThZ7XO4L/6yu
WiCBlA9FEAvZcsgV2btmtGTA1UglPAiJAKokpZKSralcMkPgyE9AVZu2oSUkD9sR
SqkOfYrKwvfJHoxbTg6At1VSoTzCwpmcwH4Uf44aiXq8EtrOsL63JnL4/Hu4N0rC
cCXPb1qA9qbnPrGE6M6nz7EKvyHTDz7YGCjXqNY1krAou44FV+l7yCaCwqLb0pbj
h0akL5WX9VInTfiKXqYQA1u5f01u1l5XxM2Wz6A5uzHihXtkVZ2P1yN/3hIztL8Q
o9MBS6Kr4KgyJblbBc7aR6+jVGfhsoeKOeFP8jZL0ia/75/VZ0TmE9B3whvIS9aM
VEx4Mpswr80Gz3TH3nVZYAZLA2zLMcsLgdxvJOUh8SP7/m73EHc=
=RtYe
-----END PGP SIGNATURE-----

--6olf2u2z7d4iphmr--
