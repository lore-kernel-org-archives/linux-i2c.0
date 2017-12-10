From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/2] eeprom: at24: fix coding style issues
Date: Sun, 10 Dec 2017 14:57:18 +0200
Message-ID: <CAHp75VfoG++eRAhZ9ZT7me6tZqxxVMzQHd8GcauszRQDDkGGFg@mail.gmail.com>
References: <20171207133915.29448-1-brgl@bgdev.pl> <20171207133915.29448-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:41976 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbdLJM5T (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 10 Dec 2017 07:57:19 -0500
In-Reply-To: <20171207133915.29448-2-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Dec 7, 2017 at 3:39 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Fix issues reported by checkpatch for at24.c.

> +module_param(io_limit, uint, 0000);

> +module_param(write_timeout, uint, 0000);


0 is a pretty much octal number as 0000.
So, I would prefer not to blindly follow the stupid advise from
checkpatch, better to teach checkpatch about 0.


-- 
With Best Regards,
Andy Shevchenko
