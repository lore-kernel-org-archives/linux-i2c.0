From: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: hix5hd2: Fix modalias to make module auto-loading
 work
Date: Fri, 08 May 2015 22:56:59 +0800
Message-ID: <554CCEBB.6000107@linaro.org>
References: <1431046211.31122.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431046211.31122.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 05/08/2015 08:50 AM, Axel Lin wrote:
> Make the modalias match driver name, this is required to make module
> auto-loading work.
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Thanks Axel

Could you also share the info what's the condition of auto-loading module.

What I am test here is change the names works.
-               .name   = "hix5hd2-i2c",
+               .name   = "i2c-hix5hd2",

Change MODULE_ALIAS("platform:hix5hd2-i2c") does not works here.
Do I make some mistake?

> ---
>   drivers/i2c/busses/i2c-hix5hd2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
> index 8fe78d0..7c696643 100644
> --- a/drivers/i2c/busses/i2c-hix5hd2.c
> +++ b/drivers/i2c/busses/i2c-hix5hd2.c
> @@ -554,4 +554,4 @@ module_platform_driver(hix5hd2_i2c_driver);
>   MODULE_DESCRIPTION("Hix5hd2 I2C Bus driver");
>   MODULE_AUTHOR("Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>");
>   MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:i2c-hix5hd2");
> +MODULE_ALIAS("platform:hix5hd2-i2c");
>
