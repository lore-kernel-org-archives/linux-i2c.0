From: Jean Delvare <jdelvare@suse.de>
Subject: i2c-tools: i2cbusses: Avoid buffer overflows in sysfs paths
Date: Tue, 31 Oct 2017 08:16:04 +0100
Message-ID: <20171031081604.18a9ca54@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbdJaHQH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 03:16:07 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 53A3BADF7
        for <linux-i2c@vger.kernel.org>; Tue, 31 Oct 2017 07:16:06 +0000 (UTC)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>

sprintf isn't safe, use snprintf instead.
---
 tools/i2cbusses.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -220,18 +220,18 @@ struct i2c_adap *gather_i2c_busses(void)
 
 		/* this should work for kernels 2.6.5 or higher and */
 		/* is preferred because is unambiguous */
-		sprintf(n, "%s/%s/name", sysfs, de->d_name);
+		snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);
 		f = fopen(n, "r");
 		/* this seems to work for ISA */
 		if(f == NULL) {
-			sprintf(n, "%s/%s/device/name", sysfs, de->d_name);
+			snprintf(n, NAME_MAX, "%s/%s/device/name", sysfs, de->d_name);
 			f = fopen(n, "r");
 		}
 		/* non-ISA is much harder */
 		/* and this won't find the correct bus name if a driver
 		   has more than one bus */
 		if(f == NULL) {
-			sprintf(n, "%s/%s/device", sysfs, de->d_name);
+			snprintf(n, NAME_MAX, "%s/%s/device", sysfs, de->d_name);
 			if(!(ddir = opendir(n)))
 				continue;
 			while ((dde = readdir(ddir)) != NULL) {
@@ -240,8 +240,8 @@ struct i2c_adap *gather_i2c_busses(void)
 				if (!strcmp(dde->d_name, ".."))
 					continue;
 				if ((!strncmp(dde->d_name, "i2c-", 4))) {
-					sprintf(n, "%s/%s/device/%s/name",
-						sysfs, de->d_name, dde->d_name);
+					snprintf(n, NAME_MAX, "%s/%s/device/%s/name",
+						 sysfs, de->d_name, dde->d_name);
 					if((f = fopen(n, "r")))
 						goto found;
 				}


-- 
Jean Delvare
SUSE L3 Support
