From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/3 V3] i2c: mxs: Rework the PIO mode operation
Date: Mon, 30 Sep 2013 13:38:26 +0200
Message-ID: <201309301338.27043.marex@denx.de>
References: <1380497035-7457-1-git-send-email-marex@denx.de> <1380497035-7457-2-git-send-email-marex@denx.de> <20130930112201.GE3222@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130930112201.GE3222@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey Wolfram,

> On Mon, Sep 30, 2013 at 01:23:54AM +0200, Marek Vasut wrote:
> > Analyze and rework the PIO mode operation. The PIO mode operation
> > was unreliable on MX28, by analyzing the bus with LA, the checks
> > for when data were available or were to be sent were wrong.
> > 
> > The PIO WRITE has to be completely reworked as it multiple problems.
> > The MX23 datasheet helped here, see comments in the code for details.
> > The problems boil down to:
> > - RUN bit in CTRL0 must be set after DATA register was written
> > - The PIO transfer must be 4 bytes long tops, otherwise use
> > 
> >   clock stretching.
> > 
> > Both of these fixes are implemented.
> > 
> > The PIO READ operation can only be done for up to four bytes as
> > we are unable to read out the data from the DATA register fast
> > enough.
> > 
> > This patch also tries to document the investigation within the
> > code.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> 
> Yay, there it is. Thanks, looks good to me. Will wait a few days so
> people can donate Tested-by tags.

Sorry for the delay, things're pretty hectic recently.

Are you coming to ELCE btw ?

Best regards,
Marek Vasut
