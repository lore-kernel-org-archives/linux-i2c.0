From: minyard@acm.org
Subject: [PATCH 2/3] ipmi: Handle I2C parms in the SSIF driver.
Date: Tue, 19 Jan 2016 11:14:13 -0600
Message-ID: <1453223654-20724-3-git-send-email-minyard@acm.org>
References: <1453223654-20724-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173023pub.verizon.net ([206.46.173.23]:42166 "EHLO
	vms173023pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbcASROb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 12:14:31 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173023.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O170098XMJSNMC0@vms173023.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:14:17 -0600 (CST)
In-reply-to: <1453223654-20724-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 8b3be8b..740fdea 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -200,7 +200,7 @@ struct ssif_info {
 	struct ipmi_smi_msg *waiting_msg;
 	struct ipmi_smi_msg *curr_msg;
 	enum ssif_intf_state ssif_state;
-	unsigned long       ssif_debug;
+	unsigned int        ssif_debug;
 
 	struct ipmi_smi_handlers handlers;
 
@@ -1386,6 +1386,60 @@ restart:
 	return found;
 }
 
+static int ssif_parse_parms(struct ssif_info *ssif_info,
+			    const char *parms, u8 *slave_addr)
+{
+	int rv;
+	char end;
+
+	if (!parms)
+		return 0;
+
+	while (*parms) {
+		const char *next = parms;
+		const char *val;
+		int parmlen;
+
+		while (*next && !isspace(*next) && *next != '=')
+			next++;
+
+		if (*next != '=') {
+			pr_err("IPMI SSIF invalid parm starting at %s\n",
+			       parms);
+			return -EINVAL;
+		}
+
+		parmlen = next - parms;
+		next++;
+		val = next;
+		while (*next && !isspace(*next))
+			next++;
+
+		if (strncmp(parms, "ipmb", parmlen) == 0) {
+			rv = sscanf(val, "%hhx%c", slave_addr, &end);
+			if ((rv < 1) || ((rv > 1) && !isspace(end))) {
+				pr_err("Invalid ipmb address: %s\n", val);
+				return -EINVAL;
+			}
+		} else if (strncmp(parms, "debug", parmlen) == 0) {
+			rv = sscanf(val, "%i%c", &ssif_info->ssif_debug, &end);
+			if ((rv < 1) || ((rv > 1) && !isspace(end))) {
+				pr_err("Invalid debug value: %s\n", val);
+				return -EINVAL;
+			}
+		} else {
+			pr_err("Invalid IPMI SSIF parameter: %s\n", parms);
+			return -EINVAL;
+		}
+
+		while (*next && isspace(*next))
+			next++;
+		parms = next;
+	}
+
+	return 0;
+}
+
 static bool check_acpi(struct ssif_info *ssif_info, struct device *dev)
 {
 #ifdef CONFIG_ACPI
@@ -1435,6 +1489,12 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (!addr_info) {
 			/* Must have come in through sysfs. */
 			ssif_info->addr_source = SI_HOTMOD;
+			rv = ssif_parse_parms(ssif_info, client->parms,
+					      &slave_addr);
+			if (rv) {
+				pr_err(PFX "Unable to parse parms from i2c\n");
+				goto out;
+			}
 		} else {
 			ssif_info->addr_source = addr_info->addr_src;
 			ssif_info->ssif_debug = addr_info->debug;
-- 
2.5.0
