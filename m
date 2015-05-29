From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] i2c: pxa: Reset i2c controller on timeout in interrupt
 and pio mode
Date: Sat, 30 May 2015 02:49:24 +0530
Message-ID: <5568D7DC.4060909@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-8-git-send-email-vaibhav.hiremath@linaro.org> <87r3pzxf1s.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r3pzxf1s.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Saturday 30 May 2015 02:43 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
>> In case of timeout during msg xfer assert reset to
>> i2c controller for both interrupt and PIO mode of operation.
>>
>> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Split & merge patches into logical changes
>> and update the Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> I have the same comment as before.
> I don't like a reset in the transfer path, especially in normal busy phases for
> slow I2C devices. A quirk as before.
>

Note that this assertion of reset in in case of timeout error.

Timeout error may be due to various reasons, and this is recovery
mechanism.

Thanks,
Vaibhav
