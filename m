From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: i3c: Document core bindings
Date: Thu, 14 Dec 2017 17:24:19 +0100
Message-ID: <CAMuHMdUx5j0zbhEM6KKc-ivmdA_HA=9XMmG7w3h5xCyY5LdyNw@mail.gmail.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com> <20171214151610.19153-6-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171214151610.19153-6-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-i2c@vger.kernel.org

Hi Boris,

On Thu, Dec 14, 2017 at 4:16 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
>
> Document this generic representation.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> @@ -0,0 +1,128 @@
> +Generic device tree bindings for I3C busses
> +===========================================
> +
> +This document describes generic bindings that should be used to describe I3C
> +busses in a device tree.
> +
> +Required properties
> +-------------------
> +
> +- #address-cells  - should be <1>. Read more about addresses below.
> +- #size-cells     - should be <0>.
> +- compatible      - name of I3C bus controller following generic names
> +                   recommended practice.
> +
> +For other required properties e.g. to describe register sets,
> +clocks, etc. check the binding documentation of the specific driver.
> +
> +Optional properties
> +-------------------
> +
> +These properties may not be supported by all I3C master drivers. Each I3C
> +master bindings should specify which of them are supported.
> +
> +- i3c-scl-frequency: frequency (in Hz) of the SCL signal used for I3C
> +                    transfers. When undefined the core set it to 12.5MHz.

sets

> +
> +- i2c-scl-frequency: frequency (in Hz) of the SCL signal used for I2C
> +                    transfers. When undefined, the core looks at LVR values

LVR (Legacy I2C Virtual Register)

> +                    of I2C devices described in the device tree to determine
> +                    the maximum I2C frequency.
> +
> +I2C devices
> +===========
> +
> +Each I2C device connected to the bus should be described in a subnode with
> +the following properties:

This colon looks a bit funny here, as below is a sentence, not a list.

> +
> +All properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> +valid here.

Perhaps rewrite as:

  Each I2C device connected to the bus should be described in a subnode with
  properties.  All properties described in
  Documentation/devicetree/bindings/i2c/i2c.txt are valid here, but several
  new properties have been added.

> +
> +New required properties:
> +------------------------
> +- i3c-lvr: 32 bits integer property (only the lowest 8 bits are meaningful)
> +          describing device capabilities as described in the I3C
> +          specification.
> +
> +          bit[31:8]: unused
> +          bit[7:5]: I2C device index. Possible values
> +           * 0: I2C device has a 50 ns spike filter
> +           * 1: I2C device does not have a 50 ns spike filter but supports high
> +                frequency on SCL
> +           * 2: I2C device does not have a 50 ns spike filter and is not
> +                tolerant to high frequencies
> +           * 3-7: reserved
> +
> +          bit[4]: tell whether the device operates in FM or FM+ mode
> +           * 0: FM+ mode
> +           * 1: FM mode

As this is the only reference to "FM", perhaps clarify the acronym, like you
do for DAA below.

> +
> +          bit[3:0]: device type
> +           * 0-15: reserved
> +
> +I3C devices
> +===========
> +
> +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> +are thus discoverable. So, by default, I3C devices do not have to be described
> +in the device tree.
> +This being said, one might want to attach extra resources to these devices,
> +and those resources may have to be described in the device tree, which in turn
> +means we have to describe I3C devices.
> +
> +Another use case for describing an I3C device in the device tree is when this
> +I3C device has a static address and we want to assign it a specific dynamic
> +address before the DAA takes place (so that other devices on the bus can't
> +take this dynamic address).
> +
> +Required properties
> +-------------------
> +- i3c-pid: PID (Provisional ID). 64-bit property which is used to match a
> +          device discovered during DAA with its device tree definition. The
> +          PID is supposed to be unique on a given bus, which guarantees a 1:1
> +          match. This property becomes optional if a reg property is defined,
> +          meaning that the device has a static address.
> +
> +Optional properties
> +-------------------
> +- reg: static address. Only valid is the device has a static address.

if


-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
