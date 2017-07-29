From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v1] i2c: aspeed: fixed potential null pointer dereference
Date: Fri, 28 Jul 2017 18:00:12 -0700
Message-ID: <20170729010012.5032-1-brendanhiggins@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, benh@kernel.crashing.org, joel@jms.id.au, venture@google.com
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-i2c@vger.kernel.org

Before I skipped null checks when the master is in the STOP state; this
fixes that.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index f19348328a71..6fdf9231c23c 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -410,10 +410,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	}
 
 	/* We are in an invalid state; reset bus to a known state. */
-	if (!bus->msgs && bus->master_state != ASPEED_I2C_MASTER_STOP) {
+	if (!bus->msgs) {
 		dev_err(bus->dev, "bus in unknown state");
 		bus->cmd_err = -EIO;
-		aspeed_i2c_do_stop(bus);
+		if (bus->master_state != ASPEED_I2C_MASTER_STOP)
+			aspeed_i2c_do_stop(bus);
 		goto out_no_complete;
 	}
 	msg = &bus->msgs[bus->msgs_index];
-- 
2.14.0.rc0.400.g1c36432dff-goog
