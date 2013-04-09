From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Tue, 09 Apr 2013 09:07:10 +0900
Message-ID: <000b01ce34b6$2e4ec710$8aec5530$%han@samsung.com>
References: <00b901ce26a2$cb3c57d0$61b50770$%han@samsung.com>
 <20130322114634.GA24508@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20130322114634.GA24508-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, March 22, 2013 8:47 PM, Wolfram Sang wrote:
> 
> On Fri, Mar 22, 2013 at 11:13:07AM +0900, Jingoo Han wrote:
> > Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> > build warning when CONFIG_PM_SLEEP is not selected. This is because
> > sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> > the CONFIG_PM_SLEEP is enabled.
> >
> > drivers/i2c/busses/i2c-designware-platdrv.c:253:12: warning: 'dw_i2c_suspend' defined but not used [-
> Wunused-function]
> > drivers/i2c/busses/i2c-designware-platdrv.c:263:12: warning: 'dw_i2c_resume' defined but not used [-
> Wunused-function]
> >
> > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> What about doing it like the s3c2410 driver which also adds CONFIG_PM
> around the whole structure? (comment applies for both patches)

Hi Wolfram Sang,
Sorry for being late.

It is similar with s3c2410 driver.
However, CONFIG_PM is not necessary, when only SIMPLE_DEV_PM_OPS is
used.

Please refer to 'include/linux/pm.h'.
SIMPLE_DEV_PM_OPS macro uses SET_SYSTEM_SLEEP_PM_OPS macro.
Also, SET_SYSTEM_SLEEP_PM_OPS macro is defined as below.
Thus, adding CONFIG_PM is not necessary, when only SIMPLE_DEV_PM_OPS
is used.

327 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
328 const struct dev_pm_ops name = { \
329         SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
330 }

302 #ifdef CONFIG_PM_SLEEP
303 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
304         .suspend = suspend_fn, \
305         .resume = resume_fn, \
306         .freeze = suspend_fn, \
307         .thaw = resume_fn, \
308         .poweroff = suspend_fn, \
309         .restore = resume_fn,
310 #else
311 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
312 #endif

Best regards,
Jingoo Han


> 
> Thanks,
> 
>    Wolfram
