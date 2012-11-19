From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mxs: Handle i2c DMA failure properly
Date: Mon, 19 Nov 2012 15:00:32 +0100
Message-ID: <201211191500.32205.marex@denx.de>
References: <1353216308-7338-1-git-send-email-marex@denx.de> <20121119092531.GE7775@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121119092531.GE7775-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Sun, Nov 18, 2012 at 06:25:07AM +0100, Marek Vasut wrote:
> > Properly terminate the DMA transfer in case the DMA PIO transfer
> > or setup fails for any reason.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> I liked the one patch approach better; but mainly still waiting for
> Tim's response.

Oh well ... you now have both, pick whichever you like ;-)

Agreed, we should wait for Tim. I thought he said he'd send the patch on friday, 
no ?

btw. I guess we won't be able to squeeze these into 3.7 anymore, right? Even if 
I'd say these are fixes.

Best regards,
Marek Vasut
