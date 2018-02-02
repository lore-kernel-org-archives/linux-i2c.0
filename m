From: Romain Porte <romain.porte@nokia.com>
Subject: [PATCH v4 1/3] Add all_addrs option for i2c tools
Date: Fri, 2 Feb 2018 13:45:16 +0100
Message-ID: <20180202124518.2663-2-romain.porte@nokia.com>
References: <20180105150248.3170-1-romain.porte@nokia.com>
 <20180202124518.2663-1-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30123.outbound.protection.outlook.com ([40.107.3.123]:50336
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751740AbeBBMqn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Feb 2018 07:46:43 -0500
In-Reply-To: <20180202124518.2663-1-romain.porte@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: jdelvare@suse.de, peda@axentia.se, linux-i2c@vger.kernel.org, Romain Porte <romain.porte@nokia.com>

If the user is sure that the reserved 0x00 - 0x02 and 0x77 - 0x7f ranges are
not needed by its devices, then he can pass the "-a" option for allowing all
theorical addresses to be used. It is then possible to access devices in this
address range.

Signed-off-by: Romain Porte <romain.porte@nokia.com>
---
 tools/i2cbusses.c   | 14 +++++++++++---
 tools/i2cbusses.h   |  2 +-
 tools/i2cdump.c     |  5 +++--
 tools/i2cget.c      |  5 +++--
 tools/i2cset.c      |  5 +++--
 tools/i2ctransfer.c |  5 +++--
 6 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
index 41f5b6b..ad06332 100644
--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -377,19 +377,27 @@ int lookup_i2c_bus(const char *i2cbus_arg)
  * Parse a CHIP-ADDRESS command line argument and return the corresponding
  * chip address, or a negative value if the address is invalid.
  */
-int parse_i2c_address(const char *address_arg)
+int parse_i2c_address(const char *address_arg, int all_addrs)
 {
 	long address;
 	char *end;
+	long min_addr = 0x03;
+	long max_addr = 0x77;
 
 	address = strtol(address_arg, &end, 0);
 	if (*end || !*address_arg) {
 		fprintf(stderr, "Error: Chip address is not a number!\n");
 		return -1;
 	}
-	if (address < 0x03 || address > 0x77) {
+
+	if (all_addrs) {
+		min_addr = 0x00;
+		max_addr = 0x7f;
+	}
+
+	if (address < min_addr || address > max_addr) {
 		fprintf(stderr, "Error: Chip address out of range "
-			"(0x03-0x77)!\n");
+			"(0x%02lx-0x%02lx)!\n", min_addr, max_addr);
 		return -2;
 	}
 
diff --git a/tools/i2cbusses.h b/tools/i2cbusses.h
index 26143a5..a192c7f 100644
--- a/tools/i2cbusses.h
+++ b/tools/i2cbusses.h
@@ -35,7 +35,7 @@ struct i2c_adap *gather_i2c_busses(void);
 void free_adapters(struct i2c_adap *adapters);
 
 int lookup_i2c_bus(const char *i2cbus_arg);
-int parse_i2c_address(const char *address_arg);
+int parse_i2c_address(const char *address_arg, int all_addrs);
 int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet);
 int set_slave_addr(int file, int address, int force);
 
diff --git a/tools/i2cdump.c b/tools/i2cdump.c
index a7bba72..567ef03 100644
--- a/tools/i2cdump.c
+++ b/tools/i2cdump.c
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])
 	int block[256], s_length = 0;
 	int pec = 0, even = 0;
 	int flags = 0;
-	int force = 0, yes = 0, version = 0;
+	int force = 0, yes = 0, version = 0, all_addrs = 0;
 	const char *range = NULL;
 	int first = 0x00, last = 0xff;
 
@@ -130,6 +130,7 @@ int main(int argc, char *argv[])
 		case 'f': force = 1; break;
 		case 'r': range = argv[1+(++flags)]; break;
 		case 'y': yes = 1; break;
