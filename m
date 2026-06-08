Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5873F8EAE
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932124; cv=none; b=RT5uZ0/vtIaOjIIj3yvo6tUcc+AlPs82KCFMsHIv59ChvyDYoCoh8kkdJ64pZiPBi8uyr9MxQh6O/uN68BetkwaW2jZZHpeBvzxLkzqaJrW/9BiwdUhetMiAlx0oDzgCIcbbVEYeXoQiaPPdYBX8BFZPYjn6Ckz/RFPBX3AxDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932124; c=relaxed/simple;
	bh=AS4FycdNyjEkkYhd94b2YgReOwbVZ7wVxU2yY+tX49o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RHjgzI5Y4KtVPo+xh3m3KojkDAi9xvLrdeTuRN6X11fUbjUeG5hKMhDgkfarxeut0AvAtGHBMrMmHC5Ze4CICKwiR/fJzRHPJtACOmLxPjwBfmAxr+/VVtzHcg3y2zPK8vNx27n2OMOG95DOyhsiNDsA1i5SKzqafXhNTuzGa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XLuVCEdX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XLuVCEdX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 600484E41672
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 15:22:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 27B755FFB7;
	Mon,  8 Jun 2026 15:22:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB95E106A2879;
	Mon,  8 Jun 2026 17:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780932119; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=d2nAvt++/P2Asigedu62Nq7DsRo+p95RzDL7X00kE/g=;
	b=XLuVCEdXO1sWSBWazrFla7MBTINUuDvQlDg6bOoDZ8dKBYCJz+ZU3aPUM98ANEfZ2q/0c6
	1onEoOGYF4wyhsVurs9vdEkMK6KfTmxEK75apfoBQvprXoCoRSj6IQzbOuosUpXuZbsLHU
	3Z/pDLNArFqUAf2gv+iryht1rkQLJrt+GVxA960OaWE5CQeuw6HAJC/inMANXLnEKfU7fS
	YcPa9Gu9g67fx+FE+Nm6lZRUXpaxZ/cM4cgYDUWJUdLWDfcWXo7N6J9eN3tIp3UKjN6pzs
	ZDVuKOk7zHg+IbSSTGqd1N8MBy+Z/yhCJ9VSvQVN4XKydcX7ZhqNALF17JxUAw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 08 Jun 2026 17:21:45 +0200
Subject: [PATCH i2c-tools v4] i2ctransfer: Add optional message modifier
 flags
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-msg-flags-v4-1-68ad6f0a4e4d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAjeJmoC/2WPQQqDMBBFryJZN0VnTNSueo/SRWKiBtSUREKLe
 PeG0FKly8//7w2zEq+d0Z5cspU4HYw3do6hPGWkHcTca2pUzARyYEUBFZ18T7tR9J6iAglKNEJ
 DTeL+4XRnnsl1IwZaulg7enKP1WD8Yt0rXQlFGnyE9U4YCppTjgw74J3gsr1Ka5fRzOfWTskT4
 McC4J6FyNaqwVKUyLmGfxa/LM+PjwSMrK4YNk3JlAR5ZLdtewMYNjO3JwEAAA==
X-Change-ID: 20251127-msg-flags-3d2b2da9ae28
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
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
supports the required functionality to handle the flag at runtime.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
I2C messages can be modified with a set of flags covered by the protocol
mangling and the skip repeated start functionalities.

The patch adds the parsing of optional flags to i2ctransfer message
description. Those command-line flags then set the i2c message flags
alongside the read/write flag.

I wrote these changes to test the insertion of I2C_M_STOP flag in
multi-message transactions with i2ctransfer, but the other flags may be
useful for various test scenarios. 
---
Changes in v4:
- Rebase on current upstream and drop first patch that has been merged.
- Return an enum from add_flag_if_supported(), to distinguish between the various possible cases.
- Link to v3: https://lore.kernel.org/r/20260127-msg-flags-v3-0-e7539945db2b@bootlin.com

Changes in v3:
- Use ifdefs to check that the flags and functionalities are known
  at compile-time.
- Check that the adapter supports the requested flags before using them
  in i2ctransfer.
- Add a warning in i2ctransfer man page about the risk of using these
  flags.
- Link to v2: https://lore.kernel.org/r/20251223-msg-flags-v2-0-8d934a4366e2@bootlin.com

Changes in v2:
- Document the flags in i2ctransfer.8 man page.
- Link to v1: https://lore.kernel.org/r/20251128-msg-flags-v1-0-6353f26fa6bc@bootlin.com
---
 tools/i2ctransfer.8 |  28 +++++++++-
 tools/i2ctransfer.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 159 insertions(+), 14 deletions(-)

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
index 4db98e3..003c70b 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -34,6 +34,14 @@ enum parse_state {
 	PARSE_GET_DATA,
 };
 
+enum supported_flags_retval {
+	FLAGS_GOT_RW,
+	FLAGS_GOT_OPTIONAL,
+	FLAGS_UNEXPECTED,
+	FLAGS_UNKNOWN,
+	FLAGS_UNSUPPORTED,
+};
+
 #define PRINT_STDERR	(1 << 0)
 #define PRINT_READ_BUF	(1 << 1)
 #define PRINT_WRITE_BUF	(1 << 2)
@@ -52,9 +60,16 @@ static void help(void)
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
@@ -66,17 +81,20 @@ static void help(void)
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
@@ -140,6 +158,104 @@ static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
 	return 1;
 }
 
