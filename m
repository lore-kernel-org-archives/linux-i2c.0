From: frowand.list@gmail.com
Subject: [RFC PATCH 1/1] device tree connectors, using plugs and sockets.
Date: Sat,  2 Jul 2016 16:55:50 -0700
Message-ID: <1467503750-31703-2-git-send-email-frowand.list@gmail.com>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32795 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbcGBX4P (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 2 Jul 2016 19:56:15 -0400
In-Reply-To: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, david@gibson.dropbear.id.au, pantelis.antoniou@konsulko.com, stephen.boyd@linaro.org, broonie@kernel.org, grant.likely@secretlab.ca, mark.rutland@arm.com
Cc: mporter@konsulko.com, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com

From: Frank Rowand <frank.rowand@am.sony.com>

This patch has been compiled but has not been booted.  It is likely
to contain bugs.

Problem: mother boards may contain multiple connectors that daughter
boards may be attached to.  If two of the daughter boards can be
described by the same .dtsi file, then it should be possible to
apply the same .dtbo overlay file for each of the boards, specifying
a different target connector for each board.

This patch provides the foundation to allow that to occur, by
creating the two halves of a connector, the socket on the mother
board and the plug on the daughter board.

The one remaining piece that this patch does not provide is how
the overlay manager (which does not yet exist in the mainline
tree) can apply an overlay to two different targets.  That
final step should be a trivial change to of_overlay_create(),
adding a parameter that is a mapping of the target (or maybe
even targets) in the overlay to different targets in the
active device tree.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 drivers/of/overlay.c | 141 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 23 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 82250815e9a5..df9b0097a1e1 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -25,8 +25,9 @@
 
 /**
  * struct of_overlay_info - Holds a single overlay info
- * @target:	target of the overlay operation
- * @overlay:	pointer to the overlay contents node
+ * @target:		target of the overlay operation
+ * @overlay:		pointer to the overlay contents node
+ * @plug_targets:	pointer to array of plug target pointers
  *
  * Holds a single overlay state, including all the overlay logs &
  * records.
@@ -34,6 +35,7 @@
 struct of_overlay_info {
 	struct device_node *target;
 	struct device_node *overlay;
+	struct device_node **plug_targets;
 };
 
 /**
@@ -54,7 +56,8 @@ struct of_overlay {
 };
 
 static int of_overlay_apply_one(struct of_overlay *ov,
-		struct device_node *target, const struct device_node *overlay);
+		struct device_node *target, const struct device_node *overlay,
+		bool plug_node, struct of_overlay_info *ovinfo);
 
 static int of_overlay_apply_single_property(struct of_overlay *ov,
 		struct device_node *target, struct property *prop)
@@ -97,7 +100,7 @@ static int of_overlay_apply_single_device_node(struct of_overlay *ov,
 	tchild = of_get_child_by_name(target, cname);
 	if (tchild != NULL) {
 		/* apply overlay recursively */
-		ret = of_overlay_apply_one(ov, tchild, child);
+		ret = of_overlay_apply_one(ov, tchild, child, false, NULL);
 		of_node_put(tchild);
 	} else {
 		/* create empty tree as a target */
@@ -112,7 +115,7 @@ static int of_overlay_apply_single_device_node(struct of_overlay *ov,
 		if (ret)
 			return ret;
 
-		ret = of_overlay_apply_one(ov, tchild, child);
+		ret = of_overlay_apply_one(ov, tchild, child, false, NULL);
 		if (ret)
 			return ret;
 	}
@@ -128,33 +131,108 @@ static int of_overlay_apply_single_device_node(struct of_overlay *ov,
  * by using the changeset.
  */
 static int of_overlay_apply_one(struct of_overlay *ov,
-		struct device_node *target, const struct device_node *overlay)
+		struct device_node *target, const struct device_node *overlay,
+		bool plug_node, struct of_overlay_info *ovinfo)
 {
-	struct device_node *child;
+	struct device_node *overlay_child;
+	struct device_node *plug_target;
 	struct property *prop;
 	int ret;
+	u32 val;
 
-	for_each_property_of_node(overlay, prop) {
-		ret = of_overlay_apply_single_property(ov, target, prop);
-		if (ret) {
-			pr_err("%s: Failed to apply prop @%s/%s\n",
-				__func__, target->full_name, prop->name);
-			return ret;
+	if (!plug_node) {
+		for_each_property_of_node(overlay, prop) {
+			ret = of_overlay_apply_single_property(ov, target, prop);
+			if (ret) {
+				pr_err("%s: Failed to apply prop @%s/%s\n",
+					__func__, target->full_name, prop->name);
+				return ret;
+			}
 		}
 	}
 
-	for_each_child_of_node(overlay, child) {
-		ret = of_overlay_apply_single_device_node(ov, target, child);
-		if (ret != 0) {
-			pr_err("%s: Failed to apply single node @%s/%s\n",
-					__func__, target->full_name,
-					child->name);
-			of_node_put(child);
-			return ret;
+	if (plug_node) {
+		struct device_node *socket_child;
+		int child_cnt = 0;
+
+		if (WARN_ON(!ovinfo))
+			return -EINVAL;
+
+		for_each_child_of_node(overlay->child, overlay_child) {
+			child_cnt++;
+		}
+		/* plug_targets[] is NULL terminated */
+		child_cnt++;
+		ovinfo->plug_targets = kcalloc(child_cnt,
+					       sizeof(*ovinfo->plug_targets),
+					       GFP_KERNEL);
+
+		child_cnt = 0;
+		for_each_child_of_node(overlay->child, overlay_child) {
+
+			socket_child = of_get_child_by_name(target,
+							    overlay_child->name);
+			ret = of_property_read_u32(socket_child,
+						   "target_phandle", &val);
+			of_node_put(socket_child);
+			if (ret != 0)
+				goto overlay_child;
+			plug_target = of_find_node_by_phandle(val);
+			if (!plug_target)
+				goto overlay_child;
+			/* save for of_node_put() in of_free_overlay_info() */
+			ovinfo->plug_targets[child_cnt++] = plug_target;
+
+			ret = of_overlay_apply_single_device_node(ov, plug_target,
+								  overlay_child);
+			if (ret != 0)
+				goto plug_target;
+		}
+
+	} else {
+		for_each_child_of_node(overlay, overlay_child) {
+			ret = of_overlay_apply_single_device_node(ov, target,
+								  overlay_child);
+			if (ret != 0)
+				goto overlay_child;
 		}
 	}
 
 	return 0;
+
+plug_target:
+	of_node_put(plug_target);
+overlay_child:
+	of_node_put(overlay_child);
+	return ret;
+}
+
+static bool plug_compatible(struct device_node *overlay,
+			    struct device_node *target)
+{
+	struct property *prop_plug;
+	struct property *prop_socket;
+	const char *c_plug;
+	const char *c_socket;
+	bool socket_node;
+
+	socket_node = of_property_read_bool(target, "connector-socket");
+	if (!socket_node)
+		return false;
+
+	prop_plug = of_find_property(overlay, "compatible", NULL);
+	prop_socket = of_find_property(target, "compatible", NULL);
+
+	for (c_socket = of_prop_next_string(prop_plug, NULL); c_socket;
+	     c_socket = of_prop_next_string(prop_plug, c_socket)) {
+		for (c_plug = of_prop_next_string(prop_plug, NULL); c_plug;
+		     c_plug = of_prop_next_string(prop_plug, c_plug)) {
+			if (!of_compat_cmp(c_plug, c_socket, strlen(c_plug)))
+				return true;
+		}
+	}
+
+	return false;
 }
 
 /**
@@ -168,13 +246,24 @@ static int of_overlay_apply_one(struct of_overlay *ov,
  */
 static int of_overlay_apply(struct of_overlay *ov)
 {
-	int i, err;
+	int i, err = 0;
+	bool plug_node = false;
 
 	/* first we apply the overlays atomically */
 	for (i = 0; i < ov->count; i++) {
 		struct of_overlay_info *ovinfo = &ov->ovinfo_tab[i];
 
-		err = of_overlay_apply_one(ov, ovinfo->target, ovinfo->overlay);
+		plug_node = of_property_read_bool(ovinfo->overlay,
+						  "connector-plug");
+		if (plug_node) {
+			if (!plug_compatible(ovinfo->target, ovinfo->overlay))
+				err = -ENODEV;
+		}
+
+		if (err == 0)
+			err = of_overlay_apply_one(ov, ovinfo->target,
+						   ovinfo->overlay, plug_node,
+						   ovinfo);
 		if (err != 0) {
 			pr_err("%s: overlay failed '%s'\n",
 				__func__, ovinfo->target->full_name);
@@ -309,6 +398,7 @@ static int of_build_overlay_info(struct of_overlay *ov,
 static int of_free_overlay_info(struct of_overlay *ov)
 {
 	struct of_overlay_info *ovinfo;
+	struct device_node **plug_targets;
 	int i;
 
 	/* do it in reverse */
@@ -317,6 +407,11 @@ static int of_free_overlay_info(struct of_overlay *ov)
 
 		of_node_put(ovinfo->target);
 		of_node_put(ovinfo->overlay);
+		plug_targets = ovinfo->plug_targets;
+		while (*plug_targets != NULL) {
+			of_node_put(*plug_targets);
+			plug_targets++;
+		}
 	}
 	kfree(ov->ovinfo_tab);
 
-- 
1.9.1
