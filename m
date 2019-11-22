From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] nvmem: add support for the write-protect pin
Date: Fri, 22 Nov 2019 13:47:10 +0100
Message-ID: <CACRpkdYwwHbjrSq7DRyCkD4jDXYoWFWNnUi-SkCZ5gUAkbxOZQ@mail.gmail.com>
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-3-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120142038.30746-3-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Khouloud,

more comments!

On Wed, Nov 20, 2019 at 3:21 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> +       if (nvmem->reg_write) {
> +               gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
> +               ret = nvmem->reg_write(nvmem->priv, offset, val, bytes);
> +               gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
> +               return ret;
> +       }

Since I requested that the GPIO line shall be flagged as
active low in the device tree, make sure to invert this
and toss in a comment:

/*
 * We assert and deassert the write protection GPIO line.
 * This line is often active low, but that semantic is handled
 * in gpiolib in respons to flags in the machine description,
 * such as the device tree or ACPI.
 */
gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
ret = nvmem->reg_write(nvmem->priv, offset, val, bytes);
gpiod_set_value_cansleep(nvmem->wp_gpio, 0);

> @@ -365,6 +372,15 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>                 kfree(nvmem);
>                 return ERR_PTR(rval);
>         }
> +       if (config->wp_gpio)
> +               nvmem->wp_gpio = config->wp_gpio;
> +       else
> +               nvmem->wp_gpio = gpiod_get_optional(config->dev,
> +                                                   "wp",
> +                                                   GPIOD_OUT_HIGH);

GPIOD_OUT_LOW as it will be inverted.

Apart from this I like the idea in this patch!

Yours,
Linus Walleij
