From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v1 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 09:10:17 -0500
Message-ID: <CAGngYiXtUBbYocb885CPCaXNM=uckeiHc47FXKghDz_B-WNYrg@mail.gmail.com>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com>
 <1512576272-25563-2-git-send-email-svendev@arcx.com> <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:41702 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753328AbdLHOKT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 09:10:19 -0500
In-Reply-To: <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

Hi Bartosz, thanks for the encouragement !

Bartosz wrote:
> Also: please have the AT24/at24 prefix for symbols in the driver.

These specific symbols are declared static, i.e. they're visible only
inside at24.c.
Do you think they should still have an at24 prefix ?

+#define DECLARE_AT24_PLATDATA(_name, _len, _flags) \
+       static const struct at24_platform_data platdata_##_name = { \
+               .byte_len = _len, .flags = _flags, \
+       }
