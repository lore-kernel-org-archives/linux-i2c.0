From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [rtc-linux] [RFC][PATCH 1/4] RTC: Class device support for
	persistent clock
Date: Wed, 07 May 2008 09:24:15 +0100
Message-ID: <1210148655.25560.825.camel@pmac.infradead.org>
References: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761986AbYEGIZO@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>, Jean Delvare <khali@linux-fr.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2008-05-07 at 01:40 +0100, Maciej W. Rozycki wrote:
> 
> +int rtc_update_persistent_clock(struct timespec now)
> +{
> +       struct rtc_device *rtc =
> rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
> +       int err;
> +
> +       if (rtc == NULL) {
> +               printk(KERN_ERR "hctosys: unable to open rtc device (%
> s)\n",
> +                      CONFIG_RTC_HCTOSYS_DEVICE);
> +               err = -ENXIO;
> +               goto out;
>         }
> -       else
> +       err = rtc_set_mmss(rtc, now.tv_sec);
> +       if (err < 0) {
>                 dev_err(rtc->dev.parent,
> -                       "hctosys: unable to read the hardware clock
> \n");
> +                       "hctosys: unable to set the hardware clock
> \n");
> +               goto out_close;
> +       }
>  
> +       err = 0;
> +
> +out_close:
>         rtc_class_close(rtc);
> +out:
> +       return err;
> +}

Ooh, shiny -- you saved me the trouble of doing this (and hopefully also
the trouble of looking through it to check whether all the callers of
read_persistent_clock() can sleep, etc.?)

One thing I was going to do in rtc_update_persistent_clock() was make it
use mutex_trylock() for grabbing rtc->lock. We go to great lengths to
make sure we're updating the clock at the correct time -- we don't want
to be doing things which delay the update. So we should probably just
use mutex_trylock() and abort the update (this time) if it fails.

I was also thinking of holding the RTC_HCTOSYS device open all the time,
too. If it's a problem that you then couldn't unload the module, perhaps
a sysfs interface to set/change/clear which device is used for this?

When we discussed it last week, Alessandro was concerned that the
'update at precisely 500ms past the second' rule was not universal to
all RTC devices, although I'm not entirely sure. It might be worth
moving that logic into a 'default' NTP-sync routine provided by the RTC
class, so that if any strange devices exist which require different
treatment, they can override that.

I wouldn't worry too much about leaving the old
update_persistent_clock() and read_persistent_clock() -- I hope we can
plan to remove those entirely in favour of the RTC class methods.

-- 
dwmw2
