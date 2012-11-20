From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mxs: Handle i2c DMA failure properly
Date: Tue, 20 Nov 2012 09:47:36 +0100
Message-ID: <201211200947.36430.marex@denx.de>
References: <1353216308-7338-1-git-send-email-marex@denx.de> <201211191500.32205.marex@denx.de> <20121120083946.GB14722@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121120083946.GB14722-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > btw. I guess we won't be able to squeeze these into 3.7 anymore, right?
> > Even if I'd say these are fixes.
> 
> After the outcoming of the discussion with Tim, I will apply the single
> patch. But I won't apply Fabio's patch to enable I2C for MX23 since
> there seem to be issues.

Sounds good.

> Since the driver currently advertises properly that it cannot do
> SMBUS_QUICK, the addition of that is not a bugfix but a feature
> addition, so I'll apply it to for-next.

Actually, I'd say apply the DMA termination fix to stable and the SMBUS_QUICK 
enabling to -next if you want to be completely correct. You're right, one part 
of the patch is a bugfix, the rest if feature addition.

Best regards,
Marek Vasut
