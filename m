From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Handle i2c DMA failure properly
Date: Thu, 15 Nov 2012 05:01:17 +0100
Message-ID: <201211150501.18009.marex@denx.de>
References: <1352903508-18113-1-git-send-email-marex@denx.de> <201211141622.22161.marex@denx.de> <CANqk_c-f3+a=f1QqWFxEpGcMQRqMD61eHiXNLyfzciJkzPGMRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqk_c-f3+a=f1QqWFxEpGcMQRqMD61eHiXNLyfzciJkzPGMRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Tim Michals,

> On Wed, Nov 14, 2012 at 9:22 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > Dear Fabio Estevam,
> > 
> > > Hi Marek,
> > > 
> > > On Wed, Nov 14, 2012 at 12:31 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > > > Properly terminate the DMA transfer in case the DMA PIO transfer
> > > > or setup fails for any reason. While at it, enable support for
> > > > SMBUS_QUICK. This essentially fixes i2c-detect on this IP.
> > > 
> > > Shouldn't this be split into two patches?
> > 
> > It should, but then it fixes one problem, so I stuck it into one ...
> > 
> > > Regards,
> > > 
> > > Fabio Estevam
> > 
> > Best regards,
> > Marek Vasut
>
> Dear Marek Vasut,
> 
> This patch
>  @@ -150,8 +150,6 @@ static void mxs_i2c_reset(struct mxs_i2c
>   writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
> 
>   writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
> -
> - dmaengine_terminate_all(i2c->dmach);
>  }

This patch doesn't apply, can you elaborate ?

Moreover ... read either RFC1855 properly [1] and/or read the mailing list 
etiquette please (!). Especially the part about top-posting. Do us a favor.

> This patch fixes current DMA requests which time out or error returned by
> the ISR.
> 
> Tim

[1] http://www.ietf.org/rfc/rfc1855.txt

Best regards,
Marek Vasut
