From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: i3c: Document core bindings
Date: Sat, 16 Dec 2017 19:35:37 +0100
Message-ID: <20171216193537.0aef2e97@bbrezillon>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
        <20171214151610.19153-6-boris.brezillon@free-electrons.com>
        <20171216172040.jcaezouqkeb7zrqy@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171216172040.jcaezouqkeb7zrqy@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Suresh Punnoose <sureshp-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 16 Dec 2017 11:20:40 -0600
Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Thu, Dec 14, 2017 at 04:16:08PM +0100, Boris Brezillon wrote:
> > A new I3C subsystem has been added and a generic description has been
> > created to represent the I3C bus and the devices connected on it.
> > 
> > Document this generic representation.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> > Changes in v2:
> > - Define how to describe I3C devices in the DT and when it should be
> >   used. Note that the parsing of I3C devices is not yet implemented in
> >   the framework. Will be added when someone really needs it.
> > ---
> >  Documentation/devicetree/bindings/i3c/i3c.txt | 128 ++++++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
> > new file mode 100644
> > index 000000000000..79a214dee025
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> > @@ -0,0 +1,128 @@
> > +Generic device tree bindings for I3C busses
> > +===========================================
> > +
> > +This document describes generic bindings that should be used to describe I3C
> > +busses in a device tree.
> > +
> > +Required properties
> > +-------------------
> > +
> > +- #address-cells  - should be <1>. Read more about addresses below.
> > +- #size-cells     - should be <0>.
> > +- compatible      - name of I3C bus controller following generic names
> > +		    recommended practice.  
> 
> generic names isn't anything recommended.

Hm, I agree. Don't even know what I wanted to say (it's probably been
copied from somewhere else).

> 
> One problem we have with i2c buses is we can't identify them in the DT 
> other than with a list of all controller's compatible strings. We can 
> fix this by defining the controller node name.

I'm fine with that.

> So please define the node 
> name to be "i3c-controller". That's more inline with other node names 
> than i3c-master that you used below.

Hm, not sure i3c-controller is appropriate though, because you can have
slave controllers. Maybe i3c-host, but I'd prefer to keep the term
master since it's employed everywhere in the spec. I can also be
i3c-master-controller if you prefer.

> 
> > +
> > +For other required properties e.g. to describe register sets,
> > +clocks, etc. check the binding documentation of the specific driver.
> > +
> > +Optional properties
> > +-------------------
> > +
> > +These properties may not be supported by all I3C master drivers. Each I3C
> > +master bindings should specify which of them are supported.
> > +
> > +- i3c-scl-frequency: frequency (in Hz) of the SCL signal used for I3C
> > +		     transfers. When undefined the core set it to 12.5MHz.
> > +
> > +- i2c-scl-frequency: frequency (in Hz) of the SCL signal used for I2C
> > +		     transfers. When undefined, the core looks at LVR values
> > +		     of I2C devices described in the device tree to determine
> > +		     the maximum I2C frequency.  
> 
> Add '-hz' suffix. You could drop 'frequency' as that would be implied by 
> Hz.

Okay.

> 
> > +
> > +I2C devices
> > +===========
> > +
> > +Each I2C device connected to the bus should be described in a subnode with
> > +the following properties:
> > +
> > +All properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> > +valid here.
> > +
> > +New required properties:
> > +------------------------
> > +- i3c-lvr: 32 bits integer property (only the lowest 8 bits are meaningful)
> > +	   describing device capabilities as described in the I3C
> > +	   specification.
> > +
> > +	   bit[31:8]: unused
> > +	   bit[7:5]: I2C device index. Possible values
> > +	    * 0: I2C device has a 50 ns spike filter
> > +	    * 1: I2C device does not have a 50 ns spike filter but supports high
> > +		 frequency on SCL
> > +	    * 2: I2C device does not have a 50 ns spike filter and is not
> > +		 tolerant to high frequencies
> > +	    * 3-7: reserved
> > +
> > +	   bit[4]: tell whether the device operates in FM or FM+ mode
> > +	    * 0: FM+ mode
> > +	    * 1: FM mode
> > +
> > +	   bit[3:0]: device type
> > +	    * 0-15: reserved
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
> > +take this dynamic address).
> > +
> > +Required properties
> > +-------------------
> > +- i3c-pid: PID (Provisional ID). 64-bit property which is used to match a
> > +	   device discovered during DAA with its device tree definition. The
> > +	   PID is supposed to be unique on a given bus, which guarantees a 1:1
> > +	   match. This property becomes optional if a reg property is defined,
> > +	   meaning that the device has a static address.  
> 
> What determines this number?

Part of it is fixed (manufacturer and part id) and the last few bits
represent the device instance on the bus (so you can have several
identical devices on the same bus). The manufacturer and part ids
should be statically assigned during production, instance id is usually
configurable through extra pins that you drive high or low at reset
time.

> 
> > +
> > +Optional properties
> > +-------------------
> > +- reg: static address. Only valid is the device has a static address.
> > +- i3c-dynamic-address: dynamic address to be assigned to this device. This
> > +		       property depends on the reg property.  
> 
> Perhaps "assigned-address" property would be appropriate. I'm not all 
> that familiar with it though.

Again, the spec use the term "dynamic address" everywhere, and I'd like
to stay as close as possible to the spec.

> 
> > +
> > +Example:
> > +
> > +	i3c-master@0d040000 {  
> 
> Drop leading 0.

Yep, already mentioned by Peter, I'll fix that.

> 
> > +		compatible = "cdns,i3c-master";
> > +		clocks = <&coreclock>, <&i3csysclock>;
> > +		clock-names = "pclk", "sysclk";
> > +		interrupts = <3 0>;
> > +		reg = <0x0d040000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		status = "okay";
> > +		i2c-scl-frequency = <100000>;
> > +
> > +		/* I2C device. */
> > +		nunchuk: nunchuk@52 {
> > +			compatible = "nintendo,nunchuk";
> > +			reg = <0x52>;
> > +			i3c-lvr = <0x10>;
> > +		};
> > +
> > +		/* I3C device with a static address. */
> > +		thermal_sensor: sensor@68 {
> > +			reg = <0x68>;
> > +			i3c-dynamic-address = <0xa>;
> > +		};
> > +
> > +		/*
> > +		 * I3C device without a static address but requiring resources
> > +		 * described in the DT.
> > +		 */
> > +		sensor2 {  
> 
> It's not great that we can't follow using generic node names. Maybe the 
> PID can be used as the address? In USB for example, we use hub ports for 
> DT addresses rather than USB addresses since those are dynamic.

Hm, the problem is, we may have 2 numbering schemes here: one where reg
is used (reg representing the I2C/static address), and another one
where the PID is used.
If you're okay with mixing those 2 schemes, then I'm fine with that too.

> 
> > +			i3c-pid = /bits/ 64 <0x39200144004>;
> > +			clocks = <&clock_provider 0>;
> > +		};
> > +	};
> > +
> > -- 
> > 2.11.0
> >   

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
