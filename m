From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/5] i2c: designware-baytrail: Disallow the CPU to
 enter C6 or C7 while holding the punit semaphore
Date: Mon, 12 Dec 2016 12:37:15 +0200
Message-ID: <1481539035.7188.20.camel@linux.intel.com>
References: <20161210224350.10290-1-hdegoede@redhat.com>
         <20161210224350.10290-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2416 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754189AbcLLKkU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Dec 2016 05:40:20 -0500
In-Reply-To: <20161210224350.10290-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

On Sat, 2016-12-10 at 23:43 +0100, Hans de Goede wrote:
> On my cherrytrail tablet with axp288 pmic, just doing a bunch of
> repeated
> reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet
> in
> 1 - 3 runs guaranteed.
> 
> This seems to be causes by the cpu trying to enter C6 or C7 while we
> hold
> the punit bus semaphore, at which point everything just hangs.
> 
> Avoid this by the CPU to enter C6 or C7 before acquiring the punit bus
> semaphore.

Please, keep Len Brown in a loop for this patch. And perhaps someone
from our Graphics team. Maybe Imre Deak?

See my comments below.

> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=109051
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -New patch in v2 of this set
> Changes in v3:
> -Change commit message and comment in the code from "force the CPU to
> C1"
>  to "Disallow the CPU to enter C6 or C7", as the CPU may still be in
> either
>  C0 or C1 with the request pm_qos
> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 12 ++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h     |  3 +++
>  drivers/i2c/busses/i2c-designware-platdrv.c  |  3 +++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> b/drivers/i2c/busses/i2c-designware-baytrail.c
> index cf02222..997d048 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/pm_qos.h>
>  
>  #include <asm/iosf_mbi.h>
>  
> @@ -33,6 +34,13 @@ static int get_sem(struct dw_i2c_dev *dev, u32
> *sem)
>  	u32 data;
>  	int ret;
>  
> +	/*
> +	 * Disallow the CPU to enter C6 or C7 state, entering these
> states
> +	 * requires the punit to talk to the pmic and if this happens
> while
> +	 * we're holding the semaphore, the SoC hangs.
> +	 */
> +	pm_qos_update_request(&dev->pm_qos, 0);
> +
>  	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> PUNIT_SEMAPHORE, &data);
>  	if (ret) {
>  		dev_err(dev->dev, "iosf failed to read punit
> semaphore\n");
> @@ -56,6 +64,8 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
>  	data &= ~PUNIT_SEMAPHORE_BIT;
>  	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> PUNIT_SEMAPHORE, data))
>  		dev_err(dev->dev, "iosf failed to reset punit
> semaphore during write\n");
> +
> +	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
>  }
>  
>  static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
> @@ -145,6 +155,8 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev
> *dev)
>  		return -EPROBE_DEFER;
>  
>  	dev_info(dev->dev, "I2C bus managed by PUNIT\n");

> +	pm_qos_add_request(&dev->pm_qos, PM_QOS_CPU_DMA_LATENCY,
> +			   PM_QOS_DEFAULT_VALUE);

Perhaps move this to the end of the function? For sake of readability.

>  	dev->acquire_lock = baytrail_i2c_acquire;
>  	dev->release_lock = baytrail_i2c_release;
>  	dev->pm_runtime_disabled = true;
> diff --git a/drivers/i2c/busses/i2c-designware-core.h
> b/drivers/i2c/busses/i2c-designware-core.h
> index fb143f5..47d284c 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -22,6 +22,7 @@
>   *
>   */
>  
> +#include <linux/pm_qos.h>
>  
>  #define DW_IC_CON_MASTER		0x1
>  #define DW_IC_CON_SPEED_STD		0x2
> @@ -67,6 +68,7 @@
>   * @fp_lcnt: fast plus LCNT value
>   * @hs_hcnt: high speed HCNT value
>   * @hs_lcnt: high speed LCNT value
> + * @pm_qos: pm_qos_request used while holding a hardware lock on the
> bus
>   * @acquire_lock: function to acquire a hardware lock on the bus
>   * @release_lock: function to release a hardware lock on the bus
>   * @pm_runtime_disabled: true if pm runtime is disabled
> @@ -114,6 +116,7 @@ struct dw_i2c_dev {
>  	u16			fp_lcnt;
>  	u16			hs_hcnt;
>  	u16			hs_lcnt;
> +	struct pm_qos_request	pm_qos;
>  	int			(*acquire_lock)(struct dw_i2c_dev
> *dev);
>  	void			(*release_lock)(struct dw_i2c_dev
> *dev);
>  	bool			pm_runtime_disabled;
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 97a2ca1..6d72929 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -291,6 +291,9 @@ static int dw_i2c_plat_remove(struct
> platform_device *pdev)
>  	if (!dev->pm_runtime_disabled)
>  		pm_runtime_disable(&pdev->dev);
> 

>  
> +	if (dev->acquire_lock)
> +		pm_qos_remove_request(&dev->pm_qos);
> +

I read your answer to v2 of this, so, taking into consideration your
notice I would recommend to provide an additional helper like
i2c_dw_down_lock_support() (I didn't find proper antonym for eval, feel
free to choose a better name) and collect the above there.

>  	return 0;
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
