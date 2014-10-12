From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
Date: Sun, 12 Oct 2014 14:24:06 -0700
Message-ID: <CAD=FV=XHOuQZPOrVRtoTGN2Yq6E7fuKSa+AM6U_MYKAoZ+nKBA@mail.gmail.com>
References: <1412837235-4202-1-git-send-email-addy.ke@rock-chips.com>
	<5700320.9GSb6erCFz@typ>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5700320.9GSb6erCFz@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5aea5pm65oOF?= <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, han jiang <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5pmT6IW+546L?= <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Max,

On Sun, Oct 12, 2014 at 5:10 AM, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
>> +     /* Adjust to avoid overflow */
>> +     i2c_rate_khz = DIV_ROUND_UP(i2c_rate, 1000);
>> +     scl_rate_khz = DIV_ROUND_UP(scl_rate, 1000);
>
> I'm not really comfortable with using DIV_ROUND_UP on the last line, since
> this may violate the user's set SCL rate. Rounding up 1.1kHz SCL rate to 2kHz
> is not good.

Ah, good point.  So we round up for i2c_rate and down for scl_rate:

  i2c_rate_khz = DIV_ROUND_UP(i2c_rate, 1000);
  scl_rate_khz = scl_rate / 1000;


> I suggest using scl_rate / 1000 and placing a
>
> if(WARN_ON(scl_rate < 1000))
>   scl_rate = 1000;
>
> somewhere to prevent scl_rate_khz from becoming 0.

Ah, makes sense.  Yeah, that should be at the top.
