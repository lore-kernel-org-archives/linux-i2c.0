From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3] Split print_i2c_busses into a gathering part and
 a printing part
Date: Sat, 12 Apr 2008 14:35:26 +0200
Message-ID: <20080412143526.26651e31@hyperion.delvare>
References: <20080412135841.1983d15c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080412135841.1983d15c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Split print_i2c_busses into a gathering part and a printing part.

---
 tools/i2cbusses.c |  172 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 147 insertions(+), 25 deletions(-)

--- i2c-tools.orig/tools/i2cbusses.c	2008-04-12 13:31:43.000000000 +0200
+++ i2c-tools/tools/i2cbusses.c	2008-04-12 13:41:19.000000000 +0200
@@ -4,6 +4,7 @@
                devices.
     Copyright (c) 1999-2003  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
                              Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
+    Copyright (C) 2008       Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -54,6 +55,13 @@ static struct adap_type adap_types[5] = 
 	  .algo		= "N/A", },
 };
 
+struct i2c_adap {
+	int nr;
+	char *name;
+	const char *funcs;
+	const char *algo;
+};
+
 static enum adt i2c_get_funcs(int i2cbus)
 {
 	unsigned long funcs;
@@ -80,14 +88,47 @@ static enum adt i2c_get_funcs(int i2cbus
 	return ret;
 }
 
-/*
-   this just prints out the installed i2c busses in a consistent format, whether
-   on a 2.4 kernel using /proc or a 2.6 kernel using /sys.
-   If procfmt == 1, print out exactly /proc/bus/i2c format on stdout.
-   This allows this to be used in a program to emulate /proc/bus/i2c on a
-   sysfs system.
-*/
-void print_i2c_busses(int procfmt)
+/* Remove trailing spaces from a string
+   Return the new string length including the trailing NUL */
+static int rtrim(char *s)
+{
+	int i;
+
+	for (i = strlen(s) - 1; i >= 0 && (s[i] == ' ' || s[i] == '\n'); i--)
+		s[i] = '\0';
+	return i + 2;
+}
+
+static void free_adapters(struct i2c_adap *adapters)
+{
+	int i;
+
+	for (i = 0; adapters[i].name; i++)
+		free(adapters[i].name);
+	free(adapters);
+}
+
+/* We allocate space for the adapters in bunches. The last item is a
+   terminator, so here we start with room for 7 adapters, which should
+   be enough in most cases. If not, we allocate more later as needed. */
+#define BUNCH	8
+
+/* n must match the size of adapters at calling time */
+static struct i2c_adap *more_adapters(struct i2c_adap *adapters, int n)
+{
+	struct i2c_adap *new_adapters;
+
+	new_adapters = realloc(adapters, (n + BUNCH) * sizeof(struct i2c_adap));
+	if (!new_adapters) {
+		free_adapters(adapters);
+		return NULL;
+	}
+	memset(new_adapters + n, 0, BUNCH * sizeof(struct i2c_adap));
+
+	return new_adapters;
+}
+
+static struct i2c_adap *gather_i2c_busses(void)
 {
 	FILE *fptr;
 	char s[100];
@@ -98,17 +139,51 @@ void print_i2c_busses(int procfmt)
 	char dev[NAME_MAX], fstype[NAME_MAX], sysfs[NAME_MAX], n[NAME_MAX];
 	int foundsysfs = 0;
 	int count=0;
+	struct i2c_adap *adapters;
 
+	adapters = calloc(BUNCH, sizeof(struct i2c_adap));
+	if (!adapters)
+		return NULL;
 
 	/* look in /proc/bus/i2c */
 	if((fptr = fopen("/proc/bus/i2c", "r"))) {
 		while(fgets(s, 100, fptr)) {
-			if(count++ == 0 && !procfmt)
-				fprintf(stderr,"  Installed I2C busses:\n");
-			if(procfmt)
-				printf("%s", s);	
-			else
-				fprintf(stderr, "    %s", s);	
+			char *algo, *name, *type, *all;
+			int len_algo, len_name, len_type;
+			int i2cbus;
+
+			algo = strrchr(s, '\t');
+			*(algo++) = '\0';
+			len_algo = rtrim(algo);
+
+			name = strrchr(s, '\t');
+			*(name++) = '\0';
+			len_name = rtrim(name);
+
+			type = strrchr(s, '\t');
+			*(type++) = '\0';
+			len_type = rtrim(type);
+
+			sscanf(s, "i2c-%d", &i2cbus);
+
+			if ((count + 1) % BUNCH == 0) {
+				/* We need more space */
+				adapters = more_adapters(adapters, count + 1);
+				if (!adapters)
+					return NULL;
+			}
+
+			all = malloc(len_name + len_type + len_algo);
+			if (all == NULL) {
+				free_adapters(adapters);
+				return NULL;
+			}
+			adapters[count].nr = i2cbus;
+			adapters[count].name = strcpy(all, name);
+			adapters[count].funcs = strcpy(all + len_name, type);
+			adapters[count].algo = strcpy(all + len_name + len_type,
+						      algo);
+			count++;
 		}
 		fclose(fptr);
 		goto done;
@@ -189,33 +264,80 @@ found:
 			}
 			if ((border = strchr(x, '\n')) != NULL)
 				*border = 0;
-			if(count++ == 0 && !procfmt)
-				fprintf(stderr,"  Installed I2C busses:\n");
-			/* match 2.4 /proc/bus/i2c format as closely as possible */
+			if (!sscanf(de->d_name, "i2c-%d", &i2cbus))
+				continue;
 			if(!strncmp(x, "ISA ", 4)) {
 				type = adt_isa;
-			} else if(!sscanf(de->d_name, "i2c-%d", &i2cbus)) {
-				type = adt_dummy;
 			} else {
 				/* Attempt to probe for adapter capabilities */
 				type = i2c_get_funcs(i2cbus);
 			}
 
-			if (procfmt)
-				printf("%s\t%-10s\t%-32s\t%s\n", de->d_name,
-					adap_types[type].funcs, x, adap_types[type].algo);
-			else
-				fprintf(stderr, "    %s\t%-10s\t%s\n", de->d_name,
-					adap_types[type].funcs, x);
+			if ((count + 1) % BUNCH == 0) {
+				/* We need more space */
+				adapters = more_adapters(adapters, count + 1);
+				if (!adapters)
+					return NULL;
+			}
+
+			adapters[count].nr = i2cbus;
+			adapters[count].name = strdup(x);
+			if (adapters[count].name == NULL) {
+				free_adapters(adapters);
+				return NULL;
+			}
+			adapters[count].funcs = adap_types[type].funcs;
+			adapters[count].algo = adap_types[type].algo;
+			count++;
 		}
 	}
 	closedir(dir);
 
 done:
