From: Rob Herring <robh+dt@kernel.org>
Subject: Re: DT connectors, thoughts
Date: Thu, 21 Jul 2016 14:15:57 -0500
Message-ID: <CAL_JsqLkMA1VHfHpP4oCWtONWq5GeyS731r8PjjeL_DZ4u1Z_g@mail.gmail.com>
References: <577ACE0D.9050700@gmail.com> <20160718142037.GS16769@voom.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160718142037.GS16769@voom.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 18, 2016 at 9:20 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> Hi,
>
> Here's some of my thoughts on how a connector format for the DT could
> be done.  Sorry it's taken longer than I hoped - I've been pretty
> swamped in my day job.
>
> This is pretty early thoughts, but gives an outline of the approach I
> prefer.
>
> So.. start with an example of a board DT including a widget socket,
> which contains pins for an MMIO bus, an i2c bus and 2 interrupt lines.
>
> /dts-v1/;
>
> / {
>         compatible = "foo,oldboard";
>         ranges;
>         soc@... {
>                 ranges;
>                 mmio: mmio-bus@... {
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
>                 };
>                 i2c: i2c@... {
>                 };
>                 intc: intc@... {
>                         #interrupt-cells = <2>;
>                 };
>         };
>
>         connectors {
>                 widget1 {
>                         compatible = "foo,widget-socket";
>                         w1_irqs: irqs {
>                                 interrupt-controller;
>                                 #address-cells = <0>;
>                                 #interrupt-cells = <1>;
>                                 interrupt-map-mask = <0xffffffff>;
>                                 interrupt-map = <
>                                         0 &intc 7 0
>                                         1 &intc 8 0
>                                 >;
>                         };
>                         aliases = {
>                                 i2c = &i2c;
>                                 intc = &w1_irqs;

I understand how you are using i2c alias, but not the intc. It would
help if the same names were not used in multiple places unless they
are the same thing.

What does using aliases here buy us vs. just properties with a phandle?

>                                 mmio = &mmio;
>                         };
>                 };
>         };
> };
>
> Note that the symbols are local to the connector, and explicitly
> listed, rather than including all labels in the tree.  This is to
> enforce (or at the very least encourage) plugins to only access those
> parts of the base tree.
>
> Note also the use of an interrupt nexus node contained within the
> connector to control which irqs the socketed device can use.  I think
> this needs some work to properly handle unit addresses, but hope
> that's enough to give the rough idea.
>
> So, what does the thing that goes in the socket look like?  I'm
> thinking some new dts syntax like this:
>
> /dts-v1/;
>
> /plugin/ foo,widget-socket {
>         compatible = "foo,whirligig-widget";
> };
>
> &i2c {
>         whirligig-controller@... {
>                 ...
>                 interrupt-parent = <&widget-irqs>;
>                 interrupts = <0>;
>         };
> };
>
> Use of the /plugin/ keyword is rather different from existing
> practice, so we may want a new one instead.
>
> The idea is that this would be compiled to something like:
>
> /dts-v1/;
>
> / {
>         socket-type = "foo,widget-socket";
>         compatible = "foo,whirligig-widget";
>
>         fragment@0 {
>                 target-alias = "i2c";

Yet another way to express the target... Every new feature for
overlays seems to define a new way. My thinking was the target is a
connector node and all devices are under it. In your case, the
connector is not part of the hierarchy for any devices in the overlay.
That may simplify adding OS support, but seems to be a less accurate
representation of the h/w.

>                 __overlay__ {
>                         whirligig-controller@... {
>                                 ...
>                                 interrupt-parent = <0xffffffff>;
>                                 interrupts = <0>;
>                         };
>                 };
>         };
>         __phandle_fixups__ {
>                 /* These are (path, property, offset) tuples) */
>                 widget-irqs =
>                         "/fragment@0/__overlay__/whirligig-controller@...",
>                         "interrupt-parent", <0>;
>         };
> };
