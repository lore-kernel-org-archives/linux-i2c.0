From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
Date: Fri, 14 Sep 2012 16:21:16 +0200
Message-ID: <OF06A39459.C875C05A-ONC1257A79.004E987A-C1257A79.004EDA28@transmode.se>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se> <20120914140234.GH2630@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120914140234.GH2630-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote on 2012/09/14 16:02:34:
>
> On Thu, Aug 30, 2012 at 12:40:04PM +0200, Joakim Tjernlund wrote:
> > mpc_i2c_stop() only initiates STOP but does not wait for it to
> > hit the I2C bus. This is a problem when using I2C devices which
> > uses fairly long clock stretching just before STOP if you also
> > have an i2c-mux which may switch to another bus before STOP has
> > been processed.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
>
> Patch didn't apply, because it was a p0-patch. Checkpatch would have
> warned you.

Bugger, it is my git config setting:
[diff]
	noprefix = true

I always forget to remove that one before generating patches, I will have to remove it.

>
> Fixed that and applied to -next, thanks!

Thanks
