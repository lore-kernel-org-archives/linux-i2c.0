From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
Date: Thu, 25 Sep 2014 14:52:08 -0700
Message-ID: <CAD=FV=UkAcR8b+T_Dvoy9STDfzyC8QVSawihoHLYyHFJ6bfXxQ@mail.gmail.com>
References: <1411523743-3444-1-git-send-email-addy.ke@rock-chips.com>
	<CAD=FV=WiHR+KcTWHnma6TdPQcc3oc4wqAofj5kF=Sgec_5kGAQ@mail.gmail.com>
	<54227F93.7000507@rock-chips.com>
	<CAD=FV=Uq9AteUcpMvcU5tmyGZbVYWM6PNmevZXSVCkYB8rqSsQ@mail.gmail.com>
	<5423765B.8000706@rock-chips.com>
	<CAD=FV=Uuk1zBYn4NgcpDSHVfKeyw3MONO7roUNVSPSDDEyD=8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=Uuk1zBYn4NgcpDSHVfKeyw3MONO7roUNVSPSDDEyD=8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5aea5pm65oOF?= <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, han jiang <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5pmT6IW+546L?= <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Addy,

On Wed, Sep 24, 2014 at 9:36 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Addy,
>
> On Wed, Sep 24, 2014 at 6:56 PM, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> In my measurement,all paramter but "Data hold time" are match the characteristics of SCL bus line.
>> the measured value is 0.928us("data hold time on RK3X"  ~=  "the low period / 2")
>> but the maximum value described in table is 0.9us
>>
>> About "Data hold time", there are described in I2C specification:
>> - for CBUS compatible masters for I2C-bus deivices
>> - the maximum data hold time has only be met if the device does not stretch the LOW period of the SCL signal.
>>
>> I have tested on RK3288-Pinky board, there are no error.
>> But I don't known whether this paramter will affect i2c communications.
>
> I'll have to spend more time tomorrow to really understand this, but
> if changing the code to bias towards slightly longer "high" times
> instead of "low" times helps fix it then that's fine with me.

So what you're saying is that you're seeing a case where the clock
goes low and the data is not valid until .928us.  Is this data that is
being driven by the master or data that is being driven by the slave?

Do you know why the data takes so long to be valid?  Maybe you can
email me some of the waveforms and I can try to help you debug it.


In any case it sounds like the the "data hold time" problem is
unrelated to the clock ratio problem (right?), so maybe you could send
out patch v2?

-Doug

P.S. I checked the Rockchip TRM and it claims 400kHz maximum i2c.  I
think that means you can just remove all of the "fast mode plus" and
"high speed mode" clock rates from your table.
