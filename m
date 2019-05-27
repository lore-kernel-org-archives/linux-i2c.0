From: Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date: Mon, 27 May 2019 18:55:41 +0530
Message-ID: <CAARK3H=qGkKodSdMe+e9N6A-t1cZoiJLatZfcv+A1G1Zuw5VVQ@mail.gmail.com>
References: <1558515574-11155-1-git-send-email-sagar.kadam@sifive.com>
 <1558515574-11155-2-git-send-email-sagar.kadam@sifive.com> <20190524204012.GA2580@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524204012.GA2580@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, peter@korsgaard.com, Andrew Lunn <andrew@lunn.ch>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Rob,

On Sat, May 25, 2019 at 2:10 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 22, 2019 at 02:29:32PM +0530, Sagar Shrikant Kadam wrote:
> > Reformatted compatibility strings to one valid combination on
> > each line.
> > Add FU540-C000 specific device tree bindings to already available
> > i2-ocores file. This device is available on
> > HiFive Unleashed Rev A00 board. Move interrupt under optional
> > property list as this can be optional.
> >
> > The FU540-C000 SoC from sifive, has an Opencore's I2C block
> > reimplementation.
> >
> > The DT compatibility string for this IP is present in HDL and available at.
> > https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/i2c/I2C.scala#L73
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > index 17bef9a..db96951 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > @@ -1,9 +1,13 @@
> >  Device tree configuration for i2c-ocores
> >
> >  Required properties:
> > -- compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
> > +- compatible      : "opencores,i2c-ocores",
> > +                    "aeroflexgaisler,i2cmst",
> > +                    "sifive,fu540-c000-i2c","sifive,i2c0".
>
> space needed                                   ^
>
> And drop the end of line commas and period.
>
>
> > +                    For Opencore based I2C IP block reimplemented in
> > +                    FU540-C000 SoC.Please refer sifive-blocks-ip-versioning.txt
>
> And here too.
>
> And 'refer to'
I will incorporate the changes you have suggested.

Thanks,
Sagar Kadam
>
> > +                    for additional details.
> >  - reg             : bus address start and address range size of device
> > -- interrupts      : interrupt number
> >  - clocks          : handle to the controller clock; see the note below.
> >                      Mutually exclusive with opencores,ip-clock-frequency
> >  - opencores,ip-clock-frequency: frequency of the controller clock in Hz;
> > @@ -12,6 +16,7 @@ Required properties:
> >  - #size-cells     : should be <0>
> >
> >  Optional properties:
> > +- interrupts      : interrupt number.
> >  - clock-frequency : frequency of bus clock in Hz; see the note below.
> >                      Defaults to 100 KHz when the property is not specified
> >  - reg-shift       : device register offsets are shifted by this value
> > --
> > 1.9.1
> >
