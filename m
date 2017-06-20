From: Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Tue, 20 Jun 2017 01:50:36 +0000
Message-ID: <AM4PR0401MB22609209653402EC1E2352DBFFC50@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
 <20170619185416.owrkfcbvutbhdrmo@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:2892
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751056AbdFTBuk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 21:50:40 -0400
In-Reply-To: <20170619185416.owrkfcbvutbhdrmo@pengutronix.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Cc: "lst@pengutronix.de" <lst@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "b38611@freescale.com" <b38611@freescale.com>, Yuan Yao <yao.yuan@freescale.com>

From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> Sent: Tuesday, Ju=
ne 20, 2017 2:54 AM
>On Fri, Jun 09, 2017 at 03:28:12PM +0200, Michail Georgios Etairidis wrote=
:
>> The i2c-imx driver incorrectly uses readb()/writeb() to read and write t=
o the
>appropriate registers when performing a repeated start. The appropriate
>imx_i2c_read_reg()/imx_i2c_write_reg() functions should be used instead.
>Performing a repeated start results in a kernel panic.
>
>please limit lines in the commit to 76 chars.
>
>> I am resubmitting this patch as the previous one was erroneous. This pat=
ch
>is based on the current upstream kernel code.
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c
>> b/drivers/i2c/busses/i2c-imx.c index 95ed171..54a47b4 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -734,9 +734,9 @@ static int i2c_imx_dma_read(struct imx_i2c_struct
>*i2c_imx,
>>  		 * the first read operation, otherwise the first read cost
>>  		 * one extra clock cycle.
>>  		 */
>> -		temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>>  		temp |=3D I2CR_MTX;
>> -		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>
>These were introduced by commit ce1a78840ff7a authored by Yao Yuan.
>
>>  	}
>>  	msgs->buf[msgs->len-1] =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
>>
>> @@ -857,9 +857,9 @@ static int i2c_imx_read(struct imx_i2c_struct
>*i2c_imx, struct i2c_msg *msgs, bo
>>  				 * the first read operation, otherwise the first
>read cost
>>  				 * one extra clock cycle.
>>  				 */
>> -				temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> +				temp =3D imx_i2c_read_reg(i2c_imx,
>IMX_I2C_I2CR);
>>  				temp |=3D I2CR_MTX;
>> -				writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> +				imx_i2c_write_reg(temp, i2c_imx,
>IMX_I2C_I2CR);
>
>These were introduced by commit 054b62d9f25c9 authored by Fugang Duan.
>
>I added these two people to Cc:, maybe they are still at Freescale/NXP and
>can comment.
>
>	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>
>results in
>
>	readb(i2c_imx->base + (reg << i2c_imx->hwdata->regshift));
>
>where .regshift is 2 for imx and 0 for vf610. So the patch makes a differe=
nce
>on the former platforms only.
>
>Best regards
>Uwe
>
The patch seems fine. It should use .imx_i2c_read_reg() instead of readb().

Acked-by: Fugang Duan <fugang.duan@nxp.com>

>--
>Pengutronix e.K.                           | Uwe Kleine-K=F6nig           =
 |
>Industrial Linux Solutions                 | http://www.pengutronix.de/  |
