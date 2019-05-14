From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 v2 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date: Tue, 14 May 2019 11:05:19 -0500
Message-ID: <CAL_JsqKGyq-GaAXWqb=8DGCPYd-2kHWaOyNO9rC9dZkx2Z=LeQ@mail.gmail.com>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
 <1557242108-13580-2-git-send-email-sagar.kadam@sifive.com>
 <20190513205615.GA5844@bogus> <CAARK3HkTCGWg4CAo1LmQHmf4_NFukjTwO1LAHjgSTS+R_5CRSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAARK3HkTCGWg4CAo1LmQHmf4_NFukjTwO1LAHjgSTS+R_5CRSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Kadam <sagar.kadam@sifive.com>
Cc: Mark Rutland <mark.rutland@arm.com>, peter@korsgaard.com, Andrew Lunn <andrew@lunn.ch>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 14, 2019 at 7:50 AM Sagar Kadam <sagar.kadam@sifive.com> wrote:
>
> Hello Rob,
>
> Thank you for the review.
>
> On Tue, May 14, 2019 at 2:26 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, May 07, 2019 at 08:45:06PM +0530, Sagar Shrikant Kadam wrote:
> > > Add FU540-C000 specific device tree bindings to already
> > > available i2-ocores file. This device is available on
> > > HiFive Unleashed Rev A00 board.
> > >
> > > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > > ---
> > >  Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > > index 17bef9a..f6bcf90 100644
> > > --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > > +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > > @@ -2,6 +2,7 @@ Device tree configuration for i2c-ocores
> > >
> > >  Required properties:
> > >  - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
> > > +                    "sifive,fu540-c000-i2c" or "sifive,i2c0"
> >
> > If this is Opencores IP, does it really follow the Sifive versioning
> > convention? If so, please reference sifive-blocks-ip-versioning.txt
> > (which appears to have missed going upstream). Also, referencing the IP
> > repository would be good too. If this IP block doesn't follow the same
> > convention, then don't try using it for this binding.
> >
> Yes, the sifive,fu540-c000-i2c is a SoC specific compatibility string,
> this way SoC specific
> workaround's or bugs, can be handled in the software and the ip-block
> specific compatibility
> string "sifive,<ip-block-name><integer version number>" i.e.
> sifive,i2c0 is IP block specific compatibility
> string. Please let me know if I need some correction here?
> I will also update reference for sifive-blocks-ip-versioning and the
> ip repository into next version of patch.

My question is whether I can correlate v0 to a specific revision of
the IP and versions will be tracked in the same way as SiFive IP
blocks?

> > >  - reg             : bus address start and address range size of device
> > >  - interrupts      : interrupt number
> > >  - clocks          : handle to the controller clock; see the note below.
> > > @@ -67,3 +68,22 @@ or
> > >                       reg = <0x60>;
> > >               };
> > >       };
> > > +or
> >
> > Just a new compatible isn't really a reason to add an example.
> >
> > > +     /*
> > > +       An Opencore based I2C node in FU540-C000 chip from SiFive
> > > +       This chip has a hardware erratum for broken IRQ
> > > +       so it's recommended not to define interrupt in the device node
> >
> > Then interrupts needs to be optional.
> True, I will move interrupts and interrupt parent into optional section
> >
> > > +     */
> > > +     i2c@10030000 {
> > > +                     compatible = "sifive,i2c0","sifive,fu540-c000-i2c";
> > > +                     reg = <0x0 0x10030000 0x0 0x1000>;
> > > +                     reg-names = "i2c-control";
> >
> > Not doucmented.
> In v1, I had added a new binding file as sifive-i2c-ocores.txt for
> SiFive i2c core.
> After Andrew's suggestion,  extending the available i2c-ocores.txt
> seemed to be a better idea rather than adding a new file.
> so added an example node which is HiFive specific in the existing file.
> Please let me know if I need to handle this in a different way.

That has nothing to do with whether reg-names is documented. Being in
the example is not documented. You either need to add it to the
property list or drop it from the example. IMO, you should drop it as
it is not necessary with only 1 entry.

Rob
