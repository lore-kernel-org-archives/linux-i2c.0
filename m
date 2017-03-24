From: =?UTF-8?B?6ZmI5Lqu?= <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
Date: Fri, 24 Mar 2017 14:31:28 +0800
Message-ID: <58D4BD40.5090900@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
 <14610453.rKm3MBREMz@diego> <58D34208.6090509@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58D34208.6090509-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Heiko:

在 2017年03月23日 11:33, 陈亮 写道:
> Hi, Heiko
>
> 在 2017年03月21日 16:55, Heiko Stübner 写道:
>> Hi,
>>
>> Am Donnerstag, 16. März 2017, 21:17:22 CET schrieb cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org:
>>> +        assigned-clock-parents =
>>> +            <&cru HDMIPHY>, <&cru PLL_APLL>,
>>> +            <&cru PLL_GPLL>, <&xin24m>,
>>> +            <&xin24m>, <&xin24m>;
>>> +        assigned-clock-rates =
>>> +            <0>, <61440000>,
>>> +            <0>, <24000000>,
>>> +            <24000000>, <24000000>,
>>> +            <15000000>, <15000000>,
>>> +            <100000000>, <100000000>,
>>> +            <100000000>, <100000000>,
>>> +            <50000000>, <100000000>,
>>> +            <100000000>, <100000000>,
>>> +            <50000000>, <50000000>,
>>> +            <50000000>, <50000000>,
>>> +            <24000000>, <600000000>,
>>> +            <491520000>, <1200000000>,
>>> +            <150000000>, <75000000>,
>>> +            <75000000>, <150000000>,
>>> +            <75000000>, <75000000>,
>>> +            <300000000>, <100000000>,
>>> +            <300000000>, <200000000>,
>>> +            <400000000>, <500000000>,
>>> +            <200000000>, <300000000>,
>>> +            <300000000>, <250000000>,
>>> +            <200000000>, <100000000>,
>>> +            <24000000>, <100000000>,
>>> +            <150000000>, <50000000>,
>>> +            <32768>, <32768>;
>>> +    };
>>> +
>>> +    gmac2io: eth@ff540000 {
>> phandle should be gmac instead?
>> Node name, ethernet@ff540000
> RK3328 have another gmac channel with PHY in the soc, so gmac2io mean 
> the channel with the PHY outside, and it is also called gmac2io in the 
> TRM.
So we remain gmac2io, or you have other idea?
>>
>>
>> Heiko
>>
>
