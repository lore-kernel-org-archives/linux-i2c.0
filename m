From: ludovic.desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: at91: use an id table for SoC dependent
 parameters
Date: Mon, 3 Sep 2012 09:24:01 +0200
Message-ID: <50445B11.5050601@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com>
 <20120831142944.GA23867@game.jcrosoft.org> <5040CF80.8060201@atmel.com>
 <504122D3.70507@gmail.com> <20120901091054.GA17540@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120901091054.GA17540-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Le 09/01/2012 11:10 AM, Jean-Christophe PLAGNIOL-VILLARD a =E9crit :
> On 22:47 Fri 31 Aug     , Sylwester Nawrocki wrote:
>> On 08/31/2012 04:51 PM, Nicolas Ferre wrote:
>>>>> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at9=
1rm9200.c
>>>>> index f2112f9..0bc91e5 100644
>>>>> --- a/arch/arm/mach-at91/at91rm9200.c
>>>>> +++ b/arch/arm/mach-at91/at91rm9200.c
>>>>> @@ -187,7 +187,7 @@ static struct clk_lookup periph_clocks_lookups[] =
=3D {
>>>>>    	CLKDEV_CON_DEV_ID("pclk", "ssc.0",&ssc0_clk),
>>>>>    	CLKDEV_CON_DEV_ID("pclk", "ssc.1",&ssc1_clk),
>>>>>    	CLKDEV_CON_DEV_ID("pclk", "ssc.2",&ssc2_clk),
>>>>> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c",&twi_clk),
>>>>> +	CLKDEV_CON_DEV_ID(NULL, "at91rm9200_i2c",&twi_clk),
>>>> use i2c-xxx as on other drivers
>>>>
>>>> and I do not like to have platform_device_id
>>>
>>> Me, I like it and find this implementation very elegant.
>>>
>>>> as we need to touch the driver to add a new soc
>>>
>>> So what? We still keep the compatibility if the new SoC has it
>>> compatibility assured with previous revision: there is nothing to modif=
y.
>>
>> I agree. The driver would need to be touched to support new SoC only if
>> the IP there have had some differences, which would have needed to be
>> resolved anyway.
>>
>>>> please use platform data
>>
>> Using platform data for the dt platforms would have been more troublesom=
e,
>> wouldn't it ? I like Ludovic's approach which handles both: dt and non-dt
>> cases in uniform way from the driver's POV.
> no you will describe it via DT as done on all the other drivers
>>
>>> No, it does not have to be exposed to the user: these data are highly
>>> dependent on the actual hardware (IP revision in fact). So, no need to
>>> mess with platform data.
> no I really see no point on these list of platform_id it's does not look =
more
> nice just more huggly to have x names. This is at the end the same as pas=
sing
> platform data via soc info (add_xx or dtsi)
>
> And here you just do the same as cpu_is via names.
>
> The driver need to read IP revision instead
>

At the beginning it was planned to do this but:
- a new SoC, with a new IP version lead to update the driver also
- with the MCI driver which uses IP version, I have some cases where =

using the version was not enough, a SoC approach would be better. For =

instance, the IP version tells that we can use PDC feature but PDC is =

not connected.

> Best Regards,
> J.
>
>

Regards

Ludovic
