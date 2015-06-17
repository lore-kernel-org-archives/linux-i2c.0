From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Make sure the device is suspended
 before disabling runtime PM
Date: Wed, 17 Jun 2015 13:24:32 +0300
Message-ID: <20150617102432.GI1478@lahna.fi.intel.com>
References: <1434532118-119906-1-git-send-email-mika.westerberg@linux.intel.com>
 <20150617101645.GA1517@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150617101645.GA1517@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 17, 2015 at 12:16:45PM +0200, Wolfram Sang wrote:
> On Wed, Jun 17, 2015 at 12:08:38PM +0300, Mika Westerberg wrote:
> > The driver calls pm_runtime_put() right before pm_runtime_disable() in its
> > ->remove() hook to make sure clock is gated etc. However, it turns out that
> > pm_runtime_put() only calls ->idle() hook without actually suspending
> > anything. The following pm_runtime_disable() will prevent the driver from
> > suspending thus leaving it "active".
> > 
> > It is better to suspend the device synchronously to make sure it is
> > actually suspended before disabling runtime PM from it.
> > 
> > While there, undo call to pm_runtime_use_autosuspend().
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> For current? For next? stable?
> 

Right, sorry about that.

I think it is fine to get this for next.
