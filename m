From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Thu, 15 Nov 2018 06:25:54 -0800
Message-ID: <CAK8P3a0gmCtMac7ctKZ3r=2Dxo03pYvuXkQ7c4Vnt9yMoLDMSQ@mail.gmail.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com> <20181115135731.25f60990@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115135731.25f60990@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Vitor Soares <vitor.soares@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 15, 2018 at 4:58 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> +Mark Brown for the question about /dev/spidev
> On Thu, 15 Nov 2018 12:14:37 +0000
> vitor <vitor.soares@synopsys.com> wrote:
> > My initial thoughts are to do the same think as for i2c, expose the
> > buses or the i3c_devices and use ioctl for private transfers.
>
> Exposing the bus is dangerous IMO, because an I3C bus is not like an
> I2C bus:
>
>    * I3C device needs to be discovered through DAA
>    * I2C devices need to be declared ahead of time, and LVR is used to
>      determine the limitations on the bus at runtime
>
> So you'd anyway be able to interact only with devices that have
> previously been discovered.
>
> Note that the virtual I2C bus is already exposed, but any command
> targeting an address that is not attached to a registered I2C dev will
> get a -ENOENT error.
>
> What we could do though, is expose I3C devices that do not have a
> driver in kernel space, like spidev does.
>
> > Some
> > direct CCC commands can be sent through the /sys as you plan for SETNEWDA .
>
> Yes, CCC commands that need to be exposed to userspace should be
> exposed through sysfs, or, if we decide to create a /dev/i3cX device
> per bus, through ioctls.
>
> >
> > What do you think about this?
>
> I think this request is perfectly valid, we just need to decide how it
> should be done, and before we take this decision, I'd like to get
> inputs from other maintainers.
>
> Mark, Wolfram, Arnd, Greg, any opinion?

I think for a new user space interface, it makes sense to explore a number of
different options before making the final decision.

I agree about better not exposing the bus as a /dev/i3c* node, and that we
probably do need to expose individual devices in some form to allow
writing complete user space drivers that can do everything a kernel driver
can do.

Can you describe what a low-level interface to the device looks like
in the kernel? Can this be abstracted as simply pread()/pwrite() plus
an interrupt mechanism, or do we need a set of ioctl() operations as
well?

If it can be purely based on a regmap abstraction, a sysfs inteface
might be sufficient, though that has some downsides with permission
management compared to a /dev/* node.

Another option might be the use of a socket interface, which also
has some issues in terms of permission management, but might
be a good fit if we could abstract bus transactions as packets that
can be queued.

       Arnd
