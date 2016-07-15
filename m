From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 05/14] eeprom: at24: hide the read/write loop
 behind a macro
Date: Fri, 15 Jul 2016 14:49:58 +0200
Message-ID: <CAMpxmJU+HDvUb__Q6UvuaVC70+GdSU312uVuXuicqsn6_v2uKQ@mail.gmail.com>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-6-git-send-email-bgolaszewski@baylibre.com> <20160715122429.GA2620@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34162 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbcGOMuA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Jul 2016 08:50:00 -0400
Received: by mail-io0-f180.google.com with SMTP id q83so103455092iod.1
        for <linux-i2c@vger.kernel.org>; Fri, 15 Jul 2016 05:49:59 -0700 (PDT)
In-Reply-To: <20160715122429.GA2620@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>

2016-07-15 14:24 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
>> +/*
>> + * Both reads and writes fail if the previous write didn't complete yet. This
>> + * macro loops a few times waiting at least long enough for one entire page
>> + * write to work.
>> + *
>> + * It takes two parameters: a variable in which the future timeout in jiffies
>> + * will be stored and a temporary variable holding the time of the last
>> + * iteration of processing the request. Both should be unsigned integers
>> + * holding at least 32 bits.
>> + */
>> +#define loop_until_timeout(tout, op_time)                            \
>> +     for (tout = jiffies + msecs_to_jiffies(write_timeout),          \
>> +             op_time = jiffies;                                      \
>> +          time_before(op_time, tout);                                \
>> +          usleep_range(1000, 1500), op_time = jiffies)
>
> There is one subtle change coming with this change: the do-while loop is
> guaranteed to run at least once while the for-loop doesn't.
>

While it's technically possible, it will never happen as long as
write_timeout is set to some sensible value.

Thanks,
Bartosz
