From: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH v4] arm64: dts: add all hi6220 i2c nodes
Date: Thu, 31 Dec 2015 09:27:06 +0800
Message-ID: <5684846A.2050305@hisilicon.com>
References: <1449051201-7288-1-git-send-email-kong.kongxinwei@hisilicon.com> <56828756.2040500@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56828756.2040500-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bintian <bintian.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

+to xuwei

On 2015/12/29 21:15, Bintian wrote:
> On 2015/12/2 18:13, Xinwei Kong wrote:
>> This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
>> use this I2C IP of Synopsys Designware for HiKey board.
>>
>> Signed-off-by: Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
>> Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
   Reviewed-by: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> ---
>>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 34 +++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> index 82d2488..8cec56a 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>> @@ -208,5 +208,39 @@
>>               clock-names = "uartclk", "apb_pclk";
>>               status = "disabled";
>>           };
>> +
>> +        i2c0: i2c@f7100000 {
>> +            compatible = "snps,designware-i2c";
>> +            reg = <0x0 0xf7100000 0x0 0x1000>;
>> +            interrupts = <0 44 4>;
>> +            clocks = <&sys_ctrl HI6220_I2C0_CLK>;
>> +            i2c-sda-hold-time-ns = <300>;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c1: i2c@f7101000 {
>> +            compatible = "snps,designware-i2c";
>> +            reg = <0x0 0xf7101000 0x0 0x1000>;
>> +            clocks = <&sys_ctrl HI6220_I2C1_CLK>;
>> +            interrupts = <0 45 4>;
>> +            i2c-sda-hold-time-ns = <300>;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
>> +            status = "disabled";
>> +        };
>> +
>> +        i2c2: i2c@f7102000 {
>> +            compatible = "snps,designware-i2c";
>> +            reg = <0x0 0xf7102000 0x0 0x1000>;
>> +            clocks = <&sys_ctrl HI6220_I2C2_CLK>;
>> +            interrupts = <0 46 4>;
>> +            i2c-sda-hold-time-ns = <300>;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
>> +            status = "disabled";
>> +        };
>> +
>>       };
>>   };
> 
> Looks good to me!
> 
> Reviewed-by: Bintian Wang<bintian.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> 
> 
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
