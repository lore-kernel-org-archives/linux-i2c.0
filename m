From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is
 called
Date: Thu, 3 May 2018 11:26:48 -0500
Message-ID: <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



On 05/02/2018 12:48 AM, Baolin Wang wrote:
> On 2 May 2018 at 13:23, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>>> We should maybe handle this in the core somewhen, though. Or?
>>>
>>> Thanks. Yes, It will more helpful if we can handle this in the i2c core.
>>
>> To understand the issue better: which kind of devices in your system
>> still send I2C transfers when the system is going to suspend? Do you
>> know?
> 
> Now we found the touch screen device will trigger I2C transfers when
> the system is going to suspend.
> 

And you have to fix it (touch screen) - not your i2c driver. Otherwise, you can get
situation when set of I2C transfers (executed from some kthread/work/threaded_irq/..)
will be just interrupted in the middle - usual behavior after this is (I2C timeout) [and/or
not-functional I2C client device [and/or I2C bus stuck (worst case)].

In case, somebody is trying to access I2C after .suspend_noirq() stage I2C bus driver 
should produce big fat warning and, most probably, abort suspend.
Above, in general, can be part of I2C core functionality.

-- 
regards,
-grygorii
