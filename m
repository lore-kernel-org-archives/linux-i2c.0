From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v1 1/1] i2c: iproc: Add i2c repeated start capability
Date: Fri, 30 Aug 2019 11:35:08 -0700
Message-ID: <3e70fa7e-de13-4edd-2e17-b7c56e91d220@broadcom.com>
References: <1565150941-27297-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190830125626.GC2870@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830125626.GC2870@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Lori Hikichi <lori.hikichi@broadcom.com>, Icarus Chau <icarus.chau@broadcom.com>, Shivaraj Shetty <sshetty1@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 8/30/19 5:56 AM, Wolfram Sang wrote:
> Hi everyone,
> 
>> +/*
>> + * If 'process_call' is true, then this is a multi-msg transfer that requires
>> + * a repeated start between the messages.
>> + * More specifically, it must be a write (reg) followed by a read (data).
>> + * The i2c quirks are set to enforce this rule.
>> + */
> 
> With all the limitations in place, I wonder if it might be easier to
> implement an smbus_xfer callback instead? What is left that makes this
> controller more than SMBus and real I2C?
> 

Right. But what is the implication of using smbus_xfer instead of 
master_xfer in our driver?

Does it mean it will break existing functions of the i2c app that our 
customers developed based on i2cdev (e.g., I2C_RDWR)?

1) Does
>> +	/* Process the read message if this is process call */
> 
> Also, the term "process call" here seriously sounds like SMBus.
> 
>> +		addr = msg->addr << 1 | 1;
> 
> addr = i2c_8bit_addr_from_msg(msg);
> 
>> +		u32 protocol;
> 
> Hmm, another SMBus terminology.
> 
> 
>> +	if (num > 2) {
>> +		dev_err(iproc_i2c->device,
>> +			"Only support up to 2 messages. Current msg count %d\n",
>> +			num);
>> +		return -EOPNOTSUPP;
>> +	}
> 
> With your quirks flags set, the core checks it for you.
> 
> Kind regards,
> 
>     Wolfram
> 
