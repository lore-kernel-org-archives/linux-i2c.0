From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [RFC/PATCH 4/4] dtc: Add /expansion/ support
Date: Mon, 30 Jan 2017 16:02:59 -0800
Message-ID: <20170131000259.28576-5-stephen.boyd@linaro.org>
References: <20170131000259.28576-1-stephen.boyd@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34547 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754638AbdAaAEC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Jan 2017 19:04:02 -0500
Received: by mail-pf0-f178.google.com with SMTP id e4so95133989pfg.1
        for <linux-i2c@vger.kernel.org>; Mon, 30 Jan 2017 16:03:07 -0800 (PST)
In-Reply-To: <20170131000259.28576-1-stephen.boyd@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: devicetree-compiler@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, mporter@konsulko.com, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

There's typically a standard pinout for expansion boards on
platforms like raspberry pi, 96boards, C.H.I.P, etc. Introduce a
new syntax to describe these types of expansion boards in
devicetree.

In general, the resulting dtb format is very similar to the
/plugin/ style of overlays, except the 'target' property in the
fragment node is replaced with a 'target-alias' property that
contains a string instead of a phandle.

	fragment@0 {
		target-alias = "i2c_1";
	};

instead of

	fragment@0 {
		target = <&i2c_1>;
	};

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 checks.c     |  2 +-
 dtc-lexer.l  |  6 ++++++
 dtc-parser.y |  5 +++++
 dtc.c        |  3 +--
 dtc.h        |  1 +
 livetree.c   | 22 +++++++++++++++-------
 6 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/checks.c b/checks.c
index 3d18e45374c8..44101def69d5 100644
--- a/checks.c
+++ b/checks.c
@@ -487,7 +487,7 @@ static void fixup_phandle_references(struct check *c, struct dt_info *dti,
 
 			refnode = get_node_by_ref(dt, m->ref);
 			if (! refnode) {
-				if (!(dti->dtsflags & DTSF_PLUGIN))
+				if (!(dti->dtsflags & (DTSF_PLUGIN | DTSF_EXPANSION)))
 					FAIL(c, "Reference to non-existent node or "
 							"label \"%s\"\n", m->ref);
 				else /* mark the entry as unresolved */
diff --git a/dtc-lexer.l b/dtc-lexer.l
index c600603044f3..c5683e0197ec 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -126,6 +126,12 @@ static void lexical_error(const char *fmt, ...);
 			return DT_PLUGIN;
 		}
 
+<*>"/expansion/"	{
+			DPRINT("Keyword: /expansion/\n");
+			return DT_EXPANSION;
+		}
+
+
 <*>"/memreserve/"	{
 			DPRINT("Keyword: /memreserve/\n");
 			BEGIN_DEFAULT();
diff --git a/dtc-parser.y b/dtc-parser.y
index 3d2ce372c286..28de8f6c1b61 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -60,6 +60,7 @@ extern bool treesource_error;
 
 %token DT_V1
 %token DT_PLUGIN
+%token DT_EXPANSION
 %token DT_MEMRESERVE
 %token DT_LSHIFT DT_RSHIFT DT_LE DT_GE DT_EQ DT_NE DT_AND DT_OR
 %token DT_BITS
@@ -127,6 +128,10 @@ header:
 		{
 			$$ = DTSF_V1 | DTSF_PLUGIN;
 		}
+	| DT_V1 ';' DT_EXPANSION ';'
+		{
+			$$ = DTSF_V1 | DTSF_EXPANSION;
+		}
 	;
 
 headers:
diff --git a/dtc.c b/dtc.c
index d52d6c77a8cd..8f0b47b53d8c 100644
--- a/dtc.c
+++ b/dtc.c
@@ -334,9 +334,8 @@ int main(int argc, char *argv[])
 	process_checks(force, dti);
 
 	/* on a plugin, generate by default */
-	if (dti->dtsflags & DTSF_PLUGIN) {
+	if (dti->dtsflags & (DTSF_PLUGIN | DTSF_EXPANSION))
 		generate_fixups = 1;
-	}
 
 	if (auto_label_aliases)
 		generate_label_tree(dti, "aliases", false);
diff --git a/dtc.h b/dtc.h
index be75aac1f185..f751757d63f6 100644
--- a/dtc.h
+++ b/dtc.h
@@ -264,6 +264,7 @@ struct dt_info {
 /* DTS version flags definitions */
 #define DTSF_V1		0x0001	/* /dts-v1/ */
 #define DTSF_PLUGIN	0x0002	/* /plugin/ */
+#define DTSF_EXPANSION	0x0004	/* /expansion/ */
 
 struct dt_info *build_dt_info(unsigned int dtsflags,
 			      struct reserve_info *reservelist,
diff --git a/livetree.c b/livetree.c
index 798a87ed587e..f8abb875be8e 100644
--- a/livetree.c
+++ b/livetree.c
@@ -331,7 +331,8 @@ struct overlay *chain_overlay(struct overlay *first, struct overlay *list)
 	return first;
 }
 
-static void add_fragment(struct node *base, struct overlay *overlay)
+static void add_fragment(struct node *base, struct overlay *overlay,
+			 bool expansion)
 {
 	static unsigned int next_fragment = 0;
 	struct node *node;
@@ -343,11 +344,18 @@ static void add_fragment(struct node *base, struct overlay *overlay)
 		die("Deletions not supported at runtime for %s\n",
 		    overlay->target);
 
-	/* Insert a target = <&phandle> property */
-	d = data_add_marker(d, REF_PHANDLE, overlay->target);
-	d = data_append_integer(d, 0xffffffff, 32);
+	if (expansion) {
+		/* Insert a target-alias = "<target>" property */
+		p = build_property("target-alias",
+				   data_copy_mem(overlay->target,
+					   strlen(overlay->target) + 1));
+	} else {
+		/* Insert a target = <&phandle> property */
+		d = data_add_marker(d, REF_PHANDLE, overlay->target);
+		d = data_append_integer(d, 0xffffffff, 32);
 
-	p = build_property("target", d);
+		p = build_property("target", d);
+	}
 
 	xasprintf(&name, "fragment@%u", next_fragment++);
 	name_node(overlay->dt, "__overlay__");
@@ -363,8 +371,8 @@ void apply_overlay(struct node *base, struct overlay *overlay,
 	struct node *target = get_node_by_ref(base, overlay->target);
 
 	if (!target) {
-		if (dtsflags & DTSF_PLUGIN) {
-			add_fragment(base, overlay);
+		if (dtsflags & (DTSF_PLUGIN | DTSF_EXPANSION)) {
+			add_fragment(base, overlay, dtsflags & DTSF_EXPANSION);
 			return;
 		} else
 			die("Couldn't find label or path %s for overlay\n",
-- 
2.10.0.297.gf6727b0
