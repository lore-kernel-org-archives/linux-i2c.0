From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v10 1/6] i2c: designware: Cleaning and comment style
 fixes.
Date: Fri, 9 Jun 2017 07:12:30 +0200
Message-ID: <5bc3077b-2e4c-eb27-bca1-b7cbfc2dec01@axentia.se>
References: <cover.1496942505.git.lolivei@synopsys.com>
 <4fb5f66dafc24e3213aaa8fc93fa12fecb6d6aa1.1496942505.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0110.outbound.protection.outlook.com ([104.47.0.110]:35616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751084AbdFIFMl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 9 Jun 2017 01:12:41 -0400
In-Reply-To: <4fb5f66dafc24e3213aaa8fc93fa12fecb6d6aa1.1496942505.git.lolivei@synopsys.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 2017-06-08 19:36, Luis Oliveira wrote:
> complicated to review. The work here won't bring any additional work to
> backported fixes because is just style and reordering.

I challenge that. If there is an old bug that existed before this patch
that is fixed in the future after this patch has been applied, it might
very well be hard_er_ to backport that fix to a point before this patch
has been applied. So, what do you mean?

> @@ -984,12 +984,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>  	}
>  
>  	i2c_dw_disable_int(dev);
> -	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, irq_flags,
> +	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr, irq_flags,
>  			     dev_name(dev->dev), dev);

Two extra spaces needed to align with the opening bracket.

Cheers,
peda
