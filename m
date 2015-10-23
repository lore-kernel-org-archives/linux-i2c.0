From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v5 1/2] acpi: add acpi_preset_companion() stub
Date: Fri, 23 Oct 2015 12:27:06 -0700
Message-ID: <1445628427-29244-2-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445628427-29244-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445628427-29244-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rjw@rjwysocki.net
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

Add a stub for acpi_preset_companion().  Fixes build failures when
acpi_preset_companion() is used and CONFIG_ACPI is not set.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 43856d1..43b55e7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -477,6 +477,11 @@ static inline bool has_acpi_companion(struct device *dev)
 	return false;
 }
 
+static inline void acpi_preset_companion(struct device *dev,
+					 struct acpi_device *parent, u64 addr)
+{
+}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return NULL;
-- 
2.1.4
