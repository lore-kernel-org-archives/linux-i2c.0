From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 07/10] i2c: i2c-smbus: remove double warning message
Date: Fri, 19 Aug 2016 15:27:39 +0200
Message-ID: <1471613262-20682-8-git-send-email-benjamin.tissoires@redhat.com>
References: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

i2c_handle_smbus_host_notify() returns an error code when it fails.
If the caller wants to warn when an error is returned, we should not
partially warn in the function itself.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 drivers/i2c/i2c-smbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 35e4f1a..819e5f2 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -347,7 +347,6 @@ int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
 
 	if (host_notify->pending) {
 		spin_unlock_irqrestore(&host_notify->lock, flags);
-		dev_warn(&adapter->dev, "Host Notify already scheduled.\n");
 		return -EBUSY;
 	}
 
-- 
2.5.5
