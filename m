From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC 0/5] Add I3C subsystem
Date: Mon, 31 Jul 2017 18:24:45 +0200
Message-ID: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39201 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdGaQYy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 31 Jul 2017 12:24:54 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>

This patch series is a proposal for a new I3C [1] subsystem.

This infrastructure is not complete yet and will be extended over
time.

There are a few design choices that are worth mentioning because they
impact the way I3C device drivers can interact with their devices:

- all functions used to send I3C/I2C frames must be called in
  non-atomic context. Mainly done this way to ease implementation, but
  this is still open to discussion. Please let me know if you think it's
  worth considering an asynchronous model here
- the bus element is a separate object and is not implicitly described
  by the master (as done in I2C). The reason is that I want to be able
  to handle multiple master connected to the same bus and visible to
  Linux.
  In this situation, we should only have one instance of the device and
  not one per master, and sharing the bus object would be part of the
  solution to gracefully handle this case.
  I'm not sure if we will ever need to deal with multiple masters
  controlling the same bus and exposed under Linux, but separating the
  bus and master concept is pretty easy, hence the decision to do it
  now, just in case we need it some day.
  The other benefit of separating the bus and master concepts is that
  master devices appear under the bus directory in sysfs.
- I2C backward compatibility has been designed to be transparent to I2C
  drivers and the I2C subsystem. The I3C master just registers an I2C
  adapter which creates a new I2C bus. I'd say that, from a
  representation PoV it's not ideal because what should appear as a
  single I3C bus exposing I3C and I2C devices here appears as 2
  different busses connected to each other through the parenting (the
  I3C master is the parent of the I2C and I3C busses).
  On the other hand, I don't see a better solution if we want something
  that is not invasive.
- the whole API is exposed through a single header file (i3c.h), but I'm
  seriously considering the option of splitting the I3C driver/user API
  and the I3C master one, mainly to hide I3C core internals and restrict
  what I3C users can do to a limited set of functionalities (send
  I3C/I2C frames to a specific device and that's all).

Missing features in this preliminary version:
- no support for IBI (In Band Interrupts). This is something I'm working
  on, and I'm still unsure how to represent it: an irqchip or a
  completely independent representation that would be I3C specific.
  Right now, I'm more inclined to go for the irqchip approach, since
  this is something people are used to deal with already.
- no Hot Join support, which is similar to hotplug
- no support for multi-master and the associated concepts (mastership
  handover, support for secondary masters, ...)
- I2C devices can only be described using DT because this is the only
  use case I have. However, the framework can easily be extended with
  ACPI and board info support
- I3C slave framework. This has been completely omitted, but shouldn't
  have a huge impact on the I3C framework because I3C slaves don't see
  the whole bus, it's only about handling master requests and generating
  IBIs. Some of the struct, constant and enum definitions could be
  shared, but most of the I3C slave framework logic will be different

If possible, I'd like to have reviews from people that are familiar
with the device model and complex/autodiscoverable busses like USB.
Arnd, Greg, I think your feedback would be very valuable here.

Wolfram, feel free to comment on the integration with the I2C subsystem,
and let me know if you see a better option.

I'd also like to get feedback on the doc. Should I detail a bit more
the protocol or the framework API? Is this the kind of things you
expect in a subsystem doc?

I'm also unsure how far I should go with sysfs attributes. Right
now, I have exposed things that should matter to udev & co plus some
extra information about I3C dev capabilities (sysfs files have not
been documented yet, but I'll do it for the next version of this patch
series). I could go even further and expose more details like device
limitations (in terms of speed), device status, etc. However, I don't
know if those information are relevant to user-space applications.

If you know other people that might be interested by this patchset,
just let me know and I'll Cc them on the next version.

Thanks,

Boris

[1]https://www.mipi.org/specifications/i3c-sensor-specification

Boris Brezillon (5):
  i2c: Export of_i2c_get_board_info()
  i3c: Add core I3C infrastructure
  dt-bindings: i3c: Document core bindings
  i3c: master: Add driver for Cadence IP
  dt-bindings: i3c: Document Cadence I3C master bindings

 .../devicetree/bindings/i3c/cdns,i3c-master.txt    |   45 +
 Documentation/devicetree/bindings/i3c/i3c.txt      |   90 ++
 Documentation/i3c/conf.py                          |   10 +
 Documentation/i3c/device-driver-api.rst            |    7 +
 Documentation/i3c/index.rst                        |    9 +
 Documentation/i3c/master-driver-api.rst            |    8 +
 Documentation/i3c/protocol.rst                     |  199 +++
 Documentation/index.rst                            |    1 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +-
 drivers/i2c/i2c-core-base.c                        |    2 +-
 drivers/i2c/i2c-core-of.c                          |   64 +-
 drivers/i3c/Kconfig                                |   24 +
 drivers/i3c/Makefile                               |    3 +
 drivers/i3c/core.c                                 |  532 ++++++++
 drivers/i3c/device.c                               |  138 ++
 drivers/i3c/internals.h                            |   45 +
 drivers/i3c/master.c                               | 1225 +++++++++++++++++
 drivers/i3c/master/Kconfig                         |    4 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-cdns.c               | 1382 ++++++++++++++++++++
 include/linux/i2c.h                                |   10 +
 include/linux/i3c/ccc.h                            |  389 ++++++
 include/linux/i3c/device.h                         |  212 +++
 include/linux/i3c/master.h                         |  453 +++++++
 include/linux/mod_devicetable.h                    |   15 +
 26 files changed, 4843 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
 create mode 100644 Documentation/i3c/conf.py
 create mode 100644 Documentation/i3c/device-driver-api.rst
 create mode 100644 Documentation/i3c/index.rst
 create mode 100644 Documentation/i3c/master-driver-api.rst
 create mode 100644 Documentation/i3c/protocol.rst
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/core.c
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/i3c-master-cdns.c
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h

-- 
2.7.4
