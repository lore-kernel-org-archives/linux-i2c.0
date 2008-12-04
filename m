From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Thu, 4 Dec 2008 11:20:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812041108460.5079@axis700.grange>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812030917440.4717@axis700.grange>
 <20081203234317.GA4256@fluff.org.uk> <4937AA1C.8050004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4937AA1C.8050004-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 4 Dec 2008, Darius wrote:

> > > > +	if (!request_mem_region(res->start, res_size, res->name)) {
> > > > +		dev_err(&pdev->dev, "can't allocate %d bytes at %d address\n",
> > > > +			res_size, res->start);
> > > > +		return -ENOMEM;
> > > > +	}
> > > I was once told, one doesn't need request_mem_region() on regions from
> > > platform data resources - this is already done implicitly.
> > 
> > I belive that request_mem_region() is the correct thing to do, IIRC,
> > the platform_device_register() calls insert_resource() on all the
> > resource regions of the device so that it is guarnateed to appear in
> > the /proc/ioport or /proc/iomem map. However I belive this does not
> > actually make a reservation of that resource.
> >  
> 
> confused... Guennadi, can you please explain more your mention?

Look at this:

http://marc.info/?l=linux-sh&m=121642007016402&w=2

> > > > +	/* Get I2C clock */
> > > > +	i2c_imx->clk = clk_get(NULL, "i2c_clk");
> > > There can be several i2c busses on the system, so you want:
> > > 
> > > +	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
> > 
> > tbh, the bus clock should be defined as NULL, any extra clocks for
> > a device get names. However this may need fixing in the platform
> > as well. I belive RMK is already making these changes for AMBA and
> > I will probably follow suit with the s3c architectures as soon as
> > the rest of the development work is out of the way.

Ben, what do you mean here? I thought Russell was against 
platform-specific clock names and for function names. But i2c_clk is a 
function name. I don't understand the difference between "bus clock" and 
"extra clocks" - on i.MX31 we have 3 i2c busses with separate clock 
sources, so, we have to use the platform device in clk_get to request a 
specific i2c clock matching the platform-device index. That's all what I 
meant.

> > > > +struct imxi2c_platform_data {
> > > > +	int (*init)(struct device *dev);
> > > > +	int (*exit)(struct device *dev);
> > > What are you going to use .exit() for? Is it really needed? Even if it is,
> > > it can easily return void I guess?
> > > 
> 
> Where to put commnets? Right here in driver code or is better in
> /Documentation?

Something like this:

+/**
+ * @init:	initialise the interface
+ * @exit:	free interface resources
+ */
+struct imxi2c_platform_data {
+	int (*init)(struct device *dev);
+	int (*exit)(struct device *dev);

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
