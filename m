From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/3] i2c: core: Dispose OF IRQ mapping at client removal time
Date: Thu, 30 Oct 2014 15:59:37 +0200
Message-ID: <1414677578-27412-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Clients instantiated from OF get an IRQ mapping created at device
registration time. Dispose the mapping when the client is removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/i2c/i2c-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2f90ac6a7f79..258765b29684 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -670,6 +670,9 @@ static int i2c_device_remove(struct device *dev)
 		status = driver->remove(client);
 	}
 
+	if (dev->of_node)
+		irq_dispose_mapping(client->irq);
+
 	dev_pm_domain_detach(&client->dev, true);
 	return status;
 }
-- 
2.0.4
