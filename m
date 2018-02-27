From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Date: Tue, 27 Feb 2018 21:13:02 +0100
Message-ID: <20180227211302.26f76427@bbrezillon>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
        <20171214151610.19153-3-boris.brezillon@free-electrons.com>
        <b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
        <20180223213000.407461d2@bbrezillon>
        <1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
        <20180226213607.7161bb0a@bbrezillon>
        <b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
        <MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Przemyslaw Sroka <psroka@cadence.com>
Cc: Vitor Soares <Vitor.Soares@synopsys.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.m>
List-Id: linux-i2c@vger.kernel.org

Hi Przemek,

On Tue, 27 Feb 2018 16:43:27 +0000
Przemyslaw Sroka <psroka@cadence.com> wrote:

> >   
> > >> Either important is the SETDASA for declared I3C devices. So the DAA
> > >> process should start by send an SETDASA and them ENTDAA CCC  
> > command.  
> > > My understanding was that SETDASA was not mandatory, and was only
> > > useful when one wants to assign a specific dynamic address to a slave
> > > that has a static address (which is again not mandatory).
> > > I've tested it, and even devices with a static address participate to
> > > the DAA procedure if they've not been assigned a dynamic address yet,
> > > so I don't see the need for this SETDASA step if you don't need to
> > > assign a particular dynamic address to the device.
> > >
> > > Could you tell me why you think SETDASA is required?  
> > 
> > Yes, you are right... But in my opinion it is required as it does part of DAA
> > process.  
> 
> SETDASA is simply faster than ENTDAA, but only if there is no need to
> collect BCR/DCR/PID of such devices. I think most applications would
> like to have them as an status information so  after all ENTDAA can 
> be regarded as an generic approach (unless I'm mistaken).

Actually, we could retrieve BCR/DCR/PID (and all other relevant
information, like MAXDS) even with the SETDASA approach. We just
need to send the according CCC commands after SETDASA.

But that's also my understanding that ENTDAA should always work, and
SETDASA usage is only needed if you want to reserve a dynamic address
and assign it to a device before DAA takes place. This way you can
enforce the device priority (WRT IBIs). But honestly, that's the only
use case I can think of, and to me, it sounds like an advanced feature
we may want to support at some point, but don't need in the initial
implementation.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
