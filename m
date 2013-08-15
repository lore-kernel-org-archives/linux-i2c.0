From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Check the return value from stmp_reset_block()
Date: Thu, 15 Aug 2013 23:31:23 +0200
Message-ID: <201308152331.23742.marex@denx.de>
References: <1373505568-21477-1-git-send-email-festevam@gmail.com> <20130815100022.GC2987@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130815100022.GC2987@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Wed, Jul 10, 2013 at 10:19:28PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > 
> > stmp_reset_block() may fail, so let's check its return value and
> > propagate it in the case of error.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Applied to for-next, thanks!
> 
> Marek: can you base your pio rework on top of this patch, too?

Yeah, where is this tree/branch please ?

Best regards,
Marek Vasut
