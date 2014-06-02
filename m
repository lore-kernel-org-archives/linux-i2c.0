From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: designware: No need to disable already disabled
 controller
Date: Mon, 2 Jun 2014 20:34:08 +0300
Message-ID: <20140602173408.GB1730@lahna.fi.intel.com>
References: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
 <1400164644-3222-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140602161234.GG2654@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140602161234.GG2654@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Yao Jin <yao.jin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aubrey Li <aubrey.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 02, 2014 at 06:12:34PM +0200, Wolfram Sang wrote:
> On Thu, May 15, 2014 at 05:37:21PM +0300, Mika Westerberg wrote:
> > If the controller is already in desired state (enabled/disabled) there is
> > no point in setting its state again.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> 
> Does it have a side-effect when setting then enable bit again? Otherwise
> it will exit the loop immediately on the first try. Not too bad IMO
> given the additional code saved.

AFAICT there shouldn't be any side effect. So the $subject patch just
saves one register write in the best case. You are right, maybe it's not
worth adding 3 extra lines of code just for that :)

> 
> >  drivers/i2c/busses/i2c-designware-core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> > index b58ecf19e767..b0792675b970 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -258,6 +258,10 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
> >  {
> >  	int timeout = 100;
> >  
> > +	/* In case the controller is already in desired state */
> > +	if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable)
> > +		return;
> > +
> >  	do {
> >  		dw_writel(dev, enable, DW_IC_ENABLE);
> >  		if ((dw_readl(dev, DW_IC_ENABLE_STATUS) & 1) == enable)
> > -- 
> > 2.0.0.rc2
> > 
