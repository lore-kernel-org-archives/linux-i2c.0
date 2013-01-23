From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-mxs: Fix type of error code
Date: Wed, 23 Jan 2013 12:01:51 +0100
Message-ID: <201301231201.51675.marex@denx.de>
References: <1357605126-26537-1-git-send-email-festevam@gmail.com> <20130123095314.GA3767@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130123095314.GA3767-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Mon, Jan 07, 2013 at 10:32:06PM -0200, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > 
> > cmd_err is used to handle error code, so it should not be unsigned.
> > 
> > This fixes the following warning when building with W=1 option:
> > 
> > drivers/i2c/busses/i2c-mxs.c: In function 'mxs_i2c_xfer_msg':
> > drivers/i2c/busses/i2c-mxs.c:331:19: warning: comparison between signed
> > and unsigned integer expressions [-Wsign-compare]
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Thanks! Applied to current and added stable.

I dont wanna be nagging, but you polling the linux-i2c stuff every 3 months or 
so doesn't make the development all that smooth. Btw. there are other patches 
(like the speed patch, like the pio/dma patch) which still keep hanging. I'd 
like to see them in 3.8, since they were submitted nearly three months ago.

I even bumped you about them every so often. Can you go through your mailbox 
please?

Best regards,
Marek Vasut
