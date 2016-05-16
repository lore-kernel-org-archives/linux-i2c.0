From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH v2 1/5] of: dynamic: Add __of_node_dupv()
Date: Mon, 16 May 2016 19:41:24 +0300
Message-ID: <1463416888-22044-2-git-send-email-pantelis.antoniou@konsulko.com>
References: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36152 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbcEPQlf (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 16 May 2016 12:41:35 -0400
Received: by mail-wm0-f49.google.com with SMTP id n129so108396652wmn.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 May 2016 09:41:34 -0700 (PDT)
In-Reply-To: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Pantelis Antoniou <panto@antoniou-consulting.com>

Add an __of_node_dupv() private method and make __of_node_dup() use it.
This is required for the subsequent changeset accessors which will
make use of it.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/of/dynamic.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 4145b44..e4dea94 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -394,8 +394,9 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 }
 
 /**
- * __of_node_dup() - Duplicate or create an empty device node dynamically.
- * @fmt: Format string (plus vargs) for new full name of the device node
+ * __of_node_dupv() - Duplicate or create an empty device node dynamically.
+ * @fmt: Format string for new full name of the device node
+ * @vargs: va_list containing the arugments for the node full name
  *
  * Create an device tree node, either by duplicating an empty node or by allocating
  * an empty one suitable for further modification.  The node data are
@@ -403,17 +404,15 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
  * OF_DETACHED bits set. Returns the newly allocated node or NULL on out of
  * memory error.
  */
-struct device_node *__of_node_dup(const struct device_node *np, const char *fmt, ...)
+struct device_node *__of_node_dupv(const struct device_node *np,
+		const char *fmt, va_list vargs)
 {
-	va_list vargs;
 	struct device_node *node;
 
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
-	va_start(vargs, fmt);
 	node->full_name = kvasprintf(GFP_KERNEL, fmt, vargs);
-	va_end(vargs);
 	if (!node->full_name) {
 		kfree(node);
 		return NULL;
@@ -445,6 +444,24 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
 	return NULL;
 }
 
+/**
+ * __of_node_dup() - Duplicate or create an empty device node dynamically.
+ * @fmt: Format string (plus vargs) for new full name of the device node
+ *
+ * See: __of_node_dupv()
+ */
+struct device_node *__of_node_dup(const struct device_node *np,
+		const char *fmt, ...)
+{
+	va_list vargs;
+	struct device_node *node;
+
+	va_start(vargs, fmt);
+	node = __of_node_dupv(np, fmt, vargs);
+	va_end(vargs);
+	return node;
+}
+
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
 	of_node_put(ce->np);
-- 
1.7.12