+		case 'a': all_addrs = 1; break;
 		default:
 			fprintf(stderr, "Error: Unsupported option "
 				"\"%s\"!\n", argv[1+flags]);
@@ -160,7 +161,7 @@ int main(int argc, char *argv[])
 		help();
 		exit(1);
 	}
-	address = parse_i2c_address(argv[flags+2]);
+	address = parse_i2c_address(argv[flags+2], all_addrs);
 	if (address < 0) {
 		help();
 		exit(1);
diff --git a/tools/i2cget.c b/tools/i2cget.c
index 2503942..34b4af1 100644
--- a/tools/i2cget.c
+++ b/tools/i2cget.c
@@ -158,7 +158,7 @@ int main(int argc, char *argv[])
 	char filename[20];
 	int pec = 0;
 	int flags = 0;
-	int force = 0, yes = 0, version = 0;
+	int force = 0, yes = 0, version = 0, all_addrs = 0;
 
 	/* handle (optional) flags first */
 	while (1+flags < argc && argv[1+flags][0] == '-') {
@@ -166,6 +166,7 @@ int main(int argc, char *argv[])
 		case 'V': version = 1; break;
 		case 'f': force = 1; break;
 		case 'y': yes = 1; break;
+		case 'a': all_addrs = 1; break;
 		default:
 			fprintf(stderr, "Error: Unsupported option "
 				"\"%s\"!\n", argv[1+flags]);
@@ -187,7 +188,7 @@ int main(int argc, char *argv[])
 	if (i2cbus < 0)
 		help();
 
-	address = parse_i2c_address(argv[flags+2]);
+	address = parse_i2c_address(argv[flags+2], all_addrs);
 	if (address < 0)
 		help();
 
diff --git a/tools/i2cset.c b/tools/i2cset.c
index 0ccc1a0..e250837 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -163,7 +163,7 @@ int main(int argc, char *argv[])
 	char filename[20];
 	int pec = 0;
 	int flags = 0;
-	int force = 0, yes = 0, version = 0, readback = 0;
+	int force = 0, yes = 0, version = 0, readback = 0, all_addrs = 0;
 	unsigned char block[I2C_SMBUS_BLOCK_MAX];
 	int len;
 
@@ -179,6 +179,7 @@ int main(int argc, char *argv[])
 			flags++;
 			break;
 		case 'r': readback = 1; break;
+		case 'a': all_addrs = 1; break;
 		default:
 			fprintf(stderr, "Error: Unsupported option "
 				"\"%s\"!\n", argv[1+flags]);
@@ -200,7 +201,7 @@ int main(int argc, char *argv[])
 	if (i2cbus < 0)
 		help();
 
-	address = parse_i2c_address(argv[flags+2]);
+	address = parse_i2c_address(argv[flags+2], all_addrs);
 	if (address < 0)
 		help();
 
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index 38b6b4a..0dce067 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -124,7 +124,7 @@ int main(int argc, char *argv[])
 {
 	char filename[20];
 	int i2cbus, address = -1, file, arg_idx = 1, nmsgs = 0, nmsgs_sent, i;
-	int force = 0, yes = 0, version = 0, verbose = 0;
+	int force = 0, yes = 0, version = 0, verbose = 0, all_addrs = 0;
 	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
 	enum parse_state state = PARSE_GET_DESC;
 	unsigned buf_idx = 0;
@@ -139,6 +139,7 @@ int main(int argc, char *argv[])
 		case 'v': verbose = 1; break;
 		case 'f': force = 1; break;
 		case 'y': yes = 1; break;
+		case 'a': all_addrs = 1; break;
 		default:
 			fprintf(stderr, "Error: Unsupported option \"%s\"!\n",
 				argv[arg_idx]);
@@ -210,7 +211,7 @@ int main(int argc, char *argv[])
 				 */
 
 				if (!force) {
-					address = parse_i2c_address(arg_ptr);
+					address = parse_i2c_address(arg_ptr, all_addrs);
 					if (address < 0)
 						goto err_out_with_arg;
 
-- 
2.11.0
