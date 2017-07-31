From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Mon, 31 Jul 2017 22:46:58 +0200
Message-ID: <20170731224658.3991e2fd@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <20170731191721.GA1542@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731191721.GA1542@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-i2c@vger.kernel.org

Le Mon, 31 Jul 2017 21:17:21 +0200,
Wolfram Sang <wsa@the-dreams.de> a écrit :

> > +This document is just a brief introduction to the I3C protocol and the concepts
> > +it brings on the table. If you need more information, please refer to the MIPI
> > +I3C specification.  
> 
> I wish I could.
> 
> > +
> > +Introduction
> > +============
> > +
> > +The I3C (I-Cube-C) is a MIPI standardized protocol designed to overcome I2C  
> 
> "Eye-three-See", according to:
> http://eecatalog.com/sensors/2017/07/05/after-35-years-of-i2c-i3c-improves-capability-and-performance/

I remember hearing eye-cube-see during the discussion we had with
Cadence engineers but I might wrong. I'll double check (or maybe I'll
just drop any mention of the pronunciation).

> 
> > +Backward compatibility with I2C devices
> > +=======================================
> > +
> > +The I3C protocol has been designed to be backward compatible with I2C devices.
> > +This backward compatibility allows one to connect a mix of I2C and I3C devices
> > +on the same bus, though, in order to be really efficient, I2C devices should
> > +be equipped with 50 ns spike filters.  
> 
> I just found a slide which says I3C does not support clock stretching.
> That should be mentioned here, too.
> 

You're right, clock stretching is not allowed, and if devices without a
50ns spike filter are connected to the bus, it lowers the maximum
speed for all devices, which renders I3C kind of useless.
