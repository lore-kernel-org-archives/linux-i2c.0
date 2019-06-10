From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH v12 0/1] Add support for IPMB driver
Date: Mon, 10 Jun 2019 14:57:01 -0400
Message-ID: <cover.1560192707.git.Asmaa@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com, michaelsh@mellanox.com, rdunlap@infradead.org
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Addressed Corey's comment:
Instead of having reference_rq_sa, check the response bit
in the ipmb_write function to provide additional protection
against arbitrary commands.

Asmaa Mnebhi (1):
  Add support for IPMB driver

 Documentation/IPMB.txt           | 103 +++++++++++
 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 364 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 476 insertions(+)
 create mode 100644 Documentation/IPMB.txt
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2
