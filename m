From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Fri, 22 Nov 2013 16:11:01 +0100
Message-ID: <528F7405.9050901@atmel.com>
References: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com> <528F71BD.2080407@overkiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528F71BD.2080407-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: boris brezillon <b.brezillon-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 22/11/2013 16:01, boris brezillon :
> Hi Ludovic,
>
> On 22/11/2013 15:07, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
>> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>
>> There are still I2C unexpected behaviors which are solved by reducing TWI
>> internal frequency.
>
> I guess I should do the same for the dt version of sama5 clks.
> Nicolas, what do you think ?

Yes, you can queue these modification on top of your "CCF related fixes" 
branch.

Bye,

>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> #3.10+
>> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>> ---
>>    arch/arm/mach-at91/sama5d3.c |    6 +++---
>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
>> index 4012797..4ee0de5 100644
>> --- a/arch/arm/mach-at91/sama5d3.c
>> +++ b/arch/arm/mach-at91/sama5d3.c
>> @@ -95,19 +95,19 @@ static struct clk twi0_clk = {
>>    	.name		= "twi0_clk",
>>    	.pid		= SAMA5D3_ID_TWI0,
>>    	.type		= CLK_TYPE_PERIPHERAL,
>> -	.div		= AT91_PMC_PCR_DIV2,
>> +	.div		= AT91_PMC_PCR_DIV8,
>>    };
>>    static struct clk twi1_clk = {
>>    	.name		= "twi1_clk",
>>    	.pid		= SAMA5D3_ID_TWI1,
>>    	.type		= CLK_TYPE_PERIPHERAL,
>> -	.div		= AT91_PMC_PCR_DIV2,
>> +	.div		= AT91_PMC_PCR_DIV8,
>>    };
>>    static struct clk twi2_clk = {
>>    	.name		= "twi2_clk",
>>    	.pid		= SAMA5D3_ID_TWI2,
>>    	.type		= CLK_TYPE_PERIPHERAL,
>> -	.div		= AT91_PMC_PCR_DIV2,
>> +	.div		= AT91_PMC_PCR_DIV8,
>>    };
>>    static struct clk mmc0_clk = {
>>    	.name		= "mci0_clk",
>>
>
>
>


-- 
Nicolas Ferre
