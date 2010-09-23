From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
Date: Thu, 23 Sep 2010 15:05:59 -0700
Message-ID: <20100923150559.9c67da11.rdunlap@xenotime.net>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
	<20100923113807.4643fbbb.rdunlap@xenotime.net>
	<19611.46496.782340.466509@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19611.46496.782340.466509@pilspetsen.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Sep 2010 22:16:32 +0200 Mikael Pettersson wrote:

> Randy Dunlap writes:
>  > On Thu, 23 Sep 2010 13:53:18 +0200 Mikael Pettersson wrote:
>  > 
>  > > Running modules_install from a newly built 2.6.36-rc5 kernel
>  > > on my 32-bit PowerMac results in:
>  > > 
>  > > WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/busses/i2c-powermac.ko ignored, due to loop
>  > > WARNING: Loop detected: /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko needs of_i2c.ko which needs i2c-core.ko again!
>  > > WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko ignored, due to loop
>  > > WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-dev.ko ignored, due to loop
>  > > WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/of/of_i2c.ko ignored, due to loop
>  > > WARNING: Module /lib/modules/2.6.36-rc5/kernel/sound/ppc/snd-powermac.ko ignored, due to loop
>  > > 
>  > > > grep '.*I2C.*=' .config
>  > > CONFIG_OF_I2C=m
>  > > CONFIG_I2C=m
>  > > CONFIG_I2C_BOARDINFO=y
>  > > CONFIG_I2C_CHARDEV=m
>  > > CONFIG_I2C_POWERMAC=m
>  > > 
>  > > I can't say exactly when this started, haven't built kernels on this
>  > > box in a while.
>  > 
>  > 
>  > No kconfig warnings?
> 
> Not that I recall.  I can check tomorrow if necessary.

No kconfig warnings.  I checked with your .config file.

>  > Please post your full .config file.

Just a matter of module i2c-core calls of_ functions and module of_i2c calls
i2c_ functions.  Hmph.  Something for Grant, Jean, and Ben to work out.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
