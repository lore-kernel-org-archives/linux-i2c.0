From: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 1/9] New drivers for MXC: add I2C support for MXC
Date: Wed, 25 Mar 2009 13:06:29 +0200
Message-ID: <49CA1035.4000906@gmail.com>
References: <49C9F337.4080102@gmail.com> <20090325105931.GC3029@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1257; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090325105931.GC3029-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> Hi Darius,
>
> this is not V5, is it? See below...Was there much rebasing needed for 2.6.29? Otherwise we could simply
> keep this one?
>
> http://article.gmane.org/gmane.linux.drivers.i2c/2962
>
>   
Please keep and merge new patch.

>> +
>> +	pdata = pdev->dev.platform_data;
>> +	if (!pdata) {
>> +		dev_err(&pdev->dev, "I2C driver needs platform data\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (pdata->init) {
>> +		ret = pdata->init(&pdev->dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>     
>
> For example, V5 stuff looked like this:
>
> 	pdata = pdev->dev.platform_data;
>
> 	if (pdata && pdata->init) {
> 		ret = pdata->init(&pdev->dev);
> 		if (ret)
> 			return ret;
> 	}
>
> which is better.

New one is better. Because one could not have anything to init in the board.
