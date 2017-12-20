From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v3 1/1] eeprom: at24: convert magic numbers to structs.
Date: Wed, 20 Dec 2017 11:42:24 -0500
Message-ID: <CAGngYiXUrzyPZ-JrktKyxKNx7hm16=ati4nzQVAbenJ5wJFsxg@mail.gmail.com>
References: <1513621702-6565-1-git-send-email-svenv@arcx.com>
 <1513621702-6565-2-git-send-email-svenv@arcx.com> <CAMRc=Md0VwJ=OeE_-2uWi2sr4gJ8v9CnmexYgdDGR0pbyXYo_g@mail.gmail.com>
 <CAGngYiVJRVuMtLThnvsXbXMuL-_4ZN=2RkuCkRBzq3cf+W4sPg@mail.gmail.com> <CAMRc=McQThGRYqmbue8jw_uKQPicitQn6rNxZxo9+HYQ3UaYDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:37661 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755657AbdLTQmZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 11:42:25 -0500
In-Reply-To: <CAMRc=McQThGRYqmbue8jw_uKQPicitQn6rNxZxo9+HYQ3UaYDw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sven Van Asbroeck <svenv@arcx.com>, Sven Van Asbroeck <svendev@arcx.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

> I'm at 77 columns if I add a single tab after '.compatible = "atmel,24c1024"'.

You're right, I had to knock some sense into my editor first :)

>
> It looks nice like this, so I prefer to keep it.

Ok I'll post a v5.
