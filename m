Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B5C77B7C
	for <linux-i2c@archiver.kernel.org>; Thu, 11 May 2023 12:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjEKMjC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 11 May 2023 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjEKMjC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 11 May 2023 08:39:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58AE5D;
        Thu, 11 May 2023 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1l03jVhzSc8K+bqtlLwcVBBttDZZk3vsGUYwhQXaOIs=; b=Z8Y1fcozhlluNLRxuORx+lUMuA
        DB4RSZ/MYMzh6DK9fVtylMS40VGVQ2DcOvpSZU/+tFzwolr6xNWNX/r/KsW0XUVZgImH5mQOl5vz0
        nXc6BvOhg/IDssgrH7uXfkXdeOJ++iHKns5bmMn7EjC7xrx4Zam1WAcoxZsfEPmSG0nM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1px5ZL-00CYLU-16; Thu, 11 May 2023 14:38:51 +0200
Date:   Thu, 11 May 2023 14:38:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     netdev@vger.kernel.org, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        jsd@semihalf.com, Jose.Abreu@synopsys.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-i2c@vger.kernel.org,
        linux-gpio@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v7 6/9] net: txgbe: Support GPIO to SFP socket
Message-ID: <f9e0da51-6c55-4768-aa27-437bb7f19888@lunn.ch>
References: <20230509022734.148970-1-jiawenwu@trustnetic.com>
 <20230509022734.148970-7-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509022734.148970-7-jiawenwu@trustnetic.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

> +static int txgbe_gpio_set_type(struct irq_data *d, unsigned int type)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	struct wx *wx = gpiochip_get_data(gc);
> +	u32 level, polarity;
> +
> +	level = rd32(wx, WX_GPIO_INTTYPE_LEVEL);
> +	polarity = rd32(wx, WX_GPIO_POLARITY);
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_BOTH:
> +		level |= BIT(hwirq);
> +		break;
> +	case IRQ_TYPE_EDGE_RISING:
> +		level |= BIT(hwirq);
> +		polarity |= BIT(hwirq);
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		level |= BIT(hwirq);
> +		polarity &= ~BIT(hwirq);
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		level &= ~BIT(hwirq);
> +		polarity |= BIT(hwirq);
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		level &= ~BIT(hwirq);
> +		polarity &= ~BIT(hwirq);
> +		break;
> +	}

You have two configuration bits, level and polarity, yet handle 5
different types?

> +	wr32m(wx, WX_GPIO_INTEN, BIT(hwirq), BIT(hwirq));
> +	wr32(wx, WX_GPIO_INTTYPE_LEVEL, level);
> +	if (type != IRQ_TYPE_EDGE_BOTH)
> +		wr32(wx, WX_GPIO_POLARITY, polarity);

If we are interested in both edges, then polarity is meaningless. So i
can understand not writing it. But how does the hardware know polarity
should not be used?

       Andrew
