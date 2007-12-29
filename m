From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 04/12] i2c : Use mutex instead of semaphore in driver
 core
Date: Sat, 29 Dec 2007 12:49:36 +0100
Message-ID: <47763450.5010604@s5r6.in-berlin.de>
References: <20071229010751.GE2883@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754937AbXL2LuL@vger.kernel.org>
In-Reply-To: <20071229010751.GE2883@darkstar.te-china.tietoenator.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Dave Young wrote:
> --- linux/drivers/i2c/i2c-core.c	2007-12-28 10:06:58.000000000 +0800
> +++ linux.new/drivers/i2c/i2c-core.c	2007-12-28 10:08:58.000000000 +0800
> @@ -33,8 +33,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
>  #include <linux/completion.h>
> +#include <linux/mutex.h>
>  #include <asm/uaccess.h>
> -#include <asm/semaphore.h>

2x #include <linux/mutex.h>
-- 
Stefan Richter
-=====-=-=== ==-- ===-=
http://arcgraph.de/sr/
