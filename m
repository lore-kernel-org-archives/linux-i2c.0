From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Fri, 22 Nov 2013 16:09:46 +0100
Message-ID: <528F73BA.2080601@atmel.com>
References: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com> <20131122143350.GA7420@katana> <20131122145141.GB30749@ludovic.desroches@atmel.com> <20131122145835.GB7420@katana> <20131122150734.GC30749@ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131122150734.GC30749-tOglhBvtKaELqBSMlTbpHvU/3Eu2kcEP@public.gmane.org@atmel.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 22/11/2013 16:07, Ludovic Desroches :
> On Fri, Nov 22, 2013 at 03:58:35PM +0100, Wolfram Sang wrote:
>> On Fri, Nov 22, 2013 at 03:51:41PM +0100, Ludovic Desroches wrote:
>>> Hi Wolfram,
>>>
>>> On Fri, Nov 22, 2013 at 03:33:51PM +0100, Wolfram Sang wrote:
>>>> On Fri, Nov 22, 2013 at 03:07:08PM +0100, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
>>>>> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>>>>
>>>>> There are still I2C unexpected behaviors which are solved by reducing TWI
>>>>> internal frequency.
>>>>>
>>>>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> #3.10+
>>>>> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>>>
>>>> I think the commit message needs more details. Is this a true bugfix
>>>> because the real bus frequency was too high because of the wrong
>>>> divider? Is this a workaround which makes things work but will make the
>>>> bus frequency slower than it should be?
>>>
>>> This fix doesn't concern the i2c bus frequency, only the internal IP frequency.
>>>
>>> TWI has been validated at 66MHz. With some devices, transfer hangs during i2c
>>> frame transmission. This issue disappears when reducing the internal frequency
>>> of the IP. Maybe there is some oversampling on i2c signals.
>>> Unfortunately, I have no clear status about the root cause that's why
>>> the commit message was imprecise.
>>
>> This paragraph is a way better commit message IMO :)
>>
>
> Ok I'll update it.


Ludo, you can also add my:

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Bye,

> Thanks for the review Wolfram.
>
> Regards
>
> Ludovic
>
>


-- 
Nicolas Ferre
