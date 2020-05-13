Return-Path: <SRS0=yjSc=63=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF99C2D0FA
	for <linux-i2c@archiver.kernel.org>; Wed, 13 May 2020 09:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A6923127
	for <linux-i2c@archiver.kernel.org>; Wed, 13 May 2020 09:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Os/ZcSdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgEMJ3U (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 13 May 2020 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgEMJ3T (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 13 May 2020 05:29:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A91C061A0C;
        Wed, 13 May 2020 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S1EKebOmxklJ89iEdCA6FkHkRp5HPs448bB2B6Evm0I=; b=Os/ZcSdgPw4delhE0F4Emd2x2
        43Y/EB85BrZZZqgPzvLWWCNhSng9hu+4jFq2etztt85v+AXIYt3rJyRl+gxbD1gt8gtq8QPa5lkoH
        xPIJdrFk8m7LziQsOkDHo2QaRJlTU9UF4VhMw9Tm7PA8UjMzqnVjj57Md4Zzy/L2xyoD6Canbai7p
        Lg7wUefFGMNd9k1eIwjzbGAy2zp8acaP2gdqwaWYXnX+AY1Cbsl6ifKKjB6JgZ0Q/ZGykbp4BNSHI
        BvIQ/fofTz4IngWTBFcVYFOTHhsiW7Z4ry/1a3eqFIpe+4oj3CO7nSR8xe4ntUFV4rzBbn6f1wPbp
        E0nJ6SkGQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:39690)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jYnhQ-00041Y-Al; Wed, 13 May 2020 10:29:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jYnhO-0007du-CI; Wed, 13 May 2020 10:29:10 +0100
Date:   Wed, 13 May 2020 10:29:10 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH 1/2] i2c: pxa: implement generic i2c bus recovery
Message-ID: <20200513092910.GF1551@shell.armlinux.org.uk>
References: <20200506094001.GP1551@shell.armlinux.org.uk>
 <E1jWGXX-0000Yx-UL@rmk-PC.armlinux.org.uk>
 <20200506140054.GG224913@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506140054.GG224913@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, May 06, 2020 at 04:00:54PM +0200, Andrew Lunn wrote:
> On Wed, May 06, 2020 at 10:40:31AM +0100, Russell King wrote:
> > Implement generic GPIO-based I2C bus recovery for the PXA I2C driver.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/i2c/busses/i2c-pxa.c | 176 +++++++++++++++++++++++++++++++----
> >  1 file changed, 159 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> > index 0e194d6cd1b5..da15ab2a519e 100644
> > --- a/drivers/i2c/busses/i2c-pxa.c
> > +++ b/drivers/i2c/busses/i2c-pxa.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > @@ -28,6 +29,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/platform_data/i2c-pxa.h>
> >  #include <linux/slab.h>
> > @@ -260,6 +262,11 @@ struct pxa_i2c {
> >  	bool			highmode_enter;
> >  	u32			fm_mask;
> >  	u32			hs_mask;
> > +
> > +	struct i2c_bus_recovery_info recovery;
> > +	struct pinctrl		*pinctrl;
> > +	struct pinctrl_state	*pinctrl_default;
> > +	struct pinctrl_state	*pinctrl_recovery;
> >  };
> >  
> >  #define _IBMR(i2c)	((i2c)->reg_ibmr)
> > @@ -559,13 +566,8 @@ static void i2c_pxa_set_slave(struct pxa_i2c *i2c, int errcode)
> >  #define i2c_pxa_set_slave(i2c, err)	do { } while (0)
> >  #endif
> >  
> > -static void i2c_pxa_reset(struct pxa_i2c *i2c)
> > +static void i2c_pxa_do_reset(struct pxa_i2c *i2c)
> >  {
> > -	pr_debug("Resetting I2C Controller Unit\n");
> > -
> > -	/* abort any transfer currently under way */
> > -	i2c_pxa_abort(i2c);
> > -
> >  	/* reset according to 9.8 */
> >  	writel(ICR_UR, _ICR(i2c));
> >  	writel(I2C_ISR_INIT, _ISR(i2c));
> > @@ -584,12 +586,25 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
> >  #endif
> >  
> >  	i2c_pxa_set_slave(i2c, 0);
> > +}
> >  
> > +static void i2c_pxa_enable(struct pxa_i2c *i2c)
> > +{
> >  	/* enable unit */
> >  	writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
> >  	udelay(100);
> >  }
> >  
> > +static void i2c_pxa_reset(struct pxa_i2c *i2c)
> > +{
> > +	pr_debug("Resetting I2C Controller Unit\n");
> 
> Hi Russell
> 
> I know you are just moving code around, but maybe pr_debug() could be
> cleaned up to dev_debug()? 

Yes, but I don't want to add irrelevant changes into this; changing
the way the driver prints stuff wouldn't be part of adding recovery
support, and would likely get review comments suggesting it should
be a separate patch.

> > +	/*
> > +	 * Claiming GPIOs can change the pinmux state, which confuses the
> > +	 * pinctrl since since pinctrl's idea of the current setting is
> 
> since since
> 
> I don't know too much about this hardware, but for what it is worth,
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
