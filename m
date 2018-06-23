From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
Date: Sat, 23 Jun 2018 12:17:05 +0200
Message-ID: <20180623121705.1d618c5d@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-2-boris.brezillon@bootlin.com>
        <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Fri, 22 Jun 2018 23:35:34 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-06-22 12:49, Boris Brezillon wrote:
> > Add core infrastructure to support I3C in Linux and document it.
> > 
> > This infrastructure is not complete yet and will be extended over
> > time.
> > 
> > There are a few design choices that are worth mentioning because they
> > impact the way I3C device drivers can interact with their devices:
> > 
> > - all functions used to send I3C/I2C frames must be called in
> >   non-atomic context. Mainly done this way to ease implementation, but
> >   this is still open to discussion. Please let me know if you think
> >   it's worth considering an asynchronous model here
> > - the bus element is a separate object and is not implicitly described
> >   by the master (as done in I2C). The reason is that I want to be able
> >   to handle multiple master connected to the same bus and visible to
> >   Linux.
> >   In this situation, we should only have one instance of the device and
> >   not one per master, and sharing the bus object would be part of the
> >   solution to gracefully handle this case.
> >   I'm not sure we will ever need to deal with multiple masters
> >   controlling the same bus and exposed under Linux, but separating the
> >   bus and master concept is pretty easy, hence the decision to do it
> >   like that.
> >   The other benefit of separating the bus and master concepts is that
> >   master devices appear under the bus directory in sysfs.  
> 
> Are bus multiplexers relevant to I3C?

Not yet, but who knows.

> The locking needed for handling
> muxes for I2C is, well, convoluted...

Do you remember what was the problem?

Anyway, I'd really like to have basic support upstreamed before we
start considering advanced use cases that do not exist yet. Don't get
me wrong, I'm not against having the multiplexer/locking discussion,
but it should not block inclusion of the I3C subsystem.

Regards,

Boris
