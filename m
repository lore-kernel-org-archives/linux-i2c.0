From: =?UTF-8?B?TWljaGFsIE1pbsOhxZk=?= <miminar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: autoload i2c-dev module when needed
Date: Thu, 05 Jun 2014 10:17:33 +0200
Message-ID: <5390279D.4030404@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010603050300010108030407"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603050300010108030407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

we've got following request (viz [1]):

i2cdetect requires the i2c-dev module be loaded so the appropriate
/dev entries are created. This is not done automatically, so when
i2cdetect is initially run it gives the false impression that no
buses/devices exist:

# i2cdetect -l
# modprobe i2c-dev
# i2cdetect -l
i2c-0	i2c       	i915 gmbus ssc                  	I2C adapter
i2c-1	i2c       	i915 gmbus vga                  	I2C adapter
i2c-2	i2c       	i915 gmbus panel                	I2C adapter
i2c-3	i2c       	i915 gmbus dpc                  	I2C adapter
i2c-4	i2c       	i915 gmbus dpb                  	I2C adapter
i2c-5	i2c       	i915 gmbus dpd                  	I2C adapter
i2c-6	i2c       	DPDDC-C                         	I2C adapter
i2c-7	i2c       	DPDDC-D                         	I2C adapter


Attached is a patch that autoloads i2c-dev module when neccessary. If
you like it and have commit rights, push it please instead of me. If
you don't like it, don't hold back and tell me.

Best regards,
Michal Minar

[1] https://bugzilla.redhat.com/show_bug.cgi?id=913203
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTkCedAAoJEPezUylxRFUDExAIAJzpGhv0O0U4zFCkzz9wH1cM
mJOzW6Pu/Xnxk/x9e5f5RVG3BIrieJueRbzU/nh+KHqWbvEV/8DOtQ6KVV3c4Sau
Deocg/QqdpMH1UasVIio2iUyuBJS/RvhclJOzo05cDhLfyo5bSp7ixLBwwcjlY4c
UeXcTq7OPID5B4bpZzs2R7T2M81FG3wdI8GcqTNthQahLnCa0XbxEbyGZn2XaiVD
51AeADzmD5OTCPfQFmYq87MW/S101O+GEJJwXb/DngHh2mIVnur0JiDnABdB+Pl4
ysgqooMOMol2blcUQmkwwLzkJ3ArE3MGvjGVtqFBOsI5VSpWsapGa6TdFeYm0UY=
=4tFG
-----END PGP SIGNATURE-----

--------------010603050300010108030407
Content-Type: text/x-patch;
 name="i2c-tools-3.1.0-load-i2c-dev-mod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-tools-3.1.0-load-i2c-dev-mod.patch"

Index: i2c-tools-3.1.0/tools/i2cbusses.c
===================================================================
--- i2c-tools-3.1.0.orig/tools/i2cbusses.c
+++ i2c-tools-3.1.0/tools/i2cbusses.c
@@ -37,9 +37,15 @@
 #include <dirent.h>
 #include <fcntl.h>
 #include <errno.h>
+#ifdef USE_LIBKMOD
+	#include <libkmod.h>
+#endif
 #include "i2cbusses.h"
 #include <linux/i2c-dev.h>
 
+#define BUFLEN 512
+#define I2C_DEV_MOD_NAME "i2c_dev"
+
 enum adt { adt_dummy, adt_isa, adt_i2c, adt_smbus, adt_unknown };
 
 struct adap_type {
@@ -60,6 +66,70 @@ static struct adap_type adap_types[5] =
 	  .algo		= "N/A", },
 };
 
