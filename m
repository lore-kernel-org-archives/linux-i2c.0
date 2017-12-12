From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC 0/5] Add I3C subsystem
Date: Tue, 12 Dec 2017 20:58:32 +0100
Message-ID: <20171212205832.4b317b21@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <20170731191745.GB1542@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170731191745.GB1542@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-i2c@vger.kernel.org

On Mon, 31 Jul 2017 21:17:45 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> Hi Boris,
> 
> > This patch series is a proposal for a new I3C [1] subsystem.  
> 
> Nice. Good luck with that!
> 
> Some hi-level comments from me related to I2C. I can't say a lot more
> because the specs are not public :(
> 
> > - the bus element is a separate object and is not implicitly described
> >   by the master (as done in I2C). The reason is that I want to be able
> >   to handle multiple master connected to the same bus and visible to
> >   Linux.
> >   In this situation, we should only have one instance of the device and
> >   not one per master, and sharing the bus object would be part of the
> >   solution to gracefully handle this case.
> >   I'm not sure if we will ever need to deal with multiple masters
> >   controlling the same bus and exposed under Linux, but separating the
> >   bus and master concept is pretty easy, hence the decision to do it
> >   now, just in case we need it some day.  
> 
> From my experience, it is a good thing to have this separation.
> 
> > - I2C backward compatibility has been designed to be transparent to I2C
> >   drivers and the I2C subsystem. The I3C master just registers an I2C
> >   adapter which creates a new I2C bus. I'd say that, from a
> >   representation PoV it's not ideal because what should appear as a
> >   single I3C bus exposing I3C and I2C devices here appears as 2
> >   different busses connected to each other through the parenting (the
> >   I3C master is the parent of the I2C and I3C busses).
> >   On the other hand, I don't see a better solution if we want something
> >   that is not invasive.  
> 
> I agree this is the least invasive and also the most compatible
> approach. The other solution would probably be to have some kind of
> emulation layer?
> 
> > I'd also like to get feedback on the doc. Should I detail a bit more
> > the protocol or the framework API? Is this the kind of things you
> > expect in a subsystem doc?  
> 
> Since the spec is not public, details about the protocol will be
> especially useful, I'd say.

MIPI has opened the I3C spec [1], it can be downloaded here [2].

v2 of this series will come soon (sorry for the delay).

Regards,

Boris

[1]https://www.businesswire.com/news//home/20171212005059/en/MIPI-Alliance-Opens-Access-MIPI-I3C-Sensor
[2]http://resources.mipi.org/mipi-i3c-v1-download
