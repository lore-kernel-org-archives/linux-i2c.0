From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] i2c: enable i2c adapter to suspend/resume asynchronously
Date: Tue, 18 Aug 2015 00:17:29 +0800
Message-ID: <55D20919.5020800@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Enable i2c adapter to suspend/resume asynchronously. This can improve
system suspend/resume speed.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 drivers/i2c/i2c-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c83e4d1..90251be 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1439,6 +1439,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	pm_runtime_no_callbacks(&adap->dev);
 
+	device_enable_async_suspend(&adap->dev);
+
 #ifdef CONFIG_I2C_COMPAT
 	res = class_compat_create_link(i2c_adapter_compat_class, &adap->dev,
 				       adap->dev.parent);
-- 1.7.1
