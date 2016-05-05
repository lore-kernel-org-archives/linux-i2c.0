From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v7 5/9] i2c: rk3x: Change SoC data to not use array
Date: Thu, 05 May 2016 23:36:49 +0200
Message-ID: <2061861.OMNZ1I2HYA@diego>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com> <1462372418-6349-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462372418-6349-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Mittwoch, 4. Mai 2016, 22:33:38 schrieb David Wu:
> Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

that makes the code look nicer (and of course prepares for you further 
changes), so

Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-rk3x.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 0838fcf..9686c81 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -867,17 +867,39 @@ static const struct i2c_algorithm rk3x_i2c_algorithm =
> { .functionality		= rk3x_i2c_func,
>  };
> 
> -static struct rk3x_i2c_soc_data soc_data[3] = {
> -	{ .grf_offset = 0x154 }, /* rk3066 */
> -	{ .grf_offset = 0x0a4 }, /* rk3188 */
> -	{ .grf_offset = -1 },    /* no I2C switching needed */
> +static const struct rk3x_i2c_soc_data rk3066_soc_data = {
> +	.grf_offset = 0x154,
> +};
> +
> +static const struct rk3x_i2c_soc_data rk3188_soc_data = {
> +	.grf_offset = 0x0a4,
> +};
> +
> +static const struct rk3x_i2c_soc_data rk3228_soc_data = {
> +	.grf_offset = -1,
> +};
> +
> +static const struct rk3x_i2c_soc_data rk3288_soc_data = {
> +	.grf_offset = -1,
>  };
> 
>  static const struct of_device_id rk3x_i2c_match[] = {
> -	{ .compatible = "rockchip,rk3066-i2c", .data = (void *)&soc_data[0] },
> -	{ .compatible = "rockchip,rk3188-i2c", .data = (void *)&soc_data[1] },
> -	{ .compatible = "rockchip,rk3228-i2c", .data = (void *)&soc_data[2] },
> -	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
> +	{
> +		.compatible = "rockchip,rk3066-i2c",
> +		.data = (void *)&rk3066_soc_data
> +	},
> +	{
> +		.compatible = "rockchip,rk3188-i2c",
> +		.data = (void *)&rk3188_soc_data
> +	},
> +	{
> +		.compatible = "rockchip,rk3228-i2c",
> +		.data = (void *)&rk3228_soc_data
> +	},
> +	{
> +		.compatible = "rockchip,rk3288-i2c",
> +		.data = (void *)&rk3288_soc_data
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rk3x_i2c_match);

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
