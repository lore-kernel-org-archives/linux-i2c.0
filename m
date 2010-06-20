From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fix compiler warning, due to missing const
Date: Sun, 20 Jun 2010 23:34:00 +0100
Message-ID: <20100620223400.GB12387@fluff.org.uk>
References: <1276592205-26284-1-git-send-email-mkl@pengutronix.de>
 <AANLkTiksiKUecR8tVYDEsKVYE7BxF5WAu9KdJISFRBFB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiksiKUecR8tVYDEsKVYE7BxF5WAu9KdJISFRBFB-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 15, 2010 at 05:52:09PM +0800, Eric Miao wrote:
> On Tue, Jun 15, 2010 at 4:56 PM, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > This patch adds the missing const to "struct platform_device_id" to fix
> > this warning:
> >
> > /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.c:
> > In function 'i2c_pxa_probe':
> > /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.c:1004:
> > warning: initialization discards qualifiers from pointer target type
> >
> > Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Ack

ok, will apply.


-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
