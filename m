From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: change the id to let the i2c-gpio work
Date: Mon, 15 Oct 2012 16:26:36 +0800
Message-ID: <507BC8BC.8000608@atmel.com>
References: <1350034971-1050-1-git-send-email-voice.shen@atmel.com> <CAGhQ9VxRGQ8JAygxJreNDJY=tJ67yt2CM9NHvW3VyhjxooXuig@mail.gmail.com> <507B7066.4060802@atmel.com> <507BC57B.8050607@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <507BC57B.8050607-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Nicolas,

On 10/15/2012 16:12, Nicolas Ferre wrote:
> On 10/15/2012 04:09 AM, Bo Shen :
>> Hi Joachim Eastwood,
>>
>> On 10/13/2012 1:42, Joachim Eastwood wrote:
>>> Hi Bo Shen,
>>>
>>> On Fri, Oct 12, 2012 at 11:42 AM, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>>>> The i2c-gpio driver will turn the platform device ID to busnum.
>>>> When using platfrom device ID as -1, it means dynamically assigned
>>>> the busnum. When writing code, we need to make sure the busnum,
>>>> and call i2c_register_board_info(int busnum, ...) to register device
>>>> if using -1, we do not know the value of busnum.
>>>>
>>>> In order to solve this issue, set the platform device ID as a fix number
>>>> Here using 0 to match the busnum used in i2c_regsiter_board_info().
>>>
>>> I have been bitten by this myself on RM9200.
>>>
>>>> Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>> Change since v1
>>>>     Make the commit message more clear
>>>> ---
>>>>    arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
>>>
>>> This pattern exist in at91rm9200_devices.c, at91sam9261_devices.c,
>>> at91sam9263_devices.c and at91sam9rl_devices.c you might want to fix
>>> them as well.
>>
>> Thanks for your information.
>> After I test these boards, I will send patches to fix them, while not in
>> this patch.
>
> I am in favor of doing a comprehensive patch series that covers all
> aspects of this issue:
> - each boards
> - both i2c-gpio and i2c-at91 cases

May I need to submit this patch as a series? One patch for one board, 
and cover i2c-gpio and i2c-at91 cases.
e.g:
[patch 1/x] i2c: change id to let i2c-gpio work on at91rm200ek
[patch 2/x] i2c: change id to let i2c-gpio work on at91sam9261ek
...

or

Just one patch, cover all these boards and i2c-gpio and i2c-at91?

> Bye,
>
