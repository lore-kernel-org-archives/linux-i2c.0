From: Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] i2c: core: Make comment about I2C table requirement to reflect the code
Date: Wed,  9 Aug 2017 11:21:28 +0200
Message-ID: <20170809092128.29202-1-javierm@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbdHIJVh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 9 Aug 2017 05:21:37 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

I2C drivers were required to have an I2C device ID table even if were for
devices that would only be registered using a specific firmware interface
(e.g: OF or ACPI).

But commit da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed
devices") changed the I2C core to relax the requirement and allow drivers
to avoid defining this table.

Unfortunately it only took into account drivers for OF-only devices and
forgot about ACPI-only ones, and this was fixed by commit c64ffff7a9d1
("i2c: core: Allow empty id_table in ACPI case as well").

But the latter didn't update the original comment, so it doesn't reflect
what the code does now.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/i2c/i2c-core-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 12822a4b8f8f..56e46581b84b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -353,8 +353,8 @@ static int i2c_device_probe(struct device *dev)
 	}
 
 	/*
-	 * An I2C ID table is not mandatory, if and only if, a suitable Device
-	 * Tree match table entry is supplied for the probing device.
+	 * An I2C ID table is not mandatory, if and only if, a suitable OF
+	 * or ACPI ID table is supplied for the probing device.
 	 */
 	if (!driver->id_table &&
 	    !i2c_acpi_match_device(dev->driver->acpi_match_table, client) &&
-- 
2.13.3
