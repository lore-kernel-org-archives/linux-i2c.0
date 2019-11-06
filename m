From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 01/17] i2c: add helper to check if a client has a driver attached
Date: Wed,  6 Nov 2019 22:21:01 +0100
Message-ID: <20191106212120.27983-2-wsa+renesas@sang-engineering.com>
References: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Factoring out something used in the media subsystem. As an improvement,
it bails out on both, NULL and ERRPTR.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index aaf57d9b41db..93b315c9a062 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -850,6 +850,11 @@ extern void i2c_del_driver(struct i2c_driver *driver);
 #define i2c_add_driver(driver) \
 	i2c_register_driver(THIS_MODULE, driver)
 
+static inline bool i2c_client_has_driver(struct i2c_client *client)
+{
+	return !IS_ERR_OR_NULL(client) && client->dev.driver;
+}
+
 extern struct i2c_client *i2c_use_client(struct i2c_client *client);
 extern void i2c_release_client(struct i2c_client *client);
 
-- 
2.20.1
