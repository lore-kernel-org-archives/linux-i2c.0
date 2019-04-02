From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
Date: Tue, 2 Apr 2019 10:57:33 -0700
Message-ID: <a1a7a9c9-be4e-c582-d0d5-feccba4022ab@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-8-ray.jui@broadcom.com> <20190402102733.GD2960@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402102733.GD2960@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 4/2/2019 3:27 AM, Wolfram Sang wrote:
> 
>> +#define IDM_CTRL_DIRECT_OFFSET       0x00
> 
> And this IDM thing is also never used outside of the I2C context? In
> other words, it also doesn't need a seperate DT node?
> 
> 

That is correct. Only in the I2C context in our use case.

>> +	/* indicates no slave mode support */
>> +	bool no_slave;
> 
> I would suggest to not use a flag, but to nullify the {un}reg_slave
> callbacks in probe depending on the type. That will also tell the
> i2c-core that slave functionality is not supported. And you can use if
> (!algo->reg_slave) as a flag, too.
> 

Yes. Great idea. I'll make the change and remove reg_slave.

>> +	iproc_i2c->type =
>> +		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);
> 
> No need to cast a void*.
> 

Yes will fix.

Thanks,

Ray
