From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH resend] i2c: rcar: fixup rcar type naming
Date: Tue, 29 Oct 2013 14:48:11 +0900
Message-ID: <20131029054809.GB5638@verge.net.au>
References: <87ob75zgn2.wl%kuninori.morimoto.gx@renesas.com>
 <87ppqzaw37.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ppqzaw37.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 21, 2013 at 01:04:32AM -0700, Kuninori Morimoto wrote:
> b720423a2627f045133bec39a31fe2bc0dab86f3
> (i2c: rcar: add rcar-H2 support)
> added R-Car H2 support on i2c-rcar.
> 
> The R-Car I2C type is based on SoC generation
> (Gen1 = E1/M1/H1, Gen2 = E2/M2/H2),
> but added naming was H1/H2 instead of Gen1/Gen2.
> Gen1/Gen2 is better naming on this driver.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Thanks Morimoto-san, this looks good to me.

Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Wolfram, please consider applying this change.

> ---
> resend
>  - exchanged Wolfram's email address
> 
>  drivers/i2c/busses/i2c-rcar.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 8603f5e..2c2fd7c 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -103,8 +103,8 @@ enum {
>  #define ID_NACK		(1 << 4)
>  
>  enum rcar_i2c_type {
> -	I2C_RCAR_H1,
> -	I2C_RCAR_H2,
> +	I2C_RCAR_GEN1,
> +	I2C_RCAR_GEN2,
>  };
>  
>  struct rcar_i2c_priv {
> @@ -240,10 +240,10 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
>  	}
>  
>  	switch (priv->devtype) {
> -	case I2C_RCAR_H1:
> +	case I2C_RCAR_GEN1:
>  		cdf_width = 2;
>  		break;
> -	case I2C_RCAR_H2:
> +	case I2C_RCAR_GEN2:
>  		cdf_width = 3;
>  		break;
>  	default:
> @@ -640,10 +640,10 @@ static const struct i2c_algorithm rcar_i2c_algo = {
>  };
>  
>  static const struct of_device_id rcar_i2c_dt_ids[] = {
> -	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_H1 },
> -	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_H1 },
> -	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_H1 },
> -	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_H2 },
> +	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
> +	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
> +	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
> +	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
> @@ -731,9 +731,9 @@ static int rcar_i2c_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_device_id rcar_i2c_id_table[] = {
> -	{ "i2c-rcar",		I2C_RCAR_H1 },
> -	{ "i2c-rcar_h1",	I2C_RCAR_H1 },
> -	{ "i2c-rcar_h2",	I2C_RCAR_H2 },
> +	{ "i2c-rcar",		I2C_RCAR_GEN1 },
> +	{ "i2c-rcar_gen1",	I2C_RCAR_GEN1 },
> +	{ "i2c-rcar_gen2",	I2C_RCAR_GEN2 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(platform, rcar_i2c_id_table);
> -- 
> 1.7.9.5
> 
