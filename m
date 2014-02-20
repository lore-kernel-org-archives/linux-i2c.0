From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: I2C dummy adapter driver ?
Date: Thu, 20 Feb 2014 09:49:48 -0700
Message-ID: <5306322C.8030703@wwwdotorg.org>
References: <5305382E.9050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5305382E.9050902-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 02/19/2014 04:03 PM, Sylwester Nawrocki wrote:
> Hi All,
> 
> I was wondering whether it would be reasonable to create a generic
> Linux dummy I2C bus controller driver. The rationale behind it is
> there might be hardware configurations where I2C communication is
> handled by firmware but still it is useful to have I2C slave devices
             ^^^^^^^^

That doesn't sound like a dummy driver. Rather, it sounds like a driver
for the firmware(?) interface that's used to do the I2C transactions.

> instantiated by a Linux I2C bus adapter driver.
> It would be useful to have the common devicetree I2C binding scheme
> working regardless of where the I2C communication is handled - in
> firmware or by the host CPU.
> 
> Currently we have a somewhat dummy I2C adapter driver at drivers/media/
> platform/exynos4-is/fimc-is-i2c.c. But it is going to be needed by
> multiple SoCs and I thought about separating it or creating a generic
> dummy I2C adapter driver.
