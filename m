From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V3] i2c: add bcm2835 driver
Date: Tue, 12 Feb 2013 11:27:44 +0100
Message-ID: <20130212102743.GB5490@nekote.pengutronix.de>
References: <1360381978-26092-1-git-send-email-swarren@wwwdotorg.org>
 <20130211225208.GA9893@nekote.pengutronix.de>
 <5119A7D0.20000@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5119A7D0.20000-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> >> +	ret = wait_for_completion_timeout(&i2c_dev->completion,
> >> +					  BCM2835_I2C_TIMEOUT);
> >> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, BCM2835_I2C_C_CLEAR);
> >> +	if (WARN_ON(ret == 0)) {
> >> +		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> >> +		return -ETIMEDOUT;
> >> +	}
> > 
> > I'd suggest to skip the WARN_ON. Timeout is the expected case when you
> > want to read from an EEPROM which is just in the process of
> > erasing/writing data from the previous command.
> 
> I copied that from Tegra. Should that driver be changed too?

The suggestion applies to all drivers, yes :)
