From: =?UTF-8?B?TWljaGFsIE1pbsOhxZk=?= <miminar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: autoload i2c-dev module when needed
Date: Thu, 17 Jul 2014 10:57:03 +0200
Message-ID: <53C78FDF.1000802@redhat.com>
References: <5390279D.4030404@redhat.com>	<20140716171457.GC2759@katana> <CAAVjN7dVSMtTFe2+WoWbBxdhJSDsgBW2NrOjSd6qJ30w81VzSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030508090307060608070103"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAVjN7dVSMtTFe2+WoWbBxdhJSDsgBW2NrOjSd6qJ30w81VzSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------030508090307060608070103
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks Dan!

Updated and a bit refactored patch is attached.

Michal
On 07/17/2014 02:56 AM, Danielle Costantino wrote:
> you need to add this after the #else , before the err = system...
> to accommodate for systems that have i2c-dev.ko built in, not as a
> module, on older kernels.
> 
> struct stat st;
> 
> err = stat("/sys/class/i2c-dev", &st);
> 
> if (err < 0) { if (errno != ENOENT) { err = -errno; goto done; }
> else err = 0; } else return 1;
> 
> 
> 
> On Wed, Jul 16, 2014 at 10:14 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> wrote:
> 
>> 
>> Adding Jean Delvare who maintains i2c-tools to CC...
>> 
>> On Thu, Jun 05, 2014 at 10:17:33AM +0200, Michal Minář wrote:
> Hello,
> 
> we've got following request (viz [1]):
> 
> i2cdetect requires the i2c-dev module be loaded so the appropriate 
> /dev entries are created. This is not done automatically, so when 
> i2cdetect is initially run it gives the false impression that no 
> buses/devices exist:
> 
> # i2cdetect -l # modprobe i2c-dev # i2cdetect -l i2c-0 i2c
> i915 gmbus ssc                          I2C adapter i2c-1 i2c
> i915 gmbus vga                          I2C adapter i2c-2 i2c
> i915 gmbus panel                        I2C adapter i2c-3 i2c
> i915 gmbus dpc                          I2C adapter i2c-4 i2c
> i915 gmbus dpb                          I2C adapter i2c-5 i2c
> i915 gmbus dpd                          I2C adapter i2c-6 i2c
> DPDDC-C                                 I2C adapter i2c-7 i2c
> DPDDC-D                                 I2C adapter
> 
> 
> Attached is a patch that autoloads i2c-dev module when neccessary.
> If you like it and have commit rights, push it please instead of
> me. If you don't like it, don't hold back and tell me.
> 
> Best regards, Michal Minar
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=913203
>> 
>>> Index: i2c-tools-3.1.0/tools/i2cbusses.c 
>>> ===================================================================
>>>
>>> 
- --- i2c-tools-3.1.0.orig/tools/i2cbusses.c
>>> +++ i2c-tools-3.1.0/tools/i2cbusses.c @@ -37,9 +37,15 @@ 
>>> #include <dirent.h> #include <fcntl.h> #include <errno.h> 
>>> +#ifdef USE_LIBKMOD +     #include <libkmod.h> +#endif #include
>>> "i2cbusses.h" #include <linux/i2c-dev.h>
>>> 
>>> +#define BUFLEN 512 +#define I2C_DEV_MOD_NAME "i2c_dev" + enum
>>> adt { adt_dummy, adt_isa, adt_i2c, adt_smbus, adt_unknown };
>>> 
>>> struct adap_type { @@ -60,6 +66,70 @@ static struct adap_type
>>> adap_types[5] = .algo         = "N/A", }, };
>>> 
>>> +/** + * Try to load i2c_dev kernel mode. Do nothing, if module
>>> is already
>> loaded.
>>> + * Returns 1 on success, 0 otherwise. + */ +static int
>>> try_load_i2c_dev_mod(void) { +     int err = 0, loaded = 0; +
>>> char errbuf[BUFLEN] = { 0 }; +#ifdef USE_LIBKMOD +     int
>>> flags = 0; +     struct kmod_ctx *ctx; +     struct kmod_list
>>> *l, *list = NULL; + +     ctx = kmod_new(NULL, NULL); +     if
>>> (!ctx) { +             snprintf(errbuf, BUFLEN, "kmod_new()
>>> failed!"); +             goto done; +     } +     if
>>> (kmod_module_new_from_lookup(ctx, I2C_DEV_MOD_NAME, &list) < 0
>> || list == NULL) {
>>> +             snprintf(errbuf, BUFLEN, I2C_DEV_MOD_NAME "
>>> module lookup
>> failed");
>>> +             goto ctx_unref; +     } + +     flags |=
>>> KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY; +
>>> kmod_list_foreach(l, list) { +             struct kmod_module
>>> *mod = kmod_module_get_module(l); +             err =
>>> kmod_module_probe_insert_module(mod, flags, NULL,
>> NULL, NULL, NULL);
>>> +             if (err == -ENOENT) { +
>>> snprintf(errbuf, BUFLEN, +
>>> "unknown symbol in module \"%s\",
>> or unknown parameter (see dmesg)",
>>> +
>>> kmod_module_get_name(mod)); +             } else if (err < 0)
>>> { +                     snprintf(errbuf, BUFLEN, "(module %s):
>>> %s", +
>>> kmod_module_get_name(mod),
>> strerror(-err));
>>> +             } else { +
>>> kmod_module_unref(mod); +                     ++loaded; +
>>> break; +             } +             kmod_module_unref(mod); +
>>> } + +list_unref: +     kmod_module_unref_list(list); 
>>> +ctx_unref: +     kmod_unref(ctx); +#else +     err =
>>> system("modprobe " I2C_DEV_MOD_NAME); +     if (err < 0) { +
>>> snprintf(errbuf, BUFLEN, "failed to execute modprobe
>> command");
>>> +     } else if (err > 0) { +             snprintf(errbuf,
>>> BUFLEN, "modprobe command exited with
>> code %d",
>>> +                             WEXITSTATUS(err)); +     } else
>>> { +             ++loaded; +             goto done; +     } 
>>> +#endif +     if (errbuf[0]) +             fprintf(stderr,
>>> "Failed to load required " I2C_DEV_MOD_NAME +
>>> " kernel module: %s\n", errbuf); +done: +     return loaded; 
>>> +} + static enum adt i2c_get_funcs(int i2cbus) { unsigned long
>>> funcs; @@ -206,8 +276,12 @@ struct i2c_adap
>>> *gather_i2c_busses(void) i2c-dev and what we really care about
>>> are the i2c-dev numbers. Unfortunately the names are harder to
>>> get in i2c-dev */ strcat(sysfs, "/class/i2c-dev"); -
>>> if(!(dir = opendir(sysfs))) -             goto done; +
>>> if(!(dir = opendir(sysfs))) { +             if
>>> (!try_load_i2c_dev_mod()) +                     goto done; +
>>> if ((!(dir = opendir(sysfs)))) +                     goto
>>> done; +     } /* go through the busses */ while ((de =
>>> readdir(dir)) != NULL) { if (!strcmp(de->d_name, ".")) Index:
>>> i2c-tools-3.1.0/tools/Module.mk 
>>> ===================================================================
>>>
>>> 
- --- i2c-tools-3.1.0.orig/tools/Module.mk
>>> +++ i2c-tools-3.1.0/tools/Module.mk @@ -15,6 +15,11 @@
>>> TOOLS_CFLAGS       := -Wstrict-prototypes -Wsh
>>> 
>>> TOOLS_TARGETS        := i2cdetect i2cdump i2cset i2cget
>>> 
>>> +ifeq ($(shell pkg-config --exists libkmod && echo 1), 1) +
>>> TOOLS_CFLAGS  += $(shell pkg-config --cflags libkmod)
>>> -DUSE_LIBKMOD +    LDFLAGS += $(shell pkg-config --libs
>>> libkmod) +endif + # # Programs #
>> 
>> 
>> 
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTx4/fAAoJEPezUylxRFUDtDAIAKffFl7jF2CfBOuDLazAnks7
laBW63KrI+j7Qk1VAiIHzu9eu7B4bbPwJ8PC9d3yUKvRmFnVOu4VefZ/Xm2cQQyo
3dqzuMjZX2zlmM3gYpSBH0Ri+BJq2iEme/JfZm+IoaieQCxhNd0Dc6SxFiKfHUrK
G2pV0Nw5o/mmbXumXHOhmj5Hi1/7YM1uT9O0qNo6AtX0XDk+Jd4+6z0fAjkjG6i4
ozepg/8jrFLK208yLQoSbXcjg5G8L3ef72zibc6QRZJcoz4N/vA2SsQ3airMoOM0
CubyVrDuYZ3hbiayleu3Cs5nnH82jPUDMV18jtUYMvddAtoXCCZU/nuVg/H32MA=
=2aNn
-----END PGP SIGNATURE-----

--------------030508090307060608070103
Content-Type: text/x-patch;
 name="i2c-tools-3.1.0-load-i2c-dev-mod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-tools-3.1.0-load-i2c-dev-mod.patch"

Index: i2c-tools/tools/i2cbusses.c
===================================================================
--- i2c-tools.orig/tools/i2cbusses.c
+++ i2c-tools/tools/i2cbusses.c
@@ -38,10 +38,17 @@
 #include <dirent.h>
 #include <fcntl.h>
 #include <errno.h>
+#ifdef USE_LIBKMOD
+	#include <libkmod.h>
+#endif
 #include "i2cbusses.h"
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
+#define BUFLEN (NAME_MAX > 512 ? NAME_MAX : 512)
+#define I2C_DEV_MOD_NAME "i2c_dev"
+#define I2C_DEV_SUBPATH  "/class/i2c-dev"
+
 enum adt { adt_dummy, adt_isa, adt_i2c, adt_smbus, adt_unknown };
 
 struct adap_type {
@@ -62,6 +69,142 @@ static struct adap_type adap_types[5] =
 	  .algo		= "N/A", },
 };
 
+/* Get and cache sysfs mount point. */
+static const char *get_sysfs_mount_point(void) {
+	static const char *mp = NULL;
+
+	if (mp == NULL) {
+		char sysfs[NAME_MAX];
+		char fstype[NAME_MAX];
+		char line[BUFLEN];
+		FILE *f;
+
+		if ((f = fopen("/proc/mounts", "r")) == NULL) {
+			perror("failed to read /proc/mounts: ");
+			goto done;
+		}
+		while (fgets(line, BUFLEN, f)) {
+			sscanf(line, "%*[^ ] %[^ ] %[^ ] %*s\n", sysfs, fstype);
+			if (strcasecmp(fstype, "sysfs") == 0) {
+				mp = strdup(sysfs);
+				if (mp == NULL)
+					perror("strdup: ");
+				break;
+			}
+		}
+		fclose(f);
+	}
+done:
+	return mp;
+}
+
+/* Get an absolute path of i2c device directory. Free the result when not
+ * needed. */
+static char *get_i2c_dev_path(void) {
+	char *path = NULL;
+	int mplen, splen;
+	const char *mp = get_sysfs_mount_point();
+
+	if (mp != NULL) {
+		mplen = strlen(mp);
+		splen = strlen(I2C_DEV_SUBPATH);
+		path = malloc(mplen + splen + 1);
+		if (path == NULL) {
+			perror("malloc: ");
+		} else {
+			strncpy(path, mp, mplen);
+			strncpy(path + mplen, I2C_DEV_SUBPATH, splen);
+			path[mplen+splen] = '\0';
+		}
+	}
+	return path;
+}
+
+/**
+ * Try to load i2c_dev kernel mode. Do nothing if module is already loaded.
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
+	kmod_module_unref_list(list);
+ctx_unref:
+	kmod_unref(ctx);
+#else   /* Try to load the module with modprobe. */
+	struct stat st;
+	char *dev_path = get_i2c_dev_path();
+
+	/* First check whether the module is already loaded or built-in. */
+	if (dev_path == NULL)
+		goto done;
+	err = stat(dev_path, &st);
+	if (err < 0) {
+		if (errno != ENOENT) {
+			snprintf(errbuf, BUFLEN, "can not stat \"%s\": %s", dev_path,
+				   	strerror(errno));
+			goto err;
+		} else {
+			err = 0;
+		}
+	} else {
+		++loaded;
+		goto done;
+	}
+
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
+
+err:
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
@@ -134,8 +277,7 @@ struct i2c_adap *gather_i2c_busses(void)
 	struct dirent *de, *dde;
 	DIR *dir, *ddir;
 	FILE *f;
-	char fstype[NAME_MAX], sysfs[NAME_MAX], n[NAME_MAX];
-	int foundsysfs = 0;
+	char *sysfs = NULL, n[NAME_MAX];
 	int count=0;
 	struct i2c_adap *adapters;
 
@@ -187,29 +329,19 @@ struct i2c_adap *gather_i2c_busses(void)
 		goto done;
 	}
 
-	/* look in sysfs */
-	/* First figure out where sysfs was mounted */
-	if ((f = fopen("/proc/mounts", "r")) == NULL) {
+	sysfs = get_i2c_dev_path();
+	if (sysfs == NULL)
 		goto done;
-	}
-	while (fgets(n, NAME_MAX, f)) {
-		sscanf(n, "%*[^ ] %[^ ] %[^ ] %*s\n", sysfs, fstype);
-		if (strcasecmp(fstype, "sysfs") == 0) {
-			foundsysfs++;
-			break;
-		}
-	}
-	fclose(f);
-	if (! foundsysfs) {
-		goto done;
-	}
 
 	/* Bus numbers in i2c-adapter don't necessarily match those in
 	   i2c-dev and what we really care about are the i2c-dev numbers.
 	   Unfortunately the names are harder to get in i2c-dev */
-	strcat(sysfs, "/class/i2c-dev");
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
@@ -274,14 +406,15 @@ found:
 				/* We need more space */
 				adapters = more_adapters(adapters, count + 1);
 				if (!adapters)
-					return NULL;
+					goto done;
 			}
 
 			adapters[count].nr = i2cbus;
 			adapters[count].name = strdup(s);
 			if (adapters[count].name == NULL) {
 				free_adapters(adapters);
-				return NULL;
+				adapters = NULL;
+				goto done;
 			}
 			adapters[count].funcs = adap_types[type].funcs;
 			adapters[count].algo = adap_types[type].algo;
@@ -291,6 +424,7 @@ found:
 	closedir(dir);
 
 done:
+	free(sysfs);
 	return adapters;
 }
 
Index: i2c-tools/tools/Module.mk
===================================================================
--- i2c-tools.orig/tools/Module.mk
+++ i2c-tools/tools/Module.mk
@@ -16,6 +16,11 @@ TOOLS_LDFLAGS	:= -Llib -li2c
 
 TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
 
+ifeq ($(shell pkg-config --exists libkmod && echo 1), 1)
+    TOOLS_CFLAGS  += $(shell pkg-config --cflags libkmod) -DUSE_LIBKMOD
+    LDFLAGS += $(shell pkg-config --libs libkmod)
+endif
+
 #
 # Programs
 #

--------------030508090307060608070103
Content-Type: application/pgp-signature;
 name="i2c-tools-3.1.0-load-i2c-dev-mod.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="i2c-tools-3.1.0-load-i2c-dev-mod.patch.sig"

iQEcBAABAgAGBQJTx4/fAAoJEPezUylxRFUDL9wIAL1k3AP7fRGAVQUbY2vjU/lZAttIzWg5
+u7GAA0JKG5Wg46omfeiFHBpT+cFh1lEDRf3ElD16RUUvJZu9stxtDh2+IOZZ7b7WY6X+/Q7
Oc1yzMR/aimysRTTLAl2XEigWCbv6FtBirFGNVdat0FwzfPLmJ4sd6r90GbkCfDMZkoAZjyK
UBkSuEE2zo9ZkJGKThs64phTpPtiEC0unv+drEIEPDVCaERbtFChh/Pp9GjpBwGh9KN3IPi2
vB8ThuE2gI+I3UY+pC8CHyzfBW3Q6NGvV49DEErEmd/o2ZbtEPWN9YVEmZGKAaIG6CGGHdYV
Ad7eJ6+Kzch5OC0jFaAinSI=
--------------030508090307060608070103--
