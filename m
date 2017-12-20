From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: i3c: Document core bindings
Date: Wed, 20 Dec 2017 12:06:45 -0600
Message-ID: <20171220180645.pis34opfwawakmqc@rob-hp-laptop>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-6-boris.brezillon@free-electrons.com>
 <20171216172040.jcaezouqkeb7zrqy@rob-hp-laptop>
 <20171216193537.0aef2e97@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171216193537.0aef2e97@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 16, 2017 at 07:35:37PM +0100, Boris Brezillon wrote:
> On Sat, 16 Dec 2017 11:20:40 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Thu, Dec 14, 2017 at 04:16:08PM +0100, Boris Brezillon wrote:
> > > A new I3C subsystem has been added and a generic description has been
> > > created to represent the I3C bus and the devices connected on it.
> > > 
> > > Document this generic representation.

[...]

> > So please define the node 
> > name to be "i3c-controller". That's more inline with other node names 
> > than i3c-master that you used below.
> 
> Hm, not sure i3c-controller is appropriate though, because you can have
> slave controllers. Maybe i3c-host, but I'd prefer to keep the term
> master since it's employed everywhere in the spec. I can also be
> i3c-master-controller if you prefer.

Okay, i3c-master is fine. Just make it explicit.

> > > +I3C devices
> > > +===========
> > > +
> > > +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> > > +are thus discoverable. So, by default, I3C devices do not have to be described
> > > +in the device tree.
> > > +This being said, one might want to attach extra resources to these devices,
> > > +and those resources may have to be described in the device tree, which in turn
> > > +means we have to describe I3C devices.
> > > +
> > > +Another use case for describing an I3C device in the device tree is when this
> > > +I3C device has a static address and we want to assign it a specific dynamic
> > > +address before the DAA takes place (so that other devices on the bus can't
> > > +take this dynamic address).
> > > +
> > > +Required properties
> > > +-------------------
> > > +- i3c-pid: PID (Provisional ID). 64-bit property which is used to match a
> > > +	   device discovered during DAA with its device tree definition. The
> > > +	   PID is supposed to be unique on a given bus, which guarantees a 1:1
> > > +	   match. This property becomes optional if a reg property is defined,
> > > +	   meaning that the device has a static address.  
> > 
> > What determines this number?
> 
> Part of it is fixed (manufacturer and part id) and the last few bits
> represent the device instance on the bus (so you can have several
> identical devices on the same bus). The manufacturer and part ids
> should be statically assigned during production, instance id is usually
> configurable through extra pins that you drive high or low at reset
> time.

Sounds like an I2C address at least for the pin strapping part...

> > > +
> > > +Optional properties
> > > +-------------------
> > > +- reg: static address. Only valid is the device has a static address.
> > > +- i3c-dynamic-address: dynamic address to be assigned to this device. This
> > > +		       property depends on the reg property.  
> > 
> > Perhaps "assigned-address" property would be appropriate. I'm not all 
> > that familiar with it though.
> 
> Again, the spec use the term "dynamic address" everywhere, and I'd like
> to stay as close as possible to the spec.

I looked at assigned-addresses a bit more and that won't really fit 
because it should be the same format as reg. So I think reg should 
always be the PID as that is fixed and always present. Then the DAA 
address is separate and can be the i3c-dynamic-address property.

However, there's still part I don't understand...

> > > +		/* I3C device with a static address. */
> > > +		thermal_sensor: sensor@68 {
> > > +			reg = <0x68>;
> > > +			i3c-dynamic-address = <0xa>;

I'm confused as to how/why you have both reg and dynamic address?

> > > +		};
> > > +
> > > +		/*
> > > +		 * I3C device without a static address but requiring resources
> > > +		 * described in the DT.
> > > +		 */
> > > +		sensor2 {  
> > 
> > It's not great that we can't follow using generic node names. Maybe the 
> > PID can be used as the address? In USB for example, we use hub ports for 
> > DT addresses rather than USB addresses since those are dynamic.
> 
> Hm, the problem is, we may have 2 numbering schemes here: one where reg
> is used (reg representing the I2C/static address), and another one
> where the PID is used.
> If you're okay with mixing those 2 schemes, then I'm fine with that too.

Mixing I2C devices and I3C devices, yes. But you need to mix in a single 
device? IOW, do I3C devices also have an I2C address?

Rob
