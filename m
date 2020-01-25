From: Colin King <colin.king@canonical.com>
Subject: [PATCH] i2c: parport: fix spelling mistake: "Atmost" -> "At most"
Date: Sat, 25 Jan 2020 20:20:20 +0000
Message-ID: <20200125202020.12861-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a module parameter description.
Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/busses/i2c-parport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index f8f94a25af26..81eb441b2387 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -129,7 +129,7 @@ static int parport[MAX_DEVICE] = {0, -1, -1, -1};
 module_param_array(parport, int, NULL, 0);
 MODULE_PARM_DESC(parport,
 		 "List of parallel ports to bind to, by index.\n"
-		 " Atmost " __stringify(MAX_DEVICE) " devices are supported.\n"
+		 " At most " __stringify(MAX_DEVICE) " devices are supported.\n"
 		 " Default is one device connected to parport0.\n"
 );
 
-- 
2.24.0
