From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: Rename struct s3c2410_platform_i2c to
 s3c_platform_i2c
Date: Thu, 12 Feb 2009 15:05:27 +0100
Message-ID: <20090212150527.2d8031ad@hyperion.delvare>
References: <1234446570.9457.28.camel@petitemort>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1234446570.9457.28.camel@petitemort>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 12 Feb 2009 13:49:30 +0000, Daniel Silverstone wrote:
> The I2C driver currently known as i2c-s3c2410 is now used by
> several different s3cXXXX SoCs. As such, this patch renames the
> platform data to be SoC agnostic.
> 
> Signed-Off-By: Simtec Linux Team <linux-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
> Signed-Off-By: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
> 
> ---
>  arch/arm/mach-s3c2410/mach-bast.c    |    2 +-
>  arch/arm/mach-s3c2410/mach-n30.c     |    2 +-
>  arch/arm/mach-s3c2412/mach-jive.c    |    2 +-
>  arch/arm/plat-s3c/dev-i2c0.c         |    8 ++++----
>  arch/arm/plat-s3c/dev-i2c1.c         |    8 ++++----
>  arch/arm/plat-s3c/include/plat/iic.h |    8 ++++----
>  drivers/i2c/busses/i2c-s3c2410.c     |    6 +++---
>  7 files changed, 18 insertions(+), 18 deletions(-)

This is Ben's call, not mine, but I tend to discourage that kind of
changes. For one thing, they cost more than then bring. And for
another, they may need to be reverted if incompatible hardware appears
in the future.

Personally, I read "s3c2410" in these structure names as "S3C 2410 and
compatible", so it looks perfectly right to me, I don't see this as
something which needs to be changed.

-- 
Jean Delvare
