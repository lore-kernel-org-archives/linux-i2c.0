From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v7 9/9] i2c: rk3x: support fast-mode plus for rk3399
Date: Fri, 6 May 2016 10:12:04 +0800
Message-ID: <572BFD74.9080200@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372668-6583-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=UtHPDtB7LTbUpwcjOcoYwNma59-TRDU3hrt6c_2TWxxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:49611 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbcEFCLx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 22:11:53 -0400
In-Reply-To: <CAD=FV=UtHPDtB7LTbUpwcjOcoYwNma59-TRDU3hrt6c_2TWxxA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Doug,

=E5=9C=A8 2016/5/6 7:02, Doug Anderson =E5=86=99=E9=81=93:
> David,
>
> On Wed, May 4, 2016 at 7:37 AM, David Wu <david.wu@rock-chips.com> wr=
ote:
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> ---
>>   drivers/i2c/busses/i2c-rk3x.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-=
rk3x.c
>> index 47368c4..c66cc39 100644
>> --- a/drivers/i2c/busses/i2c-rk3x.c
>> +++ b/drivers/i2c/busses/i2c-rk3x.c
>> @@ -124,6 +124,17 @@ static const struct i2c_spec_values fast_mode_s=
pec =3D {
>>          .min_hold_buffer_ns =3D 1300,
>>   };
>>
>> +static const struct i2c_spec_values fast_mode_plus_spec =3D {
>> +       .min_hold_start_ns =3D 260,
>> +       .min_low_ns =3D 500,
>> +       .min_high_ns =3D 260,
>> +       .min_setup_start_ns =3D 260,
>> +       .max_data_hold_ns =3D 400,
>
> I'm curious where you got the data_hold_ns.  I can't quite remember
> what this parameter does / how the timing function works anymore, but
> the doc I have (search for UM10204 and click the first link) shows
> values for Standard-mode and Fast-mode but not Fast-mode Plus.  It
> seems to imply that this is a bit of a bogus number anyway because it
> only matters if we don't stretch the tLOW to go along with the longer
> data hold.
>
> As I have said in the previous patch, how all this stuff works has
> totally left my brain, so if you understand it that's probably good
> enough.  If you feel like I should try to re-understand this again so
> I can review it more deeply, let me know.
>
>

Yes, I could not get the description of fast-mode plus data_hold_ns, bu=
t=20
I saw that the maximum tHD;DAT must be less than the maximum of=20
tVD;DATor tVD;ACKby for Standard-mode and Fast-mode.

So I think the maximum tHD;DAT for Fast-mode Plus should be less than=20
the maximum of tVD;DATor tVD;ACKby too, the maximum of tVD;DATor=20
tVD;ACKby is 450ns, and 400ns is my taking a conservative value.

Description form UM10204
[4] The maximum tHD;DATcould be 3.45=CE=BCs and 0.9=CE=BCs for Standard=
-mode and=20
=46ast-mode, but must be less than the maximum of tVD;DATor tVD;ACKby a=
=20
transition time. This maximum must only be met if the device does not=20
stretch the LOW period (tLOW) of the SCL signal. If the clock stretches=
=20
the SCL, the data must be valid by the set-up time before it releases
the clock.

> Since I assume that you had some sane reason to include max_data_hold=
_ns:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
>
>
