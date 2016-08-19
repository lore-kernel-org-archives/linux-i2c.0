From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 08/10] i2c: i2c-smbus: fix return value of i2c_handle_smbus_host_notify()
Date: Fri, 19 Aug 2016 15:27:40 +0200
Message-ID: <1471613262-20682-9-git-send-email-benjamin.tissoires@redhat.com>
References: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

schedule_work() returns a boolean (true on success, false if the work
was already queued).
This doesn't match the "negative number on error" return model that the
function exports.

Given that schedule_work() will always return true (we have an internal
.pending check protected by a spinlock), just return false and ignore
the return value of schedule_work().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 drivers/i2c/i2c-smbus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 819e5f2..f6780de 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -357,7 +357,10 @@ int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
 	host_notify->pending = true;
 	spin_unlock_irqrestore(&host_notify->lock, flags);
 
-	return schedule_work(&host_notify->work);
+	/* schedule_work is called if .pending is false, so it can't fail. */
+	schedule_work(&host_notify->work);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
 
-- 
2.5.5
