From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: designware-baytrail: Pass dw_i2c_dev into
 helper functions
Date: Fri, 09 Dec 2016 13:23:41 +0200
Message-ID: <1481282621.30772.47.camel@linux.intel.com>
References: <20161209110154.7157-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16822 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932393AbcLIL0p (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 9 Dec 2016 06:26:45 -0500
In-Reply-To: <20161209110154.7157-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org

On Fri, 2016-12-09 at 12:01 +0100, Hans de Goede wrote:
> Pass dw_i2c_dev into the helper functions, this is a preparation patch
> for adding cherrytrail support.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> b/drivers/i2c/busses/i2c-designware-baytrail.c
> index 1590ad0..a3f581c 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -28,14 +28,14 @@
>  
>  static unsigned long acquired;
>  
> -static int get_sem(struct device *dev, u32 *sem)
> +static int get_sem(struct dw_i2c_dev *dev, u32 *sem)
>  {
>  	u32 data;
>  	int ret;
>  
>  	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> PUNIT_SEMAPHORE, &data);
>  	if (ret) {
> -		dev_err(dev, "iosf failed to read punit
> semaphore\n");
> +		dev_err(dev->dev, "iosf failed to read punit
> semaphore\n");
>  		return ret;
>  	}
>  
> @@ -44,18 +44,18 @@ static int get_sem(struct device *dev, u32 *sem)
>  	return 0;
>  }
>  
> -static void reset_semaphore(struct device *dev)
> +static void reset_semaphore(struct dw_i2c_dev *dev)
>  {
>  	u32 data;
>  
>  	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> PUNIT_SEMAPHORE, &data)) {
> -		dev_err(dev, "iosf failed to reset punit semaphore
> during read\n");
> +		dev_err(dev->dev, "iosf failed to reset punit
> semaphore during read\n");
>  		return;
>  	}
>  
>  	data &= ~PUNIT_SEMAPHORE_BIT;
>  	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> PUNIT_SEMAPHORE, data))
> -		dev_err(dev, "iosf failed to reset punit semaphore
> during write\n");
> +		dev_err(dev->dev, "iosf failed to reset punit
> semaphore during write\n");
>  }
>  
>  static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
> @@ -83,7 +83,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev
> *dev)
>  	start = jiffies;
>  	end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
>  	do {
> -		ret = get_sem(dev->dev, &sem);
> +		ret = get_sem(dev, &sem);
>  		if (!ret && sem) {
>  			acquired = jiffies;
>  			dev_dbg(dev->dev, "punit semaphore acquired
> after %ums\n",
> @@ -95,7 +95,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev
> *dev)
>  	} while (time_before(jiffies, end));
>  
>  	dev_err(dev->dev, "punit semaphore timed out, resetting\n");
> -	reset_semaphore(dev->dev);
> +	reset_semaphore(dev);
>  
>  	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> PUNIT_SEMAPHORE, &sem);
>  	if (ret)
> @@ -116,7 +116,7 @@ static void baytrail_i2c_release(struct dw_i2c_dev
> *dev)
>  	if (!dev->acquire_lock)
>  		return;
>  
> -	reset_semaphore(dev->dev);
> +	reset_semaphore(dev);
>  	dev_dbg(dev->dev, "punit semaphore held for %ums\n",
>  		jiffies_to_msecs(jiffies - acquired));
>  }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
