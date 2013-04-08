From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: mxs: do error checking and handling in PIO mode
Date: Mon, 8 Apr 2013 19:19:33 +0200
Message-ID: <20130408171933.GA6865@the-dreams.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
 <1363261750-26645-3-git-send-email-l.stach@pengutronix.de>
 <201304020059.22550.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201304020059.22550.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 02, 2013 at 12:59:22AM +0200, Marek Vasut wrote:
> Dear Lucas Stach,
> 
> > In PIO mode we can end up with the same errors as in DMA mode, but as IRQs
> > are disabled there we have to check for them manually after each command.
> > 
> > Also don't use the big controller reset hammer when receiving a NAK from a
> > slave. It's sufficient to tell the controller to continue at a clean state.
> > 
> > Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Stamp it with:
> 
> Tested-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Did you test only this patch or all of them?