+/**
+ * Try to load i2c_dev kernel mode. Do nothing, if module is already loaded.
+ * Returns 1 on success, 0 otherwise.
+ */
+static int try_load_i2c_dev_mod(void) {
+	int err = 0, loaded = 0;
+	char errbuf[BUFLEN] = { 0 };
+#ifdef USE_LIBKMOD
+	int flags = 0;
+	struct kmod_ctx *ctx;
+	struct kmod_list *l, *list = NULL;
+
+	ctx = kmod_new(NULL, NULL);
+	if (!ctx) {
+		snprintf(errbuf, BUFLEN, "kmod_new() failed!");
+		goto done;
+	}
+	if (kmod_module_new_from_lookup(ctx, I2C_DEV_MOD_NAME, &list) < 0 || list == NULL) {
+		snprintf(errbuf, BUFLEN, I2C_DEV_MOD_NAME " module lookup failed");
+		goto ctx_unref;
+	}
+
+	flags |= KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY;
+	kmod_list_foreach(l, list) {
+		struct kmod_module *mod = kmod_module_get_module(l);
+		err = kmod_module_probe_insert_module(mod, flags, NULL, NULL, NULL, NULL);
+		if (err == -ENOENT) {
+			snprintf(errbuf, BUFLEN,
+					"unknown symbol in module \"%s\", or unknown parameter (see dmesg)",
+					kmod_module_get_name(mod));
+		} else if (err < 0) {
+			snprintf(errbuf, BUFLEN, "(module %s): %s",
+					kmod_module_get_name(mod), strerror(-err));
+		} else {
+			kmod_module_unref(mod);
+			++loaded;
+			break;
+		}
+		kmod_module_unref(mod);
+	}
+
+list_unref:
+	kmod_module_unref_list(list);
+ctx_unref:
+	kmod_unref(ctx);
+#else
+	err = system("modprobe " I2C_DEV_MOD_NAME);
+	if (err < 0) {
+		snprintf(errbuf, BUFLEN, "failed to execute modprobe command");
+	} else if (err > 0) {
+		snprintf(errbuf, BUFLEN, "modprobe command exited with code %d",
+				WEXITSTATUS(err));
+	} else {
+		++loaded;
+		goto done;
+	}
+#endif
+	if (errbuf[0])
+		fprintf(stderr, "Failed to load required " I2C_DEV_MOD_NAME
+			   	" kernel module: %s\n", errbuf);
+done:
+	return loaded;
+}
+
 static enum adt i2c_get_funcs(int i2cbus)
 {
 	unsigned long funcs;
@@ -206,8 +276,12 @@ struct i2c_adap *gather_i2c_busses(void)
 	   i2c-dev and what we really care about are the i2c-dev numbers.
 	   Unfortunately the names are harder to get in i2c-dev */
 	strcat(sysfs, "/class/i2c-dev");
-	if(!(dir = opendir(sysfs)))
-		goto done;
+	if(!(dir = opendir(sysfs))) {
+		if (!try_load_i2c_dev_mod())
+			goto done;
+		if ((!(dir = opendir(sysfs))))
+			goto done;
+	}
 	/* go through the busses */
 	while ((de = readdir(dir)) != NULL) {
 		if (!strcmp(de->d_name, "."))
Index: i2c-tools-3.1.0/tools/Module.mk
===================================================================
--- i2c-tools-3.1.0.orig/tools/Module.mk
+++ i2c-tools-3.1.0/tools/Module.mk
@@ -15,6 +15,11 @@ TOOLS_CFLAGS	:= -Wstrict-prototypes -Wsh
 
 TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
 
+ifeq ($(shell pkg-config --exists libkmod && echo 1), 1)
+    TOOLS_CFLAGS  += $(shell pkg-config --cflags libkmod) -DUSE_LIBKMOD
+    LDFLAGS += $(shell pkg-config --libs libkmod)
+endif
+
 #
 # Programs
 #

--------------010603050300010108030407
Content-Type: application/pgp-signature;
 name="i2c-tools-3.1.0-load-i2c-dev-mod.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="i2c-tools-3.1.0-load-i2c-dev-mod.patch.sig"

iQEcBAABAgAGBQJTkCedAAoJEPezUylxRFUDjssH/A9ADE1CG/nXLsKsHDgd1ZYDLV+I0Ksy
kBSIIhJCnGdWDL45WOY4kEuyrh7Q/jQJmrbIPmH4zjOyQWj+hWjkpNtO4vTYTccjHKWGekL6
fB+/1jcorhv9T0yyuffqKfNJhA8H4DkxmLKUbL04EwVD126F/cmIFpyedk+Q4V3vjPkRXtdb
Qc5voxPK8lRQcUdiBT3hwKyZd/aqdbzEs+UPK2vfi6VabmnKL6fpKAFPGmIAYNidV99m1AJn
JP45YCrXid/0Fv+SSTxOD0WIYVqPXOVX/ko6G6A/qnWKqqGBWDclJHRi5M4y3g+K3SxuJl+u
eYLCASTQspwP1l+XZVs+hb8=
--------------010603050300010108030407--
