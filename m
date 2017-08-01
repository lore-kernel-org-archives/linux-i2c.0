From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 16:22:21 +0200
Message-ID: <CAK8P3a10oJwsE8vQmPoX4Xf2zg17ZFqypMHMiPR_xOWUAMSB-w@mail.gmail.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon> <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
 <20170801142936.5df48702@bbrezillon> <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
 <20170801153414.6ce34ee8@bbrezillon> <20170801155813.4b811a4d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801155813.4b811a4d@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ku
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 1, 2017 at 3:58 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Tue, 1 Aug 2017 15:34:14 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>> On Tue, 1 Aug 2017 15:11:44 +0200
>> Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tue, Aug 1, 2017 at 2:29 PM, Boris Brezillon
>> > <boris.brezillon@free-electrons.com> wrote:
> I just realized I forgot to add a "depends on I2C" in the I3C Kconfig
> entry. Indeed, I'm unconditionally calling functions provided by the
> I2C framework which have no dummy wrapper when I2C support is disabled.
> I could of course conditionally compile some portion of the I3C
> framework so that it still builds when I2C is disabled but I'm not sure
> it's worth the trouble.
>
> This "depends on I2C" should also solve the I2C+I3C driver issue, since
> I2C is necessarily enabled when I3C is.
>
> Am I missing something?

That should solve another part of the problem, as a combined driver then
just needs 'depends on I3C'.

On top of that, the i3c_driver structure could also contain callback
pointers for the i2c subsystem, e.g. i2c_probe(), i2c_remove() etc.
When the i2c_probe() callback exists, the i3c layer could construct
a 'struct i2c_driver' with those callbacks and register that under the
cover. This would mean that combined drivers no longer need to
register two driver objects.

         Arnd
