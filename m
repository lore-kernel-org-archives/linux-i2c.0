From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 23 Jul 2014 11:48:34 +0200
Message-ID: <20140723114834.411f6bb4@ipc1.ka-ro>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
	<1406103883-3572-2-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406103883-3572-2-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Yuan Yao wrote:
> Add dma support for i2c. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in =
dts node.
>=20
> Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-imx.c | 377 +++++++++++++++++++++++++++++++++=
++++------
>  1 file changed, 324 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index 1d7efa3..a9893c3 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -37,22 +37,27 @@
>  /** Includes *******************************************************=
************
>  ********************************************************************=
***********/
> =20
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> -#include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/init.h>
>  #include <linux/io.h>
> -#include <linux/sched.h>
> -#include <linux/platform_device.h>
> -#include <linux/clk.h>
> -#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_dma.h>
>  #include <linux/platform_data/i2c-imx.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> =20
>  /** Defines ********************************************************=
************
>  ********************************************************************=
***********/
> @@ -63,6 +68,10 @@
>  /* Default value */
>  #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
> =20
> +/* enable DMA if transfer byte size is bigger than this threshold */
> +#define IMX_I2C_DMA_THRESHOLD	16
> +#define IMX_I2C_DMA_TIMEOUT	1000
> +
>  /* IMX I2C registers:
>   * the I2C register offset is different between SoCs,
>   * to provid support for all these chips, split the
> @@ -88,6 +97,7 @@
>  #define I2SR_IBB	0x20
>  #define I2SR_IAAS	0x40
>  #define I2SR_ICF	0x80
> +#define I2CR_DMAEN	0x02
>  #define I2CR_RSTA	0x04
>  #define I2CR_TXAK	0x08
>  #define I2CR_MTX	0x10
> @@ -174,6 +184,17 @@ struct imx_i2c_hwdata {
>  	unsigned		i2cr_ien_opcode;
>  };
> =20
> +struct imx_i2c_dma {
> +	struct dma_chan		*chan_tx;
> +	struct dma_chan		*chan_rx;
> +	struct dma_chan		*chan_using;
> +	struct completion	cmd_complete;
> +	dma_addr_t		dma_buf;
> +	unsigned int		dma_len;
> +	unsigned int		dma_transfer_dir;
> +	unsigned int		dma_data_dir;
> +};
> +
>  struct imx_i2c_struct {
>  	struct i2c_adapter	adapter;
>  	struct clk		*clk;
> @@ -184,6 +205,8 @@ struct imx_i2c_struct {
>  	int			stopped;
>  	unsigned int		ifdr; /* IMX_I2C_IFDR */
>  	const struct imx_i2c_hwdata	*hwdata;
> +
> +	struct imx_i2c_dma	*dma;
>  };
> =20
>  static const struct imx_i2c_hwdata imx1_i2c_hwdata  =3D {
> @@ -254,6 +277,133 @@ static inline unsigned char imx_i2c_read_reg(st=
ruct imx_i2c_struct *i2c_imx,
>  	return readb(i2c_imx->base + (reg << i2c_imx->hwdata->regshift));
>  }
> =20
> +/* Functions for DMA support */
> +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> +						dma_addr_t phy_addr)
> +{
> +	struct imx_i2c_dma *dma;
> +	struct dma_slave_config dma_sconfig;
> +	struct device *dev =3D &i2c_imx->adapter.dev;
> +	int ret;
> +
> +	dma =3D devm_kzalloc(dev, sizeof(struct imx_i2c_dma), GFP_KERNEL);
> +	if (!dma) {
> +		dev_info(dev, "can't allocate DMA struct\n");
>
dev_err() is designated to print ERROR messages, though this message
could well be eliminated as the memory subsystem will be noisy enough
if the allocation failed.

> +		return -ENOMEM;
> +	}
> +
> +	dma->chan_tx =3D dma_request_slave_channel(dev, "tx");
> +
> +	if (!dma->chan_tx) {
> +		dev_info(dev, "DMA tx channel request failed\n");
>
dev_err()

> +		ret =3D -ENODEV;
> +		goto fail_al;
> +	}
> +
> +	dma_sconfig.dst_addr =3D phy_addr +
> +				(IMX_I2C_I2DR << i2c_imx->hwdata->regshift);
> +	dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.dst_maxburst =3D 1;
> +	dma_sconfig.direction =3D DMA_MEM_TO_DEV;
> +	ret =3D dmaengine_slave_config(dma->chan_tx, &dma_sconfig);
> +	if (ret < 0) {
> +		dev_info(dev, "DMA slave config failed, err =3D %d\n", ret);
>
dev_err()

> +		goto fail_tx;
> +	}
> +
> +	dma->chan_rx =3D dma_request_slave_channel(dev, "rx");
> +	if (!dma->chan_rx) {
> +		dev_info(dev, "DMA rx channel request failed\n");
>
dev_err()

> +		ret =3D -ENODEV;
> +		goto fail_tx;
> +	}
> +
> +	dma_sconfig.src_addr =3D phy_addr +
> +				(IMX_I2C_I2DR << i2c_imx->hwdata->regshift);
> +	dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dma_sconfig.src_maxburst =3D 1;
> +	dma_sconfig.direction =3D DMA_DEV_TO_MEM;
> +	ret =3D dmaengine_slave_config(dma->chan_rx, &dma_sconfig);
> +	if (ret < 0) {
> +		dev_info(dev, "DMA slave config failed, err =3D %d\n", ret);
>
dev_err()

> +		goto fail_rx;
> +	}
> +
> +	i2c_imx->dma =3D dma;
> +
> +	init_completion(&dma->cmd_complete);
> +
> +	return 0;
> +
> +fail_rx:
> +	dma_release_channel(dma->chan_rx);
> +fail_tx:
> +	dma_release_channel(dma->chan_tx);
> +fail_al:
> +	devm_kfree(dev, dma);
>
No need for this one (that's the whole point of using devm_kzalloc())!

> +	return ret;
> +}
> +
> +static void i2c_imx_dma_callback(void *arg)
> +{
> +	struct imx_i2c_struct *i2c_imx =3D (struct imx_i2c_struct *)arg;
> +	struct imx_i2c_dma *dma =3D i2c_imx->dma;
> +
> +	dma_unmap_single(dma->chan_using->device->dev, dma->dma_buf,
> +			dma->dma_len, dma->dma_data_dir);
> +	complete(&dma->cmd_complete);
> +}
> +
> +static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
> +					struct i2c_msg *msgs)
> +{
> +	struct imx_i2c_dma *dma =3D i2c_imx->dma;
> +	struct dma_async_tx_descriptor *txdesc;
> +	struct device *dev =3D &i2c_imx->adapter.dev;
> +	struct device *chan_dev =3D dma->chan_using->device->dev;
> +
> +	dma->dma_buf =3D dma_map_single(chan_dev, msgs->buf,
> +					dma->dma_len, dma->dma_data_dir);
> +	if (dma_mapping_error(chan_dev, dma->dma_buf)) {
> +		dev_err(dev, "DMA mapping failed\n");
> +		return -EINVAL;
> +	}
> +
> +	txdesc =3D dmaengine_prep_slave_single(dma->chan_using, dma->dma_bu=
f,
> +					dma->dma_len, dma->dma_transfer_dir,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!txdesc) {
> +		dev_err(dev, "Not able to get desc for DMA xfer\n");
>
s/Not able/Unable/

> +		dma_unmap_single(chan_dev, dma->dma_buf,
> +					dma->dma_len, dma->dma_data_dir);
> +		return -EINVAL;
> +	}
> +
> +	txdesc->callback =3D i2c_imx_dma_callback;
> +	txdesc->callback_param =3D i2c_imx;
> +	dmaengine_submit(txdesc);
> +	dma_async_issue_pending(dma->chan_using);
> +
> +	return 0;
> +}
> +
> +static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx)
> +{
> +	struct imx_i2c_dma *dma =3D i2c_imx->dma;
> +
> +	dma->dma_buf =3D 0;
> +	dma->dma_len =3D 0;
> +
> +	dma_release_channel(dma->chan_tx);
> +	dma->chan_tx =3D NULL;
> +
> +	dma_release_channel(dma->chan_rx);
> +	dma->chan_rx =3D NULL;
> +
> +	dma->chan_using =3D NULL;
> +}
> +
>  /** Functions for IMX I2C adapter driver ***************************=
************
>  ********************************************************************=
***********/
> =20
> @@ -332,6 +482,11 @@ static int i2c_imx_start(struct imx_i2c_struct *=
i2c_imx)
> =20
>  	temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>
Why reread the register you have written just before?

