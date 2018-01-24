From: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [v2,2/5] i2c: meson: add configurable divider factors
Date: Wed, 24 Jan 2018 14:51:30 +0800
Message-ID: <600c932f-59d6-d7ec-ec02-b92b275049d5@amlogic.com>
References: <20171120145415.6581-3-yixun.lan@amlogic.com>
 <20180124062830.vi52rtlgglryq3xz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180124062830.vi52rtlgglryq3xz@ninjato>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram：



On 01/24/18 14:28, Wolfram Sang wrote:
> On Mon, Nov 20, 2017 at 10:54:12PM +0800, Yixun Lan wrote:
>> From: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>>
>> This patch try to add support for I2C controller in Meson-AXG SoC,
>> Due to the IP changes between I2C controller, we need to introduce
>> a compatible data to make the divider factor configurable.
>>
>> Reviewed-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
> 
> Applied to for-next, thanks!
> 
> But I got two build warnings, please fix them with an incremental patch:
> 
> drivers/i2c/busses/i2c-meson.c:103: warning: No description found for parameter 'data'
> drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq' description in 'meson_i2c'
> 
first, many thanks for pushing this..

I understand from above warnings, and can compose a patch to fix this.

but, I didn't get this build warnings while test locally, so is there
any specific compiler option that I need to pass to?

Yixun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
