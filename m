From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
Date: Tue, 24 Mar 2020 22:39:22 +0800
Message-ID: <AF4DCBBE-FF35-4B58-92EE-8BD804A502C4@canonical.com>
References: <20200324130712.12289-1-kai.heng.feng@canonical.com>
 <20200324134124.GL1922688@smile.fi.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200324134124.GL1922688@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ajayg@nvidia.com, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

> On Mar 24, 2020, at 21:41, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> On Tue, Mar 24, 2020 at 09:07:12PM +0800, Kai-Heng Feng wrote:
>> Nvidia card may come with a "phantom" UCSI device, and its driver gets
>> stuck in probe routine, prevents any system PM operations like suspend.
>> 
>> When the target time equals to jiffies, it's not included by
>> time_is_before_jiffies(). So let's use a boolean to make sure the
>> operation is done or timeout.
> 
> Thank you for an update, my comments below.
> 
>> 	unsigned long target = jiffies + msecs_to_jiffies(1000);
>> 	u32 val;
>> +	bool done = false;
>> 
>> 	do {
>> 		val = readl(i2cd->regs + I2C_MST_CNTL);
>> -		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER))
>> -			break;
>> -		if ((val & I2C_MST_CNTL_STATUS) !=
>> -				I2C_MST_CNTL_STATUS_BUS_BUSY)
> 
>> +		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER)
>> +		    || (val & I2C_MST_CNTL_STATUS) !=
>> +				I2C_MST_CNTL_STATUS_BUS_BUSY) {
> 
> Bad formatting. But see below.
> 
>> +			done = true;
>> 			break;
>> +		}
>> 		usleep_range(500, 600);
>> 	} while (time_is_after_jiffies(target));
>> 
>> -	if (time_is_before_jiffies(target)) {
>> +	if (!done) {
>> 		dev_err(i2cd->dev, "i2c timeout error %x\n", val);
>> 		return -ETIMEDOUT;
>> 	}
> 
> 
> Overall it can use simple tries since you already have sleep inside, but
> moreover, you may simple switch to readl_poll_timeout() this entire
> loop.

Yes that can make the retry loop much simpler.
I'll send a v3 based on your suggestion.

Kai-Heng

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
