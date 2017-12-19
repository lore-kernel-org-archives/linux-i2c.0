From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 2/3] i2c: core: add device-managed version of i2c_new_dummy
Date: Tue, 19 Dec 2017 09:34:51 +0100
Message-ID: <CAMRc=MdrMfpYXNOw8XBvwt2-VT12+KPWT=phHTL8KBZiZriYSQ@mail.gmail.com>
References: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
 <ca47ea36-9b0a-c247-29f5-1c512f52e835@gmail.com> <CAMRc=MfWv0yZsLuF8wfqBK6cNoPkMoG6oNwa3ov9nRceJ1ykHw@mail.gmail.com>
 <20171218203042.y6u7uvlhdlvozbkv@ninjato> <CAMRc=MfFXKnQUiJS0j+RodXzXRDreAnWZqvOUK945fe8pkVHsA@mail.gmail.com>
 <20171219082827.wl4q46lpgv5zvivq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45556 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759028AbdLSIew (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Dec 2017 03:34:52 -0500
Received: by mail-oi0-f65.google.com with SMTP id x20so11873803oix.12
        for <linux-i2c@vger.kernel.org>; Tue, 19 Dec 2017 00:34:52 -0800 (PST)
In-Reply-To: <20171219082827.wl4q46lpgv5zvivq@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-19 9:28 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> Indeed, but in this case, if you pick up the whole series, you'll run
>> into a conflict with patch 3/3 since at24 in my tree diverged so much
>> from mainline.
>
> I suggest then: if I apply the core patches, I'll send you a pull
> request with an immutable branch to pull in. D'accord?
>

Sound good.

Thanks,
Bartosz
