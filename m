From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v7 8/9] i2c: rk3x: add i2c support for rk3399 soc
Date: Fri, 6 May 2016 17:32:37 +0800
Message-ID: <572C64B5.6080607@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372609-6535-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=VhMJiowNWm+0=jzzK0vajg1=3PutaWbzhGPN_BU2+19w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VhMJiowNWm+0=jzzK0vajg1=3PutaWbzhGPN_BU2+19w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Doug,

=E5=9C=A8 2016/5/6 7:00, Doug Anderson =E5=86=99=E9=81=93:
> David,
>
> On Wed, May 4, 2016 at 7:36 AM, David Wu <david.wu@rock-chips.com> wr=
ote:
>> +/**
>> + * Calculate timing values for desired SCL frequency
>> + *
>> + * @clk_rate: I2C input clock rate
>> + * @t: Known I2C timing information
>> + * @t_calc: Caculated rk3x private timings that would be written in=
to regs
>> +
>> + * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow.=
 In that case
>> + * a best-effort divider value is returned in divs. If the target r=
ate is
>> + * too high, we silently use the highest possible rate.
>> + * The following formulas are v1's method to calculate timings.
>> + *
>> + * l =3D divl + 1;
>> + * h =3D divh + 1;
>> + * s =3D sda_update_config + 1;
>> + * u =3D start_setup_config + 1;
>> + * p =3D stop_setup_config + 1;
>> + * T =3D Tclk_i2c;
>> +
>> + * tHigh =3D 8 * h * T;
>> + * tLow =3D 8 * l * T;
>> +
>> + * tHD;sda =3D (l * s + 1) * T;
>> + * tSU;sda =3D [(8 - s) * l + 1] * T;
>> + * tI2C =3D 8 * (l + h) * T;
>> +
>> + * tSU;sta =3D (8h * u + 1) * T;
>> + * tHD;sta =3D [8h * (u + 1) - 1] * T;
>> + * tSU;sto =3D (8h * p + 1) * T;
>> + */
>> +static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
>> +                                   struct i2c_timings *t,
>> +                                   struct rk3x_i2c_calced_timings *=
t_calc)
>> +{
>
> I don't think I'm going to try to understand all the math here.  I'll
> trust you that this does something sane.
>
>
>> +       /* Final divh and divl must be greater than 0, otherwise the
>> +        * hardware would not output the i2c clk.
>> +        */
>
> nit: multiline comment style doesn't match rest of file.
>
>
>>   static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long=
 clk_rate)
>>   {
>>          struct i2c_timings *t =3D &i2c->t;
>> -       struct rk3x_i2c_calced_timings calc;
>> +       struct rk3x_i2c_calced_timings *calc =3D &i2c->t_calc;
>>          u64 t_low_ns, t_high_ns;
>>          int ret;
>>
>> -       ret =3D rk3x_i2c_calc_divs(clk_rate, t, &calc);
>> +       ret =3D i2c->soc_data->calc_timings(clk_rate, t, calc);
>>          WARN_ONCE(ret !=3D 0, "Could not reach SCL freq %u", t->bus=
_freq_hz);
>>
>> -       clk_enable(i2c->clk);
>> -       i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xff=
ff),
>> +       if (i2c->pclk)
>> +               clk_enable(i2c->pclk);
>> +       else
>> +               clk_enable(i2c->clk);
>> +       i2c_writel(i2c, (calc->div_high << 16) | (calc->div_low & 0x=
ffff),
>>                     REG_CLKDIV);
>
> There is a subtle bug here, though it likely doesn't manifest in any
> current hardware configurations.
>
> Specifically if you get a clock change on a device with a "v1"
> controller while an i2c transaction is happening then you will likely
> get i2c errors.
>
> The clock change notifications work like this:
> * Before the clock change, adjust the timings based on the faster of
> the old/new clock.
> * Let the clock change happen.
> * If we didn't adjust the timings before, adjust them now.
>
> With the logic above there will be a period where the i2c transaction
> is happening slower than ideal, but that should be OK.  ...and you ca=
n
> imagine the speed of the transaction changing midway through the
> transaction--even midway through a single byte.
>
>
> With v1 some of the timing information is _not_updated by
> rk3x_i2c_adapt_div()--it's only set at the start of a transaction.
> That breaks all the above assumptions.
>
> So you should probably be updating the the RKI2C_CON register here by
> doing a read-modify-write, like:
>
> ctrl =3D i2c_readl(i2c, REG_CON);
> ctrl &=3D ~REG_CON_TUNING_MASK;
> ctrl |=3D i2c->t_calc.tuning;
> i2c_writel(i2c, ctrl, REG_CON);
>
>

Yeap, it seems it is a bug when a clock changes, but not update the=20
regs, it might make transfer failed. It was not enough to just store=20
tuning value.

> Also (optional): once you do that, there becomes much less of a reaso=
n
> to store "t_calc" in "struct rk3x_i2c".  Already you're never using
> the "div_low" and "div_high" that you store in the "struct rk3x_i2c".
> Of course, to do that you've got to change other places not to clobbe=
r
> these bits in REG_CON.
>

