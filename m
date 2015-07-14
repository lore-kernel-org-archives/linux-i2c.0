From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v4 03/11] i2c: pxa: Return I2C_RETRY when timeout in pio mode
Date: Tue, 14 Jul 2015 13:06:42 +0530
Message-ID: <1436859410-28878-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, robert.jarzmik@free.fr, yizhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Shouming Wang <wangshm@marvell.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-i2c@vger.kernel.org

From: Shouming Wang <wangshm@marvell.com>

In case of timeout in pio mode of operation return I2C_RETRY.
This behavior will be same as interrupt mode of operation.

Signed-off-by: Shouming Wang <wangshm@marvell.com>
[vaibhav.hiremath@linaro.org: Updated changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/i2c/busses/i2c-pxa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 023e59f..632008f 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -745,8 +745,10 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
 	ret = i2c->msg_idx;
 
 out:
-	if (timeout == 0)
+	if (timeout == 0) {
 		i2c_pxa_scream_blue_murder(i2c, "timeout");
+		ret = I2C_RETRY;
+	}
 
 	return ret;
 }
-- 
1.9.1
