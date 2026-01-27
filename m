Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373642D6E55
	for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505964; cv=none; b=aQxhtO/JeoAvzbgWucFpqTdJ0MO11guV3N+sjH8aI5ZIDxkdijb4lFA4BpLga9EkcYcDe55C7LhofYdNvS7CiVKF2zR1iwYVzvrAf30RVM/NAWxHRo+HiUWXOTN2o+EkxefNEF+Gw5o2Iwk8k1lcBwWag/ghoo2rw1ZpX1a2FQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505964; c=relaxed/simple;
	bh=pkAH9sZLqQgxEtbfYDwO1eAuCAW3IVC4KBCXcqpGRe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/9ArPGRMyjZhJBVBYg1+vhVv36P5Z52S3NDiCHOede2Rtit3rhXNN5cciPsAgMZgGB5wm4ACjjoGBEm6e763S6E4XGxuhj+WNR6c/dq70yCg4GsM1NFz5OXvmSgrr0zUM6FG58M7jgxUvLeOF5goEo889j3USwojdXJFwxHyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DWPcRq/F; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DWPcRq/F"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A96F41A2A6C;
	Tue, 27 Jan 2026 09:26:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F2BB606F5;
	Tue, 27 Jan 2026 09:26:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8571C119A8683;
	Tue, 27 Jan 2026 10:26:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769505961; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zPB1Ge6vulCmfr4sqT06S6djlJ24muffY5hjqSMtGrA=;
	b=DWPcRq/FZ/Rl48j2ecKgXXttdk1SfYM5SuHFflM+J4k4gf1SRfq02zpbkC1dMwP0HKs2aj
	Yp+wX6nVWJON4MV7mMNlzt82JEeBoSy0tMfBUZn64S2hLLMhO23j6NrAsP75kK6b9Vcwkr
	lNvnePvgr3xqp/cBj7t9Be09msB5I+c8T5C6dfSJAAeNSjsrQxTSxiQmcB0M+Nhk1Dh6mN
	K8kycjyXEdqLaZcYbKmbNTkLn2ahMeUTmV8UyJ5kxahZWnA8K9Vkhzjk/LtNp/jtEdic3J
	RYF4OnzMFEIXx9zQXir12Kd4v4VtbD6oatH+1/mR0bw0kiEhVbE63qN9lVhqGQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Tue, 27 Jan 2026 10:25:58 +0100
Subject: [PATCH i2c-tools v3 2/2] i2ctransfer: Add optional message
 modifier flags
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-msg-flags-v3-2-e7539945db2b@bootlin.com>
References: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
In-Reply-To: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Allow setting protocol mangling and repeated start elision flags of an i2c
message with a set of optional command-line flags. These optional flags
are parsed at the beginning of the DESC field up to a read or write flag.

For example, to read one byte from address 0x50 followed by a stop, then
write two bytes at 0x54 on bus 0, one would call i2ctransfer as follow:

    i2ctransfer 0 pr1@0x50 w2@0x54 0x10 0x20

Since the new flags are optional, this patch preserves the compatibility
of the i2ctransfer syntax.

Handling of the message flags is done in add_flag_if_supported(). This
function checks if the flag is defined at compile time and if the adapter
supports the required functionality to handle the flag.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 tools/i2ctransfer.8 |  28 ++++++++++++-
 tools/i2ctransfer.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index 4bdf436..ca41241 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -96,8 +96,11 @@ The number of blocks is limited by the Linux Kernel and defined by I2C_RDWR_IOCT
 .I desc
 blocks are composed like this:
 
-.I {r|w}<length_of_message>[@address]
+.I [inpst]{r|w}<length_of_message>[@address]
 
+.TP
+.B [inpst]
+If supported, specifies optional MESSAGE MODIFIER FLAGS. See the section below for details.
 .TP
 .B {r|w}
 specifies if the message is read or write
@@ -141,6 +144,29 @@ decrease value by 1 until end of message (i.e. 0xff- means 0xff, 0xfe, 0xfd, ...
 p
 use value as seed for an 8 bit pseudo random sequence (i.e. 0p means 0x00, 0x50, 0xb0, ...)
 
+.SH "MESSAGE MODIFIER FLAGS"
+.PP
+These optional flags can be used to change the handling of a message when it is sent on the bus.
+They allow you to deviate from the I2C standard to work around device issues.
+They should be used with care, as they can confuse your I2C bus.
+Note that not all flags (or any) may be supported by your particular hardware and your kernel version.
+
+.TP
+.B i
+ignore NACK from client, treat them as ACK.
+.TP
+.B n
+in a read message, master ACK/NACK bit is skipped.
+.TP
+.B p
+emit a STOP after the message.
+.TP
+.B s
+skip repeated start.
+.TP
+.B t
+toggle read/write bit.
+
 .SH EXAMPLES
 .PP
 On bus 0, from an EEPROM at address 0x50, read 8 byte from offset 0x64
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index 4db98e3..446a174 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -52,9 +52,16 @@ static void help(void)
 		"           -V version info\n"
 		"           -y yes to all confirmations\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
-		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
-		"    1) read/write-flag 2) LENGTH (range 0-65535, or '?')\n"
-		"    3) I2C address (use last one if omitted)\n"
+		"  DESC describes the transfer in the form: [inpst]{r|w}LENGTH[@address]\n"
+		"    1) optional message modifier flags, if supported\n"
+		"       i: ignore NACK from client\n"
+		"       n: no master ACK/NACK bit in a read message\n"
+		"       p: emit a STOP after the message\n"
+		"       s: skip repeated start\n"
+		"       t: toggle read/write bit\n"
+		"    2) mandatory read/write flag\n"
+		"    3) LENGTH (range 0-65535, or '?')\n"
+		"    4) I2C address (use last one if omitted)\n"
 		"  DATA are LENGTH bytes for a write message. They can be shortened by a suffix:\n"
 		"    = (keep value constant until LENGTH)\n"
 		"    + (increase value by 1 until LENGTH)\n"
@@ -66,17 +73,20 @@ static void help(void)
 		"  # i2ctransfer 0 w17@0x50 0x42 0xff-\n");
 }
 
