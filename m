From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Wed, 3 Jul 2013 13:41:07 +0200
Message-ID: <201307031341.07920.marex@denx.de>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com> <201307030637.05324.marex@denx.de> <51D3E1D2.4070706@free-electrons.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51D3E1D2.4070706-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Alexandre Belloni,

> Hi Marek,
> 
> On 03/07/2013 06:37, Marek Vasut wrote:
> > I'm attaching a patch. Alex, please give it a go and see if it fixes your
> > issue. It is _VERY_ ugly.
> 
> Quite ugly ;)
> 
> It indeed seems to fix the issue.
> 
> > The basic idea behind the the patch is that, as (attempted to be)
> > explained above, subsequent writes to DATA register in PIO mode cause
> > constant generation of clock on the bus and therefore a very long
> > transfer of zero data. This confuses the I2C peripherals of course.
> > 
> > The patch implements clock stretching for PIO writes (maybe we need this
> > for reads too) by making the controller blast out only 4 (or less) bytes
> > of data in each write into the DATA register. To prevent interruption of
> > the transfer between writes into the DATA register, the SCK is held low
> > using the RETAIN_CLOCK bit.
> > 
> > But (!) here comes the caveat. The PIO was introduced to speed up small
> > transfers. Introducing clock stretching into PIO mode operation might
> > completely remove this advantage. This has to be measured again.
> 
> And now, PIO mode is slower than DMA...

Further digging needed then. I will update you when I'm done, but I won't be in 
my office tomorrow, so probably on friday.

Best regards,
Marek Vasut
