From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH v10 0/1] Add support for IPMB driver
Date: Wed,  5 Jun 2019 15:09:29 -0400
Message-ID: <cover.1559761562.git.Asmaa@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com, michaelsh@mellanox.com, rdunlap@infradead.org
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Addressed Wolfram's comments:
1) Removed unnecessary lock
2) added check for rq_sa

Asmaa Mnebhi (1):
  Add support for IPMB driver

 Documentation/IPMB.txt           | 103 ++++++++++
 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 400 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 512 insertions(+)
 create mode 100644 Documentation/IPMB.txt
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2
