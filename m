From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v5 5/5] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
Date: Sun, 09 Aug 2015 22:23:30 +0530
Message-ID: <55C7858A.5080308@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>	<1437482466-16126-6-git-send-email-vaibhav.hiremath@linaro.org>	<55C1CE8E.9000601@linaro.org> <87bnegk632.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bnegk632.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, "Jett.Zhou" <jtzhou@marvell.com>, Yi Zhang <yizhang@marvell.com>
List-Id: linux-i2c@vger.kernel.org



On Sunday 09 August 2015 05:48 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> Robert,
>>
>> It would be helpful if you can test this patch-series and confirm that
>> it now fixes the NULL pointer deference issue.
> Tested, it works on pxa27x in master mode, in non-DT mode.
>
> For all non-DT patches, you can add my :
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>

Thanks Robert,

Wolfram,
Request you to please take a look at this series.
We can have discussion on DT properties as well.

Thanks,
Vaibhav
