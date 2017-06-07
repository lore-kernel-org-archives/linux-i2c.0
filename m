From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 2/2] video: adp8870: move header file out of I2C realm
Date: Wed, 7 Jun 2017 11:57:45 +0100
Message-ID: <3fff4554-8f66-064c-3760-8d5fc701fbe5@linaro.org>
References: <20170521220953.2602-1-wsa@the-dreams.de>
 <20170521220953.2602-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36560 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdFGK5t (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Jun 2017 06:57:49 -0400
Received: by mail-wr0-f175.google.com with SMTP id v111so4426080wrc.3
        for <linux-i2c@vger.kernel.org>; Wed, 07 Jun 2017 03:57:48 -0700 (PDT)
In-Reply-To: <20170521220953.2602-3-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Steven Miao <realmz6@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 21/05/17 23:09, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>   arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
>   drivers/video/backlight/adp8870_bl.c           | 2 +-
>   include/linux/{i2c => platform_data}/adp8870.h | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename include/linux/{i2c => platform_data}/adp8870.h (100%)
> 
> diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
> index 7db90c72bd8ddc..7528148dc4925b 100644
> --- a/arch/blackfin/mach-bf537/boards/stamp.c
> +++ b/arch/blackfin/mach-bf537/boards/stamp.c
> @@ -1995,7 +1995,7 @@ static struct adp5588_gpio_platform_data adp5588_gpio_data = {
>   #endif
>   
>   #if IS_ENABLED(CONFIG_BACKLIGHT_ADP8870)
> -#include <linux/i2c/adp8870.h>
> +#include <linux/platform_data/adp8870.h>
>   static struct led_info adp8870_leds[] = {
>   	{
>   		.name = "adp8870-led7",
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 21acac90fd773f..058d1def2d1f4b 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -18,7 +18,7 @@
>   #include <linux/workqueue.h>
>   #include <linux/slab.h>
>   
> -#include <linux/i2c/adp8870.h>
> +#include <linux/platform_data/adp8870.h>
>   #define ADP8870_EXT_FEATURES
>   #define ADP8870_USE_LEDS
>   
> diff --git a/include/linux/i2c/adp8870.h b/include/linux/platform_data/adp8870.h
> similarity index 100%
> rename from include/linux/i2c/adp8870.h
> rename to include/linux/platform_data/adp8870.h
> 
