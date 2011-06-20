From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: correct the SYSC register offset for OMAP4
Date: Mon, 20 Jun 2011 21:21:47 +0530
Message-ID: <4DFF6C93.7090605@ti.com>
References: <1308561956-25103-1-git-send-email-shubhrajyoti@ti.com> <87aadc8qcg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87aadc8qcg.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 20 June 2011 09:09 PM, Kevin Hilman wrote:
> shubhrajyoti-l0cyMroinI0@public.gmane.org writes:
>
>> From: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>
>> The sysc offset is erroneous correct the offset.
>>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>
> Actally, a better fix for this problem is to completely remove SYSC
> register accesses for OMAP3+ platforms.  This is handled already at the
> hwmod layer.
>
> Also, please Cc linux-omap for OMAP changes.
Agree,
1. Currently the flag HWMOD_INIT_NO_RESET is there for OMAP4.
2. Currently the reset is there even in the error paths and hwmod takes 
care of it in init only.
3. I2C reset sequence is disable -> reset -> enable and poll. So it 
needs a .reset function in hwmod.

Anyways fixing it is in my plans till then thought of having it corrected.
> Kevin
>
>> ---
>>   drivers/i2c/busses/i2c-omap.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index d53cd61..cccec28 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -236,7 +236,7 @@ const static u8 reg_map_ip_v2[] = {
>>   	[OMAP_I2C_BUF_REG] = 0x94,
>>   	[OMAP_I2C_CNT_REG] = 0x98,
>>   	[OMAP_I2C_DATA_REG] = 0x9c,
>> -	[OMAP_I2C_SYSC_REG] = 0x20,
>> +	[OMAP_I2C_SYSC_REG] = 0x10,
>>   	[OMAP_I2C_CON_REG] = 0xa4,
>>   	[OMAP_I2C_OA_REG] = 0xa8,
>>   	[OMAP_I2C_SA_REG] = 0xac,
