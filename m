From: Mawanda Henry <mawandahenrynaco@gmail.com>
Subject: [PATCH] drivers/i2c:  Include SPDX-license-identifier
Date: Thu, 21 Jun 2018 12:40:19 +0300
Message-ID: <20180621094019.GA5348@sesnaco>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mawanda111@gmail.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

including the SPDX license identifier header  makes it easy for
developers and machines to know the lecense that is governing the file

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65..883ca836 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Linux I2C core slave support code
  *
-- 
2.7.4
