From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
Date: Mon, 29 Sep 2014 15:43:16 +0530
Message-ID: <542930BC.4040806@gmail.com>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com> <54292F74.2030209@gmail.com> <20140929101319.GB1559@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140929101319.GB1559@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/29/2014 03:43 PM, Wolfram Sang wrote:
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> Error checking on *res*...?
>>
>> We should *return* on platform_get_resource() failure..
>>
>>> +	base = devm_ioremap_resource(&pdev->dev, res);
> Nope. devm_ioremap_resource does that.
>
Yes it will [1]. Thanks for the clarification.

[1]:http://lxr.free-electrons.com/source/lib/devres.c#L117

-- 
Regards,
Varka Bhadram.
