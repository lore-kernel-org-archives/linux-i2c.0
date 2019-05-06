From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH v7 0/1] Add support for IPMB driver
Date: Mon,  6 May 2019 11:29:28 -0400
Message-ID: <cover.1557156354.git.Asmaa@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com, michaelsh@mellanox.com
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Vadim,

I have addressed your comments:
1) removed typecasting and replaced it with a macro to get the 8 bit
address. I think it is more readable this way.
2) added space

Thank you for your feedback!

Asmaa Mnebhi (1):
  Add support for IPMB driver

 Documentation/IPMB.txt           | 103 ++++++++++
 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 399 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 511 insertions(+)
 create mode 100644 Documentation/IPMB.txt
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2
