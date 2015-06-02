From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/12] i2c: pxa: enable/disable i2c module across msg
 xfer
Date: Tue, 02 Jun 2015 22:29:23 +0530
Message-ID: <556DE0EB.1010609@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org> <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org> <20150528132312.GC2067@n2100.arm.linux.org.uk> <556DDF43.4050804@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <556DDF43.4050804-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Tuesday 02 June 2015 10:22 PM, Vaibhav Hiremath wrote:
>
>
> On Thursday 28 May 2015 06:53 PM, Russell King - ARM Linux wrote:
>> On Thu, May 28, 2015 at 06:33:44PM +0530, Vaibhav Hiremath wrote:
>>> From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>>
>>> Enable i2c module/unit before transmission and disable when it finishes.
>>>
>>> why?
>>> It's because the i2c bus may be distrubed if the slave device,
>>> typically a touch, powers on.
>>
>> "disturbed"
>>
>> I'd recommend that this is a DT property - not every platform is going to
>> want this, and as there is rudimentary I2C slave support in this driver,
>> this change breaks that.
>>
>
> I would take it as two different comments here, and I believe you also
> meant same,
>
> 1. Not breaking I2C slave support
>
> Not sure whether enabling/disabling module in ISR would suffice here.
> To be specific, in the functions i2c_pxa_slave_start() &
> i2c_pxa_slave_stop()
>
>

Please ignore this option, as enable is important to generate interrupt
on slave start.

I will add DT property with clear note on SLAVE support issue, so that
it can be disabled and SLAVE support should work as is.

Thanks,
Vaibhav
