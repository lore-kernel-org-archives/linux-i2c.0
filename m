From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Rework the PIO mode operation
Date: Mon, 15 Jul 2013 04:05:52 +0200
Message-ID: <201307150405.53110.marex@denx.de>
References: <1373312807-13227-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373312807-13227-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

> Analyze and rework the PIO mode operation. The PIO mode operation
> was unreliable on MX28, by analyzing the bus with LA, the checks
> for when data were available or were to be sent were wrong.
> 
> The PIO WRITE has to be completely reworked as it multiple problems.
> The MX23 datasheet helped here, see comments in the code for details.
> The problems boil down to:
> - RUN bit in CTRL0 must be set after DATA register was written
> - The PIO transfer must be 4 bytes long tops, otherwise use
>   clock stretching.
> Both of these fixes are implemented.
> 
> The PIO READ operation can only be done for up to four bytes as
> we are unable to read out the data from the DATA register fast
> enough.
> 
> This patch also tries to document the investigation within the
> code.
> 
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>

I so far got confirmation from ALexandre this patch works. Can someone else test 
it please? I'd like to roll out a final version to close this issue.

One question remain though -- shall we have the PIO as an experimental feature 
and disable it by default OR not ?

Thanks!

Best regards,
Marek Vasut
