From: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] i2c: imx: remove unused return value assignments
Date: Wed, 7 Jan 2015 02:51:59 +0000
Message-ID: <BLUPR03MB3730DA4F398537D48717185F5460@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
 <1420555701-24645-2-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420555701-24645-2-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "Fabio.Estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Fabio.Estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sent: Tuesday, January 06, 2015 10:48 PM
> To: Wolfram Sang
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Duan Fugang-B38611; Yuan Yao-B46683;
> Estevam Fabio-R49496; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; Philipp Zabel
> Subject: [PATCH 2/3] i2c: imx: remove unused return value assignments
> 
> The ret variable is set and never used in the error path of
> i2c_imx_dma_request.
> 
> Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-imx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index f0d9904..b5c9ce4 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -298,7 +298,6 @@ static void i2c_imx_dma_request(struct imx_i2c_struct
> *i2c_imx,
>  	dma->chan_tx = dma_request_slave_channel(dev, "tx");
>  	if (!dma->chan_tx) {
>  		dev_dbg(dev, "can't request DMA tx channel\n");
> -		ret = -ENODEV;
>  		goto fail_al;
>  	}
> 
> @@ -316,7 +315,6 @@ static void i2c_imx_dma_request(struct imx_i2c_struct
> *i2c_imx,
>  	dma->chan_rx = dma_request_slave_channel(dev, "rx");
>  	if (!dma->chan_rx) {
>  		dev_dbg(dev, "can't request DMA rx channel\n");
> -		ret = -ENODEV;
>  		goto fail_tx;
>  	}
> 

Acked-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Regards,
Andy
