From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: at91: use an id table for SoC dependent parameters
Date: Fri, 31 Aug 2012 16:51:44 +0200
Message-ID: <5040CF80.8060201@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com> <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com> <20120831142944.GA23867@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120831142944.GA23867-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/31/2012 04:29 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 11:21 Fri 31 Aug     , ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
>> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>
>> Use the id_table to store configuration structures which are depending on
>> SoC.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/mach-at91/at91rm9200.c          |  2 +-
>>  arch/arm/mach-at91/at91rm9200_devices.c  | 11 +----
>>  arch/arm/mach-at91/at91sam9260.c         |  3 +-
>>  arch/arm/mach-at91/at91sam9260_devices.c |  8 ++-
>>  arch/arm/mach-at91/at91sam9261.c         |  3 +-
>>  arch/arm/mach-at91/at91sam9261_devices.c | 17 +++----
>>  arch/arm/mach-at91/at91sam9263.c         |  2 +-
>>  arch/arm/mach-at91/at91sam9263_devices.c |  2 +-
>>  arch/arm/mach-at91/at91sam9g45.c         |  4 +-
>>  arch/arm/mach-at91/at91sam9g45_devices.c |  4 +-
>>  arch/arm/mach-at91/at91sam9rl.c          |  4 +-
>>  arch/arm/mach-at91/at91sam9rl_devices.c  |  2 +-
>>  drivers/i2c/busses/i2c-at91.c            | 85 +++++++++++++++++++++++++-------
>>  13 files changed, 95 insertions(+), 52 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
>> index f2112f9..0bc91e5 100644
>> --- a/arch/arm/mach-at91/at91rm9200.c
>> +++ b/arch/arm/mach-at91/at91rm9200.c
>> @@ -187,7 +187,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>>  	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
>>  	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
>>  	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
>> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
>> +	CLKDEV_CON_DEV_ID(NULL, "at91rm9200_i2c", &twi_clk),
> use i2c-xxx as on other drivers
> 
> and I do not like to have platform_device_id

Me, I like it and find this implementation very elegant.

> as we need to touch the driver to add a new soc

So what? We still keep the compatibility if the new SoC has it
compatibility assured with previous revision: there is nothing to modify.

> please use platform data

No, it does not have to be exposed to the user: these data are highly
dependent on the actual hardware (IP revision in fact). So, no need to
mess with platform data.

So I will acknowledge Ludo's patches.

Bye,
-- 
Nicolas Ferre
