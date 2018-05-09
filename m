From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] i2c: robotfuzz-osif: drop pointless test
Date: Wed,  9 May 2018 21:46:58 +0200
Message-ID: <20180509194658.29106-2-peda@axentia.se>
References: <20180509194658.29106-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509194658.29106-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

In the for-loop test, ret will be either 0 or 1. So, the
comparison is pointless. Drop it, and drop the initializer
which is then also pointless.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 51d93b4b00f2..d848cf515234 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -62,10 +62,10 @@ static int osif_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 {
 	struct osif_priv *priv = adapter->algo_data;
 	struct i2c_msg *pmsg;
-	int ret = 0;
+	int ret;
 	int i;
 
-	for (i = 0; ret >= 0 && i < num; i++) {
+	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
 
 		if (pmsg->flags & I2C_M_RD) {
-- 
2.11.0
