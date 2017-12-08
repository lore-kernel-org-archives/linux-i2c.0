From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v1 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 09:17:00 -0500
Message-ID: <CAGngYiWdnE9Ztu3uGeqAS+Ksag6-W84AORJnWb1Xzc7EMBwZNg@mail.gmail.com>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com>
 <1512576272-25563-2-git-send-email-svendev@arcx.com> <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36894 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbdLHORE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 09:17:04 -0500
In-Reply-To: <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

Bartosz wrote:
>> +#define AT24_OF_DEVICE_ID(_mfg, _name) \
>> +       { .compatible = #_mfg "," #_name, .data = &platdata_##_name }
>
> I don't like hiding the way the compatible is created here from the
> user. It doesn't save any code neither. Please make the macro accept
> the whole compatible string.
>

If the macro accepts the whole compatible string "mfg,chip-name" (e.g.
"atmel,24c01")
then how can I extract chip-name from that string? I need to attach
chip-name to the
platdata_ static structures. (e.g. "atmel,24c01" -> .data = platdata_24c01)
