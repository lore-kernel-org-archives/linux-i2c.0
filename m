From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: nvmem: new optional property wp-gpios
Date: Tue, 7 Jan 2020 10:50:48 +0100
Message-ID: <CACRpkdZQUzqzHovO6qb7ExGFraTx8ovYgeAaYKADhZPH86hKBw@mail.gmail.com>
References: <20200107092922.18408-1-ktouil@baylibre.com> <20200107092922.18408-2-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107092922.18408-2-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 7, 2020 at 10:29 AM Khouloud Touil <ktouil@baylibre.com> wrote:

> Several memories have a write-protect pin, that when pulled high, it
> blocks the write operation.
>
> On some boards, this pin is connected to a GPIO and pulled high by
> default, which forces the user to manually change its state before
> writing.
>
> Instead of modifying all the memory drivers to check this pin, make
> the NVMEM subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
>
> Add a new optional property to the device tree binding document, which
> allows to specify the GPIO line to which the write-protect pin is
> connected.
>
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
