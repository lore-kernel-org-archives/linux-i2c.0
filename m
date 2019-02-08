From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 4/5] i2c:ocores: add SPDX tag
Date: Fri, 8 Feb 2019 17:12:00 +0100
Message-ID: <20190208161201.7860-5-federico.vaga@cern.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@cern.ch>
List-Id: linux-i2c@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index bbe3e96..5b80190 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
  * (https://opencores.org/project/i2c/overview)
@@ -7,9 +8,8 @@
  * Support for the GRLIB port of the controller by
  * Andreas Larsson <andreas@gaisler.com>
  *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
+ * This program is licensed "as is" without any warranty of any kind,
+ * whether express or implied.
  */
 
 #include <linux/clk.h>
-- 
2.15.0
