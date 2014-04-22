From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Resend Patch 2/9] ACPICA: Export acpi_buffer_to_resource symbol
Date: Tue, 22 Apr 2014 14:24:08 +0800
Message-ID: <1398147855-9868-3-git-send-email-tianyu.lan@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tianyu.lan@intel.com
List-Id: linux-i2c@vger.kernel.org

The acpi_buffer_to_resource is needed in i2c module
to convert aml buffer to struct acpi_resource

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/acpica/rscreate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 75d3690..5828649 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -112,6 +112,7 @@ acpi_buffer_to_resource(u8 *aml_buffer,
 
 	return (status);
 }
+ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource);
 
 /*******************************************************************************
  *
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
