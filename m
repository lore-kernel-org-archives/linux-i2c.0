From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH v6 0/1] Add support for IPMB driver
Date: Fri,  3 May 2019 18:34:40 -0400
Message-ID: <cover.1556921955.git.Asmaa@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com, michaelsh@mellanox.com
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Vadim,

I apologize I forgot to address your previous comment concerning
the ACPI table. I have added the ACPI device id as well as documented
it for whomever wants to use either the ACPI table or device tree.
I did not need that for my testing due to our internal build tools/
code structure.
But I have tested with the device tree and ACPI table as well and
it works fine.

I have addressed your comment concerning using macros instead of magic numbers.

Also, since both you and Corey suggest to not use typecasting,
I will probably change it to GENMASK in my next update. I am waiting
for one more advocate against typecasting!

Asmaa Mnebhi (1):
  Add support for IPMB driver

 Documentation/IPMB.txt           | 103 ++++++++++
 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 397 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 509 insertions(+)
 create mode 100644 Documentation/IPMB.txt
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2
