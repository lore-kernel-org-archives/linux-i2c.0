From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] hwmon/ltc2990: Generalise DT to fwnode support
Date: Fri, 16 Aug 2019 14:36:46 +0200
Message-ID: <CAMuHMdVBviJgxnzLbJJO8ap+=SiiN+wGOsRg4kvnV6eGpnAxKg@mail.gmail.com>
References: <5b9b4383-c1e9-91a6-8ab6-8f831b362dca@enpas.org>
 <20190816090731.12809-1-max@enpas.org> <CAMuHMdUE_3UEzOv3pmryMwuMRF7RC9-xTG8sXUbpR=r5fKUjrg@mail.gmail.com>
 <79f1e829-8fd4-6690-e429-f5b3d1a7c0bd@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79f1e829-8fd4-6690-e429-f5b3d1a7c0bd@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

On Fri, Aug 16, 2019 at 2:25 PM Max Staudt <max@enpas.org> wrote:
> On 08/16/2019 01:07 PM, Geert Uytterhoeven wrote:
> > One minor nit: as the driver no longer uses any of_*() symbols, you can replace
> > #include <linux/of.h> by #include <linux/property.h>.
>
> I should have thought of that, sorry.
>
> Another patch, or will you do it?

As the patch won't go through my tree, I cannot, but the hwmon maintainer
might do.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
