From: Kieran Bingham <kieranbingham@gmail.com>
Subject: [PATCH v2] i2c: return probe deferred status on dev_pm_domain_attach
Date: Mon, 12 Oct 2015 20:49:04 +0100
Message-ID: <1444679344-27284-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Kieran Bingham <kieranbingham@gmail.com>
List-Id: linux-i2c@vger.kernel.org

A change of return status was introduced in commit 3fffd1283927
("i2c: allow specifying separate wakeup interrupt in device tree")

The commit prevents the defer status being passed up the call stack
appropriately when dev_pm_domain_attach returns -EPROBE_DEFER.

Catch the PROBE_DEFER and clear up the IRQ wakeup status

Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
Fixes: 3fffd1283927 ("i2c: allow specifying separate wakeup
interrupt in device tree")

---
V2:
 Fall through the error path before returning -EPROBE_DEFER

 drivers/i2c/i2c-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5f89f1e3c2f2..51f20cce1732 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -699,6 +699,8 @@ static int i2c_device_probe(struct device *dev)
 					client));
 		if (status)
 			goto err_detach_pm_domain;
+	} else {
+		goto err_clear_wakeup_irq;
 	}
 
 	return 0;
-- 
2.1.4
