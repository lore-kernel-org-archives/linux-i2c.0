From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910
 family
Date: Mon, 20 Jul 2015 12:36:45 +0530
Message-ID: <55AC9E05.7040308@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>	<20150714113436.GD1517@katana> <55A4F434.9080407@linaro.org> <87d1zqimyc.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87d1zqimyc.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Saturday 18 July 2015 01:19 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
>>> So, I applied patches 1-6 to for-next to make some progress.
>>>
>>> The others need more thought because of the bindings which shall be
>>> discussed replying to the patches in question.
>>>
>>> Thanks for the updated work with lots of proper references.
>>>
>>
>> OK, Thanks and no issues.
>>
>> Lets discuss more on the bindings.
>
> I made a simple try on my reference platform with the whole patchset.
> It oopses on a NULL dereference.
>
> The stack is in [1].
> I think it boils down to :
>   - i2c_pxa_do_sclk_adj()
>     - reg_ilcr = readl(_ILCR(i2c));
>
> I also think the faulty patch is :
>   - i2c: pxa: Add ILCR (tLow & tHigh) configuration support
>
> My case, an I2C master case, I'd like you to find the issue and fix it.
>

Which is this reference platform?
Can you share few details -

  - reference Platform?
  - DT file if you could
  - Boot log (if you could)


I am using pxa1928 based platform, and I do not see any issues.

Thanks,
Vaibhav
