From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v3 07/11] i2c: pxa: enable/disable i2c module across msg
 xfer
Date: Mon, 13 Jul 2015 22:11:07 +0530
Message-ID: <55A3EA23.8070009@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org> <1436210695-19159-8-git-send-email-vaibhav.hiremath@linaro.org> <20150710082419.GE1528@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150710082419.GE1528@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Friday 10 July 2015 01:54 PM, Wolfram Sang wrote:
> On Tue, Jul 07, 2015 at 12:54:51AM +0530, Vaibhav Hiremath wrote:
>> From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>
>> Enable i2c module/unit before transmission and disable when it finishes.
>>
>> why?
>> It's because the i2c bus may be distrubed if the slave device,
>> typically a touch, powers on.
>>
>> As we do not want to break slave mode support, this patch introduces
>> DT property to control disable of the I2C module after xfer in master mode
>> of operation.
>>
>> i2c-disable-after-xfer : If set, driver will disable I2C module after msg xfer
>
> Hmm, I am not sure this property fits into the "describing hardware"
> category. And we can't make the below behaviour default, because the
> udelay(100) will cause quite some latency.
>
>>

Sorry for delayed response,
I thought I responded to this, but when I was preparing for V4,
realized it that I did not :)

Yes, I agree that, this doesn't look like HW description. But I could
not find any other mechanism to handle this.
And also during V1 discussion, I did not get any objection to this
approach.


Thanks,
Vaibhav
