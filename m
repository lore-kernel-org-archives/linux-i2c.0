From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: add support for Socionext SynQuacer I2C controller
Date: Mon, 26 Feb 2018 20:18:04 +0200
Message-ID: <CAHp75VdFkdQp++z2nN2+cnSeq65YUoBq04tykZfBeun-5deDSA@mail.gmail.com>
References: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
 <20180222191647.4727-3-ard.biesheuvel@linaro.org> <CAHp75Vc1AGzdgTB281XVo=FmZerkU1vijLih3JUO=_wNPjxgfA@mail.gmail.com>
 <CAKv+Gu9XkmSPHZf+jVKOm-SX1GCWJUc7y3zTCuaHBwk8O3OC3Q@mail.gmail.com>
 <CAHp75VfFKDkQQ9-vdjzDfE2Cdk2Cb93+kdceYQgEqt3hti=Wkg@mail.gmail.com>
 <CAKv+Gu__HiajW5fWvRnDft3+ef+gOowijxEd8wrF4U5Vu=3o0Q@mail.gmail.com>
 <CAHp75VcjUey4K1xOkjKjn_ppPKC0bktcBK2p9NjcPYG1ed7X0g@mail.gmail.com>
 <CAKv+Gu-y3GG+McAK2b8SCmMf60fo_XSHFBAWsKGw3OBvD04ggg@mail.gmail.com>
 <CAHp75Vco1wUR7cUu-zuaP-TVMnm+m7X+CctnRC0cgvpuo5S2vg@mail.gmail.com>
 <CAKv+Gu8ZAt43km=mANa9Ehx1Evbj8cLB5vFsFwji9x6ARvD-sw@mail.gmail.com> <CAKv+Gu9qc=h1mC=6CHiu5aX0NSjLgzahyQ1xdRWo5ZYwcDir1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu9qc=h1mC=6CHiu5aX0NSjLgzahyQ1xdRWo5ZYwcDir1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 26, 2018 at 7:51 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 26 February 2018 at 17:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Perhaps we could agree on the binding first? Currently, I have the following
>
>     Device (I2C0) {
>       Name (_HID, "SCX0003")
>       Name (_UID, Zero)
>       Name (_CRS, ResourceTemplate () {
>         Memory32Fixed (ReadWrite, SYNQUACER_I2C1_BASE, SYNQUACER_I2C1_SIZE)

>         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 197 }

>       })
>
>       Name (_DSD, Package ()  // _DSD: Device-Specific Data
>       {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>           Package (2) { "socionext,pclk-rate", 62500000 },
>         }
>       })
>

> and I don't intend to add 'clock-frequency' here because it would be
> redundant anyway.

Right.

> Does this look sane?

I can't say about property name, but otherwise yes.

-- 
With Best Regards,
Andy Shevchenko
