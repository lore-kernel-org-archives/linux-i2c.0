From: Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC/PATCH 3/4] tests: Add a test for overlays syntactic sugar
Date: Mon, 30 Jan 2017 16:02:58 -0800
Message-ID: <20170131000259.28576-4-stephen.boyd@linaro.org>
References: <20170131000259.28576-1-stephen.boyd@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170131000259.28576-1-stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, marex-ynQEQJNshbs@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Add a single test making sure the &foo { }; syntax works.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
[stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Update test to add required root node]
Signed-off-by: Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 tests/overlay_overlay_simple.dts | 3 +++
 tests/run_tests.sh               | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/overlay_overlay_simple.dts b/tests/overlay_overlay_simple.dts
index 8657e1e7a15a..ab19cc723210 100644
--- a/tests/overlay_overlay_simple.dts
+++ b/tests/overlay_overlay_simple.dts
@@ -7,6 +7,9 @@
 /dts-v1/;
 /plugin/;
 
+/ {
+};
+
 &test {
 	test-int-property = <43>;
 };
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index ed489dbdd269..e2fb084b4434 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -231,6 +231,12 @@ dtc_overlay_tests () {
     run_test check_path overlay_base_with_aliases.dtb not-exists "/__symbols__"
     run_test check_path overlay_base_with_aliases.dtb not-exists "/__fixups__"
     run_test check_path overlay_base_with_aliases.dtb not-exists "/__local_fixups__"
+
+    # Test simplified plugin syntax
+    run_dtc_test -@ -I dts -O dtb -o overlay_overlay_simple.dtb overlay_overlay_simple.dts
+
+    # Verify non-generation of local fixups
+    run_test check_path overlay_overlay_simple.dtb not-exists "/__local_fixups__"
 }
 
 tree1_tests () {
-- 
2.10.0.297.gf6727b0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
