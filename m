From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 11/14] eeprom: at24: add the at24cs series to the
 list of supported devices
Date: Fri, 15 Jul 2016 10:54:24 +0200
Message-ID: <CAMpxmJWeEXSsoTFfg-Lx3pMC0mfSY0=Ez4Tg1Z2nhf5wJyQTPA@mail.gmail.com>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-12-git-send-email-bgolaszewski@baylibre.com> <20160715063047.GA7675@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36557 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbcGOIyZ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Jul 2016 04:54:25 -0400
Received: by mail-it0-f41.google.com with SMTP id f6so13552759ith.1
        for <linux-i2c@vger.kernel.org>; Fri, 15 Jul 2016 01:54:25 -0700 (PDT)
In-Reply-To: <20160715063047.GA7675@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>

2016-07-15 8:30 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
>
>>       { "24c01",      AT24_DEVICE_MAGIC(1024 / 8,     0) },
>> +     { "24cs01",     AT24_DEVICE_MAGIC(128 / 8,
>
> I encoded the size for EEPROMs with "x / 8" originally to make it
> visible where the EEPROM name came from, i.e. that is from kilobits not
> kilobytes. So, for the serial number I would simply encode the size as
> 16 and not as (128 / 8), because it has nothing to do with the name. I
> can fix this locally if you are okay with the idea?
>

Sure, thanks!

Bart
