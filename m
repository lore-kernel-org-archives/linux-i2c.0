From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c
 master mode reset
Date: Fri, 10 Jul 2015 19:55:31 +0530
Message-ID: <559FD5DB.9030308@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org> <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org> <20150710081148.GB1528@katana> <559FBCD3.4050402@linaro.org> <20150710141440.GA6594@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150710141440.GA6594@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Friday 10 July 2015 07:44 PM, Wolfram Sang wrote:
> On Fri, Jul 10, 2015 at 06:08:43PM +0530, Vaibhav Hiremath wrote:
>>
>>
>> On Friday 10 July 2015 01:41 PM, Wolfram Sang wrote:
>>> On Tue, Jul 07, 2015 at 12:54:46AM +0530, Vaibhav Hiremath wrote:
>>>> Normally i2c controller works as master, so slave addr is not needed, or it
>>>> will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
>>>> the same i2c address with controller.
>>>
>>> Just to make sure: Does it? As I read the code, slave interrupts are
>>> enabled later only when slave mode is selected? Is that a HW bug? And if
>>> so, can't the code just be moved into this #ifdef block later?
>>>
>>
>> Yes we could, infact I thought about it;
>> but I would break recommended sequence here.
>
> And did you set the "own slave address" to a value which one of your
> existing i2c slaves also has (without enabling slave mode)? Did it
> disturb communication?
>

Since slave and master mode are mutual exclusive,
I did not try this.

But I can try.

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
