From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v4 06/11] i2c:pxa: Use devm_ variants in probe function
Date: Tue, 14 Jul 2015 17:09:53 +0530
Message-ID: <55A4F509.6010009@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org> <1436859410-28878-7-git-send-email-vaibhav.hiremath@linaro.org> <20150714113556.GE1517@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150714113556.GE1517@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Tuesday 14 July 2015 05:05 PM, Wolfram Sang wrote:
>> +	i2c->reg_base = devm_ioremap_resource(&dev->dev, res);
>> +	if (IS_ERR(i2c->reg_base)) {
>> +		dev_err(&dev->dev, "failed to map resource: %ld\n",
>> +			PTR_ERR(i2c->reg_base));
>> +		return PTR_ERR(i2c->reg_base);
>> +	}
>
> One change I did when applying: removed this error message.
> devm_ioremap_resource prints out the errors it finds.
>

devm_ioremap_resource doesn't print return value.

So this additional error message would print one of, -EINVAL, -EBUSY
or -ENOMEM.

That was the reason I kept it.

If you feel it is not required, I am OK to remove it.

Thanks for the update, it certainly saved one more version :) .

Thanks,
Vaibhav
