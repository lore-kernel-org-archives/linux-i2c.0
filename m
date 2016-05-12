From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v8 7/8] i2c: rk3x: add i2c support for rk3399 soc
Date: Thu, 12 May 2016 09:08:58 +0800
Message-ID: <5733D7AA.1060500@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908698-27284-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=Uf-U3RBpgFbR3LkPAJTWqz3d02+H7iyA-SS-y=r3cXjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Uf-U3RBpgFbR3LkPAJTWqz3d02+H7iyA-SS-y=r3cXjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Doug,

=E5=9C=A8 2016/5/12 1:37, Doug Anderson =E5=86=99=E9=81=93:
> Hi,
>
> On Tue, May 10, 2016 at 12:31 PM, David Wu <david.wu@rock-chips.com> =
wrote:
>>   static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long=
 clk_rate)
>>   {
>>          struct i2c_timings *t =3D &i2c->t;
>>          struct rk3x_i2c_calced_timings calc;
>>          u64 t_low_ns, t_high_ns;
>> +       u32 val;
>>          int ret;
>>
>> -       ret =3D rk3x_i2c_calc_divs(clk_rate, t, &calc);
>> +       ret =3D i2c->soc_data->calc_timings(clk_rate, t, &calc);
>>          WARN_ONCE(ret !=3D 0, "Could not reach SCL freq %u", t->bus=
_freq_hz);
>>
>> -       clk_enable(i2c->clk);
>> +       clk_enable(i2c->pclk);
>> +
>>          i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xf=
fff),
>>                     REG_CLKDIV);
>> -       clk_disable(i2c->clk);
>> +
>> +       val =3D i2c_readl(i2c, REG_CON);
>> +       val &=3D ~REG_CON_TUNING_MASK;
>> +       val |=3D calc.tuning;
>> +       i2c_writel(i2c, val, REG_CON);
>
> Another subtle bug here.  You need to be holding the spinlock here
> since you're doing a read-modify-write of a register that is also
> touched by the interrupt handler.  We never needed it before because
> the previous register update wasn't touched by anyone else and it was
> a single atomic write.
>
> Also: technically if we are midway through a transfer when all this
> happens then there will be a very short period of time when the two
> timing-related registers won't match with each other.  I have no idea
> how much that would matter, but in the very least it seems wise to
> minimize the time where they mismatch.  So I'd probably write:
>
>         spin_lock_irqsave(&i2c->lock, flags);
>         val =3D i2c_readl(i2c, REG_CON);
>         val &=3D ~REG_CON_TUNING_MASK;
>         val |=3D calc.tuning;
>         i2c_writel(i2c, val, REG_CON);
>         i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xfff=
f),
>                    REG_CLKDIV);
>         spin_unlock_irqrestore(&i2c->lock, flags);
>
> ...if we really end up with on a system with a dynamically changing
> clock that uses the new-style timing and we see real problems, we can
> always try to come up with a way to avoid any problems.  Sound OK?
>
>

Good, add spin_lock is very necessary for atomic write here, thanks for=
=20
your advice.

> Otherwise, I think things look good to me.  Caesar's comments would
> also be good to fix.
>
>
> -Doug
>
>
>
