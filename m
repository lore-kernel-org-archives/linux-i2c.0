From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: mxs: remove races in PIO code
Date: Mon, 15 Apr 2013 18:30:54 +0200
Message-ID: <20130415163054.GC6286@the-dreams.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
 <1366021015-5936-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1366021015-5936-1-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 15, 2013 at 12:16:54PM +0200, Lucas Stach wrote:
> This commit fixes the three following races in PIO code:
> 
> - The CTRL0 register is racy in itself, when programming transfer state and
>   run bit in the same cycle the hardware sometimes ends up using the state
>   from the last transfer. Fix this by programming state in one cycle, make
>   sure the write is flushed down APBX bus by reading back the reg and only
>   then trigger the run bit.
> 
> - Only clear the DMAREQ bit in DEBUG0 after the read/write to the data reg
>   happened. Otherwise we are racing with the hardware about who touches
>   the data reg first.
> 
> - When checking for completion of a transfer it's not sufficient to check
>   if the data engine finished, but also a check for i2c bus idle is needed.
>   In PIO mode we are really fast to program the next transfer after a finished
>   one, so the controller possibly tries to start a new transfer while the
>   clkgen engine is still busy writing the NAK/STOP from the last transfer to
>   the bus.
> 
> Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied to for-next, thanks! Both.

I'd prefer to not use reply-to <old_series> when sending <new_series>.
