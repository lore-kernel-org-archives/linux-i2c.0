From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 1/2] eeprom: at24: fix coding style issues
Date: Sun, 10 Dec 2017 13:49:37 +0100
Message-ID: <CAMRc=MeMhFj7qFRSVP27mbhOCejtjq6K=44LZ-ruRvxrRELEpA@mail.gmail.com>
References: <20171207133915.29448-1-brgl@bgdev.pl> <20171207133915.29448-2-brgl@bgdev.pl>
 <20171210013140.62bwezb2pnovf2x6@christoph-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:40010 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdLJMti (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 10 Dec 2017 07:49:38 -0500
Received: by mail-ot0-f181.google.com with SMTP id e74so12638714ote.7
        for <linux-i2c@vger.kernel.org>; Sun, 10 Dec 2017 04:49:38 -0800 (PST)
In-Reply-To: <20171210013140.62bwezb2pnovf2x6@christoph-lap>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-10 2:31 GMT+01:00 Christoph B=C3=B6hmwalder <christoph@boehmwalder.=
at>:
> On Thu, Dec 07, 2017 at 02:39:14PM +0100, Bartosz Golaszewski wrote:
>> -#define AT24_DEVICE_MAGIC(_len, _flags)              \
>> -     ((1 << AT24_SIZE_FLAGS | (_flags))              \
>> +#define AT24_DEVICE_MAGIC(_len, _flags)                      \
>> +     ((1 << AT24_SIZE_FLAGS | (_flags))              \
>>           << AT24_SIZE_BYTELEN | ilog2(_len))
>
> Looks like there's been a whitespace accident on that first added line.
> (Backslash has one more tab in front of it than it should have)
>
> --
> Regards,
> Christoph

It's only the way diff prints the patch. The file looks correct.

Thanks,
Bartosz
