From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: hix5hd2: Fix modalias to make module auto-loading work
Date: Fri, 8 May 2015 23:21:51 +0800
Message-ID: <CAFRkauATYA7DtK+NV9VcVgTmDmc40PDSXj1hNCMe6FdDzsAMHA@mail.gmail.com>
References: <1431046211.31122.1.camel@ingics.com>
	<554CCEBB.6000107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <554CCEBB.6000107-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2015-05-08 22:56 GMT+08:00 zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
>
>
> On 05/08/2015 08:50 AM, Axel Lin wrote:
>>
>> Make the modalias match driver name, this is required to make module
>> auto-loading work.
>>
>> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>
>
> Thanks Axel
>
> Could you also share the info what's the condition of auto-loading module.
>
> What I am test here is change the names works.
> -               .name   = "hix5hd2-i2c",
> +               .name   = "i2c-hix5hd2",
>
> Change MODULE_ALIAS("platform:hix5hd2-i2c") does not works here.
> Do I make some mistake?

The driver name needs to match the platform device name.
I have no idea why you change the driver name and it still work.

In drivers/base/platform.c, the platform_uevent sends uevenet with
MODALIAS=platform:pdev->name. so the MODULE_ALIAS needs to match pdev->name.
Maybe forgot running depmod -a?
