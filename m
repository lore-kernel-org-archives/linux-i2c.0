From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Mon, 20 Mar 2017 14:39:27 +0100
Message-ID: <704db0f5-7951-3d07-1d0b-4c742dd562d0@redhat.com>
References: <20170320133730.23041-1-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753957AbdCTNja (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Mar 2017 09:39:30 -0400
In-Reply-To: <20170320133730.23041-1-oneukum@suse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org

Hi,

On 20-03-17 14:37, Oliver Neukum wrote:
> Our testing shows the semaphore failing to be transferred on CherryTrail
> in about 0.5% of all cases. The existing timeout needs to be lengthened
> to accomodate the worst cases.
>
> V2: Rebased on https://cgit.freedesktop.org/drm-intel/commit/?h=topic/designware-baytrail
>
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
> index 1749a0f..c0e7c88 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -22,7 +22,7 @@
>
>  #include "i2c-designware-core.h"
>
> -#define SEMAPHORE_TIMEOUT	100
> +#define SEMAPHORE_TIMEOUT	500
>  #define PUNIT_SEMAPHORE		0x7
>  #define PUNIT_SEMAPHORE_CHT	0x10e
>  #define PUNIT_SEMAPHORE_BIT	BIT(0)
>
