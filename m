From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [RFC/PATCH 1/4] Start moving overlay handling from parser into dtc core
Date: Mon, 30 Jan 2017 16:02:56 -0800
Message-ID: <20170131000259.28576-2-stephen.boyd@linaro.org>
References: <20170131000259.28576-1-stephen.boyd@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170131000259.28576-1-stephen.boyd@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: devicetree-compiler@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, mporter@konsulko.com, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: David Gibson <david@gibson.dropbear.id.au>

To make includes more useful, dtc for some time has allowed "overlays" in
dts files, defining the tree in several chunks which are merged together.
Recent Linux kernels make use of dynamic DT overlays which have similar
mechanics, but are implemented at DT load time with specially formatted
dtbs.

In order to provide better support for these dynamic overlays in dtc, we
want to explicitly manipulate overlays, rather than just fold them together
during the parse phase.  This patch is a first step towards this.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[stephen.boyd@linaro.org: Have resolve_overlays() loop with a
cursor]
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 dtc-parser.y | 63 +++++++++++++++++++++++++++++-------------------------------
 dtc.c        | 13 +++++++++++++
 dtc.h        | 18 +++++++++++++++--
 flattree.c   |  2 +-
 fstree.c     |  2 +-
 livetree.c   | 40 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 99 insertions(+), 39 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index ca3f5003427c..3d2ce372c286 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -51,6 +51,8 @@ extern bool treesource_error;
 	struct property *proplist;
 	struct node *node;
 	struct node *nodelist;
+	struct overlay *overlay;
+	struct overlay *overlaylist;
 	struct reserve_info *re;
 	uint64_t integer;
 	unsigned int flags;
@@ -83,11 +85,14 @@ extern bool treesource_error;
 %type <prop> propdef
 %type <proplist> proplist
 
-%type <node> devicetree
 %type <node> nodedef
 %type <node> subnode
 %type <nodelist> subnodes
 
+%type <node> basetree
+%type <overlay> overlay
+%type <overlaylist> overlays
+
 %type <integer> integer_prim
 %type <integer> integer_unary
 %type <integer> integer_mul
@@ -106,9 +111,9 @@ extern bool treesource_error;
 %%
 
 sourcefile:
-	  headers memreserves devicetree
+	  headers memreserves basetree overlays
 		{
-			parser_output = build_dt_info($1, $2, $3,
+			parser_output = build_dt_info($1, $2, $3, $4,
 			                              guess_boot_cpuid($3));
 		}
 	;
@@ -157,48 +162,40 @@ memreserve:
 		}
 	;
 
-devicetree:
+basetree:
 	  '/' nodedef
 		{
 			$$ = name_node($2, "");
 		}
-	| devicetree '/' nodedef
+	;
+
+overlay:  basetree
 		{
-			$$ = merge_nodes($1, $3);
+			$$ = build_overlay("/", $1);
 		}
-
-	| devicetree DT_LABEL DT_REF nodedef
+	| DT_REF nodedef
 		{
-			struct node *target = get_node_by_ref($1, $3);
-
-			if (target) {
-				add_label(&target->labels, $2);
-				merge_nodes(target, $4);
-			} else
-				ERROR(&@3, "Label or path %s not found", $3);
-			$$ = $1;
+			$$ = build_overlay($1, $2);
 		}
-	| devicetree DT_REF nodedef
+	| DT_DEL_NODE DT_REF ';'
 		{
-			struct node *target = get_node_by_ref($1, $2);
-
-			if (target)
-				merge_nodes(target, $3);
-			else
-				ERROR(&@2, "Label or path %s not found", $2);
-			$$ = $1;
+			$$ = build_overlay($2, NULL);
 		}
-	| devicetree DT_DEL_NODE DT_REF ';'
+	| DT_LABEL overlay
 		{
-			struct node *target = get_node_by_ref($1, $3);
-
-			if (target)
-				delete_node(target);
-			else
-				ERROR(&@3, "Label or path %s not found", $3);
-
+			add_label(&$2->dt->labels, $1);
+			$$ = $2;
+		}
+	;
 
-			$$ = $1;
+overlays:
+	  /* empty */
+		{
+			$$ = NULL;
+		}
+	| overlay overlays
+		{
+			$$ = chain_overlay($1, $2);
 		}
 	;
 
diff --git a/dtc.c b/dtc.c
index a4edf4c7aebf..91e4c18b891e 100644
--- a/dtc.c
+++ b/dtc.c
@@ -58,6 +58,16 @@ static void fill_fullpaths(struct node *tree, const char *prefix)
 		fill_fullpaths(child, tree->fullpath);
 }
 
+static void resolve_overlays(struct dt_info *dti)
+{
+	struct overlay *o = dti->overlays;
+
+	while (o) {
+		apply_overlay(dti->dt, o);
+		o = o->next;
+	}
+}
+
 /* Usage related data. */
 #define FDT_VERSION(version)	_FDT_VERSION(version)
 #define _FDT_VERSION(version)	#version
@@ -317,7 +327,10 @@ int main(int argc, char *argv[])
 	if (cmdline_boot_cpuid != -1)
 		dti->boot_cpuid_phys = cmdline_boot_cpuid;
 
