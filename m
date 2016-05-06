From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v7 6/9] i2c: rk3x: Move spec timing data to "static const"
 structs
Date: Fri, 6 May 2016 12:55:15 +0800
Message-ID: <572C23B3.6090702@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372472-6396-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=Vg+umhA73uR66AdFmaNKhpyXCYojqE9kZJqkTOsyK_Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:58874 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcEFEzK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 6 May 2016 00:55:10 -0400
In-Reply-To: <CAD=FV=Vg+umhA73uR66AdFmaNKhpyXCYojqE9kZJqkTOsyK_Jg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Doug,

=E5=9C=A8 2016/5/6 6:58, Doug Anderson =E5=86=99=E9=81=93:
> David,
>
> On Wed, May 4, 2016 at 7:34 AM, David Wu <david.wu@rock-chips.com> wr=
ote:
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>
> As you can probably guess, again a description would be nice.  Like m=
aybe:
>
> The i2c timing specs are really just constant data.  There's no reaso=
n
> to write code to init them, so move them out to structures.  This not
> only is a cleaner solution but it will reduce code duplication when w=
e
> introduce a new variant of rk3x_i2c_calc_divs() in a future patch.
>
> That helps someone reading the patch understand the motivation.
>
>
>> @@ -76,6 +76,51 @@ enum {
>>   #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
>>
>>   /**
>> + * struct i2c_spec_values:
>> + * @min_hold_start_ns: min hold time (repeated) START condition
>> + * @min_low_ns: min LOW period of the SCL clock
>> + * @min_high_ns: min HIGH period of the SCL cloc
>> + * @min_setup_start_ns: min set-up time for a repeated START condit=
io
>> + * @max_data_hold_ns: max data hold time
>> + * @min_data_setup_ns: min data set-up time
>> + * @min_setup_stop_ns: min set-up time for STOP condition
>> + * @min_hold_buffer_ns: min bus free time between a STOP and
>> + * START condition
>> + */
>> +struct i2c_spec_values {
>> +       unsigned long min_hold_start_ns;
>> +       unsigned long min_low_ns;
>> +       unsigned long min_high_ns;
>> +       unsigned long min_setup_start_ns;
>> +       unsigned long max_data_hold_ns;
>> +       unsigned long min_data_setup_ns;
>> +       unsigned long min_setup_stop_ns;
>> +       unsigned long min_hold_buffer_ns;
>> +};
>> +
>> +static const struct i2c_spec_values standard_mode_spec =3D {
>> +       .min_hold_start_ns =3D 4000,
>> +       .min_low_ns =3D 4700,
>> +       .min_high_ns =3D 4000,
>> +       .min_setup_start_ns =3D 4700,
>> +       .max_data_hold_ns =3D 3450,
>> +       .min_data_setup_ns =3D 250,
>> +       .min_setup_stop_ns =3D 4000,
>> +       .min_hold_buffer_ns =3D 4700,
>
> There are more spec values than are currently used in this patch.
> Personally I'm OK with that, but if you wanted to be totally clean
> this patch would only include the spec values that were needed, then
> introduce the additional values in the rk3399 patch.
>
>
>> @@ -492,6 +548,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_=
rate,
>>          unsigned long min_div_for_hold, min_total_div;
>>          unsigned long extra_div, extra_low_div, ideal_low_div;
>>
>> +       unsigned long data_hold_buffer_ns =3D 50;
>
> aside (feel free to ignore): Gosh, I kinda forgot what the heck this
> value was for.  I guess it's not anything in the spec.  I have a
> feeling it was some sort of slop value that someone felt was
> necessary, but I don't quite remember.  Oh well, I guess we leave it
> there since I'd rather not mess with timings on old hardware that are
> apparently working for everyone.  :-P
>
>

I thing it was a tuning value for max_t_low_ns. :-P

> In any case, aside from the missing description:
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> IMHO this can be applied any time independent of any earlier patches.
>
>
> -Doug
>
>
>
