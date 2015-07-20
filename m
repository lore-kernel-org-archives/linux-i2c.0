From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910 family
Date: Mon, 20 Jul 2015 22:30:55 +0200
Message-ID: <87si8ifu68.fsf@belgarion.home>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
	<20150714113436.GD1517@katana> <55A4F434.9080407@linaro.org>
	<87d1zqimyc.fsf@belgarion.home> <55AC9E05.7040308@linaro.org>
	<55AC9E8E.8080708@linaro.org> <55AC9F61.3090207@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55AC9F61.3090207-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (Vaibhav Hiremath's message of
	"Mon, 20 Jul 2015 12:42:33 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On Monday 20 July 2015 12:39 PM, Vaibhav Hiremath wrote:
>>
>>
>> On Monday 20 July 2015 12:36 PM, Vaibhav Hiremath wrote:
>>>
>>>
>>> On Saturday 18 July 2015 01:19 AM, Robert Jarzmik wrote:
>>>> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>>
>>>>>> So, I applied patches 1-6 to for-next to make some progress.
>>>>>>
>>>>>> The others need more thought because of the bindings which shall be
>>>>>> discussed replying to the patches in question.
>>>>>>
>>>>>> Thanks for the updated work with lots of proper references.
>>>>>>
>>>>>
>>>>> OK, Thanks and no issues.
>>>>>
>>>>> Lets discuss more on the bindings.
>>>>
>>>> I made a simple try on my reference platform with the whole patchset.
>>>> It oopses on a NULL dereference.
>>>>
>>>> The stack is in [1].
>>>> I think it boils down to :
>>>>   - i2c_pxa_do_sclk_adj()
>>>>     - reg_ilcr = readl(_ILCR(i2c));
>>>>
>>>> I also think the faulty patch is :
>>>>   - i2c: pxa: Add ILCR (tLow & tHigh) configuration support
>>>>
>>>> My case, an I2C master case, I'd like you to find the issue and fix it.
>>>>
>>>
>>> Which is this reference platform?
>>> Can you share few details -
>>>
>>>   - reference Platform?
Mitac Mio A701, pxa270.

>>>   - DT file if you could
None, ran in platform_data mode.

>>>   - Boot log (if you could)
You already found the issue, no need for that anymore.

>>> I am using pxa1928 based platform, and I do not see any issues.

>> Having said that,
>> I see issues in the patch for non PXA910 platform, where
>> i2c_pxa_do_sclk_adj() will be called unconditionally and obviously
>> reg_ilcr and reg_wcr are not set.
Yep.

>> I will fix this and send the patch.
>
> This should fix the issue -
Most probably yes.

> If you are ok, I will re-spin the patch and submit.
Yes, I'm ok, let's try the next iteration.

Cheers.

-- 
Robert
