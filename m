From: "Dave Young" <hidave.darkstar@gmail.com>
Subject: Re: [PATCH 04/12] i2c : Use mutex instead of semaphore in driver core
Date: Wed, 2 Jan 2008 09:06:31 +0800
Message-ID: <a8e1da0801011706m44b001eh25136032b901cc2d@mail.gmail.com>
References: <20071229010751.GE2883@darkstar.te-china.tietoenator.com>
	 <47763450.5010604@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759423AbYABBGm@vger.kernel.org>
In-Reply-To: <47763450.5010604@s5r6.in-berlin.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Dec 29, 2007 7:49 PM, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Dave Young wrote:
> > --- linux/drivers/i2c/i2c-core.c      2007-12-28 10:06:58.000000000 +0800
> > +++ linux.new/drivers/i2c/i2c-core.c  2007-12-28 10:08:58.000000000 +0800
> > @@ -33,8 +33,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/mutex.h>
> >  #include <linux/completion.h>
> > +#include <linux/mutex.h>
> >  #include <asm/uaccess.h>
> > -#include <asm/semaphore.h>
>
> 2x #include <linux/mutex.h>

Thanks, my fault ;)
This patch series need more lockdep works to be done. After that I
will repost it.

> --
> Stefan Richter
> -=====-=-=== ==-- ===-=
> http://arcgraph.de/sr/
>
