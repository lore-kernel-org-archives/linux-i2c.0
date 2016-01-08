From: "David.Wu" <wdc@rock-chips.com>
Subject: Re: [PATCH v1 1/3] i2c: rk3x: add calc_divs ops for new version
Date: Fri, 8 Jan 2016 21:12:29 +0800
Message-ID: <568FB5BD.9050809@rock-chips.com>
References: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
 <566F5FAC.3080404@rock-chips.com>
 <CAHp75VfkteDvC0KUXOXDik9rQeanTXLn9Qq3wux-0rxk5ZotNA@mail.gmail.com>
 <20160104194042.GD1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160104194042.GD1522@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jianqun Xu <jay.xu@rock-chips.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, dianders@chromium.org, huangtao@rock-chips.com, zyw@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Wu <david.wu@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram, Andy

Thanks for your suggestion.
I will  use i2c_parse_fw_timings() function to replace it.

=E5=9C=A8 2016/1/5 3:40, Wolfram Sang =E5=86=99=E9=81=93:
>>>> +static int rk3x_i2c_v0_calc_divs(unsigned long clk_rate, unsigned=
 long
>>>> scl_rate,
>>>> +                                unsigned long scl_rise_ns,
>>>> +                                unsigned long scl_fall_ns,
>>>> +                                unsigned long sda_fall_ns,
>> Wolfram did some sturct to assign the parameters from device propert=
ies.
>> It might be re-used here.
> Yes, I think it makes sense to convert the driver first to use
> the new i2c_parse_fw_timings() function and see if it fits (or if we =
need
> to extend it perhaps).
>
> David, does this make sense to you?
>
