From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 3/5] of: changeset: Add of_changeset_node_move method
Date: Mon, 16 May 2016 19:41:26 +0300
Message-ID: <1463416888-22044-4-git-send-email-pantelis.antoniou@konsulko.com>
References: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463416888-22044-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adds a changeset helper for moving a subtree to a different place
in the running tree. This is useful in advances cases of dynamic
device tree construction.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
---
 drivers/of/dynamic.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  9 +++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 83cc801..b07fec2 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -1054,3 +1054,69 @@ int __of_changeset_add_update_property_string_list(
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__of_changeset_add_update_property_string_list);
+
+static struct device_node *
+__of_changeset_node_move_one(struct of_changeset *ocs,
+		struct device_node *np, struct device_node *new_parent)
+{
+	struct device_node *np2;
+	const char *unitname;
+	int err;
+
+	err = of_changeset_detach_node(ocs, np);
+	if (err)
+		return ERR_PTR(err);
+
+	unitname = strrchr(np->full_name, '/');
+	if (!unitname)
+		unitname = np->full_name;
+
+	np2 = __of_node_dup(np, "%s/%s",
+			new_parent->full_name, unitname);
+	if (!np2)
+		return ERR_PTR(-ENOMEM);
+	np2->parent = new_parent;
+
+	err = of_changeset_attach_node(ocs, np2);
+	if (err)
+		return ERR_PTR(err);
+
+	return np2;
+}
+
+/**
+ * of_changeset_node_move_to - Moves a subtree to a new place in
+ *                             the tree
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer to be moved
+ * @to:		device node of the new parent
+ *
+ * Moves a subtree to a new place in the tree.
+ * Note that a move is a safe operation because the phandles
+ * remain valid.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+int of_changeset_node_move(struct of_changeset *ocs,
+		struct device_node *np, struct device_node *new_parent)
+{
+	struct device_node *npc, *nppc;
+
+	/* move the root first */
+	nppc = __of_changeset_node_move_one(ocs, np, new_parent);
+	if (IS_ERR(nppc))
+		return PTR_ERR(nppc);
+
+	/* move the subtrees next */
+	for_each_child_of_node(np, npc) {
+		nppc = __of_changeset_node_move_one(ocs, npc, nppc);
+		if (IS_ERR(nppc)) {
+			of_node_put(npc);
+			return PTR_ERR(nppc);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_changeset_node_move);
diff --git a/include/linux/of.h b/include/linux/of.h
index 9df3b71..97ac5c8 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1056,6 +1056,9 @@ int __of_changeset_add_update_property_string_list(
 		struct of_changeset *ocs, struct device_node *np,
 		const char *name, const char **strs, int count, bool update);
 
+int of_changeset_node_move(struct of_changeset *ocs,
+	struct device_node *np, struct device_node *new_parent);
+
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
@@ -1118,6 +1121,12 @@ static inline int __of_changeset_add_update_property_string_list(
 	return -EINVAL;
 }
 
+static inline int of_changeset_node_move(struct of_changeset *ocs,
+		struct device_node *np, struct device_node *new_parent)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_OF_DYNAMIC */
 
 /**
-- 
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
