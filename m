From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
Date: Tue, 24 Mar 2020 15:41:24 +0200
Message-ID: <20200324134124.GL1922688@smile.fi.intel.com>
References: <20200324130712.12289-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8751 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgCXNlY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 24 Mar 2020 09:41:24 -0400
Content-Disposition: inline
In-Reply-To: <20200324130712.12289-1-kai.heng.feng@canonical.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: ajayg@nvidia.com, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Tue, Mar 24, 2020 at 09:07:12PM +0800, Kai-Heng Feng wrote:
> Nvidia card may come with a "phantom" UCSI device, and its driver gets
> stuck in probe routine, prevents any system PM operations like suspend.
> 
> When the target time equals to jiffies, it's not included by
> time_is_before_jiffies(). So let's use a boolean to make sure the
> operation is done or timeout.

Thank you for an update, my comments below.

>  	unsigned long target = jiffies + msecs_to_jiffies(1000);
>  	u32 val;
> +	bool done = false;
>  
>  	do {
>  		val = readl(i2cd->regs + I2C_MST_CNTL);
> -		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER))
> -			break;
> -		if ((val & I2C_MST_CNTL_STATUS) !=
> -				I2C_MST_CNTL_STATUS_BUS_BUSY)

> +		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER)
> +		    || (val & I2C_MST_CNTL_STATUS) !=
> +				I2C_MST_CNTL_STATUS_BUS_BUSY) {

Bad formatting. But see below.

> +			done = true;
>  			break;
> +		}
>  		usleep_range(500, 600);
>  	} while (time_is_after_jiffies(target));
>  
> -	if (time_is_before_jiffies(target)) {
> +	if (!done) {
>  		dev_err(i2cd->dev, "i2c timeout error %x\n", val);
>  		return -ETIMEDOUT;
>  	}


Overall it can use simple tries since you already have sleep inside, but
moreover, you may simple switch to readl_poll_timeout() this entire
loop.

-- 
With Best Regards,
Andy Shevchenko
