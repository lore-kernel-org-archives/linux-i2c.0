From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 11/16] driver core: Do not overwrite secondary fwnode with NULL if it is set
Date: Mon, 30 Nov 2015 17:11:39 +0200
Message-ID: <1448896304-87928-12-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

If multiple devices share single firmware node like it is case with MFD
devices, the same firmware node (ACPI) is assigned to all of them. The
function also modifies the shared firmware node in order to preserve
secondary firmware node of the device in question.

If the new device which is sharing the firmware node does not have
secondary node it will be NULL which will be assigned to the secondary node
of the shared firmware node losing all built-in properties.

Prevent this by setting the secondary firmware node only if the replacement
is non-NULL.

Print also warning if someone tries to overwrite secondary node that has
already been assigned.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b7d56c5..0a8bdad 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2261,7 +2261,10 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 		if (fwnode_is_primary(fn))
 			fn = fn->secondary;
 
-		fwnode->secondary = fn;
+		if (fn) {
+			WARN_ON(fwnode->secondary);
+			fwnode->secondary = fn;
+		}
 		dev->fwnode = fwnode;
 	} else {
 		dev->fwnode = fwnode_is_primary(dev->fwnode) ?
-- 
2.6.2
