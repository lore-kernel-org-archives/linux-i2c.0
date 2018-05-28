From: Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] i2c: ocores: update HDL sources URL
Date: Mon, 28 May 2018 10:00:11 +0200
Message-ID: <20180528080011.30054-1-federico.vaga@vaga.pv.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@vaga.pv.it>
List-Id: linux-i2c@vger.kernel.org

The URL is broken. This patch fix it

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 drivers/i2c/busses/i2c-ocores.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 8c42ca7107b2..14c5f6bbfd95 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,6 +1,6 @@
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
- * (http://www.opencores.org/projects.cgi/web/i2c/overview).
+ * (https://opencores.org/project/i2c?do=projects&download=i2c).
  *
  * Peter Korsgaard <jacmet@sunsite.dk>
  *
-- 
2.15.0
