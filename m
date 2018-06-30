From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: Add binding for Actions Semi
 OWL I2C controller
Date: Sat, 30 Jun 2018 18:10:03 +0530
Message-ID: <20180630124003.GA16775@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-2-manivannan.sadhasivam@linaro.org>
 <6809cab8-da3f-618c-05da-9935a99c1e1d@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6809cab8-da3f-618c-05da-9935a99c1e1d@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, linus.walleij@linaro.org, linux-i2c@vger.kernel.org, liuwei@actions-semi.com, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, andy.shevchenko@gmail.com, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

Hi Andreas,

On Sat, Jun 30, 2018 at 02:23:30PM +0200, Andreas Färber wrote:
> Am 28.06.2018 um 20:10 schrieb Manivannan Sadhasivam:
> > Add devicetree binding for Actions Semi OWL I2C controller
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/i2c/i2c-owl.txt       | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> > new file mode 100644
> > index 000000000000..9b691968cffd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> > @@ -0,0 +1,27 @@
> > +OWL I2C controller
> 
> As mentioned elsewhere, please fix all subjects, commit messages and
> bindings to say Owl, not OWL. There's no need to upper-case it besides
> defines.
> 
> Also, this title should mention Actions Semiconductor please, not just
> the codename Owl.
> 

Sure

> > +
> > +Required properties:
> > +
> > +- compatible        : Should be "actions,s900-i2c".
> 
> What about S500? Are you expecting it to carry an S900 compatible? That
> seems strange. Are there any differences in the implementations?
> 

I haven't tested it on S500 eventhough the implementation looks same. But
anyway if we want to add support for S500 or S700 we can just do the
modifications (if any) slightly and add a separate compatible like we
did for other drivers.

Thanks,
Mani

> Otherwise looks okay.
> 
> Thanks,
> Andreas
> 
> > +- reg               : Offset and length of the register set for the device.
> > +- #address-cells    : Should be 1.
> > +- #size-cells       : Should be 0.
> > +- interrupts        : A single interrupt specifier.
> > +- clocks            : Phandle of the clock feeding the I2C controller.
> > +
> > +Optional properties:
> > +
> > +- clock-frequency   : Desired I2C bus clock frequency in Hz. As only Normal and
> > +                      Fast modes are supported, possible values are 100000 and
> > +                      400000.
> > +Examples:
> > +
> > +        i2c0: i2c@e0170000 {
> > +                compatible = "actions,s900-i2c";
> > +                reg = <0 0xe0170000 0 0x1000>;
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +                interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks = <&clock CLK_I2C0>;
> > +                clock-frequency = <100000>;
> > +        };
> > 
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
