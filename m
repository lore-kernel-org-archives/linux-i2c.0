From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v6 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Wed, 29 Mar 2017 03:23:25 -0700
Message-ID: <CAFd5g44LhP98nzVoKKN8J3rvBTnA-tXLFP+ActTBwn8UFqCgWA@mail.gmail.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-5-brendanhiggins@google.com> <1490692168.3177.117.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32919 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755188AbdC2KX1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Mar 2017 06:23:27 -0400
Received: by mail-qk0-f180.google.com with SMTP id f11so8541744qkb.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Mar 2017 03:23:26 -0700 (PDT)
In-Reply-To: <1490692168.3177.117.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>

>> +                               ASPEED_I2CD_M_HIGH_SPEED_EN |
>> +                               ASPEED_I2CD_M_SDA_DRIVE_1T_EN |
>
> s/ASPEED_I2CD_M_SDA_DRIVE_1T_EN/ASPEED_I2CD_M_SCL_DRIVE_1T_EN/
>
> (and in the definition too)

Will fix.

>
>> +                               ASPEED_I2CD_SDA_DRIVE_1T_EN,
>> +                               ASPEED_I2C_FUN_CTRL_REG);
>> +
>> +               aspeed_i2c_write(bus, 0x3, ASPEED_I2C_AC_TIMING_REG2);
>> +               aspeed_i2c_write(bus, aspeed_i2c_get_clk_reg_val(divisor),
>> +                                ASPEED_I2C_AC_TIMING_REG1);
>> +       } else {
>
> I don't think that's right. AFAIK ASPEED_I2CD_M_HIGH_SPEED_EN is about
> ignoring the timing register completely and going for full speed which
> is a few Mhz (I forgot how much). At least from my (possibly incorrect)
> reading of the spec and the SDK driver.
>
> Or maybe that's what you intend by the above ? Anything above 1Mhz ?
>
> I think there's a blurb somewhere that says that setting that bit makes
> it ignore the timing register completely. The definition is:
>
> <<
> Enable High Speed master mode
> 0 : normal speed mode
> 1 : high speed mode (3.4Mbps)
> High speed mode can only use buffer mode for transfer. And only master
> mode supports speed switching capability
>>>

Yeah, I was picking an arbitrary cutoff and 1MHz seemed reasonable in
part because in order to get above 1MHz you would set the divisor to 0
(1 << 0) anyway because you will only modify the SCL high and low time
for anything less than that. Also because that was the cutoff for fast
mode (as opposed to high speed).

>
> The spec of the base clock field of the timing register also says
>
> <<
> When switch to High Speed (HS) mode, the divisor will be switch to 0 by
> hardware automatically
>>>
>
> Note also that we aren't use buffer mode anyway so this can't work as-
> is, we're using byte mode.
>

Good catch. Yeah, I did not realize it. I should probably remove this
until that is supported then.

> The other interesting question is what is the frequency threshold for
> setting ASPEED_I2CD_M_SCL_DRIVE_1T_EN (and the SDA one) ?

I would guess that we should make them correspond to the cutoff for
high speed mode, or fast mode plus. Not really sure though, the
documentation is not clear on this (or a lot of other things :-P)

>
> Those bits are somewhat orthogonal to ASPEED_I2CD_M_HIGH_SPEED_EN. They
> make the device drive the signals for a clock when they go up to "speed
> up" the rising edge more than a normal pull up would do.
>
> If you have some fast devices, it would be interesting to scope the
> signal see from what speed it becomes interesting to set the 1T enable
> bits to speed up rising edges.

Agreed.
