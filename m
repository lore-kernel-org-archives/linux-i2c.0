From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v5 5/8] i2c: i2c-cbus-gpio: Add vendor prefix to retu node
 in example
Date: Wed, 19 Apr 2017 15:13:19 -0400
Message-ID: <fc8fb064-8fda-d42d-036f-522964b72973@osg.samsung.com>
References: <20170412172800.23035-1-javier@osg.samsung.com>
 <20170412172800.23035-6-javier@osg.samsung.com>
 <20170419185113.msqhjm7fzqfeyjlk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:60859
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S969240AbdDSTN2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 19 Apr 2017 15:13:28 -0400
In-Reply-To: <20170419185113.msqhjm7fzqfeyjlk@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Hello Wolfram,

On 04/19/2017 02:51 PM, Wolfram Sang wrote:
> On Wed, Apr 12, 2017 at 02:27:56PM -0300, Javier Martinez Canillas wrote:
>> The example contains a device node for a retu device, but
>> its compatible string doesn't have a vendor prefix.
>>
>> While being there, drop the -mfd suffix since isn't correct.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Wouldn't it be nice if we fix the driver also so it actually matches the
> below compatible? I can't find such a change in linux-next.
> 

[snip]

>>  
>> -	retu-mfd: retu@1 {
>> -		compatible = "retu-mfd";
>> +	retu: retu@1 {
>> +		compatible = "nokia,retu";
>>  		reg = <0x1>;
>>  	};

You mean having a "nokia,retu" entry in a OF table?

That's done by patch 3/8 in this series:

http://www.spinics.net/lists/devicetree/msg173145.html

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
