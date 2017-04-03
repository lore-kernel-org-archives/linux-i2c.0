From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools 1/2] i2ctransfer: replace broken "force" handling
Date: Mon,  3 Apr 2017 19:36:12 +0200
Message-ID: <20170403173613.2238-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:58877 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbdDCRgW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 3 Apr 2017 13:36:22 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Probably because of a bad rebase, the old and bogus handling (v1) of "force"
slipped into the latest version of the patch (v3). Apply the better
version from v2 which does the error handling correct and makes the code
a lot easier to understand.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/i2ctransfer.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
index 0f7ddd5..bc027c3 100644
--- a/tools/i2ctransfer.c
+++ b/tools/i2ctransfer.c
@@ -199,8 +199,6 @@ int main(int argc, char *argv[])
 
 			arg_ptr = end;
 			if (*arg_ptr) {
-				int whole_range_ok;
-
 				if (*arg_ptr++ != '@') {
 					fprintf(stderr, "Error: Unknown seperator after length\n");
 					goto err_out_with_arg;
@@ -211,16 +209,22 @@ int main(int argc, char *argv[])
 				 * the address here.
 				 */
 
-				address = parse_i2c_address(arg_ptr);
-				/* With 'force', allow whole address range */
-				whole_range_ok = force && address == -2;
-				if (address < 0 && !whole_range_ok)
-					goto err_out_with_arg;
-
-				/* Ensure address is not busy */
-				if (!force && set_slave_addr(file, address, 0))
-					goto err_out_with_arg;
-
+				if (!force) {
+					address = parse_i2c_address(arg_ptr);
+					if (address < 0)
+						goto err_out_with_arg;
+
+					/* Ensure address is not busy */
+					if (set_slave_addr(file, address, 0))
+						goto err_out_with_arg;
+				} else {
+					/* 'force' allows whole address range */
+					address = strtol(arg_ptr, &end, 0);
+					if (arg_ptr == end || *end || address > 0x7f) {
+						fprintf(stderr, "Error: Invalid chip address\n");
+						goto err_out_with_arg;
+					}
+				}
 			} else {
 				/* Reuse last address if possible */
 				if (address < 0) {
-- 
2.11.0
