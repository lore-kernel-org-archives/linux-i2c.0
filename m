From: Colin King <colin.king@canonical.com>
Subject: [PATCH] i2c: fix spelling mistake: "insufficent" -> "insufficient"
Date: Thu, 29 Dec 2016 22:27:33 +0000
Message-ID: <20161229222733.30284-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in WARN message, insufficient has
an insufficient number of i's in the spelling.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3de95a2..c299428 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3633,7 +3633,7 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 	int ret;
 
 	if (!client || !slave_cb) {
-		WARN(1, "insufficent data\n");
+		WARN(1, "insufficient data\n");
 		return -EINVAL;
 	}
 
-- 
2.10.2
