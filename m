From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910
 family
Date: Mon, 20 Jul 2015 12:42:33 +0530
Message-ID: <55AC9F61.3090207@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>	<20150714113436.GD1517@katana> <55A4F434.9080407@linaro.org> <87d1zqimyc.fsf@belgarion.home> <55AC9E05.7040308@linaro.org> <55AC9E8E.8080708@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55AC9E8E.8080708-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Monday 20 July 2015 12:39 PM, Vaibhav Hiremath wrote:
>
>
> On Monday 20 July 2015 12:36 PM, Vaibhav Hiremath wrote:
>>
>>
>> On Saturday 18 July 2015 01:19 AM, Robert Jarzmik wrote:
>>> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>
>>>>> So, I applied patches 1-6 to for-next to make some progress.
>>>>>
>>>>> The others need more thought because of the bindings which shall be
>>>>> discussed replying to the patches in question.
>>>>>
>>>>> Thanks for the updated work with lots of proper references.
>>>>>
>>>>
>>>> OK, Thanks and no issues.
>>>>
>>>> Lets discuss more on the bindings.
>>>
>>> I made a simple try on my reference platform with the whole patchset.
>>> It oopses on a NULL dereference.
>>>
>>> The stack is in [1].
>>> I think it boils down to :
>>>   - i2c_pxa_do_sclk_adj()
>>>     - reg_ilcr = readl(_ILCR(i2c));
>>>
>>> I also think the faulty patch is :
>>>   - i2c: pxa: Add ILCR (tLow & tHigh) configuration support
>>>
>>> My case, an I2C master case, I'd like you to find the issue and fix it.
>>>
>>
>> Which is this reference platform?
>> Can you share few details -
>>
>>   - reference Platform?
>>   - DT file if you could
>>   - Boot log (if you could)
>>
>>
>> I am using pxa1928 based platform, and I do not see any issues.
>>
>
> Having said that,
> I see issues in the patch for non PXA910 platform, where
> i2c_pxa_do_sclk_adj() will be called unconditionally and obviously
> reg_ilcr and reg_wcr are not set.
>
> I will fix this and send the patch.
>

This should fix the issue -


hvaibhav@hvaibhav-ThinkPad-T440p:~/projects/mainline/linux$ git diff 
drivers/i2c/busses/i2c-pxa.c
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index e0aa087..9e372fc 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -590,6 +590,9 @@ static void i2c_pxa_do_sclk_adj(struct pxa_i2c *i2c)
  {
         unsigned int reg_ilcr;

+       if (!i2c->reg_ilcr)
+               return;
+
         reg_ilcr = readl(_ILCR(i2c));

         /* For standard/fast mode tlow and thigh counters are same */



If you are ok, I will re-spin the patch and submit.

Thanks,
Vaibhav
