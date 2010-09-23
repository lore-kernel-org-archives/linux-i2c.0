From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
Date: Thu, 23 Sep 2010 11:38:07 -0700
Message-ID: <20100923113807.4643fbbb.rdunlap@xenotime.net>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19611.16302.262307.129176-tgku4HJDRZih8lFjZTKsyTAV6s6igYVG@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Sep 2010 13:53:18 +0200 Mikael Pettersson wrote:

> Running modules_install from a newly built 2.6.36-rc5 kernel
> on my 32-bit PowerMac results in:
> 
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/busses/i2c-powermac.ko ignored, due to loop
> WARNING: Loop detected: /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko needs of_i2c.ko which needs i2c-core.ko again!
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-core.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/i2c/i2c-dev.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/drivers/of/of_i2c.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.36-rc5/kernel/sound/ppc/snd-powermac.ko ignored, due to loop
> 
> > grep '.*I2C.*=' .config
> CONFIG_OF_I2C=m
> CONFIG_I2C=m
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_POWERMAC=m
> 
> I can't say exactly when this started, haven't built kernels on this
> box in a while.


No kconfig warnings?  Please post your full .config file.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
