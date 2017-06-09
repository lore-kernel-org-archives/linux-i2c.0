From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] video: adp8860: move header file out of I2C realm
Date: Fri, 9 Jun 2017 08:43:45 +0100
Message-ID: <20170609074345.v5jkajra5qdsn2x7@dell>
References: <20170521220953.2602-1-wsa@the-dreams.de>
 <20170521220953.2602-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33489 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdFIHnt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Jun 2017 03:43:49 -0400
Received: by mail-wr0-f171.google.com with SMTP id v104so26811789wrb.0
        for <linux-i2c@vger.kernel.org>; Fri, 09 Jun 2017 00:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170521220953.2602-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 22 May 2017, Wolfram Sang wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
>  drivers/video/backlight/adp8860_bl.c           | 2 +-
>  include/linux/{i2c => platform_data}/adp8860.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/linux/{i2c => platform_data}/adp8860.h (100%)

Applied, thanks.

> diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
> index 24985e658c19cd..7db90c72bd8ddc 100644
> --- a/arch/blackfin/mach-bf537/boards/stamp.c
> +++ b/arch/blackfin/mach-bf537/boards/stamp.c
> @@ -2047,7 +2047,7 @@ static struct adp8870_backlight_platform_data adp8870_pdata = {
>  #endif
>  
>  #if IS_ENABLED(CONFIG_BACKLIGHT_ADP8860)
> -#include <linux/i2c/adp8860.h>
> +#include <linux/platform_data/adp8860.h>
>  static struct led_info adp8860_leds[] = {
>  	{
>  		.name = "adp8860-led7",
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 510e559c060e59..e7315bf14d6015 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -18,7 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  
> -#include <linux/i2c/adp8860.h>
> +#include <linux/platform_data/adp8860.h>
>  #define ADP8860_EXT_FEATURES
>  #define ADP8860_USE_LEDS
>  
> diff --git a/include/linux/i2c/adp8860.h b/include/linux/platform_data/adp8860.h
> similarity index 100%
> rename from include/linux/i2c/adp8860.h
> rename to include/linux/platform_data/adp8860.h

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
