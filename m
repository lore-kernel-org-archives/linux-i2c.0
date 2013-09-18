From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: STi: Add I2C config to B2000 and B2020 boards
Date: Wed, 18 Sep 2013 14:36:18 +0200
Message-ID: <84625B87D65BCF478CC1E9C886A4C314DEF1BD9576@SAFEX1MAIL4.st.com>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-5-git-send-email-maxime.coquelin@st.com>
 <20130918114032.GD16984@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, Olivier CLERGEAUD <olivier.clergeaud-lpHj6iFQ3dU@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Lee,

On 09/18/2013 01:40 PM, Lee Jones wrote:
> On Wed, 18 Sep 2013, Maxime COQUELIN wrote:
>
>> This patch supplies I2C configuration to B2000 and B2020
>> based on either STiH415 or STiH416 SoCs.
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/stih41x-b2000.dtsi |    7 +++++++
>>  arch/arm/boot/dts/stih41x-b2020.dtsi |   20 ++++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
>> index 8e694d2..346cc4bc 100644
>> --- a/arch/arm/boot/dts/stih41x-b2000.dtsi
>> +++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
>> @@ -37,5 +37,12 @@
>>  			};
>>  		};
>>  
>> +		/* HDMI Tx I2C */
>> +		i2c1: i2c@fed41000{
> nit: Space before the '{'
Ok. It will be fixed for all nodes in next series.
>
>> +			status = "okay";
> Consider enabling the node at the bottom.
>
>> +
>> +			/* HDMI V1.3a supports Standard mode only */
>> +			clock-frequency = <100000>;
>> +		};
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
>> index 133e181..10b98da 100644
>> --- a/arch/arm/boot/dts/stih41x-b2020.dtsi
>> +++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
>> @@ -38,5 +38,25 @@
>>  				default-state = "off";
>>  			};
>>  		};
>> +
>> +		i2c0: i2c@fed40000{
> As above.
>
>> +			status = "okay";
>> +		};
>> +
>> +		/* HDMI Tx I2C */
>> +		i2c1: i2c@fed41000{
> As above.
>
>> +			status = "okay";
> As above.
>
>> +			/* HDMI V1.3a supports Standard mode only */
>> +			clock-frequency = <100000>;
>> +		};
>> +
>> +		sbc_i2c0: i2c@fe540000{
> As above.
>
>> +			status = "okay";
>> +		};
>> +
>> +		sbc_i2c1: i2c@fe541000{
> Are these nodes referenced by phandle at all?
>
> If not, consider dropping the <lable>:s
It was references in an previous internal version of this series.
This is no more the case, so I will drop the labels.
>
>> +			status = "okay";
>> +		};
>>  	};
>>  };
> Odd tabbing here.
>
Thanks,
Maxime
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
