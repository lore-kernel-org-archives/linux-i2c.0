From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] i2c: rk3x: keep i2c irq ON in suspend
Date: Tue, 6 Dec 2016 08:31:41 -0800
Message-ID: <CAD=FV=VgGy5hA4+7nvLs4NPNRuopak+bTW34S6X6S_vWgtnkjg@mail.gmail.com>
References: <1480924979-13450-1-git-send-email-david.wu@rock-chips.com>
 <1737869.ycGphUXI8X@phil> <1d570232-af87-467e-e6f4-5b514d583a02@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1d570232-af87-467e-e6f4-5b514d583a02@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David.Wu" <david.wu@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Dec 6, 2016 at 12:12 AM, David.Wu <david.wu@rock-chips.com> wrote:
> Hi Heiko,
>
> =E5=9C=A8 2016/12/5 18:54, Heiko Stuebner =E5=86=99=E9=81=93:
>>
>> Hi David,
>>
>> Am Montag, 5. Dezember 2016, 16:02:59 CET schrieb David Wu:
>>>
>>> During suspend there may still be some i2c access happening.
>>> And if we don't keep i2c irq ON, there may be i2c access timeout if
>>> i2c is in irq mode of operation.
>>
>>
>> can you describe the issue you're trying to fix a bit more please?
>
>
> Sometimes we could see the i2c timeout errors during suspend/resume, whic=
h
> makes the duration of suspend/resume too longer.
>
> [  484.171541] CPU4: Booted secondary processor [410fd082]
> [  485.172777] rk3x-i2c ff3c0000.i2c: timeout, ipd: 0x10, state: 1
> [  486.172760] rk3x-i2c ff3c0000.i2c: timeout, ipd: 0x10, state: 1
> [  487.172759] rk3x-i2c ff3c0000.i2c: timeout, ipd: 0x10, state: 1
> [  487.172840] cpu cpu4: _set_opp_voltage: failed to set voltage (800000
> 800000 800000 mV): -110
> [  487.172874] cpu cpu4: failed to set volt 800000
>
>>
>> I.e. I'd think the i2c-core does suspend i2c-client devices first, so th=
at
>> these should be able to finish up their ongoing transfers and not start
>> any
>> new ones instead?
>>
>> Your irq can still happen slightly after the system started going to
>> actually
>> sleep, so to me it looks like you just widened the window where irqs can
>> be
>> handled. Especially as your irq could also just simply stem from the sta=
rt
>> state, so you cannot even be sure if your transaction actually is
>> finished.
>
>
> Okay, you are right. I want to give it a double insurance at first, but i=
t
> may hide the unhappend issue.
>
>>
>> So to me it looks like the i2c-connected device driver should be fixed
>> instead?
>
>
> I tell them to fix it in rk808 driver.

To me it seems like perhaps cpufreq should not be changing frequencies
until it is resumed properly.  Presumably if all the ordering is done
right then cpufreq should be resumed _after_ the i2c regulator so you
should be OK.  ...or am I somehow confused about that?

Also note that previous i2c busses I worked with simply returned -EIO
in the case where they were called when suspended.  See
"i2c-exynos5.c" and "i2c-s3c2410.c".

-Doug
