From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 17:20:41 +0200
Message-ID: <20170801172041.30aaac2e@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
        <20170731231509.77d1fba4@bbrezillon>
        <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
        <20170801142936.5df48702@bbrezillon>
        <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
        <20170801153414.6ce34ee8@bbrezillon>
        <20170801141218.GA1450@katana>
        <20170801164826.423183ff@bbrezillon>
        <20170801150108.GC1450@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170801150108.GC1450@katana>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
List-Id: linux-i2c@vger.kernel.org

On Tue, 1 Aug 2017 17:01:08 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> > I do not know of any real devices as of today (all my tests have been
> > done with a dummy/fake I3C slaves emulated with a slave IP),  
> 
> I see.
> 
> > spec clearly describe what legacy/static addresses are for and one of
> > their use case is to connect an I3C device on an I2C bus and let it act
> > as an I2C device.  
> 
> OK. That makes it more likely.
> 
> > Unless you want your device (likely a sensor) to be compatible with both
> > I3C and I2C so that you can target even more people.  
> 
> Right. My question was if this is a realistic or more academic scenario.
> 
> > I'm perfectly fine with the I3C / I2C framework separation. The only
> > minor problem I had with that was the inaccuracy of the
> > sysfs/device-model representation: we don't have one i2c and one i3c
> > bus, we just have one i3c bus with a mix of i2c and i3c devices.  
> 
> I understand that. What if I2C had the same seperation between the "bus"
> and the "master"?
> 

Yep, it might work if we can register an i2c_adapter and pass it an
existing bus object. We'd still need a common base for i2c and i3c
busses, unless we consider the bus as an opaque "struct device *"
object.
