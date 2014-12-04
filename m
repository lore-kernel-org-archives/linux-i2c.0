From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
Date: Thu, 4 Dec 2014 10:43:19 -0800
Message-ID: <CAD=FV=Vp3hwxbDzb+FUhNXy8qW8fTCkgd67jRDV3foT0o9HQuQ@mail.gmail.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
	<1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
	<20141203111518.GB1039@katana>
	<CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
	<20141204184046.GL7944@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141204184046.GL7944@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5aea5pm65oOF?= <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, han jiang <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, caesar <caesar.wang@rock-c>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

On Thu, Dec 4, 2014 at 10:40 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> If you don't read all the below, my belief is that we should simply
>> rename the strings in Addy's patch.  We should change "rise-ns" to
>> "i2c-scl-rising-time" and "fall-ns" to "i2c-scl-falling-time".
>> Wolfram: can you confirm this is OK?  I'm voting to leave the "-ns"
>> off the end of both to avoid asymmetry.
>
> New binding should have the "-ns" suffix, right? So, I'd vote to add the
> suffix to the new bindings and deprecate the ones used in the designware
> driver: "i2c-scl-rising-time-ns" and "i2c-scl-falling-time-ns"
>
> It might be a little more work now, but it will help us in the future,
> because it is the correct way to do it.

OK, that sounds fair.  You're OK with my proposal otherwise?

Are you looking for Addy or me to submit a patch supporting the "-ns"
suffix on the Designware i2c driver, or should we just use the "-ns"
suffix in the Rockchip driver and assume someone will later add
support for the new binding in the Designware i2c driver?

-Doug
