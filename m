From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v5 2/5] i2c: pxa: enable/disable i2c module across msg
 xfer
Date: Wed, 05 Aug 2015 18:12:09 +0530
Message-ID: <55C204A1.3060206@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>	<1437482466-16126-3-git-send-email-vaibhav.hiremath@linaro.org> <CAKfKVtGzDjgHzy70aa0d2W=ROMcxVzerg-qpuB9e4PaGKPpMTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKfKVtGzDjgHzy70aa0d2W=ROMcxVzerg-qpuB9e4PaGKPpMTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Wednesday 05 August 2015 04:16 PM, Shubhrajyoti Datta wrote:
> hi ,
> On Tue, Jul 21, 2015 at 6:11 PM, Vaibhav Hiremath
> <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>
>> Enable i2c module/unit before transmission and disable when it
>> finishes.
>>
>> why?
>> It's because the i2c bus may be disturbed if the slave device,
>> typically a touch, powers on.
>
> Why should that be an issue?
> Is it an errata.
>

Not I am aware of.

> In which mode it is an issue slave / master or both?
>

since it talks about touch, I expect it to be master mode.

Thanks,
Vaibhav
