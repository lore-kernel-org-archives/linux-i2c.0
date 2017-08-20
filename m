From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] i2c: mux: reg: use of_property_read_bool()
Date: Sun, 20 Aug 2017 22:06:50 +0300
Message-ID: <20170820190656.846142358@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:38272 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbdHTTHB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 20 Aug 2017 15:07:01 -0400
Received: by mail-lf0-f43.google.com with SMTP id y15so59051147lfd.5
        for <linux-i2c@vger.kernel.org>; Sun, 20 Aug 2017 12:07:00 -0700 (PDT)
Content-Disposition: inline; filename=i2c-mux-reg-use-of_property_read_bool.patch
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Use more compact of_property_read_bool() calls for the boolean properties
instead  of of_find_property() calls  in i2c_mux_reg_probe_dt().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Wolfram Sang's 'linux.git' repo's 'i2c/for-next' branch.

 drivers/i2c/muxes/i2c-mux-reg.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux/drivers/i2c/muxes/i2c-mux-reg.c
===================================================================
--- linux.orig/drivers/i2c/muxes/i2c-mux-reg.c
+++ linux/drivers/i2c/muxes/i2c-mux-reg.c
@@ -107,9 +107,9 @@ static int i2c_mux_reg_probe_dt(struct r
 	put_device(&adapter->dev);
 
 	mux->data.n_values = of_get_child_count(np);
-	if (of_find_property(np, "little-endian", NULL)) {
+	if (of_property_read_bool(np, "little-endian")) {
 		mux->data.little_endian = true;
-	} else if (of_find_property(np, "big-endian", NULL)) {
+	} else if (of_property_read_bool(np, "big-endian")) {
 		mux->data.little_endian = false;
 	} else {
 #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : \
@@ -122,10 +122,7 @@ static int i2c_mux_reg_probe_dt(struct r
 #error Endianness not defined?
 #endif
 	}
-	if (of_find_property(np, "write-only", NULL))
-		mux->data.write_only = true;
-	else
-		mux->data.write_only = false;
+	mux->data.write_only = of_property_read_bool(np, "write-only");
 
 	values = devm_kzalloc(&pdev->dev,
 			      sizeof(*mux->data.values) * mux->data.n_values,
