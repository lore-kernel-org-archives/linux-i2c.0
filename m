From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v10 1/6] i2c: designware: Cleaning and comment style
 fixes.
Date: Fri, 9 Jun 2017 10:57:12 +0200
Message-ID: <3276089c-58f0-d7de-d21e-3eccc94f830d@axentia.se>
References: <cover.1496942505.git.lolivei@synopsys.com>
 <4fb5f66dafc24e3213aaa8fc93fa12fecb6d6aa1.1496942505.git.lolivei@synopsys.com>
 <5bc3077b-2e4c-eb27-bca1-b7cbfc2dec01@axentia.se>
 <1496997489.22624.63.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0101.outbound.protection.outlook.com ([104.47.0.101]:63695
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751600AbdFII51 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 9 Jun 2017 04:57:27 -0400
In-Reply-To: <1496997489.22624.63.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On 2017-06-09 10:38, Andy Shevchenko wrote:
> On Fri, 2017-06-09 at 07:12 +0200, Peter Rosin wrote:
>> On 2017-06-08 19:36, Luis Oliveira wrote:
>>> @@ -984,12 +984,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>>>  	}
>>>  
>>>  	i2c_dw_disable_int(dev);
>>> -	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
>>> irq_flags,
>>> +	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
>>> irq_flags,
>>>  			     dev_name(dev->dev), dev);
>>
> 
>> Two extra spaces needed to align with the opening bracket.
> 
> It's a bikeshedding, though it looks like v11 is needed anyway (see
> kbuild bot complains), thus it might be addressed as well.
> 

Bikeshedding or not, checkpatch.pl --strict notifies about the issue
with:

CHECK: Alignment should match open parenthesis

Cheers,
peda
