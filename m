From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 04/10] dt-bindings: i3c: Document core bindings
Date: Wed, 11 Jul 2018 16:45:29 +0200
Message-ID: <20180711164529.3388d045@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-5-boris.brezillon@bootlin.com>
        <CAK8P3a1gyvvpKdVV+STOJXd-=BFdiFF638F0agXur0kLYP7ksw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1gyvvpKdVV+STOJXd-=BFdiFF638F0agXur0kLYP7ksw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.or>
List-Id: linux-i2c@vger.kernel.org

On Wed, 11 Jul 2018 16:10:10 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > A new I3C subsystem has been added and a generic description has been
> > created to represent the I3C bus and the devices connected on it.
> >  
> 
> > +I2C devices
> > +===========
> > +
> > +Each I2C device connected to the bus should be described in a subnode. All
> > +properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
> > +valid here, but several new properties have been added.
> > +
> > +New constraint on existing properties:
> > +--------------------------------------  
> ...
> > +  + third cell: should be 0  
> 
> What for? Just to be future-proof, or do you have something specific
> in mind here?

Even if I2C devices only need 1 cell, I3C devices need 3 (1 for the
static address and 2 for the PID). Since both type of devices are
described under the same bus node, and we can have different
#address-cells, I had to put 0-padding in the last cell.
