From: Patrick Williams <alpawi@amazon.com>
Subject: [PATCH 0/2] i2c: pxa: migrate to i2c-core-slave APIs
Date: Tue, 1 Oct 2019 10:59:58 -0500
Message-ID: <20191001160001.2388-1-alpawi@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Patrick Williams <alpawi@amazon.com>, Patrick Williams <patrick@stwcx.xyz>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

i2c-pxa has its own i2c slave APIs rather than using the i2c-core
APIs.  There are no in-tree drivers currently using this custom
slave API set.

Migrate the i2c-pxa driver from its own i2c slave APIs to the
i2c-core slave APIs so that in-tree slave devices can be used with
the i2c-pxa hardware (ex. i2c-slave-eeprom).

Patrick Williams (2):
  i2c: pxa: migrate to new i2c_slave APIs
  i2c: pxa: remove unused i2c-slave APIs

 drivers/i2c/busses/Kconfig            |  1 +
 drivers/i2c/busses/i2c-pxa.c          | 75 +++++++++++++++++++++------
 include/linux/i2c-pxa.h               | 18 -------
 include/linux/platform_data/i2c-pxa.h |  4 --
 4 files changed, 61 insertions(+), 37 deletions(-)
 delete mode 100644 include/linux/i2c-pxa.h

-- 
2.17.2 (Apple Git-113)
