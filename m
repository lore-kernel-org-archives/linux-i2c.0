From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: driver for the Synopsys DesignWare I2C controller
Date: Sun, 31 May 2009 20:47:31 +0200
Message-ID: <63386a3d0905311147h5a92bb3cy6659db914acd476e@mail.gmail.com>
References: <1242725005-6431-1-git-send-email-baruch@tkos.co.il>
	 <63386a3d0905271223k470bb89elbbb566b68c0d7cd7@mail.gmail.com>
	 <20090528041051.GB4855@tarshish>
	 <63386a3d0905280032x7f427213t2b9b027d5be2a472@mail.gmail.com>
	 <20090531052345.GB14148@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090531052345.GB14148@tarshish>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2009/5/31 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:
> On Thu, May 28, 2009 at 09:32:37AM +0200, Linus Walleij wrote:
>> 2009/5/28 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:
>>
>> >> > +static int dw_i2c_probe(struct platform_device *pdev)
>> >>
>> >> Can you tag this with __init?
>> >
>> > OK. __devinit is probably better.
>>
>> I don't think any platform_device tagged with __devinit is
>> correct really, platform_device:s cannot =A0be hotplugged that's
>> against the definition of a platform_device.
>
> Doesn't this __devinit have something to do with the ability to compi=
le the
> driver as a module (as is the case here)? See for example
> drivers/watchdog/omap_wdt.c and commit
> 0e3912c75f42986c17d955542247bf04c6eef738

In that case I doubt that even module_init() could be __init, as it is.

The linkage handling of these symbols is defined in:
include/asm-generic/vmlinux.lds.h

As you can see:

#ifdef CONFIG_HOTPLUG
#define DEV_KEEP(sec)    *(.dev##sec)
#define DEV_DISCARD(sec)
#else
#define DEV_KEEP(sec)
#define DEV_DISCARD(sec) *(.dev##sec)
#endif

=46urther down the file you can see how this is handled in different
kinds of symbols. It is kept if CONFIG_HOTPLUG is set, it is moved
into the DATA_DATA section and kept in memory (so that it can be
reused when devices are plugged/unplugged) else it is discarded
after init.

In practice this means that if you device is _NOT_ hot-pluggable, the
kernel will still nevertheless keep all the code in __devinit and
__devexit around which means that __devinit code cannot be
free:ed after init and it increases the footprint of your kernel for no
good reason.

Linus
