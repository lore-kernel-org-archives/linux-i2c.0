From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH v2 2/4] i2c: imx: Fix race condition in dma read
Date: Thu, 09 Aug 2018 13:57:08 +0200
Message-ID: <87o9ebzraj.fsf@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
        <20180709094304.8814-3-esben.haabendal@gmail.com>
        <20180724075707.7wrqltjj54gjrl4y@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724075707.7wrqltjj54gjrl4y@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 24 Jul 2018 09:57:07
 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Phil Reid <preid@electromag.com.au>, Clemens Gruber <clemens.gruber@pqgruber.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Mon, Jul 09, 2018 at 11:43:02AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> This fixes a race condition, where the DMAEN bit ends up being set after
>> I2C slave has transmitted a byte following the dummy read.  When that
>> happens, an interrupt is generated instead, and no DMA request is genera=
ted
>> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 se=
c).
>>=20
>> Fixed by setting the DMAEN bit before the dummy read.
>>=20
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> ---
>>  drivers/i2c/busses/i2c-imx.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 39cfd98c7b23..d86f152176a4 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -668,9 +668,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i=
2c_imx,
>>  	struct imx_i2c_dma *dma =3D i2c_imx->dma;
>>  	struct device *dev =3D &i2c_imx->adapter.dev;
>>=20=20
>> -	temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>> -	temp |=3D I2CR_DMAEN;
>> -	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>>=20=20
>>  	dma->chan_using =3D dma->chan_rx;
>>  	dma->dma_transfer_dir =3D DMA_DEV_TO_MEM;
>> @@ -810,6 +807,11 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_=
imx, struct i2c_msg *msgs, bo
>>  	if ((msgs->len - 1) || block_data)
>>  		temp &=3D ~I2CR_TXAK;
>>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>> +	if (i2c_imx->dma && msgs->len >=3D DMA_THRESHOLD && !block_data) {
>> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>> +		temp |=3D I2CR_DMAEN;
>> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>> +	}
>
> Does this need to be a separate write to the I2CR register? Just before
> the if there is temp written to this register, so probably this can be
> changed to just:
>
> 	if (i2c_imx->dma && msgs->len >=3D DMA_THRESHOLD && !block_data)
> 		temp |=3D I2CR_DMAEN;
>
> when moved before up one line.

Sure, that is clearly better.

> I don't find documentation for the LS processors where this
> register is described though (and the imx family doesn't seem to support
> DMA for i2c).

Yes, unfortunately, I think the LS1021A reference manual requires NDA.

> Other than that this looks reasonable and warrants a
>
> 	Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver=
")

I will add that.

/Esben
