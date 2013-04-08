From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: mxs: do error checking and handling in PIO mode
Date: Mon, 8 Apr 2013 19:23:53 +0200
Message-ID: <201304081923.53350.marex@denx.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de> <201304020059.22550.marex@denx.de> <20130408171933.GA6865@the-dreams.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130408171933.GA6865-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Tue, Apr 02, 2013 at 12:59:22AM +0200, Marek Vasut wrote:
> > Dear Lucas Stach,
> > 
> > > In PIO mode we can end up with the same errors as in DMA mode, but as
> > > IRQs are disabled there we have to check for them manually after each
> > > command.
> > > 
> > > Also don't use the big controller reset hammer when receiving a NAK
> > > from a slave. It's sufficient to tell the controller to continue at a
> > > clean state.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > 
> > Stamp it with:
> > 
> > Tested-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> 
> Did you test only this patch or all of them?

Whole set.

Best regards,
Marek Vasut
