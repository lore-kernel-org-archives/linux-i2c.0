From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: core: fix compile issue related to incorrect
 gpio header
Date: Tue, 28 Nov 2017 11:04:41 +0200
Message-ID: <380c34f9-6501-a11c-b077-670d4a1346aa@linux.intel.com>
References: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
 <1511838551-4035-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14711 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752258AbdK1JEp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 04:04:45 -0500
In-Reply-To: <1511838551-4035-2-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, sfr@canb.auug.org.au

On 11/28/2017 05:09 AM, Phil Reid wrote:
> The correct header to include for the gpiod interface is
> <linux/gpio/consumer.h>.
> 
> fixes commit 3991c5c80beaf7eb9 ("i2c: Switch to using gpiod interface
> for gpio bus recovery")
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/i2c-core-base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 54ffc8d..bf52cca 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -27,7 +27,7 @@
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/errno.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

Looks like this was masked by CONFIG_GPIOLIB=y.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
