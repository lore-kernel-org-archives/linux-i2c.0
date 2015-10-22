From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v4 1/2] acpi: add acpi_preset_companion() stub
Date: Thu, 22 Oct 2015 02:17:41 -0700
Message-ID: <1445505462-27915-2-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

Add a stub for acpi_preset_companion().  Fixes build failures when
acpi_preset_companion() is used and CONFIG_ACPI is not set.

Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
---
 include/linux/acpi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 51a96a8..66564f8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -505,6 +505,12 @@ static inline bool has_acpi_companion(struct device *dev)
 	return false;
 }
 
+static inline void acpi_preset_companion(struct device *dev,
+					 struct acpi_device *parent, u64 addr)
+{
+	return;
+}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return NULL;
-- 
2.1.4
