From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH v3] arm64: dts: add all hi6220 i2c nodes
Date: Wed, 2 Dec 2015 17:06:31 +0800
Message-ID: <565EB497.6080700@hisilicon.com>
References: <1449037749-14388-1-git-send-email-kong.kongxinwei@hisilicon.com> <20151202073427.GM692@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151202073427.GM692@tiger>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 2015/12/2 15:34, Shawn Guo wrote:
> On Wed, Dec 02, 2015 at 02:29:09PM +0800, Xinwei Kong wrote:
>> This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
>> use this I2C IP of Synopsys Designware for HiKey board.
>>
>> Signed-off-by: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> index 82d2488..6eae673 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> @@ -208,5 +208,36 @@
>>  			clock-names = "uartclk", "apb_pclk";
>>  			status = "disabled";
>>  		};
>> +
>> +		i2c0: i2c@f7100000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x0 0xf7100000 0x0 0x1000>;
>> +			interrupts = <0 44 4>;
>> +			i2c-sda-hold-time-ns = <300>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
>> +			status = "disabled";
> 
> You got me wrong.  I was asking you to drop property 'clock-names' only,
> not 'clocks' together.  I do not think it works if you drop property
> 'clocks', because I see that dw_i2c_plat_probe() will fail if
> devm_clk_get() fails.  Did you test the patch before posting it out?

I am sorry that my Hikey board don't work well. I will fix my board and test
it.

Thank you very much.
xinwei

> 
> Shawn
> 
>> +		};
>> +
>> +		i2c1: i2c@f7101000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x0 0xf7101000 0x0 0x1000>;
>> +			interrupts = <0 45 4>;
>> +			i2c-sda-hold-time-ns = <300>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c2: i2c@f7102000 {
>> +			compatible = "snps,designware-i2c";
>> +			reg = <0x0 0xf7102000 0x0 0x1000>;
>> +			interrupts = <0 46 4>;
>> +			i2c-sda-hold-time-ns = <300>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
>> +			status = "disabled";
>> +		};
>> +
>>  	};
>>  };
>> -- 
>> 1.9.1
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