So, I only just need to store tuning value in the "struct rk3x_i2c", bu=
t=20
not to store the "div_low" and "div_high"?
>
>> @@ -728,11 +910,11 @@ static int rk3x_i2c_clk_notifier_cb(struct not=
ifier_block *nb, unsigned long
>>   {
>>          struct clk_notifier_data *ndata =3D data;
>>          struct rk3x_i2c *i2c =3D container_of(nb, struct rk3x_i2c, =
clk_rate_nb);
>> -       struct rk3x_i2c_calced_timings calc;
>>
>>          switch (event) {
>>          case PRE_RATE_CHANGE:
>> -               if (rk3x_i2c_calc_divs(ndata->new_rate, &i2c->t, &ca=
lc) !=3D 0)
>> +               if (i2c->soc_data->calc_timings(ndata->new_rate, &i2=
c->t,
>> +                                               &i2c->t_calc) !=3D 0=
)
>
> This change is incorrect.  Please change it back to being calculated
> in a local variable.  Optionally also add a comment that says:
>
> /*
>   * Try the calculation (but don't store the result) ahead of
>   * time to see if we need to block the clock change.  Timings
>   * shouldn't actually take effect until rk3x_i2c_adapt_div().
>   */
>
> Specifically in the case that we return NOTIFY_STOP here we _don't_
> want to have modified our internal timings.  We also _don't_ want to
> have modified our internal timings in the case that the old_rate > th=
e
> new_rate.

Okay, use &i2c->t_calc is an error here, timings shouldn't actually tak=
e=20
effect until rk3x_i2c_adapt_div().

>
> BTW: Did you manage to find anyone using an old Rockchip SoC that can
> test your patches?
>

The patches we have already used in our projects, they are verified by=20
the basic tests. I would ask them to do more tests. Because we didn't=20
change the clock rate now, it was a fixed value when clk inited, so we=20
could not find the bug here.

>
>> @@ -1042,17 +1236,38 @@ static int rk3x_i2c_probe(struct platform_de=
vice *pdev)
>>
>>          platform_set_drvdata(pdev, i2c);
>>
>> +       i2c->clk =3D devm_clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(i2c->clk)) {
>> +               dev_err(&pdev->dev, "cannot get clock\n");
>> +               return PTR_ERR(i2c->clk);
>> +       }
>> +
>>          ret =3D clk_prepare(i2c->clk);
>>          if (ret < 0) {
>>                  dev_err(&pdev->dev, "Could not prepare clock\n");
>>                  return ret;
>>          }
>>
>> +       if (i2c->soc_data->calc_timings =3D=3D rk3x_i2c_v1_calc_timi=
ngs) {
>> +               i2c->pclk =3D devm_clk_get(&pdev->dev, "pclk");
>> +               if (IS_ERR(i2c->pclk)) {
>> +                       dev_err(i2c->dev, "Could not get i2c pclk\n"=
);
>> +                       ret =3D PTR_ERR(i2c->pclk);
>> +                       goto err_clk;
>> +               }
>> +
>> +               ret =3D clk_prepare(i2c->pclk);
>> +               if (ret) {
>> +                       dev_err(i2c->dev, "Could not prepare pclk\n"=
);
>> +                       goto err_clk;
>> +               }
>> +       }
>
> This is not matching the bindings.  You are still assuming that "i2c"
> clock is the first clock and "pclk" is the one named "pclk".  Said
> another way, if you had the following in your device tree:
>
>    clocks =3D  <&pmucru PCLK_I2C0_PMU>, <&pmucru SCLK_I2C0_PMU>;
>    clock-names =3D "pclk", "i2c";
>
> ...you'll find that you'll get back "pclk" twice.  The first time
> you'll get it because you asked for the first clock listed, the secon=
d
> time because you asked for the clock named "pclk".
>
> I'd also say that your life will probably be easier if you always
> setup both "clk" and "pclk", even on old CPUs.  It's OK to call
> "clk_prepare" twice and OK to call "clk_enable" twice.
>
> Thus, I'd probably write all the code as this (untested):
>
>    if (i2c->soc_data->calc_timings =3D=3D rk3x_i2c_v0_calc_timings) {
>      /* Only one clock to use for bus clock and peripheral clock */
>      i2c->clk =3D devm_clk_get(&pdev->dev, NULL);
>      i2c->pclk =3D i2c->clk;
>    } else {
>      i2c->clk =3D devm_clk_get(&pdev->dev, "i2c");
>      i2c->pclk =3D devm_clk_get(&pdev->dev, "pclk");
>    }
>    if (IS_ERR(i2c->clk)) {
>      ret =3D PTR_ERR(i2c->clk);
>      if (ret !=3D -EPROBE_DEFER)
>        dev_err(&pdev->dev, "Can't get bus clk: %d\n", ret);
>      return ret;
>    }
>    if (IS_ERR(i2c->pclk)) {
>      ret =3D PTR_ERR(i2c->pclk);
>      if (ret !=3D -EPROBE_DEFER)
>        dev_err(&pdev->dev, "Can't get periph clk: %d\n", ret);
>      return ret;
>    }
>    ret =3D clk_prepare(i2c->clk);
>    if (ret < 0) {
>      dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
>      return ret;
>    }
>    ret =3D clk_prepare(i2c->pclk);
>    if (ret < 0) {
>      dev_err(&pdev->dev, "Can't prepare periph clock: %d\n", ret);
>      goto err_clk;
>    }
>
> If you take that advice, you can get rid of all of the "if
> (i2c->pclk)" statements in your code.
>

It would make i2c->clk to be enabled and prepared twice when uses=20
rk3x_i2c_v0_calc_timings for old hardware. But if do the opposite
disabled and unprepated twice, that is okay.

>
> -Doug
>
>
>
