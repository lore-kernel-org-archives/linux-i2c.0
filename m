From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH v2 0/1] *** Add support for IPMB driver ***
Date: Wed, 17 Apr 2019 15:59:18 -0400
Message-ID: <cover.1555529640.git.Asmaa@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Thank you for your feedback Corey. I have addressed your inlined comments.

I understand your suggestion for making this an I2C driver.
I can certainly make those changes once we hear back from the i2c mailing list.
My only concern is that the ipmb_write is responsible for
sending the response via SMBus, so it needs the total length of the message.
So we need to document that this driver requires that the user program
(it is attached) passes the msg length as the first byte in the message. 

Asmaa Mnebhi (1):
  Add support for IPMB driver

 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 407 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2
