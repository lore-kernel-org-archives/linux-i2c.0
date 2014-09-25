From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
Date: Wed, 24 Sep 2014 21:36:38 -0700
Message-ID: <CAD=FV=Uuk1zBYn4NgcpDSHVfKeyw3MONO7roUNVSPSDDEyD=8Q@mail.gmail.com>
References: <1411523743-3444-1-git-send-email-addy.ke@rock-chips.com>
	<CAD=FV=WiHR+KcTWHnma6TdPQcc3oc4wqAofj5kF=Sgec_5kGAQ@mail.gmail.com>
	<54227F93.7000507@rock-chips.com>
	<CAD=FV=Uq9AteUcpMvcU5tmyGZbVYWM6PNmevZXSVCkYB8rqSsQ@mail.gmail.com>
	<5423765B.8000706@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5423765B.8000706-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5aea5pm65oOF?= <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, han jiang <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5pmT6IW+546L?= <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Addy,

On Wed, Sep 24, 2014 at 6:56 PM, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> In my measurement,all paramter but "Data hold time" are match the characteristics of SCL bus line.
> the measured value is 0.928us("data hold time on RK3X"  ~=  "the low period / 2")
> but the maximum value described in table is 0.9us
>
> About "Data hold time", there are described in I2C specification:
> - for CBUS compatible masters for I2C-bus deivices
> - the maximum data hold time has only be met if the device does not stretch the LOW period of the SCL signal.
>
> I have tested on RK3288-Pinky board, there are no error.
> But I don't known whether this paramter will affect i2c communications.

I'll have to spend more time tomorrow to really understand this, but
if changing the code to bias towards slightly longer "high" times
instead of "low" times helps fix it then that's fine with me.
