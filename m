From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 2/2] dt-bindings: add eeprom "at24,no-read-rollover" property
Date: Thu, 7 Dec 2017 15:21:54 +0100
Message-ID: <CAMRc=Mc1MvDcZO=Lr-v33G-bFR1ds-uLs1ra2XO68g4vqSkafw@mail.gmail.com>
References: <1512487422-6284-1-git-send-email-svendev@arcx.com>
 <1512487422-6284-3-git-send-email-svendev@arcx.com> <20171206220404.oyqg6ckhdx7jtbxw@rob-hp-laptop>
 <CAGngYiXLeVVSn-Fn9WGXd4zNmQ0SBZcuSAdrv-d2K=Wp0zHN0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f171.google.com ([74.125.82.171]:44941 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753589AbdLGOVz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Dec 2017 09:21:55 -0500
Received: by mail-ot0-f171.google.com with SMTP id d27so6449241ote.11
        for <linux-i2c@vger.kernel.org>; Thu, 07 Dec 2017 06:21:54 -0800 (PST)
In-Reply-To: <CAGngYiXLeVVSn-Fn9WGXd4zNmQ0SBZcuSAdrv-d2K=Wp0zHN0A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Sven Van Asbroeck <svendev@arcx.com>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner <david@lechnology.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

2017-12-07 15:06 GMT+01:00 Sven Van Asbroeck <thesven73@gmail.com>:
>> at24 is not a vendor prefix. Either this is atmel specific and you want
>> atmel,no-read-rollover or it is for all vendors at24 compatible eeproms
>> and you want at24-no-read-rollover. Or just drop the at24 if this
>> binding is in fact for just at24 eeproms as none of the other properties
>> has at24 in them.
>
> Bartosz, shall I rename
> at24,no-read-rollover -> no-read-rollover ?

Yes, please.

Thanks,
Bartosz
