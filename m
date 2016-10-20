From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/10] Introduce Juniper PTXPMB CPLD driver
Date: Thu, 20 Oct 2016 15:42:27 +0200
Message-ID: <CACRpkdYkgondu3NuReFg=FZ29Xzi0zncpku0+++_OSsPnUs+Ew@mail.gmail.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>, Debjit Ghosh <dghosh@juniper.net>, Georgi Vlaev <gvlaev@juniper.net>, Guenter Roeck <groeck@juniper.net>, JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>, Rajat Jain <rajatjain@juniper.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vg>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 7, 2016 at 5:17 PM, Pantelis Antoniou
<pantelis.antoniou@konsulko.com> wrote:

> Add Juniper's PTXPMB FPGA CPLD driver. Those FPGAs
> are present in Juniper's PTX series of routers.
>
> The MFD driver provices watchdog/i2c/gpio/mtd devices.

Since it's quite a bunch of patches to quite a bunch of controllers
I think it's best if you get the MFD parts ready and merged through
Lee first for v4.10, then we can add the subdrivers on top, maybe
in v4.11, or on top of an immutable branch from Lee once he is
happy with the core if the MFD core is finished quickly.

I will review all the GPIO stuff though so you can revise these
patches too :)

Yours,
Linus Walleij
