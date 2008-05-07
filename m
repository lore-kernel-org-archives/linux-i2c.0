From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Date: Wed, 7 May 2008 09:05:14 +0200
Message-ID: <20080507090514.3a86cf4b@hyperion.delvare>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763724AbYEGHF5@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Oh, BTW...

On Wed, 7 May 2008 01:40:27 +0100 (BST), Maciej W. Rozycki wrote:
> (...)
> 1. i2c-swarm.c -- SWARM I2C board setup, currently for the M41T80 chip on 
>    the bus #1 only.
> (...)
> --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/Makefile	2004-01-29 04:57:05.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/Makefile	2008-05-06 01:18:21.000000000 +0000
> @@ -1,3 +1,4 @@
> -lib-y				= setup.o rtc_xicor1241.o rtc_m41t81.o
> +obj-y				:= setup.o rtc_xicor1241.o rtc_m41t81.o
>  
> -lib-$(CONFIG_KGDB)		+= dbg_io.o
> +obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-swarm.o
> +obj-$(CONFIG_KGDB)		+= dbg_io.o
> (...)
> --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/i2c-swarm.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/i2c-swarm.c	2008-05-06 23:51:34.000000000 +0000

i2c-foo.c is consistently used for i2c bus driver themselves so far.
It's somewhat confusing to see you name platform code that way. It's
also redundant, given that the file lives in the swarm platform
directory. May I suggest naming this file just
arch/mips/sibyte/swarm/i2c.c? Other architectures (cris, arm) are doing
this already.

-- 
Jean Delvare
