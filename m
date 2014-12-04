From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c-designware: Add i2c bus locking support
Date: Thu, 4 Dec 2014 10:49:47 -0800
Message-ID: <20141204184947.GB1530@pathfinder>
References: <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-2-git-send-email-david.e.box@linux.intel.com>
 <20141203160125.GB28857@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141203160125.GB28857-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 03, 2014 at 06:01:25PM +0200, Mika Westerberg wrote:
> On Mon, Dec 01, 2014 at 04:09:32PM -0800, David E. Box wrote:
> > Adds support for acquiring and releasing a hardware bus lock in the i2c
> > designware core transfer function. This is needed for i2c bus controllers
> > that are shared with but not controlled by the kernel.
> > 
> > Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c    | 11 +++++++++++
> >  drivers/i2c/busses/i2c-designware-core.h    |  6 ++++++
> >  drivers/i2c/busses/i2c-designware-platdrv.c | 18 +++++++++++++-----
> >  3 files changed, 30 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> > index 3c20e4b..377deeb 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -631,6 +631,14 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >  	dev->abort_source = 0;
> >  	dev->rx_outstanding = 0;
> >  
> > +	if (dev->acquire_lock) {
> > +		ret = dev->acquire_lock(dev);
> > +		if (ret) {
> > +			dev_err(dev->dev, "couldn't acquire bus ownership\n");
> > +			goto done;
> 
> I wonder what happens now since you failed to acquire the lock...
> 
> > +		}
> > +	}
> > +
> >  	ret = i2c_dw_wait_bus_not_busy(dev);
> >  	if (ret < 0)
> >  		goto done;
> > @@ -676,6 +684,9 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >  	ret = -EIO;
> >  
> >  done:
> > +	if (dev->release_lock)
> > +		dev->release_lock(dev);
> 
> ... but here you unconditionally release it?
> 

Releasing the lock unconditionally isn't a problem, but it is an unnecessary
path should we fail to acquire the lock. I'll add another label to skip it.

Dave
