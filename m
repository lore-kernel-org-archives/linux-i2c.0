From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 1/2] at24: support eeproms that do not auto-rollover reads.
Date: Thu, 7 Dec 2017 22:33:51 +0100
Message-ID: <CAMRc=MeEnDYjDTpE=XKuP3LricsnEnh0RHKMzxEPUcOS6E0tPQ@mail.gmail.com>
References: <1512657378-5221-1-git-send-email-svendev@arcx.com>
 <1512657378-5221-2-git-send-email-svendev@arcx.com> <CAMRc=MdhJRD+G18Xh5vfmaHHdJ+g9EnDTxUHVxhzDzVt-D0KMg@mail.gmail.com>
 <20171207190230.ttq5xthgsuuy4swn@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34409 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdLGVdw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Dec 2017 16:33:52 -0500
Received: by mail-oi0-f50.google.com with SMTP id u193so5943518oie.1
        for <linux-i2c@vger.kernel.org>; Thu, 07 Dec 2017 13:33:51 -0800 (PST)
In-Reply-To: <20171207190230.ttq5xthgsuuy4swn@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner <david@lechnology.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

2017-12-07 20:02 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> Hello,
>
> On Thu, Dec 07, 2017 at 05:26:50PM +0100, Bartosz Golaszewski wrote:
>> > +       if (at24->chip.flags & AT24_FLAG_NO_RDROL) {
>> > +               bits =3D (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : =
8;
>>
>> There's no need for braces around the ternary operator's condition.
>
> Even if not required, I'd keep them for clearity.
>

I don't want to start bikeshedding, so I'll take it as it is, but I
prefer to avoid braces wherever it's not necessary.

Thanks,
Bartosz
