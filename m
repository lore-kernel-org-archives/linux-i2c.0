From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
Date: Wed, 25 Jul 2018 11:26:29 +0800
Message-ID: <4163910a-f37b-5987-ecc2-074cebda753b@electromag.com.au>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
 <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
 <20180717090920.zy6lkeqlcewhrfs5@ninjato>
 <b8d7c7aa-dbde-3037-4a1b-691bcf045131@electromag.com.au>
 <20180724072637.smhlrx4kpyh6hvwa@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724072637.smhlrx4kpyh6hvwa@ninjato>
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 24/07/2018 15:26, Wolfram Sang wrote:
> Hi Phil,
> 
>>> So, it is not possible to read SCL status then? Hmm, currently a working
>>> get_scl is required...
> ...
>>> Well, I don't know much about this IP core and how/where it is used. I
>>> just wonder what happens if another user comes along using an
>>> open-drain GPIO. Is that possible?
>>>
>>> I assume it is the same with SDA? Non open-drain? Output only?
>>>
>>
>> Just had a closer look at how it's setup here.
>> Maybe the following helps.
> 
> Thanks for the detailed explanation. I am just afraid it is a litle too
> detailed for me. I am not sure if I can read it correctly:
> 
> When you read the SCL/SDA GPIO, does it return the true state of the
> SCL/SDA line or does it just reflect the value it was set to output?
Yes it returns the true state of the output pin.
I admit it's a bit odd from the classic GPIO point of view.

> 
>> There's no concept of HiZ internally in the FPGA.
> 
> Which probably means SDA is to be treated the same as SCL -> push/pull.
Yes. They're both driven push/pull, but the try state of the line is available.

> 
>> If there was some kinda of OpenDrain gpio driver that modelled a FET
>> driven by a push pull GPIO I guess it could be made to work.
> 
> Still, that sounds quite unlikely to me, so we can for now assume that
> all designware users will have push/pull?
I know of one other doing the same thing with the core in the Altera SocFPGA platform.
As they put me on to this solution for doing the recovery when the i2c was routed thru the SOC's fpga.

In other hard configurations they may have a 'proper' GPIO available that needs to be OpenDrain.



> 
> Disclaimer: I have zero experience with this core, I don't know how hard
> it is to modify or which versions are out there.
> 


-- 
Regards
Phil Reid