> +	temp &=3D ~I2CR_DMAEN;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
>  	return result;
>  }
> =20
> @@ -425,44 +580,104 @@ static irqreturn_t i2c_imx_isr(int irq, void *=
dev_id)
> =20
>  static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_=
msg *msgs)
>  {
> -	int i, result;
> +	int i, result, timeout =3D IMX_I2C_DMA_TIMEOUT;
> +	unsigned int temp =3D 0;
> +	struct imx_i2c_dma *dma =3D i2c_imx->dma;
> +	struct device *dev =3D &i2c_imx->adapter.dev;
> =20
> -	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=3D0x=
%x\n",
> +	dev_dbg(dev, "<%s> write slave address: addr=3D0x%x\n",
>  		__func__, msgs->addr << 1);
> +	if (dma && msgs->len >=3D IMX_I2C_DMA_THRESHOLD) {
> +		reinit_completion(&i2c_imx->dma->cmd_complete);
> +		dma->chan_using =3D dma->chan_tx;
> +		dma->dma_transfer_dir =3D DMA_MEM_TO_DEV;
> +		dma->dma_data_dir =3D DMA_TO_DEVICE;
> +		dma->dma_len =3D msgs->len - 1;
> +		result =3D i2c_imx_dma_xfer(i2c_imx, msgs);
> +		if (result)
> +			return result;
> =20
> -	/* write slave address */
> -	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> -	result =3D i2c_imx_trx_complete(i2c_imx);
> -	if (result)
> -		return result;
> -	result =3D i2c_imx_acked(i2c_imx);
> -	if (result)
> -		return result;
> -	dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp |=3D I2CR_DMAEN;
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> =20
> -	/* write data */
> -	for (i =3D 0; i < msgs->len; i++) {
> -		dev_dbg(&i2c_imx->adapter.dev,
> -			"<%s> write byte: B%d=3D0x%X\n",
> -			__func__, i, msgs->buf[i]);
> -		imx_i2c_write_reg(msgs->buf[i], i2c_imx, IMX_I2C_I2DR);
> +		/*
> +		 * Write slave address.
> +		 * The first byte muse be transmitted by the CPU.
> +		 */
> +		imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> +		result =3D wait_for_completion_interruptible_timeout(
> +					&i2c_imx->dma->cmd_complete,
> +					msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> +		if (result <=3D 0) {
> +			dmaengine_terminate_all(dma->chan_using);
> +			if (result)
> +				return result;
> +			else
> +				return -ETIMEDOUT;
> +		}
> +
> +		/* Waiting for Transfer complete. */
> +		while (timeout--) {
> +			temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +			if (temp & I2SR_ICF)
> +				break;
> +			udelay(10);
> +		}
> +
> +		if (!timeout)
> +			return -ETIMEDOUT;
> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp &=3D ~I2CR_DMAEN;
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +		/* The last data byte must be transferred by the CPU. */
> +		imx_i2c_write_reg(msgs->buf[msgs->len-1],
> +					i2c_imx, IMX_I2C_I2DR);
>  		result =3D i2c_imx_trx_complete(i2c_imx);
>  		if (result)
>  			return result;
> +
>  		result =3D i2c_imx_acked(i2c_imx);
>  		if (result)
>  			return result;
> +	} else {
> +		/* write slave address */
> +		imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> +		result =3D i2c_imx_trx_complete(i2c_imx);
> +		if (result)
> +			return result;
> +
> +		result =3D i2c_imx_acked(i2c_imx);
> +		if (result)
> +			return result;
> +
> +		dev_dbg(dev, "<%s> write data\n", __func__);
> +
> +		/* write data */
> +		for (i =3D 0; i < msgs->len; i++) {
> +			dev_dbg(dev, "<%s> write byte: B%d=3D0x%X\n",
> +				__func__, i, msgs->buf[i]);
> +			imx_i2c_write_reg(msgs->buf[i], i2c_imx, IMX_I2C_I2DR);
> +			result =3D i2c_imx_trx_complete(i2c_imx);
> +			if (result)
> +				return result;
> +			result =3D i2c_imx_acked(i2c_imx);
> +			if (result)
> +				return result;
> +		}
>  	}
>  	return 0;
>  }
> =20
>  static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_m=
sg *msgs)
>  {
> -	int i, result;
> +	int i, result, timeout =3D IMX_I2C_DMA_TIMEOUT;
>  	unsigned int temp;
> +	struct imx_i2c_dma *dma =3D i2c_imx->dma;
> +	struct device *dev =3D &i2c_imx->adapter.dev;
> =20
> -	dev_dbg(&i2c_imx->adapter.dev,
> -		"<%s> write slave address: addr=3D0x%x\n",
> +	dev_dbg(dev, "<%s> write slave address: addr=3D0x%x\n",
>  		__func__, (msgs->addr << 1) | 0x01);
> =20
>  	/* write slave address */
> @@ -474,7 +689,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2=
c_imx, struct i2c_msg *msgs)
>  	if (result)
>  		return result;
> =20
> -	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
> +	dev_dbg(dev, "<%s> setup bus\n", __func__);
> =20
>  	/* setup bus to read data */
>  	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> @@ -484,35 +699,82 @@ static int i2c_imx_read(struct imx_i2c_struct *=
i2c_imx, struct i2c_msg *msgs)
>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>  	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
> =20
> -	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
> +	dev_dbg(dev, "<%s> read data\n", __func__);
> =20
> -	/* read data */
> -	for (i =3D 0; i < msgs->len; i++) {
> -		result =3D i2c_imx_trx_complete(i2c_imx);
> +	if (dma && msgs->len >=3D IMX_I2C_DMA_THRESHOLD) {
> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp |=3D I2CR_DMAEN;
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +		reinit_completion(&i2c_imx->dma->cmd_complete);
> +		dma->chan_using =3D dma->chan_rx;
> +		dma->dma_transfer_dir =3D DMA_DEV_TO_MEM;
> +		dma->dma_data_dir =3D DMA_FROM_DEVICE;
> +		/* The last two data bytes must be transferred by the CPU. */
> +		dma->dma_len =3D msgs->len - 2;
> +		result =3D i2c_imx_dma_xfer(i2c_imx, msgs);
>  		if (result)
>  			return result;
> -		if (i =3D=3D (msgs->len - 1)) {
> -			/* It must generate STOP before read I2DR to prevent
> -			   controller from generating another clock cycle */
> -			dev_dbg(&i2c_imx->adapter.dev,
> -				"<%s> clear MSTA\n", __func__);
> -			temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> -			temp &=3D ~(I2CR_MSTA | I2CR_MTX);
> -			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> -			i2c_imx_bus_busy(i2c_imx, 0);
> -			i2c_imx->stopped =3D 1;
> -		} else if (i =3D=3D (msgs->len - 2)) {
> -			dev_dbg(&i2c_imx->adapter.dev,
> -				"<%s> set TXAK\n", __func__);
> -			temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> -			temp |=3D I2CR_TXAK;
> -			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +		result =3D wait_for_completion_interruptible_timeout(
> +					&i2c_imx->dma->cmd_complete,
> +					msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> +		if (result <=3D 0) {
> +			dmaengine_terminate_all(dma->chan_using);
> +			if (result)
> +				return result;
> +			else
> +				return -ETIMEDOUT;
>  		}
> -		msgs->buf[i] =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> -		dev_dbg(&i2c_imx->adapter.dev,
> -			"<%s> read byte: B%d=3D0x%X\n",
> -			__func__, i, msgs->buf[i]);
> +
> +		/* waiting for Transfer complete. */
> +		while (timeout--) {
> +			temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +			if (temp & I2SR_ICF)
> +				break;
> +			udelay(10);
> +		}
> +
> +		if (!timeout)
> +			return -ETIMEDOUT;
> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp &=3D ~I2CR_DMAEN;
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +	} else {
> +		/* read data */
> +		for (i =3D 0; i < msgs->len - 2; i++) {
> +			result =3D i2c_imx_trx_complete(i2c_imx);
> +			if (result)
> +				return result;
> +			msgs->buf[i] =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +			dev_dbg(dev, "<%s> read byte: B%d=3D0x%X\n",
> +				__func__, i, msgs->buf[i]);
> +		}
> +		result =3D i2c_imx_trx_complete(i2c_imx);
>  	}
> +
> +	/* read n-1 byte data */
> +	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	temp |=3D I2CR_TXAK;
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +	msgs->buf[msgs->len-2] =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +	/* read n byte data */
> +	result =3D i2c_imx_trx_complete(i2c_imx);
> +	if (result)
> +		return result;
> +
> +	/*
> +	 * It must generate STOP before read I2DR to prevent
> +	 * controller from generating another clock cycle
> +	 */
> +	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +	temp &=3D ~(I2CR_MSTA | I2CR_MTX);
> +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +	i2c_imx_bus_busy(i2c_imx, 0);
> +	i2c_imx->stopped =3D 1;
> +	msgs->buf[msgs->len-1] =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +
>  	return 0;
>  }
> =20
> @@ -599,6 +861,7 @@ static int i2c_imx_probe(struct platform_device *=
pdev)
>  	void __iomem *base;
>  	int irq, ret;
>  	u32 bitrate;
> +	u32 phy_addr;
> =20
>  	dev_dbg(&pdev->dev, "<%s>\n", __func__);
> =20
> @@ -609,6 +872,7 @@ static int i2c_imx_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	phy_addr =3D res->start;
>
res->start is NOT a u32 type!

>  	base =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -694,6 +958,10 @@ static int i2c_imx_probe(struct platform_device =
*pdev)
>  		i2c_imx->adapter.name);
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> =20
> +	/* Init DMA config if support*/
> +	if (i2c_imx_dma_request(i2c_imx, (dma_addr_t)phy_addr))
>
If you want a dma_addr_t variable, why do you declare it with a
different type?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
