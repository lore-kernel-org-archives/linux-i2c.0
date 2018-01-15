From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [v2] i2c: acorn: add MODULE_LICENSE tag
Date: Mon, 15 Jan 2018 21:28:39 +0100
Message-ID: <20180115202942.1858432-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

As of v4.15, Kbuild warns about missing MODULE_LICENSE tags:

WARNING: modpost: missing MODULE_LICENSE() in drivers/i2c/busses/i2c-acorn.o

This adds a license, author and description tag, matching the
comment at the start of the acorn i2c driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use linux@armlinux.org.uk instead of the old address
---
 drivers/i2c/busses/i2c-acorn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-acorn.c b/drivers/i2c/busses/i2c-acorn.c
index 9d7be5af2bf2..a6f22d30a288 100644
--- a/drivers/i2c/busses/i2c-acorn.c
+++ b/drivers/i2c/busses/i2c-acorn.c
@@ -94,3 +94,7 @@ static int __init i2c_ioc_init(void)
 }
 
 module_init(i2c_ioc_init);
+
+MODULE_AUTHOR("Russell King <linux@armlinux.org.uk>");
+MODULE_DESCRIPTION("ARM IOC/IOMD i2c driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.0
