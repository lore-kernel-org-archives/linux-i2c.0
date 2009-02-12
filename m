From: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: Re: [PATCH] I2C: Rename struct s3c2410_platform_i2c to
 s3c_platform_i2c
Date: Thu, 12 Feb 2009 14:24:40 +0000
Message-ID: <1234448680.9457.38.camel@petitemort>
References: <1234446570.9457.28.camel@petitemort>
	 <20090212150527.2d8031ad@hyperion.delvare>
Reply-To: dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090212150527.2d8031ad-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2009-02-12 at 15:05 +0100, Jean Delvare wrote:
> > The I2C driver currently known as i2c-s3c2410 is now used by
> > several different s3cXXXX SoCs. As such, this patch renames the
> > platform data to be SoC agnostic.
> This is Ben's call, not mine, but I tend to discourage that kind of
> changes. For one thing, they cost more than then bring. And for
> another, they may need to be reverted if incompatible hardware appears
> in the future.

The same I2C controller is found throughout Samsung's s3c24xx and 64xx
range. I doubt they'll introduce wildly incompatible peripherals in the
same range.

> Personally, I read "s3c2410" in these structure names as "S3C 2410 and
> compatible", so it looks perfectly right to me, I don't see this as
> something which needs to be changed.

Whereas I see it as "s3c2410" or at most liberal, "s3c241x". Given
there's a family of 10 or more chips which all use this i2c controller,
only 4 of which could plausibly be thought of as a 2410 (2410, 2412,
2413, 2416) it seems disingenuously named as-is. The confusion which
could ensue (and indeed *does* ensue with some of our customers) seems
worth trying to avoid.

D.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895
