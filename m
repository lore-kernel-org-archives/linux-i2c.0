Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86826C7EE23
	for <linux-i2c@archiver.kernel.org>; Tue, 16 May 2023 02:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEPCjv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 15 May 2023 22:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPCju (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 15 May 2023 22:39:50 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1023102;
        Mon, 15 May 2023 19:39:45 -0700 (PDT)
X-QQ-mid: Yeas43t1684204734t839t48313
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.228.151])
X-QQ-SSF: 00400000000000F0FNF000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6361813060171089198
To:     <andy.shevchenko@gmail.com>
Cc:     <netdev@vger.kernel.org>, <jarkko.nikula@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>,
        <mika.westerberg@linux.intel.com>, <jsd@semihalf.com>,
        <Jose.Abreu@synopsys.com>, <andrew@lunn.ch>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <linux-i2c@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <mengyuanlou@net-swift.com>
References: <20230515063200.301026-1-jiawenwu@trustnetic.com> <20230515063200.301026-7-jiawenwu@trustnetic.com> <ZGH-fRzbGd_eCASk@surfacebook>
In-Reply-To: <ZGH-fRzbGd_eCASk@surfacebook>
Subject: RE: [PATCH net-next v8 6/9] net: txgbe: Support GPIO to SFP socket
Date:   Tue, 16 May 2023 10:38:53 +0800
Message-ID: <00cd01d9879f$8e444950$aaccdbf0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHvj8QD3pC+6Aq9H9h6P1+q5LrHRgMH5FTyAkITzACvBcuB4A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

> > +static int txgbe_gpio_init(struct txgbe *txgbe)
> > +{
> > +	struct gpio_irq_chip *girq;
> > +	struct wx *wx = txgbe->wx;
> > +	struct gpio_chip *gc;
> > +	struct device *dev;
> > +	int ret;
> 
> > +	dev = &wx->pdev->dev;
> 
> This can be united with the defintion above.
> 
> 	struct device *dev = &wx->pdev->dev;
> 

This is a question that I often run into, when I want to keep this order,
i.e. lines longest to shortest, but the line of the pointer which get later
is longer. For this example:

	struct wx *wx = txgbe->wx;
	struct device *dev = &wx->pdev->dev;

should I split the line, or put the long line abruptly there?

> > +	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
> > +	if (!gc)
> > +		return -ENOMEM;
> > +
> > +	gc->label = devm_kasprintf(dev, GFP_KERNEL, "txgbe_gpio-%x",
> > +				   (wx->pdev->bus->number << 8) | wx->pdev->devfn);
> > +	gc->base = -1;
> > +	gc->ngpio = 6;
> > +	gc->owner = THIS_MODULE;
> > +	gc->parent = dev;
> > +	gc->fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_GPIO]);
> 
> Looking at the I²C case, I'm wondering if gpio-regmap can be used for this piece.

I can access this GPIO region directly, do I really need to use regmap?
 

