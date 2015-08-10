From: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: core: add support for read commands longer than byte
Date: Mon, 10 Aug 2015 12:06:07 +0200
Message-ID: <CAKv63usQZBqjcAWFEpFvkRuGLd7JXcJh=5aKmd8B94A68dsZ7w@mail.gmail.com>
References: <1437744042-24471-1-git-send-email-cmo@melexis.com>
 <20150809074006.GC1526@katana> <CAKv63usiWb4QgV=pnwuqFJtTogRca7UjtmiSKV69OTM2h7LtHw@mail.gmail.com>
 <20150810091352.GB4682@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150810091352.GB4682@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "Simon G. Vogl" <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10 August 2015 at 11:13, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>
> > This debate is what I wanted to have. The new Melexis sensor will be
> > using it and since I think some others might also be using it in
> > future I would rather put it to i2c. It is more i2c command than
> > sensor specific so I think it fits into i2c.
>
> There is no thing as 'I2C command'. There are just I2C messages combined
> into a transfer. I think you mix SMBus and I2C terminology here.
>
This is true, but write/read sequence can also be a request/reply
which is basically
a command for reading.

> > Another gain is that when number of functions each device does increase, as
> > well as ram/rom addressing read commands with longer than 8-bit register read
> > commands will be needed. Especially since most sensors have digital design of
> > i2c interface (not software) which means native access to registers is required,
> > therefor 8bit read addressing (smbus) might not be suitable.
>
> Adding a function to i2c-core will grow the kernel for everyone. So, it
> really has to be justified. So, here is the deal: If you can send a
> series which fixes existing drivers to use your new function and it
> shows that it really saves code, we can add it. Otherwise "thinking it
> might be useful in the future" is too vague for me in this case.
>
Same function as my exists in: ./drivers/base/regmap/regmap-i2c.c ,
maybe it is better
just to use that?

So far in IIO I have found:
-./drivers/iio/accel/bmc150-accel.c:913
-./drivers/iio/gyro/itg3200_buffer.c:26 itg3200_read_all_channels

Grep showed me quite a bit more in drivers for example (won't list all):
-./drivers/mfd/menelaus.c:899 menelaus_read_time
-./drivers/mfd/tps65912-i2c.c:25 tps65912_i2c_read
-./drivers/rtc/rtc-pcf8563.c:81 pcf8563_read_block_data
-./drivers/rtc/rtc-ds1672.c:33 ds1672_get_datetime
-./drivers/power/ltc2941-battery-gauge.c:90 ltc294x_read_regs
Also in other parts:
-./sound/soc/codecs/rl6347a.c:79 rl6347a_hw_read
-./sound/soc/codecs/tas5086.c:202 tas5086_reg_read
-./sound/soc/codecs/sigmadsp-i2c.c: 37 sigmadsp_read_i2c
as well as good resemblance:
-./arch/arm/mach-davinci/board-dm644x-evm.c:517 dm6444evm_msp430_get_pins

Do you want me to prepare a patch to fix all this?
> > I can fix the function name, but in core this is a master read command.
>
> What "core" are you referring to?
>
> You set up a write and a read message, no?
>
True, but focus is on read
