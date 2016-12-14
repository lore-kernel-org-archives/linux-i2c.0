From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 5/5] mfd: axp20x: Fix axp288 volatile ranges
Date: Wed, 14 Dec 2016 16:07:23 +0100
Message-ID: <b3d9f09e-dfd1-5908-59f8-b6ed146f84bc@redhat.com>
References: <20161214135209.16369-1-hdegoede@redhat.com>
 <20161214135209.16369-5-hdegoede@redhat.com>
 <CAGb2v66Wd06foGn3dxaVrTYZrfhwox0Mc1YB=jM5+Z87UWXMrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932370AbcLNPHb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 10:07:31 -0500
In-Reply-To: <CAGb2v66Wd06foGn3dxaVrTYZrfhwox0Mc1YB=jM5+Z87UWXMrg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee.jones@linaro.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Hi,

On 14-12-16 15:41, Chen-Yu Tsai wrote:
> On Wed, Dec 14, 2016 at 9:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The axp288 pmic has a lot more volatile registers then we were
>> listing in axp288_volatile_ranges, fix this.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mfd/axp20x.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index a294121..b9c1adf 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -117,7 +117,10 @@ static const struct regmap_range axp288_writeable_ranges[] = {
>>  };
>>
>>  static const struct regmap_range axp288_volatile_ranges[] = {
>> +       regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
>
> Actually register 0x02 is volatile as well. Various fields say "write
> 1 to clear".
> You might need a new define for it though, as the usage is different.
>
>>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
>> +       regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>> +       regmap_reg_range(AXP20X_FG_RES, AXP288_FG_CC_CAP_REG),
>
> Could you also add AXP20X_TIMER_CTRL and 0xa0 ~ 0xa1 (real time
> battery voltage),
> if you're adding defines?

Hmm, ok, I'll do 2 new patches then 1 adding the defines and a v2
of this one. Lee, can you pick up 1 - 4 as they currently are
please? Then I'll just send these 2 new patches.

Regards,

Hans
