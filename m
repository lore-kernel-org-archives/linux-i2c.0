From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH] i2c-mv64xxx: use subsys_initcall for early initialization
Date: Sun, 12 Sep 2010 11:35:29 +0200
Message-ID: <1284284129-28105-1-git-send-email-mike@compulab.co.il>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1624206..6f3d084 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -592,7 +592,7 @@ mv64xxx_i2c_exit(void)
 	platform_driver_unregister(&mv64xxx_i2c_driver);
 }
 
-module_init(mv64xxx_i2c_init);
+subsys_initcall(mv64xxx_i2c_init);
 module_exit(mv64xxx_i2c_exit);
 
 MODULE_AUTHOR("Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>");
-- 
1.6.6.2
