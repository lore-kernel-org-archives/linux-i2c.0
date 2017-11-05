From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: Looking for AT24 maintainer
Date: Sun, 5 Nov 2017 13:31:23 +0100
Message-ID: <CAMRc=Mf4V5hXBtfh6qEz_YrB9R_b9sBx2p0GG3W_FncKGwh=3A@mail.gmail.com>
References: <20171030183926.flybg3oestd43c7h@ninjato> <CAMRc=Mdirm=3iS4bU4Mg=psjmZo9FNnAuZ0_1srrkCvVgnTCfQ@mail.gmail.com>
 <20171101231518.ac5cuddqgzpixgfc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:44656 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdKEMbY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 5 Nov 2017 07:31:24 -0500
Received: by mail-ot0-f178.google.com with SMTP id d36so6207107otf.1
        for <linux-i2c@vger.kernel.org>; Sun, 05 Nov 2017 04:31:24 -0800 (PST)
In-Reply-To: <20171101231518.ac5cuddqgzpixgfc@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>

2017-11-02 0:15 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> Hi Bartosz,
>
>> I have access to a couple compatible chips including some exotic ones
>> and I'm interested in this driver being actively maintained, so I can
>> give it a try.
>
> Awesome! Thank you. I'll prepare a patch for MAINTAINERS in a minute.
>
> As a last thing, I'll take care of this patch for 4.15:
>
> " [v6] eeprom: at24: Add OF device ID table "
>
> But after that, I'd hand things over to you. You can check i2c patchwork
> for a list of pending patches:
>

Sounds good, I'll start picking up patches after the next merge window.

Thanks,
Bartosz
