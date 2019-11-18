From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 4/4 v2] i2c: i801: Instantiate SPD EEPROMs automatically
Date: Mon, 18 Nov 2019 10:28:48 +0100
Message-ID: <20191118102848.4fdadeb7@endymion>
References: <20191118102410.78cd8e6e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118102410.78cd8e6e@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Call the function to instantiate SPD EEPROMs automatically on the
main SMBus controller.

Multiplexed SMBus systems are excluded for now as they are more
complex to handle.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Changes since v1:
 * Fixed build error reported by kbuild test robot

 drivers/i2c/busses/i2c-i801.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-5.4-rc7.orig/drivers/i2c/busses/i2c-i801.c	2019-11-18 10:21:39.688372006 +0100
+++ linux-5.4-rc7/drivers/i2c/busses/i2c-i801.c	2019-11-18 10:21:41.928402933 +0100
@@ -1320,6 +1320,12 @@ static void i801_probe_optional_slaves(s
 
 	if (is_dell_system_with_lis3lv02d())
 		register_dell_lis3lv02d_i2c_device(priv);
+
+	/* Instantiate SPD EEPROMs unless the SMBus is multiplexed */
+#if IS_ENABLED(CONFIG_I2C_MUX_GPIO)
+	if (!priv->mux_drvdata)
+#endif
+		i2c_register_spd(&priv->adapter);
 }
 #else
 static void __init input_apanel_init(void) {}

-- 
Jean Delvare
SUSE L3 Support
