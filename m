From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Mon, 1 Jul 2013 23:05:08 +0200
Message-ID: <201307012305.09050.marex@denx.de>
References: <1372711303-17705-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1372711303-17705-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Recently we have been seing some reports about PIO mode not working
> properly.
> 
> - http://www.spinics.net/lists/linux-i2c/msg11985.html
> - http://marc.info/?l=linux-i2c&m=137235593101385&w=2
> - https://lkml.org/lkml/2013/6/24/430
> 
> Let's use DMA mode even for small transfers.
> 
> Without this patch, i2c reads the incorrect sgtl5000 version on a mx28evk
> when touchscreen is enabled:
> 
> [    5.856270] sgtl5000 0-000a: Device with ID register 0 is not a sgtl5000
> [    9.877307] sgtl5000 0-000a: ASoC: failed to probe CODEC -19
> [    9.883528] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -19
> [    9.892955] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-19)
> 
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Can you possibly just disable the PIO for now so the code doesn't need to be re-
introduced once fixed?

Best regards,
Marek Vasut
