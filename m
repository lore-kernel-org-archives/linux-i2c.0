From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] leds: Remove obsolete cleanup for clientdata
Date: Tue, 21 Jun 2011 10:55:13 +0200
Message-ID: <20110621105513.4cac1282@endymion.delvare>
References: <1308603674-19264-1-git-send-email-w.sang@pengutronix.de>
	<1308603674-19264-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308603674-19264-2-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 20 Jun 2011 23:01:13 +0200, Wolfram Sang wrote:
> A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> on exit or error. This is obsolete meanwhile, the core will do it.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

> ---
> 
> This is more a cleanup than a bugfix. Still, would be happy to have this
> obsolete programming style largely removed in 3.0 if possible.
> 
>  drivers/leds/leds-lm3530.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/leds/leds-lm3530.c b/drivers/leds/leds-lm3530.c
> index 4d7ce76..59f5604 100644
> --- a/drivers/leds/leds-lm3530.c
> +++ b/drivers/leds/leds-lm3530.c
> @@ -382,7 +382,6 @@ err_class_register:
>  err_reg_init:
>  	regulator_put(drvdata->regulator);
>  err_regulator_get:
> -	i2c_set_clientdata(client, NULL);
>  	kfree(drvdata);
>  err_out:
>  	return err;


-- 
Jean Delvare