+/*
+ * Parse one message flag and check if the adapter supports it.
+ * Return:
+ * FLAGS_GOT_RW if we have the direction of the message (read or write)
+ * FLAGS_GOT_OPTIONAL if the argument is a valid and supported optional flag
+ * FLAGS_UNEXPECTED if the argument is the beginning of the size or address
+ * FLAGS_UNKNOWN for unknown flag
+ * FLAGS_UNSUPPORTED for flag unsupported by the adapter
+ */
+static enum supported_flags_retval
+	add_flag_if_supported(__u16 *flags, unsigned long funcs, char arg)
+{
+	int mangling = 0, nostart = 0;
+
+	/* Get the message flag from the argument */
+	switch (arg) {
+	/* mandatory direction flag: ends the parsing of flags */
+	case 'r':
+		*flags |= I2C_M_RD;
+		return FLAGS_GOT_RW;
+	case 'w':
+		return FLAGS_GOT_RW;
+
+	/* optional flags */
+#ifdef I2C_M_IGNORE_NAK
+	case 'i':
+		*flags |= I2C_M_IGNORE_NAK;
+		mangling = 1;
+		break;
+#endif
+#ifdef I2C_M_NO_RD_ACK
+	case 'n':
+		*flags |= I2C_M_NO_RD_ACK;
+		mangling = 1;
+		break;
+#endif
+#ifdef I2C_M_STOP
+	case 'p':
+		*flags |= I2C_M_STOP;
+		mangling = 1;
+		break;
+#endif
+#ifdef I2C_M_NOSTART
+	case 's':
+		*flags |= I2C_M_NOSTART;
+		nostart = 1;
+		break;
+#endif
+#ifdef I2C_M_REV_DIR_ADDR
+	case 't':
+		*flags |= I2C_M_REV_DIR_ADDR;
+		mangling = 1;
+		break;
+#endif
+
+	/* unexpected next part of the message: length or address */
+	case '0':
+	case '1':
+	case '2':
+	case '3':
+	case '4':
+	case '5':
+	case '6':
+	case '7':
+	case '8':
+	case '9':
+	case '?':
+	case '@':
+		fprintf(stderr, "Error: Unexpected flag '%c'\n", arg);
+		return FLAGS_UNEXPECTED;
+
+	default:
+		fprintf(stderr, "Error: Unknown flag '%c'\n", arg);
+		return FLAGS_UNKNOWN;
+	}
+
+	/* Check that the adapter supports the requested flags */
+#ifdef I2C_FUNC_PROTOCOL_MANGLING
+	if (funcs & I2C_FUNC_PROTOCOL_MANGLING)
+		mangling = 0;
+#endif
+	if (mangling) {
+		fprintf(stderr, MISSING_FUNC_FMT, "protocol mangling");
+		return FLAGS_UNSUPPORTED;
+	}
+
+#ifdef I2C_FUNC_NOSTART
+	if (funcs & I2C_FUNC_NOSTART)
+		nostart = 0;
+#endif
+	if (nostart) {
+		fprintf(stderr, MISSING_FUNC_FMT, "repeated start skipping");
+		return FLAGS_UNSUPPORTED;
+	}
+
+	return FLAGS_GOT_OPTIONAL;
+}
+
 int main(int argc, char *argv[])
 {
 	char filename[20];
@@ -148,6 +264,7 @@ int main(int argc, char *argv[])
 	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
 	enum parse_state state = PARSE_GET_DESC;
 	unsigned int buf_idx = 0;
+	unsigned long funcs;
 
 	memset(msgs, 0, sizeof(msgs));
 
@@ -182,7 +299,7 @@ int main(int argc, char *argv[])
 		exit(1);
 
 	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
-	if (file < 0 || check_funcs(file))
+	if (file < 0 || get_funcs(file, &funcs) || check_funcs(funcs))
 		exit(1);
 
 	while (optind < argc) {
@@ -191,6 +308,7 @@ int main(int argc, char *argv[])
 		__u16 flags;
 		__u8 data, *buf;
 		char *end;
+		int ret;
 
 		if (nmsgs == I2C_RDRW_IOCTL_MAX_MSGS) {
 			fprintf(stderr, "Error: Too many messages (max: %d)\n",
@@ -202,11 +320,12 @@ int main(int argc, char *argv[])
 		case PARSE_GET_DESC:
 			flags = 0;
 
-			switch (*arg_ptr++) {
-			case 'r': flags |= I2C_M_RD; break;
-			case 'w': break;
-			default:
-				fprintf(stderr, "Error: Invalid direction\n");
+			for (ret = FLAGS_GOT_OPTIONAL; *arg_ptr && ret == FLAGS_GOT_OPTIONAL; arg_ptr++)
+				ret = add_flag_if_supported(&flags, funcs, *arg_ptr);
+			if (ret == FLAGS_UNKNOWN || ret == FLAGS_UNEXPECTED || ret == FLAGS_UNSUPPORTED)
+				goto err_out_with_arg;
+			if (ret != FLAGS_GOT_RW) {
+				fprintf(stderr, "Error: Missing direction flag 'r' or 'w'\n");
 				goto err_out_with_arg;
 			}
 

---
base-commit: ec1267371e378fc6aaf1cd7686b5b9b31293255a
change-id: 20251127-msg-flags-3d2b2da9ae28

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

