From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
	I2C clock source
Date: Tue, 13 Oct 2009 10:54:17 +0100
Message-ID: <20091013095417.GB1230@sirena.org.uk>
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4AD3EB09.8050304-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Cc: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 13, 2009 at 11:50:49AM +0900, Shinya Kuribayashi wrote:
> This driver is originally prepared for the ARM kernel where rich and
> well-maintained "clkdev" clock framework is available, and clock name
> might not be strictly required.  ARM's clkdev does slightly fuzzy
> matching where it basically gives preference to "struct device" mathing
> over "clock id".  As long as used for ARM machines, there's no problem.

> However, all users of this driver necessarily don't have the same clk
> framework with ARM's, as the clk I/F implementation varies depending on
> ARCHs and machines.

> This patch adds a clock name so that other users with simple/minimum/
> limited clk support could make use of the driver.

This seems like something that it'd be better to fix in the relevant
clock frameworks in order to try to keep the API consistently usable
between platforms.  The clkdev matching library that most of the ARM
platforms use should be generic enough to be usable elsewhere, there
is regular discussion of moving it somewhere more generic.
