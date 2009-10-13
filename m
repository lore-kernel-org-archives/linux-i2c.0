From: "Olivares, Ricardo Perez" <richo-l0cyMroinI0@public.gmane.org>
Subject: FW: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
	I2C clock source
Date: Tue, 13 Oct 2009 16:27:23 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE401554D7448@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Mark Brown
Sent: Tuesday, October 13, 2009 4:54 AM
To: Shinya Kuribayashi
Cc: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Subject: Re: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare I2C clock source

On Tue, Oct 13, 2009 at 11:50:49AM +0900, Shinya Kuribayashi wrote:
> This driver is originally prepared for the ARM kernel where rich and 
> well-maintained "clkdev" clock framework is available, and clock name 
> might not be strictly required.  ARM's clkdev does slightly fuzzy 
> matching where it basically gives preference to "struct device" 
> mathing over "clock id".  As long as used for ARM machines, there's no problem.

> However, all users of this driver necessarily don't have the same clk 
> framework with ARM's, as the clk I/F implementation varies depending 
> on ARCHs and machines.

> This patch adds a clock name so that other users with simple/minimum/ 
> limited clk support could make use of the driver.

This seems like something that it'd be better to fix in the relevant clock frameworks in order to try to keep the API consistently usable between platforms.  The clkdev matching library that most of the ARM platforms use should be generic enough to be usable elsewhere, there is regular discussion of moving it somewhere more generic.
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
