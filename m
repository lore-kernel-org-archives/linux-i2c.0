From: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add driver for Rockchip RK3xxx SoC I2C adapter
Date: Mon, 28 Apr 2014 00:39:19 +0200
Message-ID: <4500103.Z38Pp35WUa@typ>
References: <1840959.yqLj3D6H4q@typ> <2533407.kJCGHuX10p@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2533407.kJCGHuX10p@diego>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Heiko,

thanks for your comments.

> both the grf as well as the bus-idx are rockchip specific, so they should be
> prefixed (rockchip,grf, etc) and from my personal taste I would hope we
> could invest in an "n" and "e", to make it a full bus-index ;-)
I will change the names to rockchip,grf and rockchip,bus-index.

> the convention seems to be "clock-frequency" for the desired bus speed
> (checked i2c-sirf, i2c-exynos, i2c-at91and i2c-qup).
Thanks for looking that up, will change.

> > + * Driver for I2C unit in Rockchip RK3188 SoC
> 
> RK3188 -> RK3xxx?
yes, of course.

> > +static inline void i2c_writel(struct rk3x_i2c *i2c, u32 value,
> > +			      unsigned int offset)
> > +{
> > +	writel(value, i2c->regs + offset);
> > +}
> > +
> > +static inline u32 i2c_readl(struct rk3x_i2c *i2c, unsigned int offset)
> > +{
> > +	return readl(i2c->regs + offset);
> > +}
> 
> I'm not sure what the policy here is, but is this indirection really
> necessary when it's only doing a normal readl/writel?
I saw that pattern in several device drivers (a quick grep for
"static inline void .*_writel" turns up quite a bit of those). Obviously, it 
doesn't hurt performance-wise as they are just inline functions. I personally 
think that

i2c_writel(i2c, val, REG_CON);

is a bit more concise than

writel(val, i2c->regs + REG_CON);

And it makes tracing easier by giving me a single function were I can trace 
all register accesses, if needed.

But as you said, there might be some policy I don't know about. If you feel 
strongly about it or someone else also votes for plain readl/writel, I will 
happily change it.

Thanks,
  Max
