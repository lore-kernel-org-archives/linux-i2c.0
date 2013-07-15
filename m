From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Rework the PIO mode operation
Date: Tue, 16 Jul 2013 01:25:03 +0200
Message-ID: <201307160125.03823.marex@denx.de>
References: <1373312807-13227-1-git-send-email-marex@denx.de> <201307150405.53110.marex@denx.de> <20130715145836.GB23589@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130715145836.GB23589-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Shawn Guo,

> On Mon, Jul 15, 2013 at 04:05:52AM +0200, Marek Vasut wrote:
> > I so far got confirmation from ALexandre this patch works. Can someone
> > else test it please? I'd like to roll out a final version to close this
> > issue.
> 
> I just confirmed that it fixes sgtl5000 register write failure for me.

Thanks, I'll roll out the V2 this week.

Best regards,
Marek Vasut
