From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 4/4] eeprom: at24: remove the write-protect pin support
Date: Mon, 16 Dec 2019 12:03:42 +0100
Message-ID: <CAMpxmJWGRskDudwLpzVZKvYb=Gbcxy6s0gCLUUFkgLq-CYEiZg@mail.gmail.com>
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-5-ktouil@baylibre.com>
 <CACRpkdbHLv2R+XvCjCaEgaztUqpmHWCmSAqHABkkstJREkmfVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbHLv2R+XvCjCaEgaztUqpmHWCmSAqHABkkstJREkmfVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Khouloud Touil <ktouil@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, baylibre-upstreaming@groups.io, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

pon., 16 gru 2019 o 09:13 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrot=
e:
>
> > NVMEM framework is an interface for the at24 EEPROMs as well as for
> > other drivers, instead of passing the wp-gpios over the different
> > drivers each time, it would be better to pass it over the NVMEM
> > subsystem once and for all.
> >
> > Removing the support for the write-protect pin after adding it to the
> > NVMEM subsystem.
> >
> > Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
>
> I wonder if this needs to be in the same patch that adds it to
> the NVMEM subsystem, so as to avoid both code paths being
> taken between the two patches (bisectability..)
>
> However that is not the biggest thing in the universe and I'm
> no bisectability-perfectionist, so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

AFAIK Khouloud tested it and it's bisectable thanks to using the
optional gpiod_get() variant.

Best regards,
Bartosz Golaszewski
