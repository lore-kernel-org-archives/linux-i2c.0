Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6487FC77B7F
	for <linux-i2c@archiver.kernel.org>; Fri, 19 May 2023 13:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjESNY6 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 19 May 2023 09:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjESNY5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 19 May 2023 09:24:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8230CE;
        Fri, 19 May 2023 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yLx9VzoDWbBqJmTZ++/Rgv4qWRRHxJCH7fo4Hi8SvFM=; b=Z9H4TKxWGRt9jxCZOoCjFNBp5N
        6fDon5lgZx72hAYHl5dnnHyXNzBpvCT2wRoCsSr6RmQZAEIElG7ZcFHNGSnEGtmxSJCMvuDsWFg6L
        RBh8nbRF0ZQXJEsm160RdvcFON9Q2rnVSjYdKo12qO+GV47MR76B5Bt4K0zWLP/aQcXw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q0068-00DKOH-CK; Fri, 19 May 2023 15:24:44 +0200
Date:   Fri, 19 May 2023 15:24:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     'Andy Shevchenko' <andy.shevchenko@gmail.com>,
        netdev@vger.kernel.org, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        jsd@semihalf.com, Jose.Abreu@synopsys.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-i2c@vger.kernel.org,
        linux-gpio@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v8 6/9] net: txgbe: Support GPIO to SFP socket
Message-ID: <3abf6e14-7029-4a52-a360-353870a9906a@lunn.ch>
References: <20230515063200.301026-1-jiawenwu@trustnetic.com>
 <20230515063200.301026-7-jiawenwu@trustnetic.com>
 <ZGH-fRzbGd_eCASk@surfacebook>
 <00cd01d9879f$8e444950$aaccdbf0$@trustnetic.com>
 <CAHp75VdthEZL6GvT5Q=f7rbcDfA5XX=7-VLfVz1kZmBFem_eCA@mail.gmail.com>
 <016701d9886a$f9b415a0$ed1c40e0$@trustnetic.com>
 <90ef7fb8-feac-4288-98e9-6e67cd38cdf1@lunn.ch>
 <025b01d9897e$d8894660$899bd320$@trustnetic.com>
 <1e1615b3-566c-490c-8b1a-78f5521ca0b0@lunn.ch>
 <02ad01d98a2b$4cd080e0$e67182a0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ad01d98a2b$4cd080e0$e67182a0$@trustnetic.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

> It's true for the problem of name, but there is another problem. SFP driver has
> successfully got gpio_desc, then it failed to get gpio_irq from gpio_desc (with error
> return -517). I traced the function gpiod_to_irq():

-517 is a number you learn after a while. -EPROBE_DEFFER. So the GPIO
controller is not fully ready when the SFP driver tries to use it.

I guess this is the missing upstream interrupt. You need to get the
order correct:

Register the MAC interrupt controller
Instantiate the regmap-gpio controller
Instantiate the I2C bus master
Instantiate the SPF devices
Instantiate PHYLINK.

	Andrew
