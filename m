From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 0/5] at24: move write-protect pin handling to nvmem core
Date: Thu, 9 Jan 2020 11:31:18 +0100
Message-ID: <CAMpxmJVj3DHXFq9D5HUD0j7t=Q7gFNF1eQsg2jUa4PEFrFas4w@mail.gmail.com>
References: <20200107092922.18408-1-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107092922.18408-1-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, LKML <linux-kernel@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-i2c@vger.kernel.org

wt., 7 sty 2020 o 10:29 Khouloud Touil <ktouil@baylibre.com> napisa=C5=82(a=
):
>
> The write-protect pin handling looks like a standard property that
> could benefit other users if available in the core nvmem framework.
>
> Instead of modifying all the drivers to check this pin, make the
> nvmem subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
>
> This patchset:
>
> - adds support for the write-protect pin split into two parts.
> The first patch modifies modifies the relevant binding document,
> while the second modifies the nvmem code to pull the write-protect
> GPIO low (if present) during write operations.
>
> - removes support for the write-protect pin split into two parts.
> The first patch modifies the relevant binding document to make the
> wp-gpio a reference to the property defined by nvmem , while the
> second removes the relevant code in the at24 driver.
>
> - adds reference in the at25 binding document for the wp-gpios property
> as it uses nvmem subsystem.
>
> Changes since v1:
> -Add an explenation on how the wp-gpios works
> -Keep reference to the wp-gpios in the at24 binding
>
> Changes since v2:
> -Use the flag GPIO_ACTIVE_HIGH instead of 0
>
> Changes since v3:
> -Keep the example of the wp-gpios in the at25 bindings
> -Add reference for the wp-gpios property in the at25 binding

I picked up patches 1-3 & 5 into the at24 tree.

Patch 4 will need an Ack from Greg.

Bart
