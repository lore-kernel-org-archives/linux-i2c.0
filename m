From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [4/7] i2c-designware: use dynamic adapter numbering on Lynxpoint
Date: Tue, 9 Apr 2013 12:37:22 +0300
Message-ID: <20130409093722.GH21818@intel.com>
References: <1363867800-23861-4-git-send-email-mika.westerberg@linux.intel.com>
 <20130409090605.GC28509@the-dreams.de>
 <20130409092319.GF21818@intel.com>
 <20130409092923.GF3624@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130409092923.GF3624-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 09, 2013 at 11:29:24AM +0200, Wolfram Sang wrote:
> On Tue, Apr 09, 2013 at 12:23:19PM +0300, Mika Westerberg wrote:
> > On Tue, Apr 09, 2013 at 11:06:05AM +0200, Wolfram Sang wrote:
> > > On Thu, Mar 21, 2013 at 02:09:57AM -0000, Mika Westerberg wrote:
> > > > It is not good idea to mix static and dynamic I2C adapter numbering. In
> > > > this particular case on Lynxpoint we had graphics I2C adapter which took
> > > > the first numbers preventing the designware I2C driver from using the
> > > > adapter numbers it preferred.
> > > > 
> > > > Fix this by switching to use dynamic adapter numbering on Intel Lynxpoint.
> > > > 
> > > > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > 
> > > I am fearing regressions here if the bus numbering changes.
> > 
> > There are no users for this dynamic numbering yet since it was introduced
> > with the Lynxpoint support.
> 
> Please add this to the commit msg.

Sure, thanks.