+	resolve_overlays(dti);
+
 	fill_fullpaths(dti->dt, "");
+
 	process_checks(force, dti);
 
 	/* on a plugin, generate by default */
diff --git a/dtc.h b/dtc.h
index c6f125c68ba8..c4eb6421eabf 100644
--- a/dtc.h
+++ b/dtc.h
@@ -164,6 +164,12 @@ struct node {
 	struct label *labels;
 };
 
+struct overlay {
+	char *target;
+	struct node *dt;
+	struct overlay *next;
+};
+
 #define for_each_label_withdel(l0, l) \
 	for ((l) = (l0); (l); (l) = (l)->next)
 
@@ -208,6 +214,10 @@ void delete_node(struct node *node);
 void append_to_property(struct node *node,
 			char *name, const void *data, int len);
 
+struct overlay *build_overlay(char *target, struct node *dt);
+struct overlay *chain_overlay(struct overlay *first, struct overlay *list);
+void apply_overlay(struct node *base, struct overlay *overlay);
+
 const char *get_unitname(struct node *node);
 struct property *get_property(struct node *node, const char *propname);
 cell_t propval_cell(struct property *prop);
@@ -245,7 +255,9 @@ struct dt_info {
 	unsigned int dtsflags;
 	struct reserve_info *reservelist;
 	uint32_t boot_cpuid_phys;
-	struct node *dt;		/* the device tree */
+
+	struct node *dt;
+	struct overlay *overlays;
 };
 
 /* DTS version flags definitions */
@@ -254,7 +266,9 @@ struct dt_info {
 
 struct dt_info *build_dt_info(unsigned int dtsflags,
 			      struct reserve_info *reservelist,
-			      struct node *tree, uint32_t boot_cpuid_phys);
+			      struct node *basetree,
+			      struct overlay *overlays,
+			      uint32_t boot_cpuid_phys);
 void sort_tree(struct dt_info *dti);
 void generate_label_tree(struct dt_info *dti, char *name, bool allocph);
 void generate_fixups_tree(struct dt_info *dti, char *name);
diff --git a/flattree.c b/flattree.c
index ebac548b3fa8..13e4a4a46b6b 100644
--- a/flattree.c
+++ b/flattree.c
@@ -942,5 +942,5 @@ struct dt_info *dt_from_blob(const char *fname)
 
 	fclose(f);
 
-	return build_dt_info(DTSF_V1, reservelist, tree, boot_cpuid_phys);
+	return build_dt_info(DTSF_V1, reservelist, tree, NULL, boot_cpuid_phys);
 }
diff --git a/fstree.c b/fstree.c
index ae7d06c3c492..08ee93d26157 100644
--- a/fstree.c
+++ b/fstree.c
@@ -86,5 +86,5 @@ struct dt_info *dt_from_fs(const char *dirname)
 	tree = read_fstree(dirname);
 	tree = name_node(tree, "");
 
-	return build_dt_info(DTSF_V1, NULL, tree, guess_boot_cpuid(tree));
+	return build_dt_info(DTSF_V1, NULL, tree, NULL, guess_boot_cpuid(tree));
 }
diff --git a/livetree.c b/livetree.c
index afa2f67b142a..dd51223d1e61 100644
--- a/livetree.c
+++ b/livetree.c
@@ -313,6 +313,39 @@ void append_to_property(struct node *node,
 	}
 }
 
+struct overlay *build_overlay(char *target, struct node *dt)
+{
+	struct overlay *new = xmalloc(sizeof(*new));
+
+	new->target = target;
+	new->dt = dt;
+	new->next = NULL;
+	return new;
+}
+
+struct overlay *chain_overlay(struct overlay *first, struct overlay *list)
+{
+	assert(first->next == NULL);
+
+	first->next = list;
+	return first;
+}
+
+void apply_overlay(struct node *base, struct overlay *overlay)
+{
+	struct node *target = get_node_by_ref(base, overlay->target);
+
+	if (!target)
+		die("Couldn't find label or path %s for overlay\n",
+		    overlay->target);
+
+	if (!overlay->dt)
+		/* Deletion */
+		delete_node(target);
+	else
+		merge_nodes(target, overlay->dt);
+}
+
 struct reserve_info *build_reserve_entry(uint64_t address, uint64_t size)
 {
 	struct reserve_info *new = xmalloc(sizeof(*new));
@@ -354,15 +387,18 @@ struct reserve_info *add_reserve_entry(struct reserve_info *list,
 
 struct dt_info *build_dt_info(unsigned int dtsflags,
 			      struct reserve_info *reservelist,
-			      struct node *tree, uint32_t boot_cpuid_phys)
+			      struct node *basetree,
+			      struct overlay *overlays,
+			      uint32_t boot_cpuid_phys)
 {
 	struct dt_info *dti;
 
 	dti = xmalloc(sizeof(*dti));
 	dti->dtsflags = dtsflags;
 	dti->reservelist = reservelist;
-	dti->dt = tree;
 	dti->boot_cpuid_phys = boot_cpuid_phys;
+	dti->dt = basetree;
+	dti->overlays = overlays;
 
 	return dti;
 }
-- 
2.10.0.297.gf6727b0
