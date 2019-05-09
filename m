From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] i2c: sh_mobile: Fix compilation warning
Date: Thu,  9 May 2019 10:13:46 +0530
Message-ID: <f526f90ea62741716de2ecfa310ba22d8cf1d3c2.1557377015.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This currently generates a warning:

drivers/i2c/busses/i2c-sh_mobile.c: In function 'sh_mobile_i2c_isr':
drivers/i2c/busses/i2c-sh_mobile.c:399:26: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]

Though the code looks okay and shouldn't ever use the variable
uninitialized.

Fix the warning by moving the code around and getting rid of 'data'.

Compile tested only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 8777af4c695e..945eb8504fb7 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -369,7 +369,6 @@ static int sh_mobile_i2c_isr_tx(struct sh_mobile_i2c_data *pd)
 
 static int sh_mobile_i2c_isr_rx(struct sh_mobile_i2c_data *pd)
 {
-	unsigned char data;
 	int real_pos;
 
 	/* switch from TX (address) to RX (data) adds two interrupts */
@@ -390,13 +389,11 @@ static int sh_mobile_i2c_isr_rx(struct sh_mobile_i2c_data *pd)
 		if (real_pos < 0)
 			i2c_op(pd, OP_RX_STOP);
 		else
-			data = i2c_op(pd, OP_RX_STOP_DATA);
+			pd->msg->buf[real_pos] = i2c_op(pd, OP_RX_STOP_DATA);
 	} else if (real_pos >= 0) {
-		data = i2c_op(pd, OP_RX);
+		pd->msg->buf[real_pos] = i2c_op(pd, OP_RX);
 	}
 
-	if (real_pos >= 0)
-		pd->msg->buf[real_pos] = data;
  done:
 	pd->pos++;
 	return pd->pos == (pd->msg->len + 2);
-- 
2.21.0.rc0.269.g1a574e7a288b
