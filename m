From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/3] of/irq: Export of_irq_get()
Date: Tue, 04 Nov 2014 15:55:27 +0000
Message-ID: <20141104155527.3CF78C423D0@trevor.secretlab.ca>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1414677578-27412-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20141030141644.GE23852@katana>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141030141644.GE23852@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 30 Oct 2014 15:16:44 +0100
, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
 wrote:
> On Thu, Oct 30, 2014 at 03:59:36PM +0200, Laurent Pinchart wrote:
> > The function will be used by the I2C core which can be compiled as a
> > module.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> I think it makes sense if I take this via I2C to get the dependencies
> for the later patches right?

Agreed.

Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> 
> > ---
> >  drivers/of/irq.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 1471e0a223a5..0d7765807f49 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -405,6 +405,7 @@ int of_irq_get(struct device_node *dev, int index)
> >  
> >  	return irq_create_of_mapping(&oirq);
> >  }
> > +EXPORT_SYMBOL_GPL(of_irq_get);
> >  
> >  /**
> >   * of_irq_get_byname - Decode a node's IRQ and return it as a Linux irq number
> > -- 
> > 2.0.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
