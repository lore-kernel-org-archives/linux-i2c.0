From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Handle i2c DMA failure properly
Date: Wed, 14 Nov 2012 16:22:21 +0100
Message-ID: <201211141622.22161.marex@denx.de>
References: <1352903508-18113-1-git-send-email-marex@denx.de> <CAOMZO5AVDXeu59ZwB35k_0yYx5XwTzdmtj+QXXEoQRMs7Br-KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5AVDXeu59ZwB35k_0yYx5XwTzdmtj+QXXEoQRMs7Br-KA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Wed, Nov 14, 2012 at 12:31 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > Properly terminate the DMA transfer in case the DMA PIO transfer
> > or setup fails for any reason. While at it, enable support for
> > SMBUS_QUICK. This essentially fixes i2c-detect on this IP.
> 
> Shouldn't this be split into two patches?

It should, but then it fixes one problem, so I stuck it into one ...

> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
