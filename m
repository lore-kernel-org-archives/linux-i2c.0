From: "Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2] i2c: imx: Add arbitration lost check
Date: Thu, 18 Sep 2014 06:48:02 +0000
Message-ID: <7e13bb25c99a4300a6e9a238d45e6420@BY2PR03MB379.namprd03.prod.outlook.com>
References: <1409723527-30603-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409723527-30603-1-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi, Wolfram,

From: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org> Sent: Wednesday, September 03, 2014 1:52 PM + 0800
> To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
> Cc: Duan Fugang-B38611; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [PATCH v2] i2c: imx: Add arbitration lost check
> 
> According to the i.mx spec, for multimaster mode, if I2C is enabled when
> the bus is busy and asserts start, hardware inhibits the transmission,
> clears MSTA without signaling a stop, generate an interrupt, and set
> I2C_I2SR[IAL] to indicate a failed attempt to engage the bus, which means
> arbitration lost. In this case, we should first test I2C_I2SR[IAL], and
> clear this bit if it is set, and then I2C controller default to slave
> receive mode.
> 
> This patch check the IAL bit every time before an I2c transmission.
> if IAL is set, clear it and make I2C controller to default mode.
> 
> Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Acked-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> Changes for V2:
> -Use 'EAGAIN' instead of 'EIO' for arbitration lost -Modify the comment
> style
> 
>  drivers/i2c/busses/i2c-imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 613069b..ceff87c 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -268,6 +268,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct
> *i2c_imx, int for_busy)
> 
>  	while (1) {
>  		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +
> +		/* check for arbitration lost */
> +		if (temp & I2SR_IAL) {
> +			temp &= ~I2SR_IAL;
> +			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
> +			return -EAGAIN;
> +		}
> +
>  		if (for_busy && (temp & I2SR_IBB))
>  			break;
>  		if (!for_busy && !(temp & I2SR_IBB))
> --
> 1.9.1
> 
> --

Can you apply the patch or other comments ?

Thanks,
Haibo
