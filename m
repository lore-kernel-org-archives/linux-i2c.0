From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
Date: Wed, 28 Mar 2018 10:19:22 +0200
Message-ID: <20180328101922.22a7039d@bbrezillon>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
        <20180323110020.19080-6-boris.brezillon@bootlin.com>
        <20180326071946.dtrhhxx3iwwymk73@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180326071946.dtrhhxx3iwwymk73@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak>
List-Id: linux-i2c@vger.kernel.org

Hi Rob,

On Mon, 26 Mar 2018 17:24:58 -0500
Rob Herring <robh@kernel.org> wrote:

> > +
> > +I3C devices
> > +===========
> > +
> > +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> > +are thus discoverable. So, by default, I3C devices do not have to be described
> > +in the device tree.
> > +This being said, one might want to attach extra resources to these devices,
> > +and those resources may have to be described in the device tree, which in turn
> > +means we have to describe I3C devices.
> > +
> > +Another use case for describing an I3C device in the device tree is when this
> > +I3C device has a static address and we want to assign it a specific dynamic
> > +address before the DAA takes place (so that other devices on the bus can't  
> 
> static is I2C address and dynamic is an I3C address. That could be 
> clearer throughout.

I'll clarify that.

> 
> > +take this dynamic address).
> > +
> > +The I3C device should be names <device-type>@<static-address>,<i3c-pid>,  
> 
> s/static-address/static-i2c-address/

Okay.

> 
> > +where device-type is describing the type of device connected on the bus
> > +(gpio-controller, sensor, ...).
> > +
> > +Required properties
> > +-------------------
> > +- reg: contains 3 cells
> > +  + first cell : encodes the I2C address. Should be 0 if the device does not
> > +		 have one (0 is not a valid I3C address).  
> 
> Change here to "encodes the static I2C address". 
> 
> 0 is not a valid I2C address?

According to [1] it is reserved, and it's reserved in the I3C spec
anyway (see "Table 9 I3C Slave Address Restrictions" in the I3C spec).

> 
> > +
> > +  + second and third cells: should encode the ProvisionalID. The second cell
> > +			    contains the manufacturer ID left-shifted by 1.
> > +			    The third cell contains ORing of the part ID
> > +			    left-shifted by 16, the instance ID left-shifted
> > +			    by 12 and the extra information. This encoding is
> > +			    following the PID definition provided by the I3C
> > +			    specification.

One extra question for you: should I refer to the I3C_DEV(),
I3C_DEV_WITH_STATIC_ADDR() and I2C_DEV() macros in the bindings doc?
And if I do, should I use them my example?

Thanks,

Boris

> > +
> > +Optional properties
> > +-------------------
> > +- assigned-address: dynamic address to be assigned to this device. This
> > +		    property is only valid if the I3C device has a static
> > +		    address (first cell of the reg property != 0).
> > +
> > +
> > +Example:
> > +
> > +	i3c-master@d040000 {
> > +		compatible = "cdns,i3c-master";
> > +		clocks = <&coreclock>, <&i3csysclock>;
> > +		clock-names = "pclk", "sysclk";
> > +		interrupts = <3 0>;
> > +		reg = <0x0d040000 0x1000>;
> > +		#address-cells = <3>;
> > +		#size-cells = <0>;
> > +
> > +		status = "okay";
> > +		i2c-scl-frequency = <100000>;
> > +
> > +		/* I2C device. */
> > +		nunchuk: nunchuk@52 {
> > +			compatible = "nintendo,nunchuk";
> > +			reg = <0x52 0x80000010 0x0>;
> > +		};
> > +
> > +		/* I3C device with a static address. */
> > +		thermal_sensor: sensor@68,39200144004 {
> > +			reg = <0x68 0x392 0x144004>;
> > +			assigned-address = <0xa>;
> > +		};
> > +
> > +		/*
> > +		 * I3C device without a static address but requiring resources
> > +		 * described in the DT.
> > +		 */
> > +		sensor@0,39200154004 {
> > +			reg = <0x0 0x392 0x154004>;
> > +			clocks = <&clock_provider 0>;
> > +		};
> > +	};
> > +
> > -- 
> > 2.14.1
> >   

[1]http://www.i2c-bus.org/addressing

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
