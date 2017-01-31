From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [RFC/PATCH 2/4] dtc: Add syntactic sugar version of overlays
Date: Mon, 30 Jan 2017 16:02:57 -0800
Message-ID: <20170131000259.28576-3-stephen.boyd@linaro.org>
References: <20170131000259.28576-1-stephen.boyd@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170131000259.28576-1-stephen.boyd@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: devicetree-compiler@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, mporter@konsulko.com, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Instead of writing overlays with the target property and
__overlay__ node, i.e.

	fragment@0 {
		target = <&foo>;
		__overlay__ {
			bar-property = <0x200>;
		};
	}

support the syntactic sugar version of overlays where this can
be written as

&foo {
	bar-property = <0x200>;
};

and have dtc convert that into a fragment node.

Based on a patch by Pantelis Antoniou.

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 dtc.c      |  2 +-
 dtc.h      |  3 ++-
 livetree.c | 40 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/dtc.c b/dtc.c
index 91e4c18b891e..d52d6c77a8cd 100644
--- a/dtc.c
+++ b/dtc.c
@@ -63,7 +63,7 @@ static void resolve_overlays(struct dt_info *dti)
 	struct overlay *o = dti->overlays;
 
 	while (o) {
-		apply_overlay(dti->dt, o);
+		apply_overlay(dti->dt, o, dti->dtsflags);
 		o = o->next;
 	}
 }
diff --git a/dtc.h b/dtc.h
index c4eb6421eabf..be75aac1f185 100644
--- a/dtc.h
+++ b/dtc.h
@@ -216,7 +216,8 @@ void append_to_property(struct node *node,
 
 struct overlay *build_overlay(char *target, struct node *dt);
 struct overlay *chain_overlay(struct overlay *first, struct overlay *list);
-void apply_overlay(struct node *base, struct overlay *overlay);
+void apply_overlay(struct node *base, struct overlay *overlay,
+		   unsigned int dtsflags);
 
 const char *get_unitname(struct node *node);
 struct property *get_property(struct node *node, const char *propname);
diff --git a/livetree.c b/livetree.c
index dd51223d1e61..798a87ed587e 100644
--- a/livetree.c
+++ b/livetree.c
@@ -331,14 +331,46 @@ struct overlay *chain_overlay(struct overlay *first, struct overlay *list)
 	return first;
 }
 
-void apply_overlay(struct node *base, struct overlay *overlay)
+static void add_fragment(struct node *base, struct overlay *overlay)
 {
-	struct node *target = get_node_by_ref(base, overlay->target);
+	static unsigned int next_fragment = 0;
+	struct node *node;
+	struct property *p;
+	struct data d = empty_data;
+	char *name;
 
-	if (!target)
-		die("Couldn't find label or path %s for overlay\n",
+	if (!overlay->dt)
+		die("Deletions not supported at runtime for %s\n",
 		    overlay->target);
 
+	/* Insert a target = <&phandle> property */
+	d = data_add_marker(d, REF_PHANDLE, overlay->target);
+	d = data_append_integer(d, 0xffffffff, 32);
+
+	p = build_property("target", d);
+
+	xasprintf(&name, "fragment@%u", next_fragment++);
+	name_node(overlay->dt, "__overlay__");
+	node = build_node(p, overlay->dt);
+	name_node(node, name);
+
+	add_child(base, node);
+}
+
+void apply_overlay(struct node *base, struct overlay *overlay,
+		   unsigned int dtsflags)
+{
+	struct node *target = get_node_by_ref(base, overlay->target);
+
+	if (!target) {
+		if (dtsflags & DTSF_PLUGIN) {
+			add_fragment(base, overlay);
+			return;
+		} else
+			die("Couldn't find label or path %s for overlay\n",
+			    overlay->target);
+	}
+
 	if (!overlay->dt)
 		/* Deletion */
 		delete_node(target);
-- 
2.10.0.297.gf6727b0
