From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 00/10] Add the I3C subsystem
Date: Mon, 8 Oct 2018 12:47:21 +0200
Message-ID: <CAK8P3a2C+FHiPnHKEAanhD=RpqDG1VywTEGhpdBvvKQ8zmwdUA@mail.gmail.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003132212.12619-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@he>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 3, 2018 at 3:22 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Sorry for the huge delay between v7 and v8 despite the small amount of
> things I was asked to fix/rework.
>
> This patch series is adding a new subsystem to support I3C devices.
>
> This is just adding support for basic features. Extra features will
> be added afterwards.
>
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
>
> - all functions used to send I3C/I2C frames must be called in
>   non-atomic context. Mainly done this way to ease implementation, but
>   this is still open to discussion. Please let me know if you think it's
>   worth considering an asynchronous model here
> - the I3C bus and I3C master controller are now tightly coupled even
>   though they're still allocated separately. There's now a 1:1
>   relationship between these objects, and the I3C master is no longer
>   represented under the I3C bus object.
>   Arnd, let me know if you had something different in mind, and I'll
>   rework the implementation accordingly.

I looked at the entire series again and I'm rather happy with how
it turned out. I've commented on a tiny issue about the readsl()
that should be easy to resolve one way or another, with that
you can add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

There is one additional issue that we've talked about previously
and that I'd like to hear about from GregKH or maybe other
subsystem maintainers: In the current version, you have a single
'bus_type' object, and this is used to represent both a 'host' and
a 'device'. I think we concluded that this is done in other
subsystems as well, and that this is fitting here because a
host (master device) can hand over being a master to another
device (slave), which then becomes the host and sees this
one as a slave. Also a lot of the sysfs attributes are the same
because of this relationship.

It also means that you get a mix of things in sysfs:

/sys/devices/i3c/<bus>
/sys/devices/i3c/<device>
/sys/devices/i3c/<bus>/<device>

which is a bit like what we have on USB where we can have hub
devices that are again parents of other USB devices, but I don't
think we can have i3c hubs or multiplexers in the same way, so
it's only a single level.

I'm ok with this model after our previous discussion and couldn't
come up with a better one. If anyone else still sees it as
problematic and has a better idea, please let us know now.

         Arnd
