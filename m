From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910
 family
Date: Mon, 20 Jul 2015 12:39:02 +0530
Message-ID: <55AC9E8E.8080708@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>	<20150714113436.GD1517@katana> <55A4F434.9080407@linaro.org> <87d1zqimyc.fsf@belgarion.home> <55AC9E05.7040308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AC9E05.7040308@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, robh+dt@kernel.org, yizhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On Monday 20 July 2015 12:36 PM, Vaibhav Hiremath wrote:
>
>
> On Saturday 18 July 2015 01:19 AM, Robert Jarzmik wrote:
>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>>
>>>> So, I applied patches 1-6 to for-next to make some progress.
>>>>
>>>> The others need more thought because of the bindings which shall be
>>>> discussed replying to the patches in question.
>>>>
>>>> Thanks for the updated work with lots of proper references.
>>>>
>>>
>>> OK, Thanks and no issues.
>>>
>>> Lets discuss more on the bindings.
>>
>> I made a simple try on my reference platform with the whole patchset.
>> It oopses on a NULL dereference.
>>
>> The stack is in [1].
>> I think it boils down to :
>>   - i2c_pxa_do_sclk_adj()
>>     - reg_ilcr = readl(_ILCR(i2c));
>>
>> I also think the faulty patch is :
>>   - i2c: pxa: Add ILCR (tLow & tHigh) configuration support
>>
>> My case, an I2C master case, I'd like you to find the issue and fix it.
>>
>
> Which is this reference platform?
> Can you share few details -
>
>   - reference Platform?
>   - DT file if you could
>   - Boot log (if you could)
>
>
> I am using pxa1928 based platform, and I do not see any issues.
>

Having said that,
I see issues in the patch for non PXA910 platform, where
i2c_pxa_do_sclk_adj() will be called unconditionally and obviously
reg_ilcr and reg_wcr are not set.

I will fix this and send the patch.

Thanks,
Vaibhav
