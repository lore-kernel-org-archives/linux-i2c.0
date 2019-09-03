From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v1 1/1] i2c: iproc: Add i2c repeated start capability
Date: Tue, 3 Sep 2019 16:11:16 -0700
Message-ID: <540c4e2d-0dd5-5260-30b2-e1589b279d71@broadcom.com>
References: <1565150941-27297-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190830125626.GC2870@ninjato>
 <3e70fa7e-de13-4edd-2e17-b7c56e91d220@broadcom.com>
 <20190831094940.GA1138@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831094940.GA1138@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Lori Hikichi <lori.hikichi@broadcom.com>, Icarus Chau <icarus.chau@broadcom.com>, Shivaraj Shetty <sshetty1@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 8/31/19 2:49 AM, Wolfram Sang wrote:
> Hi Ray,
> 
>>> With all the limitations in place, I wonder if it might be easier to
>>> implement an smbus_xfer callback instead? What is left that makes this
>>> controller more than SMBus and real I2C?
>>>
>>
>> Right. But what is the implication of using smbus_xfer instead of
>> master_xfer in our driver?
>>
>> Does it mean it will break existing functions of the i2c app that our
>> customers developed based on i2cdev (e.g., I2C_RDWR)?
> 
> If the customers uses I2C_RDWR (and it cannot be mapped to i2c_smbus_*
> calls) then this is an indication that there is some I2C functionality
> left which the HW can provide. I'd be interested which one, though.
> 
>>
>> 1) Does
> 
> Maybe you wanted to describe it here and it got accidently cut off? >

I think you are right that the controller does not seem to support 
additional I2C features in addition to SMBUS.

However, my concern of switching to the smbus_xfer API is:

1) Some customers might have used I2C_RDWR based API from i2cdev. 
Changing from master_xfer to smbus_xfer may break the existing 
applications that are already developed.

2) The sound subsystem I2C regmap based implementation seems to be using 
i2c_ based API instead of smbus_ based API. Does this mean this will 
also break most of the audio codec drivers with I2C regmap API based usage?

Thanks,

Ray

> Regards,
> 
>     Wolfram
> 
