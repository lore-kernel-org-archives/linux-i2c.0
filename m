From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 05/14] eeprom: at24: hide the read/write loop
 behind a macro
Date: Sat, 16 Jul 2016 21:25:08 +0200
Message-ID: <CAMpxmJWniibfkoQCFgpwH8D23t8V1+3g=NBY2tmNZsGN=6Ufvg@mail.gmail.com>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-6-git-send-email-bgolaszewski@baylibre.com>
 <20160715122429.GA2620@tetsubishi> <CAMpxmJU+HDvUb__Q6UvuaVC70+GdSU312uVuXuicqsn6_v2uKQ@mail.gmail.com>
 <20160715150352.GB5136@tetsubishi> <20160716045651.GB1677@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38371 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbcGPTZK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 16 Jul 2016 15:25:10 -0400
Received: by mail-it0-f45.google.com with SMTP id j124so1970604ith.1
        for <linux-i2c@vger.kernel.org>; Sat, 16 Jul 2016 12:25:09 -0700 (PDT)
In-Reply-To: <20160716045651.GB1677@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>

2016-07-16 6:56 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> > >> +#define loop_until_timeout(tout, op_time)                            \
>> > >> +     for (tout = jiffies + msecs_to_jiffies(write_timeout),          \
>> > >> +             op_time = jiffies;                                      \
>> > >> +          time_before(op_time, tout);                                \
>> > >> +          usleep_range(1000, 1500), op_time = jiffies)
>
> What about:
>
> #define loop_until_timeout(tout, op_time)                                \
>      for (tout = jiffies + msecs_to_jiffies(write_timeout), op_time = 0; \
>           op_time ? time_before(op_time, tout) : true;                   \
>           usleep_range(1000, 1500), op_time = jiffies)
>
> ? Would probably need an explanation in a comment, though.
>

Hi Wolfram,

thanks for the suggestion, it looks good. I'm not at home right now
and don't have access to any device with which I could test it. I'll
try to send the patch tomorrow evening or Monday morning.

Best regards,
Bartosz Golaszewski
