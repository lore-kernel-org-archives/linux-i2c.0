From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH v2 4/5] of: unittest: changeset helpers
Date: Mon, 16 May 2016 19:41:27 +0300
Message-ID: <1463416888-22044-5-git-send-email-pantelis.antoniou@konsulko.com>
References: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org

Add a unitest specific for the new changeset helpers.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/of/unittest.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e986e6e..ff6939b 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -543,6 +543,59 @@ static void __init of_unittest_changeset(void)
 #endif
 }
 
+static void __init of_unittest_changeset_helper(void)
+{
+#ifdef CONFIG_OF_DYNAMIC
+	struct device_node *n1, *n2, *n21, *parent, *np;
+	struct of_changeset chgset;
+
+	of_changeset_init(&chgset);
+
+	parent = of_find_node_by_path("/testcase-data/changeset");
+
+	unittest(parent, "testcase setup failure\n");
+	n1 = of_changeset_create_device_node(&chgset,
+			parent, "/testcase-data/changeset/n1");
+	unittest(n1, "testcase setup failure\n");
+	n2 = of_changeset_create_device_node(&chgset,
+			parent, "/testcase-data/changeset/n2");
+	unittest(n2, "testcase setup failure\n");
+	n21 = of_changeset_create_device_node(&chgset, n2, "%s/%s",
+			"/testcase-data/changeset/n2", "n21");
+	unittest(n21, "testcase setup failure\n");
+
+	unittest(!of_changeset_add_property_string(&chgset, parent,
+				"prop-add", "foo"), "fail add prop\n");
+
+	unittest(!of_changeset_attach_node(&chgset, n1), "fail n1 attach\n");
+	unittest(!of_changeset_attach_node(&chgset, n2), "fail n2 attach\n");
+	unittest(!of_changeset_attach_node(&chgset, n21), "fail n21 attach\n");
+
+	unittest(!of_changeset_apply(&chgset), "apply failed\n");
+
+	/* Make sure node names are constructed correctly */
+	np = of_find_node_by_path("/testcase-data/changeset/n1");
+	unittest(np, "'%s' not added\n", n1->full_name);
+	of_node_put(np);
+
+	/* Make sure node names are constructed correctly */
+	np = of_find_node_by_path("/testcase-data/changeset/n2");
+	unittest(np, "'%s' not added\n", n2->full_name);
+	of_node_put(np);
+
+	np = of_find_node_by_path("/testcase-data/changeset/n2/n21");
+	unittest(np, "'%s' not added\n", n21->full_name);
+	of_node_put(np);
+
+	unittest(!of_changeset_revert(&chgset), "revert failed\n");
+
+	of_changeset_destroy(&chgset);
+
+	of_node_put(parent);
+#endif
+}
+
+
 static void __init of_unittest_parse_interrupts(void)
 {
 	struct device_node *np;
@@ -1969,6 +2022,7 @@ static int __init of_unittest(void)
 	of_unittest_property_string();
 	of_unittest_property_copy();
 	of_unittest_changeset();
+	of_unittest_changeset_helper();
 	of_unittest_parse_interrupts();
 	of_unittest_parse_interrupts_extended();
 	of_unittest_match_node();
-- 
1.7.12
