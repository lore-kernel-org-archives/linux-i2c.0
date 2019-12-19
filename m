From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/4] at24: move write-protect pin handling to nvmem core
Date: Thu, 19 Dec 2019 11:59:29 +0100
Message-ID: <CAMRc=Mc+OCJTMOx2qXT74RBma6iVTsuwjc_g3SbmHDKxvtfOWA@mail.gmail.com>
References: <20191210154157.21930-1-ktouil@baylibre.com> <cd9f342c-5576-57f5-c62d-a78c5876a7fd@linaro.org>
 <CAMpxmJUM2WWyJyU0MuOu9qObPFr2ghH5LHs8DXo_poMwtZqPNA@mail.gmail.com> <b56813c2-d29e-c461-ca1d-80a131c9341a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b56813c2-d29e-c461-ca1d-80a131c9341a@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Khouloud Touil <ktouil@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, baylibre-upstreaming@groups.io, LKML <linux-kernel@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-i2c@vger.kernel.org

czw., 19 gru 2019 o 11:56 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
> >>
> >> Thanks Khouloud for this patchset,
> >>
> >> I can take this via nvmem tree once we get an ack on dt bindings from =
DT
> >> maintainers.
> >>
> >
> > Hi Srinivas,
> >
> > this will conflict with my at24 tree for this release - can you put
> > those patches (once they're fine) into an immutable branch for me to
> > merge in?
>
> I can ack nvmem core patch so that you can take it directly via at24
> tree if thats okay.
>

Sure, even better!

Bart
