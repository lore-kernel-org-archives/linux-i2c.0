From: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/5] ARM64: dts: meson-axg: add I2C DT info for Meson-AXG
 SoC
Date: Fri, 17 Nov 2017 22:02:32 +0800
Message-ID: <1dd88afc-04fd-2443-f948-1d5bcd186ab8@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
 <20171117080236.32504-4-yixun.lan@amlogic.com>
 <96dc68e3-c394-70c4-eabe-f59d4c36150e@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <96dc68e3-c394-70c4-eabe-f59d4c36150e-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Neil

see my comments in line

On 11/17/17 21:05, Neil Armstrong wrote:
> Hi Yixun, Jian,
> 
> On 17/11/2017 09:02, Yixun Lan wrote:
>> From: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>>
>> There are four I2C masters in EE domain, and one I2C Master in
>> AO domain, the DT info here should describe them all.
>>
>> Signed-off-by: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 59 ++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 57faaa9d8013..99e967aff439 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -129,6 +129,54 @@
>>  				#reset-cells = <1>;
>>  			};
>>  
>> +			i2c_m0: i2c@1f000 {
> 
> Can you use a more simple "i2c0" phandle naming instead ? or get back to the "i2c_A/B/C/D" naming like in meson_gx to keep consistency ?
> 
Ok, I would prefer to use 'i2c0' then

we had a internal discussion about the inconsistent naming of the I2C
controller, and reach a consensus to name them as:
 the EE domain: ee_i2c_m0, ee_i2c_m1 ..
 the AO domain: ao_i2c_m0, ao_i2c_s0
in the future datasheet.

note: 'ee' means the EE domain, m0 mean the master 0, s0 mean the I2C
slave 0


> [...]
> 
>> +			};
>> +
>> +			i2c_m1: i2c@1e000 {
> 
> [...]
> 
>> +			};
>> +
>> +			i2c_m2: i2c@1d000 {
> 
> [...]
> 
>> +			};
>> +
>> +			i2c_m3: i2c@1c000 {
> 
> [...]
> 
>> +			};
>> +
>>  			uart_A: serial@24000 {
>>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
>>  				reg = <0x0 0x24000 0x0 0x14>;
>> @@ -312,6 +360,17 @@
>>  				};
>>  			};
>>  
>> +			i2c_ao: i2c@5000 {
> 
> Can you keep the same "i2c_AO" as in meson-gx ?
> 
> 
sure, can do

> [...]
> 
>> +			};
>> +
>>  			uart_AO: serial@3000 {
>>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>>  				reg = <0x0 0x3000 0x0 0x18>;
>>
> 
> Neil
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
