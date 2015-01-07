From: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 1/3] i2c: imx: silence dma_request_slave_channel errors if
 dma not set up in device tree
Date: Wed, 7 Jan 2015 02:31:05 +0000
Message-ID: <BLUPR03MB373E2444083BA1779662AF9F5460@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420555701-24645-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
> Subject: [PATCH 1/3] i2c: imx: silence dma_request_slave_channel errors
> if dma not set up in device tree
> 
> If the i2c device tree nodes don't contain the dmas and dma-names
> property, an error is displayed for each i2c device:
> 
>     of_dma_request_slave_channel: dma-names property of node '/soc/aips-
> bus@02100000/i2c@021a0000' missing or empty
> 
> This patch avoids calling dma_request_slave_channel if the dma-names
> property does not exist in the device tree in the first place.
> 
> Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 7f3a9fe..f0d9904 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -288,6 +288,9 @@ static void i2c_imx_dma_request(struct imx_i2c_struct
> *i2c_imx,
>  	struct device *dev = &i2c_imx->adapter.dev;
>  	int ret;
> 
> +	if (!of_get_property(dev->of_node, "dma-names", NULL))
> +		return;
> +
>  	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>  	if (!dma)
>  		return;
> --

Acked-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
