From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-V2 04/12] i2c: pxa: Reset i2c controller on timeout in
 interrupt and pio mode
Date: Fri, 03 Jul 2015 23:43:18 +0530
Message-ID: <5596D0BE.8070902@linaro.org>
References: <vaibhav.hiremath@linaro.org>	<1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>	<1434383399-2370-5-git-send-email-vaibhav.hiremath@linaro.org> <87fv55clcy.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fv55clcy.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Friday 03 July 2015 08:57 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
>> In case of timeout during msg xfer assert reset to
>> i2c controller for both interrupt and PIO mode of operation.
>>
>> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Split & merge patches into logical changes
>> and update the Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> I already said it previously, I'm against an unconditional reset in a timeout
> path. Make it a quirk or whatever, but in the current status, I'm against.
>
> The previous behavior looks correct to me : upon timeout, retry, no need to
> reset.
>

We still do return RETRY here, but also assert reset to I2C.

Anyway, lets revisit this again later. I will remove it in my next
version.

Thanks,
Vaibhav
