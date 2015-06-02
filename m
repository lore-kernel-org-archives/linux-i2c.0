From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/12] i2c: pxa: Add support for pxa910/988 & new configuration
 features
Date: Tue, 02 Jun 2015 10:31:38 +0530
Message-ID: <556D38B2.2030704@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org> <1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org> <4edfb7fe9edf4800e73c86a258fe4fd1@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4edfb7fe9edf4800e73c86a258fe4fd1-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Monday 01 June 2015 05:43 AM, Wolfram Sang wrote:
> On 2015-05-28 22:03, Vaibhav Hiremath wrote:
>> From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>
>> TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
>> of standard & fast mode in pxa910/988; so this patch adds these two new
>> entries to "struct pxa_reg_layout" and "struct pxa_i2c" and also adds two
>> new DT properties to take configuration value for the same.
>
> Mapping registers 1:1 to DT is nearly always wrong. We have some generic
> bindings for SCL/SDA tweaking. Check
> Documentation/devicetree/bindings/i2c/i2c-designware.txt for them and if
> they match your needs. (Yes, they should be in a more generic place).
>
>


Thanks for your suggestion.

Let me check above documentation.

Thanks,
Vaibhav
