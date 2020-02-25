From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/1] i2c: imc: Add support for Intel iMC SMBus host controller.
Date: Tue, 25 Feb 2020 10:22:23 +0200
Message-ID: <CAHp75Veoj8ZpqAoGGAphjPQDn0i+5c_WS3U+mRMiinCuK0YBYQ@mail.gmail.com>
References: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40981 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgBYIWf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Feb 2020 03:22:35 -0500
In-Reply-To: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Schaeckeler <schaecsn@gmx.net>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>

On Mon, Feb 24, 2020 at 12:54 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> This patch is based on Andy Lutomirski's iMC SMBus driver patch-set
> https://lkml.org/lkml/2016/4/28/926. It never made it into the kernel. I hope
> this rewrite will:

Thanks for the patch!
I'll review the code later.

I think the better to have a documentation file where you describe
stuff like enumeration and so on for this drivers (under Documentation
folder).

> Stefan Schaeckeler (1):
>   i2c: imc: Add support for Intel iMC SMBus host controller.
>
>  MAINTAINERS                  |   5 +
>  drivers/i2c/busses/Kconfig   |  15 ++
>  drivers/i2c/busses/Makefile  |   1 +
>  drivers/i2c/busses/i2c-imc.c | 515 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 536 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-imc.c
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
