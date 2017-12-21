From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: i3c: Document core bindings
Date: Thu, 21 Dec 2017 11:41:44 +0100
Message-ID: <20171221114144.2610d49b@bbrezillon>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
        <20171214151610.19153-6-boris.brezillon@free-electrons.com>
        <20171216172040.jcaezouqkeb7zrqy@rob-hp-laptop>
        <20171216193537.0aef2e97@bbrezillon>
        <20171220180645.pis34opfwawakmqc@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48976 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdLUKl5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 05:41:57 -0500
In-Reply-To: <20171220180645.pis34opfwawakmqc@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Wed, 20 Dec 2017 12:06:45 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Dec 16, 2017 at 07:35:37PM +0100, Boris Brezillon wrote:
> > On Sat, 16 Dec 2017 11:20:40 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >   
> > > On Thu, Dec 14, 2017 at 04:16:08PM +0100, Boris Brezillon wrote:  
> > > > A new I3C subsystem has been added and a generic description has been
> > > > created to represent the I3C bus and the devices connected on it.
> > > > 
> > > > Document this generic representation.  
> 
> [...]
> 
> > > So please define the node 
> > > name to be "i3c-controller". That's more inline with other node names 
> > > than i3c-master that you used below.  
> > 
> > Hm, not sure i3c-controller is appropriate though, because you can have
> > slave controllers. Maybe i3c-host, but I'd prefer to keep the term
> > master since it's employed everywhere in the spec. I can also be
> > i3c-master-controller if you prefer.  
> 
> Okay, i3c-master is fine. Just make it explicit.

Okay.

> 
> > > > +I3C devices
> > > > +===========
> > > > +
> > > > +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> > > > +are thus discoverable. So, by default, I3C devices do not have to be described
> > > > +in the device tree.
> > > > +This being said, one might want to attach extra resources to these devices,
> > > > +and those resources may have to be described in the device tree, which in turn
> > > > +means we have to describe I3C devices.
> > > > +
> > > > +Another use case for describing an I3C device in the device tree is when this
> > > > +I3C device has a static address and we want to assign it a specific dynamic
> > > > +address before the DAA takes place (so that other devices on the bus can't
> > > > +take this dynamic address).
> > > > +
> > > > +Required properties
> > > > +-------------------
> > > > +- i3c-pid: PID (Provisional ID). 64-bit property which is used to match a
> > > > +	   device discovered during DAA with its device tree definition. The
> > > > +	   PID is supposed to be unique on a given bus, which guarantees a 1:1
> > > > +	   match. This property becomes optional if a reg property is defined,
> > > > +	   meaning that the device has a static address.    
> > > 
> > > What determines this number?  
> > 
> > Part of it is fixed (manufacturer and part id) and the last few bits
> > represent the device instance on the bus (so you can have several
> > identical devices on the same bus). The manufacturer and part ids
> > should be statically assigned during production, instance id is usually
> > configurable through extra pins that you drive high or low at reset
> > time.  
> 
> Sounds like an I2C address at least for the pin strapping part...

The address space of this instance-id is smaller (4bits) than the I2C
one (7bits), and more importantly, the instance-id is not required to
be unique, it's the aggregation of the vendor-id, part-id and
instance-id that has to be unique. So, if you were thinking about using
this id to uniquely identify the device on the bus it's not a good idea.

> 
> > > > +
> > > > +Optional properties
> > > > +-------------------
> > > > +- reg: static address. Only valid is the device has a static address.
> > > > +- i3c-dynamic-address: dynamic address to be assigned to this device. This
> > > > +		       property depends on the reg property.    
> > > 
> > > Perhaps "assigned-address" property would be appropriate. I'm not all 
> > > that familiar with it though.  
> > 
> > Again, the spec use the term "dynamic address" everywhere, and I'd like
> > to stay as close as possible to the spec.  
> 
> I looked at assigned-addresses a bit more and that won't really fit 
> because it should be the same format as reg. So I think reg should 
> always be the PID as that is fixed and always present. Then the DAA 
> address is separate and can be the i3c-dynamic-address property.
> 
> However, there's still part I don't understand...
> 
> > > > +		/* I3C device with a static address. */
> > > > +		thermal_sensor: sensor@68 {
> > > > +			reg = <0x68>;
> > > > +			i3c-dynamic-address = <0xa>;  
> 
> I'm confused as to how/why you have both reg and dynamic address?

Some I3C devices have an I2C address (also called static or legacy
address in a few places). The static/I2C/legacy address is used until
the I3C device is assigned a dynamic address by the master. The whole
point of specifying both an I2C address (through the reg property) and
a dynamic address (through the i3c-dynamic-address) is to tell the
controller that a specific dynamic address should be assigned to this
device using the SETSADA (Set Dynamic Address from Static Address)
command before a DAA (Dynamic Address Assignment) procedure is started.
This way, the device will not participate to the DAA (because it
already has a valid DA) and the dynamic address can't be assigned to
a different device (which is one of the problem with the automatic DAA
procedure).

> 
> > > > +		};
> > > > +
> > > > +		/*
> > > > +		 * I3C device without a static address but requiring resources
> > > > +		 * described in the DT.
> > > > +		 */
> > > > +		sensor2 {    
> > > 
> > > It's not great that we can't follow using generic node names. Maybe the 
> > > PID can be used as the address? In USB for example, we use hub ports for 
> > > DT addresses rather than USB addresses since those are dynamic.  
> > 
> > Hm, the problem is, we may have 2 numbering schemes here: one where reg
> > is used (reg representing the I2C/static address), and another one
> > where the PID is used.
> > If you're okay with mixing those 2 schemes, then I'm fine with that too.  
> 
> Mixing I2C devices and I3C devices, yes. But you need to mix in a single 
> device? IOW, do I3C devices also have an I2C address?

Yes, some of them have both.
