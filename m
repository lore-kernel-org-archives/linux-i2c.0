From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: correctly setup speed for non devicetree
Date: Sun, 16 Sep 2012 12:05:42 +0200
Message-ID: <201209161205.42575.marex@denx.de>
References: <1347118732-4896-1-git-send-email-w.sang@pengutronix.de> <201209152009.44320.marex@denx.de> <20120916081525.GA4367@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120916081525.GA4367-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > > Commit cd4f2d4 (i2c: mxs: Set I2C timing registers for mxs-i2c) only
> > > covered the case for devicetree and made platform_data based boards
> > > bail out with -EINVAL. Correctly support the latter one, too.
> > 
> > MXS is now DT only, so this patch is pointless.
> 
> This is not true for 3.5.

Did that patch made it into 3.5 ?

> > Rather make it depend on CONFIG_OF
> 
> I wanted to avoid ifdeffery.

Best regards,
Marek Vasut
