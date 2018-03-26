From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
Date: Mon, 26 Mar 2018 12:22:24 +0200
Message-ID: <CAMuHMdV9xW8o6zuOmOxB+=h1XTdi-VFq2mp897SUjZKtRMOWOw@mail.gmail.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com> <20180323110020.19080-6-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323110020.19080-6-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian
List-Id: linux-i2c@vger.kernel.org

Hi Boris,

On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
>
> Document this generic representation.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> @@ -0,0 +1,140 @@

> +I3C devices
> +===========
> +
> +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> +are thus discoverable. So, by default, I3C devices do not have to be described
> +in the device tree.

But if they're described, they should have a compatible value, no?

> +This being said, one might want to attach extra resources to these devices,
> +and those resources may have to be described in the device tree, which in turn
> +means we have to describe I3C devices.
> +
> +Another use case for describing an I3C device in the device tree is when this
> +I3C device has a static address and we want to assign it a specific dynamic
> +address before the DAA takes place (so that other devices on the bus can't
> +take this dynamic address).
> +
> +The I3C device should be names <device-type>@<static-address>,<i3c-pid>,

named

So the i3c-pid in the unit address is represented as a 64-bit number, not as two
comma-separated 32-bit numbers?

> +Example:
> +
> +       i3c-master@d040000 {
> +               compatible = "cdns,i3c-master";
> +               clocks = <&coreclock>, <&i3csysclock>;
> +               clock-names = "pclk", "sysclk";
> +               interrupts = <3 0>;
> +               reg = <0x0d040000 0x1000>;
> +               #address-cells = <3>;
> +               #size-cells = <0>;
> +
> +               status = "okay";
> +               i2c-scl-frequency = <100000>;
> +
> +               /* I2C device. */
> +               nunchuk: nunchuk@52 {

@52,8000001000000000?

> +                       compatible = "nintendo,nunchuk";
> +                       reg = <0x52 0x80000010 0x0>;
> +               };
> +
> +               /* I3C device with a static address. */
> +               thermal_sensor: sensor@68,39200144004 {

No compatible value?

> +                       reg = <0x68 0x392 0x144004>;
> +                       assigned-address = <0xa>;
> +               };
> +
> +               /*
> +                * I3C device without a static address but requiring resources
> +                * described in the DT.
> +                */
> +               sensor@0,39200154004 {

No compatible value?

> +                       reg = <0x0 0x392 0x154004>;
> +                       clocks = <&clock_provider 0>;
> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
