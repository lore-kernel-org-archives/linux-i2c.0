From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 3/5] dt-bindings: i3c: Document core bindings
Date: Wed, 9 Aug 2017 18:43:02 -0500
Message-ID: <20170809234302.ffcr3gwpiy4roj7l@rob-hp-laptop>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-4-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501518290-5723-4-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 31, 2017 at 06:24:48PM +0200, Boris Brezillon wrote:
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
> 
> Document this generic representation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 90 +++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
> new file mode 100644
> index 000000000000..49261dec7b01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> @@ -0,0 +1,90 @@
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
> +		    recommended practice.
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
> +		     transfers. When undefined the core set it to 12.5MHz.
> +
> +- i2c-scl-frequency: frequency (in Hz) of the SCL signal used for I2C
> +		     transfers. When undefined, the core looks at LVR values
> +		     of I2C devices described in the device tree to determine
> +		     the maximum I2C frequency.
> +
> +I2C devices
> +===========
> +
> +Each I2C device connected to the bus should be described in a subnode with
> +the following properties:
> +
> +All properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> +valid here.
> +
> +New required properties:
> +------------------------
> +- i3c-lvr: 32 bits integer property (only the lowest 8 bits are meaningful)

What does lvr mean?

> +	   describing device capabilities as described in the I3C
> +	   specification.
> +
> +	   bit[31:8]: unused
> +	   bit[7:5]: I2C device index. Possible values

index? Seems more like flags

> +	    * 0: I2C device has a 50 ns spike filter
> +	    * 1: I2C device does not have a 50 ns spike filter but supports high
> +		 frequency on SCL
> +	    * 2: I2C device does not have a 50 ns spike filter and is not
> +		 tolerant to high frequencies
> +	    * 3-7: reserved
> +
> +	   bit[4]: tell whether the device operates in FM or FM+ mode
> +	    * 0: FM+ mode
> +	    * 1: FM mode
> +
> +	   bit[3:0]: device type
> +	    * 0-15: reserved

That's useful...

> +
> +I3C devices
> +===========
> +
> +I3C are not described in the device tree yet. We could decide to represent them
> +at some point to assign a specific dynamic address to a device or to force an
> +I3C device to act as an I2C device if it has a static address.

I think we need to define this sooner rather than later if there's not a 
standard connector. That's the only thing that would enforce any sort of 
standard. Of course, that didn't help with SDIO.

> +
> +Example:
> +
> +	i3c-master@0d040000 {

The node name should go into the DT spec. I tend to think "i3c" would be 
sufficient and aligned with i2c.

> +		compatible = "cdns,i3c-master";
> +		clocks = <&coreclock>, <&i3csysclock>;
> +		clock-names = "pclk", "sysclk";
> +		interrupts = <3 0>;
> +		reg = <0x0d040000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		status = "okay";
> +		i2c-scl-frequency = <100000>;
> +
> +		nunchuk: nunchuk@52 {
> +			compatible = "nintendo,nunchuk";
> +			reg = <0x52>;
> +			i3c-lvr = <0x10>;
> +		};
> +	};
> +
> -- 
> 2.7.4
> 
