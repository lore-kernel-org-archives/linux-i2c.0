From: Mawanda Henry <mawandahenrynaco@gmail.com>
Subject: [PATCH] drivers/i2c: SPDX-License-header information
Date: Thu, 21 Jun 2018 15:36:52 +0300
Message-ID: <20180621123652.GA8426@sesnaco>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mawanda111@gmail.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

SPDX License header included to easy developers and machine to know the
license governing a particular file

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65..d2cc8fc 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,12 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Linux I2C core slave support code
- *
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
