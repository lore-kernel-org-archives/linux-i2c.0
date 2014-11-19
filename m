From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c: imx: simplify i2c_imx_dma_write() a little
Date: Wed, 19 Nov 2014 10:15:34 +0000
Message-ID: <BL2PR03MB338C5B78DA771E61570E6CD83890@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1416388299-4650-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416388299-4650-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Great, It's quite simpler than before.
I should take more attention on make the code cleanly and efficiently.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
> Sent: Wednesday, November 19, 2014 5:12 PM
> To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Yuan Yao-B46683; Wolfram Sang
> Subject: [PATCH] i2c: imx: simplify i2c_imx_dma_write() a little
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-imx.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d0668d0d626d..aab1f4bb9e30 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -657,11 +657,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct
> *i2c_imx,
>  	if (result)
>  		return result;
> 
> -	result = i2c_imx_acked(i2c_imx);
> -	if (result)
> -		return result;
> -
> -	return 0;
> +	return i2c_imx_acked(i2c_imx);
>  }
> 
>  static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
> --
> 2.1.1