-static int check_funcs(int file)
+static int get_funcs(int file, unsigned long *funcs)
 {
-	unsigned long funcs;
-
 	/* check adapter functionality */
-	if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
+	if (ioctl(file, I2C_FUNCS, funcs) < 0) {
 		fprintf(stderr, "Error: Could not get the adapter "
 			"functionality matrix: %s\n", strerror(errno));
 		return -1;
 	}
 
+	return 0;
+}
+
+static int check_funcs(unsigned long funcs)
+{
 	if (!(funcs & I2C_FUNC_I2C)) {
 		fprintf(stderr, MISSING_FUNC_FMT, "I2C transfers");
 		return -1;
@@ -140,6 +150,85 @@ static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
 	return 1;
 }
 
+/*
+ * Parse one message flag and check if the adapter supports it.
+ * Return:
+ * 1 if we have the direction of the message (read or write)
+ * 0 if the argument is a valid and supported optional flag
+ * -1 for unsupported flag
+ */
+static int add_flag_if_supported(__u16 *flags, unsigned long funcs, char arg)
+{
+	int mangling = 0, nostart = 0;
+
+	/* Get the message flag from the argument */
+	switch (arg) {
+		/* mandatory direction flag: ends the parsing of flags */
+		case 'r':
+			*flags |= I2C_M_RD;
+			return 1;
+		case 'w':
+			return 1;
+
+		/* optional flags */
+#ifdef I2C_M_IGNORE_NAK
+		case 'i':
+			*flags |= I2C_M_IGNORE_NAK;
+			mangling = 1;
+			break;
+#endif
+#ifdef I2C_M_NO_RD_ACK
+		case 'n':
+			*flags |= I2C_M_NO_RD_ACK;
+			mangling = 1;
+			break;
+#endif
+#ifdef I2C_M_STOP
+		case 'p':
+			*flags |= I2C_M_STOP;
+			mangling = 1;
+			break;
+#endif
+#ifdef I2C_M_NOSTART
+		case 's':
+			*flags |= I2C_M_NOSTART;
+			nostart = 1;
+			break;
+#endif
+#ifdef I2C_M_REV_DIR_ADDR
+		case 't':
+			*flags |= I2C_M_REV_DIR_ADDR;
+			mangling = 1;
+			break;
+#endif
+
+		default:
+			fprintf(stderr, "Error: Unsupported flag '%c'\n", arg);
+			return -1;
+	}
+
+	/* Check that the adapter supports the requested flags */
+#ifdef I2C_FUNC_PROTOCOL_MANGLING
+	if (funcs & I2C_FUNC_PROTOCOL_MANGLING)
+		mangling = 0;
+#endif
+	if (mangling) {
+		fprintf(stderr, MISSING_FUNC_FMT, "protocol mangling");
+		return -1;
+	}
+
+#ifdef I2C_FUNC_NOSTART
+	if (funcs & I2C_FUNC_NOSTART)
+		nostart = 0;
+#endif
+	if (nostart) {
+		fprintf(stderr, MISSING_FUNC_FMT, "repeated start skipping");
+		return -1;
+	}
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	char filename[20];
@@ -148,6 +237,7 @@ int main(int argc, char *argv[])
 	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
 	enum parse_state state = PARSE_GET_DESC;
 	unsigned int buf_idx = 0;
+	unsigned long funcs;
 
 	memset(msgs, 0, sizeof(msgs));
 
@@ -182,7 +272,7 @@ int main(int argc, char *argv[])
 		exit(1);
 
 	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
-	if (file < 0 || check_funcs(file))
+	if (file < 0 || get_funcs(file, &funcs) || check_funcs(funcs))
 		exit(1);
 
 	while (optind < argc) {
@@ -191,6 +281,7 @@ int main(int argc, char *argv[])
 		__u16 flags;
 		__u8 data, *buf;
 		char *end;
+		int ret;
 
 		if (nmsgs == I2C_RDRW_IOCTL_MAX_MSGS) {
 			fprintf(stderr, "Error: Too many messages (max: %d)\n",
@@ -202,11 +293,13 @@ int main(int argc, char *argv[])
 		case PARSE_GET_DESC:
 			flags = 0;
 
-			switch (*arg_ptr++) {
-			case 'r': flags |= I2C_M_RD; break;
-			case 'w': break;
-			default:
-				fprintf(stderr, "Error: Invalid direction\n");
+			for (ret = 0; *arg_ptr && !ret; arg_ptr++) {
+				ret = add_flag_if_supported(&flags, funcs, *arg_ptr);
+				if (ret < 0)
+					goto err_out_with_arg;
+			}
+			if (ret != 1) {
+				fprintf(stderr, "Error: Missing direction flag 'r' or 'w'\n");
 				goto err_out_with_arg;
 			}
 

-- 
2.52.0

