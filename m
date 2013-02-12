From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V3] i2c: add bcm2835 driver
Date: Mon, 11 Feb 2013 19:24:16 -0700
Message-ID: <5119A7D0.20000@wwwdotorg.org>
References: <1360381978-26092-1-git-send-email-swarren@wwwdotorg.org> <20130211225208.GA9893@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130211225208.GA9893-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/11/2013 03:52 PM, Wolfram Sang wrote:
> Hi Stephen,
> 
> On Fri, Feb 08, 2013 at 08:52:58PM -0700, Stephen Warren wrote:
>> This implements a very basic I2C host driver for the BCM2835 SoC. Missing
>> features so far are:
>>
>> * 10-bit addressing.
>> * DMA.
...
>> +	ret = wait_for_completion_timeout(&i2c_dev->completion,
>> +					  BCM2835_I2C_TIMEOUT);
>> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
>> +	if (WARN_ON(ret == 0)) {
>> +		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
>> +		return -ETIMEDOUT;
>> +	}
> 
> I'd suggest to skip the WARN_ON. Timeout is the expected case when you
> want to read from an EEPROM which is just in the process of
> erasing/writing data from the previous command.

I copied that from Tegra. Should that driver be changed too?

>> +	adap = &i2c_dev->adapter;
>> +	i2c_set_adapdata(adap, i2c_dev);
>> +	adap->owner = THIS_MODULE;
>> +	adap->class = I2C_CLASS_HWMON;
> 
> Do you really need the class?

If I grep for I2C_CLASS_HWMON, I see a ton of hits. I think I'll keep it
unless you strongly object, since it seems typical.

I'll fix up the other points you mentioned.
