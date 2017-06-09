From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v10 1/6] i2c: designware: Cleaning and comment style
 fixes.
Date: Fri, 09 Jun 2017 11:38:09 +0300
Message-ID: <1496997489.22624.63.camel@linux.intel.com>
References: <cover.1496942505.git.lolivei@synopsys.com>
         <4fb5f66dafc24e3213aaa8fc93fa12fecb6d6aa1.1496942505.git.lolivei@synopsys.com>
         <5bc3077b-2e4c-eb27-bca1-b7cbfc2dec01@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5bc3077b-2e4c-eb27-bca1-b7cbfc2dec01-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2017-06-09 at 07:12 +0200, Peter Rosin wrote:
> On 2017-06-08 19:36, Luis Oliveira wrote:
> > complicated to review. The work here won't bring any additional work
> > to
> > backported fixes because is just style and reordering.
> 
> I challenge that. If there is an old bug that existed before this
> patch
> that is fixed in the future after this patch has been applied, it
> might
> very well be hard_er_ to backport that fix to a point before this
> patch
> has been applied. So, what do you mean?

I asked this during review of ~v3. I don't remember what Wolfram told
about it.

> 
> > @@ -984,12 +984,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
> >  	}
> >  
> >  	i2c_dw_disable_int(dev);
> > -	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
> > irq_flags,
> > +	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
> > irq_flags,
> >  			     dev_name(dev->dev), dev);
> 

> Two extra spaces needed to align with the opening bracket.

It's a bikeshedding, though it looks like v11 is needed anyway (see
kbuild bot complains), thus it might be addressed as well.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
