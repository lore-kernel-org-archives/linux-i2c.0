From: "Liu, Chuansheng" <chuansheng.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] i2c_dw: deadlock happening when system is trying to
 suspend
Date: Mon, 9 Jul 2012 13:40:08 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A10F174@SHSMSX101.ccr.corp.intel.com>
References: <27240C0AC20F114CBF8149A2696CBE4A0EE76A@SHSMSX101.ccr.corp.intel.com>
 <20120709133154.GK1296@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120709133154.GK1296-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Yanmin Zhang <yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
	(yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org)" <yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Srivatsa S. Bhat" <srivatsa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Tu, Xiaobing" <xiaobing.tu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Sorry, I found the latest kernel code has some difference with my analysis.
I need more thoughts, then update this issue.

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org]
> Sent: Monday, July 09, 2012 9:32 PM
> To: Liu, Chuansheng
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org;
> ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; Yanmin Zhang <yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> (yanmin_zhang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org); Srivatsa S. Bhat; Tu, Xiaobing
> Subject: Re: [PATCH] i2c_dw: deadlock happening when system is trying to
> suspend
> 
> On Tue, Jun 26, 2012 at 02:29:13PM +0000, Liu, Chuansheng wrote:
> > From: liu chuansheng <chuansheng.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Subject: [PATCH] i2c_dw: deadlock happening when system is trying to
> > suspend
> >
> > In i2c_dw code, there is a race condition that causes pm suspend
> > thread blocking there always. The scenerio is as below:
> >
> > PM thread:
> > suspend -->
> > pm_suspend -->
> > enter_state -->
> > dpm_suspend_start(will call i2c_dw_pci_suspend(), and the
> > dw_i2c_dev->lock is hold) ...
> > suspend_enter -->
> > dpm_suspend_noirq -->
> > suspend_device_irqs -->
> > synchronize_irq()
> >
> > synchronize_irq will wait for any pending irq is handled, and the
> > correpsonding irq thread is finished.
> >
> > In this case, there is a i2c device interrupt is pending, the irq
> > thread do the below things:
> > IRQ thread:
> > i2c_smbus_read_byte_data -->
> > i2c_smbus_xfer -->
> > i2c_transfer -->
> > i2c_dw_xfer -->
> > down()
> >
> > The irq thread blocked at down dw_i2c_dev->lock, because in PM thread,
> > it has been hold after calling i2c_dw_pci_suspend(), but PM thread is
> > waiting for IRQ thread, then deadlock happened.
> >
> > The solution is moving the down() action after pm_runtime_get_sync().
> >
> > Signed-off-by: liu chuansheng <chuansheng.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c
> > b/drivers/i2c/busses/i2c-designware-core.c
> > index 1e48bec..748ecb1 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -512,8 +512,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct
> > i2c_msg msgs[], int num)
> >
> >         dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
> >
> > -       mutex_lock(&dev->lock);
> >         pm_runtime_get_sync(dev->dev);
> > +       mutex_lock(&dev->lock);
> >
> >         INIT_COMPLETION(dev->cmd_complete);
> >         dev->msgs = msgs;
> 
> Don't you need to place the mutex_unlock() before pm_runtime_put then?
> 
> Thanks,
> 
>    Wolfram
> 
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
