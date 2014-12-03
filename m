From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
Date: Wed, 3 Dec 2014 09:53:40 -0800
Message-ID: <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
	<1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
	<20141203111518.GB1039@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141203111518.GB1039@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Eddie Cai <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Tao Huang <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Chris <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?5aea5pm65oOF?= <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, han jiang <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, caesar <caesar.wang@rock-c>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

On Wed, Dec 3, 2014 at 3:15 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> + - rise-ns : Number of nanoseconds the signal takes to rise (t(r) in i2c spec).
>> +          If not specified this is assumed to be the max the spec allows
>> +          (1000 ns for standard mode, 300 ns for fast mode) which might
>> +          cause slightly slower communication.
>> + - fall-ns : Number of nanoseconds the signal takes to fall (t(f) in the i2c0
>> +          spec).  If not specified this is assumed to be the max the spec
>> +          allows (300 ns) which might cause slightly slower communication.
>
> We already have those bindings from the designware driver:
>
>  - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
>  - i2c-scl-falling-time : should contain the SCL falling time in nanoseconds.
>  - i2c-sda-falling-time : should contain the SDA falling time in nanoseconds.
>
> Can you reuse them? Or do you really need a specific rise-time property?
> If so, please matche the style of the bindings above.

Ah, doh!  I should have thought to look for existing bindings.  Sorry
about that.  :(

If you don't read all the below, my belief is that we should simply
rename the strings in Addy's patch.  We should change "rise-ns" to
"i2c-scl-rising-time" and "fall-ns" to "i2c-scl-falling-time".
Wolfram: can you confirm this is OK?  I'm voting to leave the "-ns"
off the end of both to avoid asymmetry.

---

Details:

Hrm, we seem to need different parameters than designware i2c.  The
designware bus is specifying "i2c-sda-hold-time-ns".  On Rockchip i2c
we specify just the number of cycles that the clk line should be high
and the number of cycles that it should be low.  The adapter does the
rest of the work.  As I understand it, the data hold time on Rockchip
i2c is equal to half the low time, for instance.  That was indicated
by Addy who talked to the IC engineer.

Because of the above, I _think_ that means that specifying
"i2c-sda-hold-time-ns" is not appropriate for us, or at least not easy
to convert in a sane way.

We could add a "i2c-scl-hold-time-ns", but if I understand correctly I
think that the "rise-time" describes the hardware in a cleaner way.
If you specify the hold time then (I think) that it requires the user
to tweak it whenever he/she adjusts the bus speed.  In other words if
you have a bus and you decide to move it from running at 400kHz to
running at 300kHz (signal integrity issues?) or 100kHz, you need to
manually modify the hold time.  ...on the other hand the rise time is
a property of the hardware I think (size of resistor, etc).

For the falling times I guess we should use the "i2c-scl-falling-time"
and not list the "i2c-sda-falling-time" for now?  As per above the
controller takes in the high/low period of the clocks and figures out
the rest itself.  Possibly we will need to account for
i2c-sda-falling-time eventually, but maybe that can come later?


-Doug
