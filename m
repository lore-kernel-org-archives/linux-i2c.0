From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/4] eeprom: at24: remove the write-protect pin support
Date: Mon, 16 Dec 2019 09:13:20 +0100
Message-ID: <CACRpkdbHLv2R+XvCjCaEgaztUqpmHWCmSAqHABkkstJREkmfVw@mail.gmail.com>
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-5-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210154157.21930-5-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> NVMEM framework is an interface for the at24 EEPROMs as well as for
> other drivers, instead of passing the wp-gpios over the different
> drivers each time, it would be better to pass it over the NVMEM
> subsystem once and for all.
>
> Removing the support for the write-protect pin after adding it to the
> NVMEM subsystem.
>
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>

I wonder if this needs to be in the same patch that adds it to
the NVMEM subsystem, so as to avoid both code paths being
taken between the two patches (bisectability..)

However that is not the biggest thing in the universe and I'm
no bisectability-perfectionist, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
