From: Mawanda Henry <mawandahenrynaco@gmail.com>
Subject: [PATCH v4] i2c: slave: Apply SPDX Lincense-Information
Date: Thu, 21 Jun 2018 19:05:30 +0300
Message-ID: <20180621160530.GA20061@sesnaco>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mawanda111@gmail.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

SPDX license header eases work for developers and machines to know the
license that is governing a particular file

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65..6f56e65 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Linux I2C core slave support code
  *
  * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <dt-bindings/i2c/i2c.h>
-- 
2.7.4
