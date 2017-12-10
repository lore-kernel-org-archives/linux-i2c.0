From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 1/2] eeprom: at24: fix coding style issues
Date: Sun, 10 Dec 2017 19:42:52 +0100
Message-ID: <CAMRc=MesSDBmqLWAWw7gKz_Gaqhwuy7CtFS4gob_8Oy1ztTVHw@mail.gmail.com>
References: <20171207133915.29448-1-brgl@bgdev.pl> <20171207133915.29448-2-brgl@bgdev.pl>
 <CAHp75VfoG++eRAhZ9ZT7me6tZqxxVMzQHd8GcauszRQDDkGGFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44288 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbdLJSmx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 10 Dec 2017 13:42:53 -0500
Received: by mail-ot0-f195.google.com with SMTP id d27so13024655ote.11
        for <linux-i2c@vger.kernel.org>; Sun, 10 Dec 2017 10:42:53 -0800 (PST)
In-Reply-To: <CAHp75VfoG++eRAhZ9ZT7me6tZqxxVMzQHd8GcauszRQDDkGGFg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2017-12-10 13:57 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Thu, Dec 7, 2017 at 3:39 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> Fix issues reported by checkpatch for at24.c.
>
>> +module_param(io_limit, uint, 0000);
>
>> +module_param(write_timeout, uint, 0000);
>
>
> 0 is a pretty much octal number as 0000.
> So, I would prefer not to blindly follow the stupid advise from
> checkpatch, better to teach checkpatch about 0.
>
>

I submitted a patch for that - let's see what checkpatch maintainers say.

Thanks,
Bartosz