+	return adapters;
+}
+
+/*
+   this just prints out the installed i2c busses in a consistent format, whether
+   on a 2.4 kernel using /proc or a 2.6 kernel using /sys.
+   If procfmt == 1, print out exactly /proc/bus/i2c format on stdout.
+   This allows this to be used in a program to emulate /proc/bus/i2c on a
+   sysfs system.
+*/
+void print_i2c_busses(int procfmt)
+{
+	struct i2c_adap *adapters;
+	int count;
+
+	adapters = gather_i2c_busses();
+	if (adapters == NULL) {
+		fprintf(stderr, "Error: Out of memory!\n");
+		return;
+	}
+
+	for (count = 0; adapters[count].name; count++) {
+		if (count == 0 && !procfmt)
+			fprintf(stderr,"  Installed I2C busses:\n");
+		if (procfmt)
+			/* match 2.4 /proc/bus/i2c format as closely as possible */
+			printf("i2c-%d\t%-10s\t%-32s\t%s\n",
+				adapters[count].nr,
+				adapters[count].funcs,
+				adapters[count].name,
+				adapters[count].algo);
+		else
+			fprintf(stderr, "    i2c-%d\t%-10s\t%s\n",
+				adapters[count].nr,
+				adapters[count].funcs,
+				adapters[count].name);
+	}
+
 	if(count == 0 && !procfmt)
 		fprintf(stderr,"Error: No I2C busses found!\n"
 		               "Be sure you have done 'modprobe i2c-dev'\n"
 		               "and also modprobed your i2c bus drivers\n");
+
+	free_adapters(adapters);
 }
 
 /*

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
