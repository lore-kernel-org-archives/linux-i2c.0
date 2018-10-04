From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH i2c-next v6 2/5] i2c: Add support reading of 'timeout-ms' and '#retries' properties
Date: Thu,  4 Oct 2018 13:43:19 -0700
Message-ID: <20181004204322.20665-3-jae.hyun.yoo@linux.intel.com>
References: <20181004204322.20665-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004204322.20665-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

This commit adds support for 'timeout-ms' and '#retries' properties
to set 'timeout' and 'retries' values in 'struct i2c_adapter' in
case an adapter node has the properties. Still the values can be
set by I2C_TIMEOUT and I2C_RETRIES ioctls on cdev at runtime too.

These properties may not be supported by all drivers. However, if
a driver wants to support one of them, it should adapt the
bindings in the dt-bindings document.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/i2c-core-base.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9ee9a15e7134..433867e9af2f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1214,6 +1214,7 @@ EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = -EINVAL;
+	u32 timeout_ms = 0;
 
 	/* Can't register until after driver model init */
 	if (WARN_ON(!is_registered)) {
@@ -1239,8 +1240,13 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	INIT_LIST_HEAD(&adap->userspace_clients);
 
 	/* Set default timeout to 1 second if not already set */
-	if (adap->timeout == 0)
-		adap->timeout = HZ;
+	if (adap->timeout == 0) {
+		device_property_read_u32(&adap->dev, "timeout-ms", &timeout_ms);
+		adap->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : HZ;
+	}
+
+	/* Set retries value if it has the property setting */
+	device_property_read_u32(&adap->dev, "#retries", &adap->retries);
 
 	/* register soft irqs for Host Notify */
 	res = i2c_setup_host_notify_irq_domain(adap);
-- 
2.19.0
