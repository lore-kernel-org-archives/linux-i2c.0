Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32090C6FD18
	for <linux-i2c@archiver.kernel.org>; Tue, 28 Mar 2023 13:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjC1NMe (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjC1NMc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Mar 2023 09:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B40F107
        for <linux-i2c@vger.kernel.org>; Tue, 28 Mar 2023 06:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D77BD61775
        for <linux-i2c@vger.kernel.org>; Tue, 28 Mar 2023 13:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87623C433EF;
        Tue, 28 Mar 2023 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680009142;
        bh=syclwcK/oT0pSom8NZFtmAdR8n43l8GNIE7YH56c9w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DM0XoB3KQaJfPLp3jiKz+cfjQWvr72eRkBryHiXwIgMq9QAObJ8b5ZBrKxdsPYopW
         7NId+xloccQjYxKmgd2LZLICdSoPCHrWRVKgBgcjBe1sYjK4nFzbgTzRJIfRRfRdPu
         Iw1gej7xeMbyfGvBkptrrrCBcSJMqwMNhIL1ViYiLt8GrxNhru3ZhN8MxMZt9Sbma+
         A6WeUDFduyIx8+RPIJwQ9KG3s1gOAdKNXsXl4T7HF/5fIfnGRwm1LBAx/sNeJ4RNC8
         kXt+ZhOfDFM+rP++NYfpkhcaXCo7QRT42dNgQY+nxVXle2Y0FczHBsoQOi30Ix7mcB
         Q+kEcdj9JdCBQ==
Date:   Tue, 28 Mar 2023 15:12:19 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     jk@codeconstruct.com.au, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v7 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
Message-ID: <20230328131219.khfd2jz3z4es5bzy@intel.intel>
References: <20230327092524.3916389-1-ryan_chen@aspeedtech.com>
 <20230327092524.3916389-3-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327092524.3916389-3-ryan_chen@aspeedtech.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Ryan,

[...]

> +	ret = of_property_read_u32(dev->of_node,
> +							"i2c-scl-clk-low-timeout-us",
> +							&i2c_bus->timeout);

in your v6 patch this was a boolean value. If you need to keep it
boolean you have the "i2c-scl-has-clk-low-timeout".

> +	if (ret < 0) {
> +		i2c_bus->timeout = 0;
> +	} else {
> +		/* i2c timeout counter: use base clk4 1Mhz
> +		 * per unit: 1/(1000/4096) = 4096us
> +		 */
> +		i2c_bus->timeout /= 4096;
> +	}

Can you please run checkpatch.pl before sending the patch?

[...]

> +	dev_info(dev, "%s [%d]: adapter [%d khz] mode [%d]\n",
> +		 dev->of_node->name, i2c_bus->adap.nr, i2c_bus->bus_frequency / 1000,
> +		 i2c_bus->mode);
> +
> +	return 0;
> +
> +	return ret;

can you also please do some cleanups before sending the patch?

Thanks,
Andi
