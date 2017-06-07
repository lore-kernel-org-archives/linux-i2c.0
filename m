From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 1/2] video: adp8860: move header file out of I2C realm
Date: Wed, 7 Jun 2017 11:57:30 +0100
Message-ID: <d66d5331-7b9b-9b7d-fb24-b148dcc41673@linaro.org>
References: <20170521220953.2602-1-wsa@the-dreams.de>
 <20170521220953.2602-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35856 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdFGK5e (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Jun 2017 06:57:34 -0400
Received: by mail-wm0-f54.google.com with SMTP id 7so115611475wmo.1
        for <linux-i2c@vger.kernel.org>; Wed, 07 Jun 2017 03:57:33 -0700 (PDT)
In-Reply-To: <20170521220953.2602-2-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 21/05/17 23:09, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>   arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
>   drivers/video/backlight/adp8860_bl.c           | 2 +-
>   include/linux/{i2c => platform_data}/adp8860.h | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename include/linux/{i2c => platform_data}/adp8860.h (100%)
> 
> diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
> index 24985e658c19cd..7db90c72bd8ddc 100644
> --- a/arch/blackfin/mach-bf537/boards/stamp.c
> +++ b/arch/blackfin/mach-bf537/boards/stamp.c
> @@ -2047,7 +2047,7 @@ static struct adp8870_backlight_platform_data adp8870_pdata = {
>   #endif
>   
>   #if IS_ENABLED(CONFIG_BACKLIGHT_ADP8860)
> -#include <linux/i2c/adp8860.h>
> +#include <linux/platform_data/adp8860.h>
>   static struct led_info adp8860_leds[] = {
>   	{
>   		.name = "adp8860-led7",
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 510e559c060e59..e7315bf14d6015 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -18,7 +18,7 @@
>   #include <linux/slab.h>
>   #include <linux/workqueue.h>
>   
> -#include <linux/i2c/adp8860.h>
> +#include <linux/platform_data/adp8860.h>
>   #define ADP8860_EXT_FEATURES
>   #define ADP8860_USE_LEDS
>   
> diff --git a/include/linux/i2c/adp8860.h b/include/linux/platform_data/adp8860.h
> similarity index 100%
> rename from include/linux/i2c/adp8860.h
> rename to include/linux/platform_data/adp8860.h
> 
