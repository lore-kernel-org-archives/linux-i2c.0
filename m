From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: at24: convert the binding document to yaml
Date: Fri, 27 Sep 2019 10:44:29 -0500
Message-ID: <CAL_Jsq+R9wdB521dQtwMiWXEJEB5tGEDYi_efDqZL6xzF9YduA@mail.gmail.com>
References: <20190927134220.8734-1-robh@kernel.org> <CAMRc=MctTVh99vE+dfd25ienWEjtMNwrM200f1im--fx9ALo7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MctTVh99vE+dfd25ienWEjtMNwrM200f1im--fx9ALo7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Peter Rosin <peda@axentia.se>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 27, 2019 at 10:06 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> pt., 27 wrz 2019 o 15:42 Rob Herring <robh@kernel.org> napisa=C5=82(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Convert the binding document for at24 EEPROMs from txt to yaml. The
> > compatible property uses a regex pattern to address all the possible
> > combinations of "vendor,model" strings.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > [robh: rework compatible schema, fix missing allOf for $ref, fix errors=
 in example]
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v4:
> > - Add a $nodename definition
> >
> > - Turns out the compatible schema is too complex for generating a 'sele=
ct'
> > schema and only a small subset where getting validated. So we need a
> > custom 'select' schema. This in turn fixes the issue with the nxp,se97b
> > binding.
>
> Thanks again!
>
> >
> > Now we get a different set of errors checking Arm dts files (omitting
> > a bunch of node name ones):
> >
>
> > arch/arm/boot/dts/at91-dvk_som60.dt.yaml: eeprom@57: compatible: ['gian=
tec,gt24c32a', 'atmel,24c32'] is not valid under any of the given schemas
>
> This is because nobody bothered adding 'giantec,gt24c32a' to previous
> .txt bindings. I'll add this in a follow-up patch.
>
> > arch/arm/boot/dts/am3874-iceboard.dt.yaml: at24cs01@5f: compatible: ['a=
tmel,24cs01'] is not valid under any of the given schemas
> > arch/arm/boot/dts/am3874-iceboard.dt.yaml: at24cs08@5c: compatible: ['a=
tmel,24cs08'] is not valid under any of the given schemas
> >
>
> These look fine at first glance, I'm not sure what the problem here
> is. I'll take a look at these as soon as I can.

Ah, that's my mistake. I guess there's only no 24cs00 variant.

Rob
