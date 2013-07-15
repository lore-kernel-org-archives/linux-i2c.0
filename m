From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Mon, 15 Jul 2013 16:12:08 +0200
Message-ID: <201307151612.09198.marex@denx.de>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com> <20130702022342.GZ13206@S2101-09.ap.freescale.net> <CAOMZO5Dyk_5CzcXvG7eJ3h07i=So0DS7MjtMQVHfpfx9Se_Teg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5Dyk_5CzcXvG7eJ3h07i=So0DS7MjtMQVHfpfx9Se_Teg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Fabio Estevam,

> Hi Wolfram,
> 
> On Mon, Jul 1, 2013 at 11:23 PM, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, Jul 01, 2013 at 06:14:21PM -0300, Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >> 
> >> Recently we have been seing some reports about PIO mode not working
> >> properly.
> >> 
> >> - http://www.spinics.net/lists/linux-i2c/msg11985.html
> >> - http://marc.info/?l=linux-i2c&m=137235593101385&w=2
> >> - https://lkml.org/lkml/2013/6/24/430
> > 
> > It also causes sgtl5000 register write failure [1].  Changing it back to
> > DMA mode fixes the failure.  So,
> > 
> > Acked-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > 
> > [1] http://thread.gmane.org/gmane.linux.alsa.devel/109715/focus=109747
> 
> Any comment about this patch, please?
> 
> If you are happy with it, could we please have it applied into stable?
> 
> 3.10 is currently broken without this patch.

Hi, either this or the PIO fix, but that's a RFC and quite a big slab of change 
which still needs some work. So please apply this and let's try the PIOfix for 
3.11 or 3.12.

Best regards,
Marek Vasut
