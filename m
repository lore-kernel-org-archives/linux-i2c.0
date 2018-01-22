From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: i3c: Document core bindings
Date: Mon, 22 Jan 2018 09:47:39 +0100
Message-ID: <20180122094739.6b05d5b2@bbrezillon>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
        <20171214151610.19153-6-boris.brezillon@free-electrons.com>
        <20171216172040.jcaezouqkeb7zrqy@rob-hp-laptop>
        <20171216193537.0aef2e97@bbrezillon>
        <20171220180645.pis34opfwawakmqc@rob-hp-laptop>
        <20171221114144.2610d49b@bbrezillon>
        <CAL_JsqLBTtaM=7qdbbyODs61hbGdLughuVtPC-BsfrU8KV79aA@mail.gmail.com>
        <20180107151425.124c2c75@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180107151425.124c2c75@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list:OPEN FIR
List-Id: linux-i2c@vger.kernel.org

Hi Rob,

On Sun, 7 Jan 2018 15:14:25 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Rob,
> 
> On Tue, 26 Dec 2017 12:29:34 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > >> > > > +Optional properties
> > >> > > > +-------------------
> > >> > > > +- reg: static address. Only valid is the device has a static address.
> > >> > > > +- i3c-dynamic-address: dynamic address to be assigned to this device. This
> > >> > > > +                      property depends on the reg property.    
> > >> > >
> > >> > > Perhaps "assigned-address" property would be appropriate. I'm not all
> > >> > > that familiar with it though.    
> > >> >
> > >> > Again, the spec use the term "dynamic address" everywhere, and I'd like
> > >> > to stay as close as possible to the spec.    
> > >>
> > >> I looked at assigned-addresses a bit more and that won't really fit
> > >> because it should be the same format as reg. So I think reg should
> > >> always be the PID as that is fixed and always present. Then the DAA
> > >> address is separate and can be the i3c-dynamic-address property.
> > >>
> > >> However, there's still part I don't understand...
> > >>    
> > >> > > > +               /* I3C device with a static address. */
> > >> > > > +               thermal_sensor: sensor@68 {
> > >> > > > +                       reg = <0x68>;
> > >> > > > +                       i3c-dynamic-address = <0xa>;    
> > >>
> > >> I'm confused as to how/why you have both reg and dynamic address?    
> > >
> > > Some I3C devices have an I2C address (also called static or legacy
> > > address in a few places). The static/I2C/legacy address is used until
> > > the I3C device is assigned a dynamic address by the master. The whole
> > > point of specifying both an I2C address (through the reg property) and
> > > a dynamic address (through the i3c-dynamic-address) is to tell the
> > > controller that a specific dynamic address should be assigned to this
> > > device using the SETSADA (Set Dynamic Address from Static Address)
> > > command before a DAA (Dynamic Address Assignment) procedure is started.
> > > This way, the device will not participate to the DAA (because it
> > > already has a valid DA) and the dynamic address can't be assigned to
> > > a different device (which is one of the problem with the automatic DAA
> > > procedure).    
> > 
> > Okay, think I got it now.
> > 
> > I think we should extend "reg" to have either I2C address, I3C PID, or
> > both (in a defined order). I'm assuming you can always distinguish a
> > static I2C address and an I3C PID just by upper bits all being 0s for
> > I2C addresses. Maybe both is not needed? This means we'd have to allow
> > 64-bit I2C addresses (#address-cells=2), but that should be easily
> > fixed if that causes problems in the kernel.
> > 
> > So i3c-pid would go away and i3c-dynamic-address stays.  
> 
> Hm, actually I'm not sure this is a good idea. Sounds like we're
> abusing the purpose of reg here. For busses, reg is supposed to encode
> the id of the device on the bus that is used to communicate with this
> device (CS line for SPI, I2C address for I2C devs, ...). With I3C, the
> PID is just a way to uniquely identify a device, but is not used during
> communications (we either use the static/I2C address or the dynamic
> address assigned by the master).
> 
> If your concern is just about I3C dev naming convention, maybe we
> could have something like:
> 
> 	i3c-master@xxxx {
> 		...
> 		i2cdev@xx {
> 			reg = <xx>;
> 			i3c-lvr = <yy>;
> 			...
> 		};
> 		...
> 
> 		i3cdev-<i3c-pid>[@zz] {
> 			i3c-pid = <pppppp>;
> 			/*
> 			 * reg only defined if the device has a static
> 			 * address.
> 			 */
> 			[reg = <zz>;]
> 			/*
> 			 * i3c-dynamic-address only defined if a
> 			 * specific dynamic address is requested.
> 			 */
> 			[i3c-dynamic-address = <dd>;]
> 		};
> 	}; 
> 
> With this approach we have a way to quickly identify i3c devices by
> their pid when looking at their names (with the -<i3c-pid> suffix), and
> we keep reg for static/i2c addresses only.

Did you have time to read this email (AKA ping)?

Regards,

Boris
