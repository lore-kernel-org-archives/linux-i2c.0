From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
Date: Tue, 2 Apr 2019 18:10:52 -0700
Message-ID: <8a731837-b21b-c2ae-fe0f-3c8943b587e3@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-8-ray.jui@broadcom.com> <20190402102733.GD2960@kunai>
 <a1a7a9c9-be4e-c582-d0d5-feccba4022ab@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a1a7a9c9-be4e-c582-d0d5-feccba4022ab@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 4/2/2019 10:57 AM, Ray Jui wrote:
> 
> 
> On 4/2/2019 3:27 AM, Wolfram Sang wrote:

[...]

>>> +	iproc_i2c->type =
>>> +		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);
>>
>> No need to cast a void*.
>>

In fact, we do need to type cast here since 'iproc_i2c->type' is NOT a
pointer:

drivers/i2c/busses/i2c-bcm-iproc.c:870:18: error: incompatible types
when assigning to type ‘enum bcm_iproc_i2c_type’ from type ‘const void *’
  iproc_i2c->type = of_device_get_match_data(&pdev->dev);
                  ^
> 
> Yes will fix.
> 
> Thanks,
> 
> Ray
> 
