From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Sat, 7 Jan 2017 03:24:40 +0200
Message-ID: <3748130b-5321-12eb-ec75-e2637dd9fc54@mleia.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
 <73246c4a-504c-52d7-dde4-970a45dca0bd@mleia.com>
 <CAHp75Ve87TE3y6hg1bMxSFAPVcY3wPifGuvtpXNhBw5-eOnPrg@mail.gmail.com>
 <b5788d1d-c951-0fc3-eed8-88457df1f27e@mleia.com>
 <CAHp75Ve7zNN3m1ngLGi-81mFehKzZG07mh5H2T5+_k-=jJqqNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Ve7zNN3m1ngLGi-81mFehKzZG07mh5H2T5+_k-=jJqqNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/07/2017 02:19 AM, Andy Shevchenko wrote:
> On Sat, Jan 7, 2017 at 1:43 AM, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org> wrote:
>> On 01/07/2017 12:45 AM, Andy Shevchenko wrote:
>>> On Fri, Jan 6, 2017 at 11:46 PM, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org> wrote:
>>>>> +     if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
>>>>
>>>> IS_BUILTIN(CONFIG_OF) looks excessive, check for non-NULL dev->of_node
>>>> should be sufficient.
>>>
>>> Sorry, but you missed the point.
>>> This will enable compile time optimization and basically be collapsed to no-op.
>>>
>>
>> Good point, do you plan to add more "IS_BUILTIN(CONFIG_OF)" checks all
>> over the code to reduce the size of the built image?
> 
> There is no black and white, don't be silly.
> 
>>
>>>>> +             }
>>>>> +     } else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
>>>>> +             dev_dbg(dev, "ACPI slave is not supported yet\n");
>>>>> +     }
>>>>
>>>> If so, then it might be better to drop else-if stub for now.
>>>
>>> Please, don't.
>>>
>>
>> Why do you ask for this stub to be added?
> 
> 1. Exactly the reason you asked above. Here is the code which has
> built differently on different platforms. x86 usually is not using
> CONFIG_OF, ARM doesn't ACPI (versus ARM64). Check GPIO library for
> existing examples.

>From the context by the stub I mean dev_dbg() in i2c_slave_mode_detect()
function, I don't see a connection to GPIO library, please clarify.

> 2. We might add that support later, but here is again, just no-op.
> 
> So, what is your strong argument here against that?
> 

When the support is ready for ACPI case, you'll remove the added
dev_dbg(), and I don't see a good point by adding it temporarily.

What is wrong with the approach of adding the ACPI case handling
branch when it is ready and remove any kind of stubs right now?

On ACPI platforms the function returns 'false' always, will the
function work correctly (= corresponding to its description) as is?

PS, if it is possible, please give up on arrogance in discussion.

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
