From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2] i2c: mxs: Add PIO and mixed-DMA support
Date: Thu, 24 Jan 2013 15:18:41 +0100
Message-ID: <201301241518.41593.marex@denx.de>
References: <1359032181-10601-1-git-send-email-marex@denx.de> <20130124141715.GJ12933@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130124141715.GJ12933-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Thu, Jan 24, 2013 at 01:56:21PM +0100, Marek Vasut wrote:
> > Add support for the PIO mode and mixed PIO/DMA mode support. The mixed
> > PIO/DMA is the default mode of operation. This shall leverage overhead
> > that the driver creates due to setting up DMA descriptors even for very
> > short transfers.
> > 
> > The current boundary between PIO/DMA 8 bytes, transfers shorter than 8
> > bytes are transfered by PIO, longer transfers use DMA. The performance
> > of write transfers remains unchanged, while there is a minor improvement
> > of read performance. Reading 16KB EEPROM with DMA-only operations gives
> > a read speed of 39.5KB/s, while with then new mixed-mode the speed is
> > blazing 40.6KB/s.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> OK, the polling can be argued. I shortened the comment about the
> threshold a little, since bandwidth measurements depend on a lot of
> other things and it is not really needed there.
> 
> Applied to -next, thanks!

Thank you very much! And good luck with the stuff up ahead ;-)

Best regards,
Marek Vasut
