From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [RESEND PATCH 2/2] i2c: mediatek: Add i2c compatible for
 MediaTek MT7622
Date: Thu, 10 Aug 2017 15:22:40 +0800
Message-ID: <1502349760.930.66.camel@mhfsdcap03>
References: <1502332061-25085-1-git-send-email-jun.gao@mediatek.com>
         <1502332061-25085-3-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502332061-25085-3-git-send-email-jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-08-10 at 10:27 +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Add i2c compatible for MT7622. Compare to MT8173 i2c controller,
> MT7622 limits message numbers to 255, and does not support 4GB
> DMA mode.
> 

These two resend patches only modify commit message.
Thanks!

Jun

> Signed-off-by: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 9bedf0b..2c7f847 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -172,6 +172,14 @@ struct mtk_i2c {
>  	.max_comb_2nd_msg_len = 31,
>  };
>  
> +static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
> +	.max_num_msgs = 255,
> +	.max_write_len = 65535,
> +	.max_read_len = 65535,
> +	.max_comb_1st_msg_len = 65535,
> +	.max_comb_2nd_msg_len = 65535,
> +};
> +
>  static const struct mtk_i2c_compatible mt6577_compat = {
>  	.quirks = &mt6577_i2c_quirks,
>  	.pmic_i2c = 0,
> @@ -190,6 +198,15 @@ struct mtk_i2c {
>  	.support_33bits = 0,
>  };
>  
> +static const struct mtk_i2c_compatible mt7622_compat = {
> +	.quirks = &mt7622_i2c_quirks,
> +	.pmic_i2c = 0,
> +	.dcm = 1,
> +	.auto_restart = 1,
> +	.aux_len_reg = 1,
> +	.support_33bits = 0,
> +};
> +
>  static const struct mtk_i2c_compatible mt8173_compat = {
>  	.pmic_i2c = 0,
>  	.dcm = 1,
> @@ -201,6 +218,7 @@ struct mtk_i2c {
>  static const struct of_device_id mtk_i2c_of_match[] = {
>  	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
>  	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
> +	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
>  	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
>  	{}
>  };


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
