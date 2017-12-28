From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: at24: consistently document the
 compatible property
Date: Thu, 28 Dec 2017 13:57:22 +0200
Message-ID: <CAHp75VfSr2vMwywUxw4FdiDMK+9_J83TsfXmn0EDkL9xuqPG8w@mail.gmail.com>
References: <20171228104913.29873-1-brgl@bgdev.pl> <20171228104913.29873-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228104913.29873-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 28, 2017 at 12:49 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Current description of the compatible property for at24 is quite vague.
>
> State explicitly that any "<manufacturer>,<model>" pair is accepted as
> long as a correct fallback is used for non-atmel chips.

> -       "atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
> -       "atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
> -       "atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"

> +                "atmel,24c00",
> +                "atmel,24c01",
> +                "atmel,24c02",
> +                "atmel,spd",
> +                "atmel,24c04",

Just to whom it may concern, I still don't like the ordering.
By name is better to read and catch up the (un)supported chips.

-- 
With Best Regards,
Andy Shevchenko
