From: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Subject: Re: [PATCH 02/24] power/ds2782: really clear i2c_clientdata on exit
Date: Sun, 21 Mar 2010 10:53:53 +1300
Message-ID: <4BA543F1.6080504@bluewatersys.com>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269094385-16114-3-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> Probably due to a copy & paste bug, clientdata was set again to the data
> structure (which is freed immediately afterwards) when it should be NULLed.

Good catch. Thanks.

Acked-by: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>

> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
> Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/power/ds2782_battery.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_battery.c
> index da14f37..6971b85 100644
> --- a/drivers/power/ds2782_battery.c
> +++ b/drivers/power/ds2782_battery.c
> @@ -236,7 +236,7 @@ static int ds2782_battery_remove(struct i2c_client *client)
>  	idr_remove(&battery_id, info->id);
>  	mutex_unlock(&battery_lock);
>  
> -	i2c_set_clientdata(client, info);
> +	i2c_set_clientdata(client, NULL);
>  
>  	kfree(info);
>  	return 0;
> @@ -289,7 +289,7 @@ static int ds2782_battery_probe(struct i2c_client *client,
>  fail_register:
>  	kfree(info->battery.name);
>  fail_name:
> -	i2c_set_clientdata(client, info);
> +	i2c_set_clientdata(client, NULL);
>  	kfree(info);
>  fail_info:
>  	mutex_lock(&battery_lock);
