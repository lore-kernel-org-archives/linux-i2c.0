From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7] i2c: rk3x: handle dynamic clock rate changes correctly
Date: Fri, 21 Nov 2014 10:22:17 -0800
Message-ID: <CAD=FV=UnaHQFfO1CXAGGiHJHgrxCOdu2yEnwenvRvkz+TuiArw@mail.gmail.com>
References: <1827790.Sq6eyYqr17@typ>
	<20141121181834.GE3754@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141121181834.GE3754@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Huang Tao <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

On Fri, Nov 21, 2014 at 10:18 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Thu, Nov 20, 2014 at 10:26:50AM +0100, Max Schwarz wrote:
>> The i2c input clock can change dynamically, e.g. on the RK3066 where
>> pclk_i2c0 and pclk_i2c1 are connected to the armclk, which changes
>> rate on cpu frequency scaling.
>>
>> Until now, we incorrectly called clk_get_rate() while holding the
>> i2c->lock in rk3x_i2c_xfer() to adapt to clock rate changes.
>> Thanks to Huang Tao for reporting this issue.
>>
>> Do it properly now using the clk notifier framework. The callback
>> logic was taken from i2c-cadence.c.
>>
>> Also rename all misleading "i2c_rate" variables to "clk_rate", as they
>> describe the *input* clk rate.
>>
>> Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
>> Tested-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> on RK3188
>
> Superfluous, I assume that you tested a patch when you send it :)
>
>> Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> on RK3288
>> Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Please drop such tags when there are significant changes between the
> revisions (which happened here). They need to be sent again explicitly,
> so I know really this version has been worked on.
>
> So, Doug, please confirm those tags.

Consider them confirmed.  I like this new version and it seems to be
working well for me.  I don't use the dynamic clock changes but it at
least doesn't crash or break in any other ways.  I've landed it
locally in my tree.

-Doug
