From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 2/3] i2c: core: add device-managed version of i2c_new_dummy
Date: Tue, 19 Dec 2017 09:22:48 +0100
Message-ID: <CAMRc=MfFXKnQUiJS0j+RodXzXRDreAnWZqvOUK945fe8pkVHsA@mail.gmail.com>
References: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
 <ca47ea36-9b0a-c247-29f5-1c512f52e835@gmail.com> <CAMRc=MfWv0yZsLuF8wfqBK6cNoPkMoG6oNwa3ov9nRceJ1ykHw@mail.gmail.com>
 <20171218203042.y6u7uvlhdlvozbkv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45671 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933207AbdLSIWt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Dec 2017 03:22:49 -0500
Received: by mail-ot0-f195.google.com with SMTP id d44so6576985otd.12
        for <linux-i2c@vger.kernel.org>; Tue, 19 Dec 2017 00:22:49 -0800 (PST)
In-Reply-To: <20171218203042.y6u7uvlhdlvozbkv@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-18 21:30 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> @Wolfram: if you're ok with these changes, I think they should go
>> through my tree. Let me know if you agree.
>
> Frankly, adding 115 lines to i2c-core should go through my tree, I
> think. Still need to look at the latest revision, though.
>

Indeed, but in this case, if you pick up the whole series, you'll run
into a conflict with patch 3/3 since at24 in my tree diverged so much
from mainline.

Thanks,
Bartosz
