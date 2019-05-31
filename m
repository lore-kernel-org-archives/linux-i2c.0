From: Eduardo Valentin <eduval@amazon.com>
Subject: [PATCH 0/3] introduce i2c-slave-mqueue
Date: Thu, 30 May 2019 21:33:44 -0700
Message-ID: <20190531043347.4196-1-eduval@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>, jarkko.nikula@linux.intel.com, andriy.shevchenko@intel.com, brendanhiggins@google.com, Eduardo Valentin <eduval@amazon.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram,

I am sending you the i2c-slave-mqueue driver.
Apparently Haiyue had to move on to another project and
does not have cycles to continue with the comments on this
driver after some time waiting for feedback,
that is essentially why I took over.

Here is a small changelog from V5 to V6:
- Added DT support for probing via Device Tree
- Docummented DT bindings
- Documented sysfs ABI
- Small fixes on wording and Kconfig entries.

Haiyue's V5: https://lkml.org/lkml/2018/4/23/835

BR,

Eduardo Valentin (2):
  dt-bindings: i2c: document bindings for i2c-slave-mqueue
  Documentation: ABI: Add i2c-slave-mqueue sysfs documentation

Haiyue Wang (1):
  i2c: slave-mqueue: add a slave backend to receive and queue messages

 .../sysfs-bus-i2c-devices-slave-mqueue        |  10 +
 .../bindings/i2c/i2c-slave-mqueue.txt         |  34 +++
 Documentation/i2c/slave-mqueue-backend.rst    | 124 ++++++++++
 MAINTAINERS                                   |   8 +
 drivers/i2c/Kconfig                           |  25 +++
 drivers/i2c/Makefile                          |   1 +
 drivers/i2c/i2c-slave-mqueue.c                | 211 ++++++++++++++++++
 7 files changed, 413 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-slave-mqueue
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-slave-mqueue.txt
 create mode 100644 Documentation/i2c/slave-mqueue-backend.rst
 create mode 100644 drivers/i2c/i2c-slave-mqueue.c

-- 
2.21.0
