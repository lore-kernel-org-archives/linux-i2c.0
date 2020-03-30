From: Biwen Li <biwen.li@nxp.com>
Subject: RE: [PATCH] i2c: slave: support I2C_SLAVE_STOP event for the read
 transactions
Date: Mon, 30 Mar 2020 10:56:28 +0000
Message-ID: <DB6PR0401MB24389E2570C242FB9036EC968FCB0@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20200330105038.22546-1-biwen.li@oss.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:4161
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729313AbgC3K4b (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Mar 2020 06:56:31 -0400
In-Reply-To: <20200330105038.22546-1-biwen.li@oss.nxp.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Biwen Li (OSS)" <biwen.li@oss.nxp.com>, Leo Li <leoyang.li@nxp.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiafei Pan <jiafei.pan@nxp.com>

Hi All,

The patch based on https://patchwork.ozlabs.org/patch/1203640/
and it is not accepted, so it(https://patchwork.ozlabs.org/patch/1203640/) =
is needed before apply the new patch.=20

Best Regards,
Biwen Li
> Support I2C_SLAVE_STOP event for the read transactions(master read from
> slave)
>=20
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 62517a41b32d..1fd0d87885d5 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1464,6 +1464,7 @@ static irqreturn_t i2c_imx_slave_isr(struct
> imx_i2c_struct *i2c_imx)
>  		ctl &=3D ~I2CR_MTX;
>  		imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
>  		imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +		i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &value);
>  	}
>  	return IRQ_HANDLED;
>  }
> --
> 2.17.1
