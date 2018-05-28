From: Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH V2] i2c: ocores: update HDL sources URL
Date: Mon, 28 May 2018 10:59:14 +0200
Message-ID: <20180528085914.30657-2-federico.vaga@vaga.pv.it>
References: <20180528085914.30657-1-federico.vaga@vaga.pv.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180528085914.30657-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@vaga.pv.it>
List-Id: linux-i2c@vger.kernel.org

The URL is broken. This patch fix it

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/i2c/busses/i2c-ocores | 2 +-
 drivers/i2c/busses/i2c-ocores.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-ocores b/Documentation/i2c/busses/i2c-ocores
index c269aaa2f26a..260736e28056 100644
--- a/Documentation/i2c/busses/i2c-ocores
+++ b/Documentation/i2c/busses/i2c-ocores
@@ -2,7 +2,7 @@ Kernel driver i2c-ocores
 
 Supported adapters:
   * OpenCores.org I2C controller by Richard Herveille (see datasheet link)
-    Datasheet: http://www.opencores.org/projects.cgi/web/i2c/overview
+    https://opencores.org/project/i2c?do=projects&download=i2c
 
 Author: Peter Korsgaard <jacmet@sunsite.dk>
 
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
