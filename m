From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] nvmem: add support for the write-protect pin
Date: Mon, 16 Dec 2019 09:09:52 +0100
Message-ID: <CACRpkdZPO+nBA=H0qJUiSq2iA0BDg=n3Ez5wPgnrtLc3MYdpJw@mail.gmail.com>
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-3-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210154157.21930-3-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> The write-protect pin handling looks like a standard property that
> could benefit other users if available in the core nvmem framework.
>
> Instead of modifying all the memory drivers to check this pin, make
> the NVMEM subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
>
> There was a suggestion for introducing the gpiodesc from pdata, but
> as pdata is already removed it could be replaced by adding it to
> nvmem_config.
>
> Reference: https://lists.96boards.org/pipermail/dev/2018-August/001056.html
>
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>

This is consistent IMO, we just specify that WP is active high
as in "when it is high, it actively protects against writing", so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
