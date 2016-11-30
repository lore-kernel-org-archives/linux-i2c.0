From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 1/4] i2c: pxa: Add definition of fast and high speed
 modes via the regs layout
Date: Wed, 30 Nov 2016 16:49:38 +0100
Message-ID: <20161130164938.32ba768f@free-electrons.com>
References: <20161130140017.26307-1-romain.perier@free-electrons.com>
        <20161130140017.26307-2-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161130140017.26307-2-romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yahuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Igal Liberman <igall-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, 30 Nov 2016 15:00:14 +0100, Romain Perier wrote:

>  #ifdef CONFIG_I2C_PXA_SLAVE
>  	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
> @@ -1234,6 +1238,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
>  	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
>  	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
> +	i2c->fm_mask = pxa_reg_layout[i2c_type].fm ? pxa_reg_layout[i2c_type].fm : ICR_FM;
> +	i2c->hs_mask = pxa_reg_layout[i2c_type].hs ? pxa_reg_layout[i2c_type].hs : ICR_HS;

These lines are too long according to checkpatch. What about using what
Wolfram originally suggested, i.e:

	i2c->fm_mask = pxa_reg_layout[i2c_type].fm ?: ICR_FM;

which does exactly the same, but fits within 80 characters ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
