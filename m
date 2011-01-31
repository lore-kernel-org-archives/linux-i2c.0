From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: i2ctools/i2cset: Remove obsolete means to specify value mask
Date: Mon, 31 Jan 2011 08:19:45 -0800
Message-ID: <20110131161945.GA4197@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Attached patch removes the obsolete means to specify the value mask from i2cset.
It also streamlines and improves parameter validation.

--
Index: tools/i2cset.c
===================================================================
--- tools/i2cset.c	(revision 5911)
+++ tools/i2cset.c	(working copy)
@@ -156,7 +156,7 @@
 	char *end;
 	const char *maskp = NULL;
 	int res, i2cbus, address, size, file;
-	int value, daddress, vmask = 0;
+	int value = -1, daddress, vmask = 0;
 	char filename[20];
 	int pec = 0;
 	int flags = 0;
@@ -207,74 +207,78 @@
 		help();
 	}
 
-	/* check for block data */
 	len = 0;
-	if (argc > flags + 5) {
+	if (argc == flags + 4) {
+		/* Implicit "c" */
+		size = I2C_SMBUS_BYTE;
+	} else if (argc == flags + 5) {
+		/* "c", "cp",  or implicit "b" */
+		if (!strcmp(argv[flags+4], "c")
+		 || !strcmp(argv[flags+4], "cp")) {
+			size = I2C_SMBUS_BYTE;
+			pec = argv[flags+4][1] == 'p';
+		} else {
+			size = I2C_SMBUS_BYTE_DATA;
+		}
+	} else {
+		/* All other commands */
+		if (strlen(argv[argc-1]) > 2
+		    || (strlen(argv[argc-1]) == 2 && argv[argc-1][1] != 'p')) {
+			fprintf(stderr, "Error: Invalid argument '%s'\n", argv[argc-1]);
+			help();
+		}
 		switch (argv[argc-1][0]) {
+		case 'b': size = I2C_SMBUS_BYTE_DATA; break;
+		case 'w': size = I2C_SMBUS_WORD_DATA; break;
 		case 's': size = I2C_SMBUS_BLOCK_DATA; break;
 		case 'i': size = I2C_SMBUS_I2C_BLOCK_DATA; break;
 		default:
-			size = 0;
-			break;
+			fprintf(stderr, "Error: Invalid argument '%s'\n", argv[argc-1]);
+			help();
 		}
+		pec = argv[argc-1][1] == 'p';
 		if (size == I2C_SMBUS_BLOCK_DATA || size == I2C_SMBUS_I2C_BLOCK_DATA) {
-			pec = argv[argc-1][1] == 'p';
 			if (pec && size == I2C_SMBUS_I2C_BLOCK_DATA) {
 				fprintf(stderr, "Error: PEC not supported for I2C block writes!\n");
 				help();
 			}
-			for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {
-				value = strtol(argv[flags + len + 4], &end, 0);
-				if (*end || value < 0 || value > 0xff) {
-                                	fprintf(stderr, "Error: Block data value invalid!\n");
-                                	help();
-                        	}
-				block[len] = value;
-			}
-			goto dofile;
-		}
-	}
-
-	if (argc > flags + 4) {
-		if (!strcmp(argv[flags+4], "c")
-		 || !strcmp(argv[flags+4], "cp")) {
-			size = I2C_SMBUS_BYTE;
-			value = -1;
-			pec = argv[flags+4][1] == 'p';
-		} else {
-			size = I2C_SMBUS_BYTE_DATA;
-			value = strtol(argv[flags+4], &end, 0);
-			if (*end || value < 0) {
-				fprintf(stderr, "Error: Data value invalid!\n");
+			if (maskp) {
+				fprintf(stderr, "Error: Mask not supported for block writes!\n");
 				help();
 			}
+		} else if (argc != flags + 6) {
+			fprintf(stderr, "Error: Bad number of arguments!\n");
+			help();
 		}
-	} else {
-		size = I2C_SMBUS_BYTE;
-		value = -1;
 	}
 
-	if (argc > flags + 5) {
-		switch (argv[flags+5][0]) {
-		case 'b': size = I2C_SMBUS_BYTE_DATA; break;
-		case 'w': size = I2C_SMBUS_WORD_DATA; break;
-		default:
-			fprintf(stderr, "Error: Invalid mode!\n");
+	switch(size) {
+	case I2C_SMBUS_BYTE_DATA:
+	case I2C_SMBUS_WORD_DATA:
+		value = strtol(argv[flags+4], &end, 0);
+		if (*end || value < 0) {
+			fprintf(stderr, "Error: Data value invalid!\n");
 			help();
 		}
-		pec = argv[flags+5][1] == 'p';
-	}
-
-	/* Old method to provide the value mask, deprecated and no longer
-	   documented but still supported for compatibility */
-	if (argc > flags + 6) {
-		if (maskp) {
-			fprintf(stderr, "Error: Data value mask provided twice!\n");
+		if ((size == I2C_SMBUS_BYTE_DATA && value > 0xff)
+	 	    || (size == I2C_SMBUS_WORD_DATA && value > 0xffff)) {
+			fprintf(stderr, "Error: Data value out of range!\n");
 			help();
 		}
-		fprintf(stderr, "Warning: Using deprecated way to set the data value mask!\n");
-		fprintf(stderr, "         Please switch to using -m.\n");
-		maskp = argv[flags+6];
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {
+			value = strtol(argv[flags + len + 4], &end, 0);
+			if (*end || value < 0 || value > 0xff) {
+                               	fprintf(stderr, "Error: Block data value invalid!\n");
+                               	help();
+                       	}
+			block[len] = value;
+		}
+		break;
+	default:
+		break;
 	}
 
 	if (maskp) {
@@ -285,13 +289,6 @@
 		}
 	}
 
-	if ((size == I2C_SMBUS_BYTE_DATA && value > 0xff)
-	 || (size == I2C_SMBUS_WORD_DATA && value > 0xffff)) {
-		fprintf(stderr, "Error: Data value out of range!\n");
-		help();
-	}
-
-dofile:
 	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
 	if (file < 0
 	 || check_funcs(file, size, pec)
Index: CHANGES
===================================================================
--- CHANGES	(revision 5911)
+++ CHANGES	(working copy)
@@ -4,6 +4,8 @@
 SVN
   i2c-dev.h: Make value arrays const for block write functions
   i2cset: Add support for SMBus and I2C block writes
+          Removed obsolete method to specify write mask
+          More stringent parameter validation
 
 3.0.3 (2010-12-12)
   Makefile: Let the environment set CC and CFLAGS
