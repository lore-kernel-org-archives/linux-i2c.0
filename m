From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c: Not all adapters have a parent
Date: Thu, 10 Oct 2013 08:04:06 +0200
Message-ID: <20131010080406.3e0fd78e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The code in acpi_i2c_register_devices() assumes that all i2c adapters
have a parent. This is not necessarily the case, for example the
i2c-stub driver instantiate a virtual i2c adapter without a parent.
Check for this to avoid a NULL pointer deference.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-3.12-rc4.orig/drivers/i2c/i2c-core.c	2013-09-24 00:41:09.000000000 +0200
+++ linux-3.12-rc4/drivers/i2c/i2c-core.c	2013-10-10 07:46:12.244886047 +0200
@@ -1134,6 +1134,9 @@ static void acpi_i2c_register_devices(st
 	acpi_handle handle;
 	acpi_status status;
 
+	if (!adap->dev.parent)
+		return;
+
 	handle = ACPI_HANDLE(adap->dev.parent);
 	if (!handle)
 		return;


-- 
Jean Delvare
Suse L3 Support
