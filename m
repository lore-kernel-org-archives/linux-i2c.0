From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 15:11:44 +0200
Message-ID: <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon> <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
 <20170801142936.5df48702@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170801142936.5df48702@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ku
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 1, 2017 at 2:29 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Tue, 1 Aug 2017 14:00:05 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:

>> Another argument for a combined bus would be devices that
>> can be attached to either i2c and i3c, depending on the host
>> capabilities.
>
> Hm, that's already the case, isn't it? And you'll anyway need to
> develop specific code for both cases in the I2C/I3C device driver
> because I2C and I3C transfers are different. So I don't see how it
> would help to have a single bus here.
>
>> We have discussed whether i2c and spi should be
>> merged into a single bus_type in the past, as a lot of devices
>> can be attached to either of them.
>
> Oh, really? What's the rational behind that? I mean, I2C and SPI are
> quite different, and even if some devices provide both interfaces, I
> don't see why we should merge them. But you probably had good reasons
> to do so.

Well, we never changed it, so at least the work required to merge
the two was considered too much to justify any advantages.

The main problem with having one driver that can operate on
different bus types (i2c plus either spi or i3c) is the handling for
the various combinations in configurations (e.g. I2C=m, SPI=y).

The easy case is having a module_init function that registers two
device drivers, but that requires having a Kconfig dependency
on both subsystems, and you can't use the module_i2c_driver()
helper.

The second way is to have a number of #ifdef and complex
Kconfig dependencies for the driver to only register the
device_driver objects for the buses that are enabled. This
is also doable, but everyone gets the logic wrong the first time.

What we end up doing to work around this for other drivers is
to have the base driver in one library module, and separate
modules for the bus-specific portions, which can then
use module_i2c_driver again. There are many instances
for combined i2c/spi drivers in the kernel, and it works fine,
but it adds a fair bit of overhead compared to having one
driver that would e.g. use regmap to abstract the differences
in the probe() function and otherwise keeps everything in
one place.

       Arnd
