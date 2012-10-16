From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: change id to let i2c-at91 work
Date: Tue, 16 Oct 2012 11:13:14 +0800
Message-ID: <507CD0CA.9010006@atmel.com>
References: <1350293428-24551-1-git-send-email-voice.shen@atmel.com> <1350293428-24551-3-git-send-email-voice.shen@atmel.com> <20121015150244.GZ12801@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121015150244.GZ12801-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi J,

On 10/15/2012 23:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:30 Mon 15 Oct     , Bo Shen wrote:
>> The i2c core driver will turn the platform device ID to busnum
>> When using platfrom device ID as -1, it means dynamically assigned
>> the busnum. When writing code, we need to make sure the busnum,
>> and call i2c_register_board_info(int busnum, ...) to register device
>> if using -1, we do not know the value of busnum
>> 	
>> In order to solve this issue, set the platform device ID as a fix number
>> Here using 0 to match the busnum used in i2c_regsiter_board_info()
>>
>> Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>> ---
>
> can you check when this append for the first time to schedule a patch for stable too

OK. I will resend it and add linux stable into the cc list.

Thanks.

BRs,
Bo Shen

> Best Regards,
> J.
>
