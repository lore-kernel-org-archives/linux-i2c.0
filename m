From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Sun, 26 May 2013 19:00:11 +0200
Message-ID: <20130526170011.GK17847@lukather>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
 <24460034.7lWPC5EJAp@flatron>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBHP7RCGQKGQEJFU6PPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <24460034.7lWPC5EJAp@flatron>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, May 26, 2013 at 04:38:19PM +0200, Tomasz Figa wrote:
> On Sunday 26 of May 2013 12:20:37 Maxime Ripard wrote:
> > +	/*
> > +	 * Address + Read bit have been transmitted, ACK has not been
> > +	 * received. If we don't care about the NAKs, we just treat
> > +	 * this case as if an ACK would have been received, and fall
> > +	 * through to the next case.
> > +	 */
> > +	case SUNXI_I2C_STA_MASTER_RADDR_NAK:
> > +		if (!(i2c_dev->msg_cur->flags & I2C_M_IGNORE_NAK)) {
> > +			i2c_dev->msg_err = SUNXI_I2C_NAK;
> > +			goto out;
> > +		}
> 
> I meant something more like:
> 
> +
> +	/* Intentional fall through. */
> 
> This is enough to let the reader know that there is no break missing here 
> and you can keep those nice short state descriptions from v1.

Ok, I'll do it that way

[..]

> > +static int sunxi_i2c_probe(struct platform_device *pdev)
> > +{
> > +	struct sunxi_i2c_dev *i2c_dev;
> > +	struct device_node *np;
> > +	u32 freq, div_m, div_n;
> > +	struct resource res;
> 
> 	struct resource *res;
> 
> and then...
> 
> > +	int ret;
> > +
> > +	np = pdev->dev.of_node;
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
> > +	if (!i2c_dev)
> > +		return -ENOMEM;
> > +	platform_set_drvdata(pdev, i2c_dev);
> > +	i2c_dev->dev = &pdev->dev;
> > +
> > +	init_completion(&i2c_dev->completion);
> > +
> > +	ret = of_address_to_resource(np, 0, &res);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not get IO memory\n");
> > +		return ret;
> > +	}
> > +
> > +	i2c_dev->membase = devm_ioremap_resource(&pdev->dev, &res);
> 
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	i2c_dev->membase = devm_ioremap_resource(&pdev->dev, res);
> 
> This way you can save yourself from parsing device tree again, one error 
> check and few lines of code. Remember that of_platform_populate() creates 
> all the resources of platform_devices based on reg and interrupts 
> properties, so there is no point in wasting this effort in drivers by 
> parsing them manually again.

Ah, right, I didn't thought about the double dt parsing. I'll switch to
platform_get_resource and platform_get_irq as you suggested.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
