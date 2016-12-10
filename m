From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/5] i2c: designware-baytrail: Force the CPU to C1
 state while holding the punit semaphore
Date: Sat, 10 Dec 2016 16:53:15 +0200
Message-ID: <1481381595.7188.6.camel@linux.intel.com>
References: <20161210141908.16470-1-hdegoede@redhat.com>
         <20161210141908.16470-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3313 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbcLJOxT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Dec 2016 09:53:19 -0500
In-Reply-To: <20161210141908.16470-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

+Cc: Len
Len, I think you would be interested by this.

Hans, thanks for the change! Most probably we will anticipate Len's ACK
on this one.

On Sat, 2016-12-10 at 15:19 +0100, Hans de Goede wrote:
> On my cherrytrail tablet with axp288 pmic, just doing a bunch of
> repeated
> reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet
> in
> 1 - 3 runs guaranteed.
> 
> This seems to be causes by the cpuidle / intel_idle driver trying to
> change the C-state while we hold the punit bus semaphore, at which
> point
> everything just hangs.
> 
> Avoid this by forcing the CPU to C1 before acquiring the punit bus
> semaphore.

Isn't it C0? C1 as far as I remember is halted state.

> @@ -33,6 +34,13 @@ static int get_sem(struct dw_i2c_dev *dev, u32
> *sem)
>  	u32 data;
>  	int ret;
>  
> +	/*
> +	 * Force CPU to C1 state, otherwise if the cpuidle /
> intel_idle
> +	 * driver tries to change the C state while we're holding the
> +	 * semaphore, the SoC hangs.

C0?

> +	 */
> +	pm_qos_update_request(&dev->pm_qos, 0);

C1 is when you set 1 here, right?

> platform_device *pdev)
>  	if (!dev->pm_runtime_disabled)
>  		pm_runtime_disable(&pdev->dev);

> +	if (dev->acquire_lock)
> +		pm_qos_remove_request(&dev->pm_qos);
> +

Perhaps you need to do this in -core.c. Otherwise you missed PCI case.
(Even with PCI enumerated host with ACPI-enabled firmware you may get
_SEM object present)

>  	return 0;
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
