From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v6 4/5] i2c: ocores: add SPDX tag
Date: Mon, 11 Feb 2019 17:49:12 +0100
Message-ID: <20190211164913.5988-5-federico.vaga@cern.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211164913.5988-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@cern.ch>
List-Id: linux-i2c@vger.kernel.org

It adds the SPDX tag and it removes the old text about the GPLv2.

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 5dea7b9..78085a8 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
  * (https://opencores.org/project/i2c/overview)
@@ -6,10 +7,6 @@
  *
  * Support for the GRLIB port of the controller by
  * Andreas Larsson <andreas@gaisler.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/clk.h>
-- 
2.15.0
