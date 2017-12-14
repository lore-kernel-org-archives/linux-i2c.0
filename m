From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 0/7] Add the I3C subsystem
Date: Thu, 14 Dec 2017 16:16:03 +0100
Message-ID: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-i2c@vger.kernel.org

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

Missing features in this preliminary version:
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

Main changes between the initial RFC and this v2 are:
- Add a generic infrastructure to support IBIs. It's worth mentioning
  that I tried exposing IBIs as a regular IRQs, but after several
  attempts and a discussion with Mark Zyngier, it appeared that it was
  not really fitting in the Linux IRQ model (the fact that you have
  payload attached to IBIs, the fact that most of the time an IBI will
  generate a transfer on the bus which has to be done in an atomic
  context, ...)
  The counterpart of this decision is the latency induced by the
  workqueue approach, but since I don't have real use cases, I don't
  know if this can be a problem or not. 
- Add helpers to support Hot Join
- Add support for IBIs and Hot Join in Cadence I3C master driver
- Address several issues in how I was using the device model

I'll finish on a good news: this week the MIPI alliance opened the I3C
spec. So everyone can now review the patches (no need to be member of
the MIPI I3C group).
I'll let you find the link in the doc, this way maybe I'll have reviews
on the doc itself :-).

Thanks,

Boris

Boris Brezillon (7):
  i2c: Export of_i2c_get_board_info()
  i3c: Add core I3C infrastructure
  docs: driver-api: Add I3C documentation
  i3c: Add sysfs ABI spec
  dt-bindings: i3c: Document core bindings
  i3c: master: Add driver for Cadence IP
  dt-bindings: i3c: Document Cadence I3C master bindings

 Documentation/ABI/testing/sysfs-bus-i3c            |   95 ++
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    |   45 +
 Documentation/devicetree/bindings/i3c/i3c.txt      |  128 ++
 Documentation/driver-api/i3c/conf.py               |   10 +
 Documentation/driver-api/i3c/device-driver-api.rst |    7 +
 Documentation/driver-api/i3c/index.rst             |    9 +
 Documentation/driver-api/i3c/master-driver-api.rst |    8 +
 Documentation/driver-api/i3c/protocol.rst          |  201 +++
 Documentation/driver-api/index.rst                 |    1 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +-
 drivers/i2c/i2c-core-base.c                        |    2 +-
 drivers/i2c/i2c-core-of.c                          |   66 +-
 drivers/i3c/Kconfig                                |   24 +
 drivers/i3c/Makefile                               |    4 +
 drivers/i3c/core.c                                 |  573 +++++++
 drivers/i3c/device.c                               |  344 ++++
 drivers/i3c/internals.h                            |   34 +
 drivers/i3c/master.c                               | 1433 ++++++++++++++++
 drivers/i3c/master/Kconfig                         |    5 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-cdns.c               | 1797 ++++++++++++++++++++
 include/linux/i2c.h                                |   10 +
 include/linux/i3c/ccc.h                            |  380 +++++
 include/linux/i3c/device.h                         |  321 ++++
 include/linux/i3c/master.h                         |  564 ++++++
 include/linux/mod_devicetable.h                    |   17 +
 27 files changed, 6053 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
 create mode 100644 Documentation/driver-api/i3c/conf.py
 create mode 100644 Documentation/driver-api/i3c/device-driver-api.rst
 create mode 100644 Documentation/driver-api/i3c/index.rst
 create mode 100644 Documentation/driver-api/i3c/master-driver-api.rst
 create mode 100644 Documentation/driver-api/i3c/protocol.rst
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
2.11.0
