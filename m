From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Tue, 17 Jan 2017 01:14:17 +0200
Message-ID: <f751ffbe-f9f8-c5bd-3b1a-2edd91152a78@mleia.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
 <73246c4a-504c-52d7-dde4-970a45dca0bd@mleia.com>
 <CAHp75Ve87TE3y6hg1bMxSFAPVcY3wPifGuvtpXNhBw5-eOnPrg@mail.gmail.com>
 <b5788d1d-c951-0fc3-eed8-88457df1f27e@mleia.com>
 <CAHp75Ve7zNN3m1ngLGi-81mFehKzZG07mh5H2T5+_k-=jJqqNA@mail.gmail.com>
 <3748130b-5321-12eb-ec75-e2637dd9fc54@mleia.com>
 <1484240482.2133.92.camel@linux.intel.com>
 <7fdf5d3c-d0ea-ec45-6b18-4573fff6dd11@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7fdf5d3c-d0ea-ec45-6b18-4573fff6dd11-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Luis,

On 01/16/2017 12:32 PM, Luis Oliveira wrote:
> On 12-Jan-17 17:01, Andy Shevchenko wrote:
>> On Sat, 2017-01-07 at 03:24 +0200, Vladimir Zapolskiy wrote:
>>> On 01/07/2017 02:19 AM, Andy Shevchenko wrote:
>>>> On Sat, Jan 7, 2017 at 1:43 AM, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
>>>> wrote:
>>>>> On 01/07/2017 12:45 AM, Andy Shevchenko wrote:
>>
>>>>>> +             }
>>>>>>>> +     } else if (IS_BUILTIN(CONFIG_ACPI) &&
>>>>>>>> ACPI_HANDLE(dev)) {
>>>>>>>> +             dev_dbg(dev, "ACPI slave is not supported
>>>>>>>> yet\n");
>>>>>>>> +     }
>>>>>>>
>>>>>>> If so, then it might be better to drop else-if stub for now.
>>>>>>
>>>>>> Please, don't.
>>>>>>
>>>>>
>>>>> Why do you ask for this stub to be added?
>>>>
>>>> 1. Exactly the reason you asked above. Here is the code which has
>>>> built differently on different platforms. x86 usually is not using
>>>> CONFIG_OF, ARM doesn't ACPI (versus ARM64). Check GPIO library for
>>>> existing examples.
>>>
>>> From the context by the stub I mean dev_dbg() in
>>> i2c_slave_mode_detect()
>>> function, I don't see a connection to GPIO library, please clarify.
>>
>> I agree that is not good proof for using IS_ENABLED/IS_BUILTIN macro.
> 
> I can prepare a V3 and remove it if that's the decision.
> 

from my review comments you may find that your v2 change contains a bug
plus it misses a minor but desirable code optimization. You may get more
review comments then, for example it is not obvious that on a platform
with both CONFIG_ACPI and CONFIG_OF enabled there should be an exclusive
selection of only one of two possible branches as in your code etc.

The discussed IS_BUILTIN() and dev_dbg() code chunks are other ones, for
both of them you may find my review comments and Andy's responses, it's
up to you as the author to make any updates or keep the code as is,
taking into account any expressed concerns and concerns about concerns
the maintainer will make a decision.

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
