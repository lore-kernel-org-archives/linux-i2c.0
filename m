From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 0/5] eeprom: at24: device tree support fixes
Date: Thu, 21 Dec 2017 14:50:48 +0100
Message-ID: <CAMRc=MdFPPHEvv9GOdELXn7PTeYQBHxUchjby3fto_Di2Z5vnQ@mail.gmail.com>
References: <20171221130830.16813-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40606 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdLUNut (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:50:49 -0500
Received: by mail-ot0-f194.google.com with SMTP id o39so3015020otd.7
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:50:49 -0800 (PST)
In-Reply-To: <20171221130830.16813-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>

2017-12-21 14:08 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> The first three patches fix certain issues with the DT binding
> document.
>
> The last two extend the device tree support in the driver with more
> at24 EEPROM variants.
>
> Bartosz Golaszewski (5):
>   dt-bindings: at24: consistently document the compatible property
>   dt-bindings: at24: add a missing compatible
>   dt-bindings: at24: fix formatting and style
>   dt-bindings: at24: extend the list of supported chips
>   eeprom: at24: extend the list of chips supported in DT
>
>  Documentation/devicetree/bindings/eeprom/at24.txt | 84 ++++++++++++++---------
>  drivers/misc/eeprom/at24.c                        |  9 +++
>  2 files changed, 59 insertions(+), 34 deletions(-)
>
> --
> 2.15.1
>

Superseded by v2.
