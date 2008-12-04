From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Thu, 4 Dec 2008 01:21:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812040120220.7961@axis700.grange>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812031355120.4717@axis700.grange>
 <gh609o$gs0$1@ger.gmane.org> <Pine.LNX.4.64.0812032155350.7961@axis700.grange>
 <20081203234833.GC4256@fluff.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081203234833.GC4256-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 3 Dec 2008, Ben Dooks wrote:

> On Wed, Dec 03, 2008 at 09:58:10PM +0100, Guennadi Liakhovetski wrote:
> >  
> >  struct imxi2c_platform_data {
> > +	u32 i2c_clk;
> >  	int (*init)(struct device *dev);
> >  	int (*exit)(struct device *dev);
> >  };
> >  
> > +struct imxi2c_board_data {
> > +	struct imxi2c_platform_data	data;
> > +	unsigned int			id;
> > +};
> > +
> > +extern int mxc_i2c_register_adapters(struct imxi2c_board_data *data, int n);
> 
> if there are only 1 or two busses, why not do
> 
> mx2_i2c_register_board(int i2c_channel_nr, struct
> 		       imx_i2c_platform_data *pd);

on i.MX31 there are 3.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
