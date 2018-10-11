From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
Date: Thu, 11 Oct 2018 12:41:51 +0200
Message-ID: <20181011104151.GA31491@gmail.com>
References: <20181011102627.7418-1-hdegoede@redhat.com>
 <20181011102627.7418-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011102627.7418-2-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> +int iosf_mbi_block_punit_i2c_access(void)
> +{
> +	unsigned long start, end;
> +	int ret = 0;
> +	u32 sem;
> +
> +	if (WARN_ON(!mbi_pdev || !iosf_mbi_sem_address))
> +		return -ENXIO;
> +
> +	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> +
> +	if (iosf_mbi_block_punit_i2c_access_count > 0)
> +		goto out;
> +
> +	mutex_lock(&iosf_mbi_punit_mutex);
> +	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
> +				     MBI_PMIC_BUS_ACCESS_BEGIN, NULL);
> +
> +	/*
> +	 * Disallow the CPU to enter C6 or C7 state, entering these states
> +	 * requires the punit to talk to the pmic and if this happens while
> +	 * we're holding the semaphore, the SoC hangs.
> +	 */
> +	pm_qos_update_request(&iosf_mbi_pm_qos, 0);
> +
> +	/* host driver writes to side band semaphore register */
> +	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> +			     iosf_mbi_sem_address, PUNIT_SEMAPHORE_ACQUIRE);
> +	if (ret) {
> +		dev_err(&mbi_pdev->dev, "Error punit semaphore request failed\n");
> +		goto out;
> +	}

Isn't this error path leaking the iosf_mbi_punit_mutex held mutex? The 'out' label only unlocks 
iosf_mbi_block_punit_i2c_access_count_mutex:


> +	/* host driver waits for bit 0 to be set in semaphore register */
> +	start = jiffies;
> +	end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
> +	do {
> +		ret = iosf_mbi_get_sem(&sem);
> +		if (!ret && sem) {
> +			iosf_mbi_sem_acquired = jiffies;
> +			dev_dbg(&mbi_pdev->dev, "punit semaphore acquired after %ums\n",
> +				jiffies_to_msecs(jiffies - start));
> +			/*
> +			 * Success, keep iosf_mbi_punit_mutex locked till
> +			 * iosf_mbi_unblock_punit_i2c_access() gets called.
> +			 */
> +			goto out;

Ditto - although this does claim that this is done intentionally.

> +		}
> +
> +		usleep_range(1000, 2000);
> +	} while (time_before(jiffies, end));
> +
> +	ret = -ETIMEDOUT;
> +	dev_err(&mbi_pdev->dev, "Error punit semaphore timed out, resetting\n");
> +	iosf_mbi_reset_semaphore();
> +	mutex_unlock(&iosf_mbi_punit_mutex);
> +
> +	if (!iosf_mbi_get_sem(&sem))
> +		dev_err(&mbi_pdev->dev, "PUNIT SEM: %d\n", sem);
> +out:
> +	if (!WARN_ON(ret))
> +		iosf_mbi_block_punit_i2c_access_count++;
> +
> +	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(iosf_mbi_block_punit_i2c_access);

So this is a rather unusual looking locking pattern.

So if this is all intended and works fine then at minimum the semantics of the function should 
be explained - right now it has no description whatsoever.

Thanks,

	Ingo
