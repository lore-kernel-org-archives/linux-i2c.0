From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Wed, 10 Apr 2013 09:26:11 +0900
Message-ID: <002901ce3582$00d43190$027c94b0$%han@samsung.com>
References: <00b901ce26a2$cb3c57d0$61b50770$%han@samsung.com>
 <20130322114634.GA24508@the-dreams.de>
 <000b01ce34b6$2e4ec710$8aec5530$%han@samsung.com>
 <20130409085038.GB3624@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20130409085038.GB3624-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, April 09, 2013 5:51 PM, Wolfram Sang wrote:
> On Tue, Apr 09, 2013 at 09:07:10AM +0900, Jingoo Han wrote:
> > On Friday, March 22, 2013 8:47 PM, Wolfram Sang wrote:
> > >
> > > On Fri, Mar 22, 2013 at 11:13:07AM +0900, Jingoo Han wrote:
> > > > Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> > > > build warning when CONFIG_PM_SLEEP is not selected. This is because
> > > > sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> > > > the CONFIG_PM_SLEEP is enabled.
> > > >
> > > > drivers/i2c/busses/i2c-designware-platdrv.c:253:12: warning: 'dw_i2c_suspend' defined but not used
> [-
> > > Wunused-function]
> > > > drivers/i2c/busses/i2c-designware-platdrv.c:263:12: warning: 'dw_i2c_resume' defined but not used
> [-
> > > Wunused-function]
> > > >
> > > > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > >
> > > What about doing it like the s3c2410 driver which also adds CONFIG_PM
> > > around the whole structure? (comment applies for both patches)
> >
> > Hi Wolfram Sang,
> > Sorry for being late.
> >
> > It is similar with s3c2410 driver.
> > However, CONFIG_PM is not necessary, when only SIMPLE_DEV_PM_OPS is
> > used.
> 
> Still, you are always creating a dev_pm_ops structure, even if empty in
> case of no CONFIG_PM. The s3c driver skips that and uses NULL for
> setting the pm member of the driver struct then.

I know it.

When SIMPLE_DEV_PM_OPS is used and CONFIG_PM is NOT selected,
call back functions (suspend, resume) are empty.
Then it cannot be called by PM framework.

Of course in this case, it requires additional NULL checking by
PM framework.

However, in my opinion, it would not be critical.
Now, many drivers are using SIMPLE_DEV_PM_OPS macro in this way,
not adding CONFIG_PM. There is no side effect.


Best regards,
Jingoo Han
