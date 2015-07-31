From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: designware-pci: use IRQF_COND_SUSPEND flag
Date: Fri, 31 Jul 2015 14:35:33 +0300
Message-ID: <20150731113533.GJ11956@lahna.fi.intel.com>
References: <1436350536-99102-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1437997043.29746.86.camel@linux.intel.com>
 <20150731100723.GA1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150731100723.GA1522@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 31, 2015 at 12:07:23PM +0200, Wolfram Sang wrote:
> On Mon, Jul 27, 2015 at 02:37:23PM +0300, Andy Shevchenko wrote:
> > On Wed, 2015-07-08 at 13:15 +0300, Andy Shevchenko wrote:
> > > The mentioned flag fixes a warning on Intel Edison board since one of 
> > > the I2C
> > > controller shares IRQ line with watchdog timer.
> > > 
> > 
> > Wolfram, do you have any comments on this?
> 
> Adding Mika to cc, he is more experienced with these platforms.

intel_mid_wdt.c requests the same IRQ with IRQF_NO_SUSPEND so this patch
makes sense to me,

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
