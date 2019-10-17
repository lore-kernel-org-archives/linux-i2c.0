From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [v3,1/2] dt-bindings: i2c: support property idle-state
Date: Thu, 17 Oct 2019 11:45:49 -0500
Message-ID: <CAL_JsqK_BOSZ=UNP-L7OpuNsFUAqWBhAjCObex+0xtkYp=7c+A@mail.gmail.com>
References: <20191016040920.8511-1-biwen.li@nxp.com> <bfdb97c1-76f4-52d9-7f02-c62bed8192ce@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bfdb97c1-76f4-52d9-7f02-c62bed8192ce@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Biwen Li <biwen.li@nxp.com>, "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 17, 2019 at 10:38 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2019-10-16 06:09, Biwen Li wrote:
> > This supports property idle-state
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> > Change in v3:
> >       - update subject and description
> >       - add some information for property idle-state
> >
> > Change in v2:
> >       - update subject and description
> >       - add property idle-state
> >
> >  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > index 30ac6a60f041..7abda506b828 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> > @@ -25,6 +25,8 @@ Required Properties:
> >  Optional Properties:
> >
> >    - reset-gpios: Reference to the GPIO connected to the reset input.
> > +  - idle-state: if present, overrides i2c-mux-idle-disconnect,
> > +    Please refer to Documentation/devicetree/bindings/mux/mux-controller.txt
> >    - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
> >      children in idle state. This is necessary for example, if there are several
> >      multiplexers on the bus and the devices behind them use same I2C addresses.
> >
>
> Rob, should i2c-mux-idle-disconnect perhaps be deprecated here? Is that
> appropriate?
>
> idle-state provides a super-set of what i2c-mux-idle-disconnect provides.

Yes, seems like it and it is not too widely used.

Rob
