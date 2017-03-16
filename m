From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Thu, 16 Mar 2017 18:35:29 +0200
Message-ID: <1489682129.19767.25.camel@linux.intel.com>
References: <20170316162455.22876-1-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4282 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755133AbdCPQhM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 16 Mar 2017 12:37:12 -0400
In-Reply-To: <20170316162455.22876-1-oneukum@suse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, hdegoede@redhat.com

On Thu, 2017-03-16 at 17:24 +0100, Oliver Neukum wrote:
> Our testing shows the semaphore failing to be transferred on
> CherryTrail
> in about 0.5% of all cases. The existing timeout needs to be
> lengthened
> to accomodate the worst cases.

I think it's just a semi-hiding of real issue.

Hans?

> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> b/drivers/i2c/busses/i2c-designware-baytrail.c
> index 1590ad0..2d238e3 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -21,7 +21,7 @@
>  
>  #include "i2c-designware-core.h"
>  
> -#define SEMAPHORE_TIMEOUT	100
> +#define SEMAPHORE_TIMEOUT	500
>  #define PUNIT_SEMAPHORE		0x7
>  #define PUNIT_SEMAPHORE_BIT	BIT(0)
>  #define PUNIT_SEMAPHORE_ACQUIRE	BIT(1)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
