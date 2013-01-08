From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-mxs: Fix type of error code
Date: Tue, 8 Jan 2013 07:57:00 +0100
Message-ID: <201301080757.00365.marex@denx.de>
References: <1357605126-26537-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357605126-26537-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> cmd_err is used to handle error code, so it should not be unsigned.
> 
> This fixes the following warning when building with W=1 option:
> 
> drivers/i2c/busses/i2c-mxs.c: In function 'mxs_i2c_xfer_msg':
> drivers/i2c/busses/i2c-mxs.c:331:19: warning: comparison between signed and
> unsigned integer expressions [-Wsign-compare]
> 
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Amazing catch

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Can this also go to -stable 3.7 ?

> ---
>  drivers/i2c/busses/i2c-mxs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 1b1a936..621153a 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -127,7 +127,7 @@ struct mxs_i2c_dev {
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct completion cmd_complete;
> -	u32 cmd_err;
> +	int cmd_err;
>  	struct i2c_adapter adapter;
>  	const struct mxs_i2c_speed_config *speed;

Best regards,
Marek Vasut
