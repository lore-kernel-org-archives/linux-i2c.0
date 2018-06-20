From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 5/5] i2c: mux: make use of __i2c_smbus_xfer
Date: Wed, 20 Jun 2018 10:51:57 +0200
Message-ID: <20180620085157.30121-6-peda@axentia.se>
References: <20180620085157.30121-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620085157.30121-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Calling the __i2c_smbus_xfer wrapper in __i2c_mux_smbus_xfer provides
retries and thus makes the parent-locked case consistent with the both
mux-locked (i2c_mux_smbus_xfer) and the I2C transfer cases.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 300ab4b672e4..221365eb7c05 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -87,8 +87,8 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
 	ret = muxc->select(muxc, priv->chan_id);
 	if (ret >= 0)
-		ret = parent->algo->smbus_xfer(parent, addr, flags,
-					read_write, command, size, data);
+		ret = __i2c_smbus_xfer(parent, addr, flags,
+				       read_write, command, size, data);
 	if (muxc->deselect)
 		muxc->deselect(muxc, priv->chan_id);
 
-- 
2.11.0
