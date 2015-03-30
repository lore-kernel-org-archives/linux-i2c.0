From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 3/3] I2C: mediatek: Add driver for MediaTek MT8173
 I2C controller
Date: Mon, 30 Mar 2015 16:05:19 +0800
Message-ID: <1427702719.26464.5.camel@mtksdaap41>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
	 <1426917922-61356-4-git-send-email-eddie.huang@mediatek.com>
	 <20150323073905.GF9742@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150323073905.GF9742-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sascha,

On Mon, 2015-03-23 at 08:39 +0100, Sascha Hauer wrote:
> On Sat, Mar 21, 2015 at 02:05:22PM +0800, Eddie Huang wrote:
> > Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> > of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> > also increase message size to 64kb.
> > 
> 
> [...]
> 
> > +static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
> > +	.max_num_msgs = MAX_MSG_NUM_MT8173,
> > +	.max_write_len = MAX_DMA_TRANS_SIZE_MT8173,
> > +	.max_read_len = MAX_DMA_TRANS_SIZE_MT8173,
> > +	.max_comb_1st_msg_len = MAX_DMA_TRANS_SIZE_MT8173,
> > +	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT8173,
> > +};
> > +
> >  static int mtk_i2c_probe(struct platform_device *pdev)
> >  {
> >  	int ret = 0;
> > @@ -587,7 +626,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  
> >  	i2c->platform_compat = mtk_get_device_prop(pdev);
> > -	if (i2c->have_pmic && (i2c->platform_compat & COMPAT_MT6577))
> > +	if (i2c->have_pmic && (i2c->platform_compat &
> > +			(COMPAT_MT6577 | COMPAT_MT8173)))
> >  		return -EINVAL;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -613,7 +653,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
> >  	i2c->adap.dev.parent = &pdev->dev;
> >  	i2c->adap.owner = THIS_MODULE;
> >  	i2c->adap.algo = &mtk_i2c_algorithm;
> > -	i2c->adap.quirks = &mt6577_i2c_quirks;
> > +	if (i2c->platform_compat & COMPAT_MT8173)
> > +		i2c->adap.quirks = &mt8173_i2c_quirks;
> > +	else
> > +		i2c->adap.quirks = &mt6577_i2c_quirks;
> 
> Instead of putting an integer into struct of_device_id you should
> introduce a
> 
> struct mtk_i2c_data {
> 	struct i2c_adapter_quirks quirks;
> 	int compat;
> 	/* Additional SoC specific data */
> };
> 
> and put a pointer to this directly into the of_device_id. This way you
> need less casting and can put newly discovered differences diretly into
> some data struct and don't have to introduce if(socxy) ... else ...
> everytime.
> 

Thanks your suggestion. I will use capability struct like 

struct mtk_i2c_compatible {
	unsigned char pmic_i2c;
	unsigned char dcm;
	unsigned char auto_restart;
	const struct i2c_adapter_quirks *quirks;
};

And pass in of_device_id, then remove all if(socxy).... else ... in
driver.

Eddie





--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
