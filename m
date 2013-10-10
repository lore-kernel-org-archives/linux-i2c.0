From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v4 3/4] ARM: STi: Supply I2C configuration to STiH415 SoC
Date: Thu, 10 Oct 2013 14:49:45 +0200
Message-ID: <5256A269.9070809@st.com>
References: <1381250576-7916-1-git-send-email-maxime.coquelin@st.com>
 <1381250576-7916-4-git-send-email-maxime.coquelin@st.com>
 <A3BF01DB4A606149A4C20C4C4C808F6C5BC8A70D4E@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A3BF01DB4A606149A4C20C4C4C808F6C5BC8A70D4E-+EwDPpWUVoThJTuQ9jeba9BPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>, Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On 10/10/2013 02:33 PM, Stephen GALLIMORE wrote:
>> -----Original Message-----
>> From: Maxime COQUELIN [mailto:maxime.coquelin-qxv4g6HH51o@public.gmane.org]
>> Sent: 08 October 2013 17:43
>> .....
>> +
>> +		i2c@fed40000 {
>> +			compatible	= "st,comms-ssc-i2c";
>> +			reg		= <0xfed40000 0x110>;
>> +			interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> This should specify level (high) triggered, not edge triggered, for our
> SoC integrations.
>
> Note that level triggered is the default GIC setup and was therefore
> what was being used when you specified "0" for the flags previously.
Thanks Stephen.
As discussed this morning, I agree this should be high level triggered.

This will be fixed in next revision.

>
>> +			clocks		= <&CLKS_ICN_REG_0>;
>> +			clock-names	= "ssc";
>> +			clock-frequency = <400000>;
>> +			pinctrl-names	= "default";
>> +			pinctrl-0	= <&pinctrl_i2c0_default>;
>> +
>> +			status		= "disabled";
>> +		};
