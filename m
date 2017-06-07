From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCHv3 1/4] ARM: dts: socfpga: Add Altera I2C Controller to
 CycloneV
Date: Wed, 7 Jun 2017 15:45:50 -0500
Message-ID: <b5b5dd02-9c07-1ecd-086d-ef668f280514@linux.intel.com>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
 <1496447559-19782-2-git-send-email-thor.thayer@linux.intel.com>
 <73vao9vcsq.fsf@pengutronix.de>
Reply-To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <73vao9vcsq.fsf-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Steffen,

On 06/06/2017 01:40 AM, Steffen Trumtrar wrote:
> 
> Hi!
> 
> thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org writes:
> 
>> From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>
>> Add the Altera I2C Controller to the CycloneV SoCFPGA device tree.
>>
>> Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>> v2  Remove altr, from fifo-size.
>>      Rename compatible string to "altr,softip-i2c"
>> v3  Add version to commpatible string "altr,softip-i2c-v1.0"
>> ---
>>   arch/arm/boot/dts/socfpga.dtsi               | 13 ++++++++++---
>>   arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 28 +++++++++++++++++++++++++++-
>>   2 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index b2674bd..d69c13d 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -133,6 +133,13 @@
>>   					#address-cells = <1>;
>>   					#size-cells = <0>;
>>   
>> +					clk_0: clk_0 {
>> +						compatible = "fixed-clock";
>> +						#clock-cells = <0>;
>> +						clock-frequency = <50000000>;
>> +						clock-output-names = "clk_0-clk";
>> +					};
>> +
>>   					osc1: osc1 {
>>   						#clock-cells = <0>;
>>   						compatible = "fixed-clock";
>> @@ -529,11 +536,11 @@
>>   				};
>>   		};
>>   
>> -		fpga_bridge0: fpga_bridge@ff400000 {
>> +		fpga_bridge0: fpga_bridge@ff200000 {
>>   			compatible = "altr,socfpga-lwhps2fpga-bridge";
>> -			reg = <0xff400000 0x100000>;
>> +			reg = <0xff200000 0x00200000>;
>>   			resets = <&rst LWHPS2FPGA_RESET>;
>> -			clocks = <&l4_main_clk>;
>> +			clocks = <&clk_0>;
>>   		};
>>
> 
> Why this change? This looks wrong and unrelated. The LWHPS2FPGA bridge
> is at 0xff400000, so it is correct the way it is or not?
> 
Yes, good point. I was using the LWHPS2FPGA slave bus so I shouldn't 
change this one. I'll add the slave version.

Thanks,

Thor
>>   		fpga_bridge1: fpga_bridge@ff500000 {
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> index 155829f..f99576b 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> @@ -68,6 +68,7 @@
>>   		regulator-min-microvolt = <3300000>;
>>   		regulator-max-microvolt = <3300000>;
>>   	};
>> +
>>   };
> 
> ???
> 
Whoops. I should remove the extra space. Thanks!

> 
> (...)
> 
> 
> Best regards,
> Steffen
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
