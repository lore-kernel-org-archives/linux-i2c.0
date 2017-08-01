From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 17:14:34 +0200
Message-ID: <20170801171434.2bc2aa84@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
        <20170731231509.77d1fba4@bbrezillon>
        <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
        <20170801142936.5df48702@bbrezillon>
        <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
        <20170801153414.6ce34ee8@bbrezillon>
        <20170801155813.4b811a4d@bbrezillon>
        <CAK8P3a10oJwsE8vQmPoX4Xf2zg17ZFqypMHMiPR_xOWUAMSB-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a10oJwsE8vQmPoX4Xf2zg17ZFqypMHMiPR_xOWUAMSB-w@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ku
List-Id: linux-i2c@vger.kernel.org

On Tue, 1 Aug 2017 16:22:21 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tue, Aug 1, 2017 at 3:58 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Tue, 1 Aug 2017 15:34:14 +0200
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:  
> >> On Tue, 1 Aug 2017 15:11:44 +0200
> >> Arnd Bergmann <arnd@arndb.de> wrote:  
> >> > On Tue, Aug 1, 2017 at 2:29 PM, Boris Brezillon
> >> > <boris.brezillon@free-electrons.com> wrote:  
> > I just realized I forgot to add a "depends on I2C" in the I3C Kconfig
> > entry. Indeed, I'm unconditionally calling functions provided by the
> > I2C framework which have no dummy wrapper when I2C support is disabled.
> > I could of course conditionally compile some portion of the I3C
> > framework so that it still builds when I2C is disabled but I'm not sure
> > it's worth the trouble.
> >
> > This "depends on I2C" should also solve the I2C+I3C driver issue, since
> > I2C is necessarily enabled when I3C is.
> >
> > Am I missing something?  
> 
> That should solve another part of the problem, as a combined driver then
> just needs 'depends on I3C'.
> 
> On top of that, the i3c_driver structure could also contain callback
> pointers for the i2c subsystem, e.g. i2c_probe(), i2c_remove() etc.
> When the i2c_probe() callback exists, the i3c layer could construct
> a 'struct i2c_driver' with those callbacks and register that under the
> cover. This would mean that combined drivers no longer need to
> register two driver objects.

That should work. Actually, i2c_driver contains a few more hooks, like
->alert(), ->command() and ->detect(). Of course we could assume that
I3C/I2C drivers do not need them, but I'm wondering if it's not easier
to just add an i2c_driver pointer inside the i3c_driver struct and let
the driver populate it if it needs to supports both protocols.

Something like:

	struct i3c_driver {
		...
		struct i2c_driver *i2c_compat;
		...
	};


and then in I3C/I2C drivers:

	static struct i2c_driver my_i2c_driver = {
		...
	};

	static struct i3c_driver my_i3c_driver = {
		...
		.i2c_compat = &my_i2c_driver,
		...
	};
	module_i3c_driver(my_i3c_driver);



Of course, you'll have a few fields of ->i2c_compat that would be
filled by the core (like the driver name which can be extracted from
my_i3c_driver->driver.name).
