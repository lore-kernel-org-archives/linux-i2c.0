From: Hu Haowen <xianfengting221@163.com>
Subject: [PATCH] i2c: piix4: remove an empty and redundant comment line
Date: Thu,  2 Apr 2020 22:03:59 +0800
Message-ID: <20200402140359.22017-1-xianfengting221@163.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:58870 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbgDBOEb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 2 Apr 2020 10:04:31 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Hu Haowen <xianfengting221@163.com>

This line in the comment is empty and redundant, so removed it.

Signed-off-by: Hu Haowen <xianfengting221@163.com>
---
 drivers/i2c/busses/i2c-piix4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 30ded6422e7b..8bdb1d4abac5 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -2,7 +2,6 @@
 /*
     Copyright (c) 1998 - 2002 Frodo Looijaard <frodol@dds.nl> and
     Philip Edelbrock <phil@netroedge.com>
-
 */
 
 /*
-- 
2.20.1
