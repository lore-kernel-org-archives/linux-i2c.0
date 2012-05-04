From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 00/15] DT enablement for Snowball
Date: Fri, 4 May 2012 20:26:14 +0000
Message-ID: <201205042026.14614.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 04 May 2012, Lee Jones wrote:
> 
> Here's your next back of DT related doings for the ux500,
> along with some bugs encountered fixed along the way.
> 
>  arch/arm/boot/dts/db8500.dtsi      |  103 +++++++++++++-
>  arch/arm/boot/dts/snowball.dts     |    3 +
>  arch/arm/configs/u8500_defconfig   |    1 +
>  arch/arm/mach-ux500/board-mop500.c |   55 ++------
>  drivers/i2c/busses/i2c-nomadik.c   |   53 ++++++-
>  drivers/mfd/Makefile               |    5 +-
>  drivers/mfd/ab8500-core.c          |  165 +++++++++++++++++++---
>  drivers/mfd/ab8500-i2c.c           |  128 -----------------
>  drivers/mfd/db8500-prcmu.c         |   30 ++--
>  drivers/power/ab8500_btemp.c       |   12 +-
>  drivers/power/ab8500_charger.c     |   12 +-
>  drivers/power/ab8500_fg.c          |   12 +-
>  drivers/regulator/ab8500.c         |  273 +++++++++++++++++++++++-------------

Looks all good, but I commented on two patches that I think can be done
in a simpler way.

	Arnd
