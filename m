From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: powermac: don't workaround for keywest
Date: Sat,  9 May 2015 19:23:33 +0200
Message-ID: <1431192213-2904-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Mark Elliott <txlitebeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Commit 3a3dd0186f619b ("i2c/powermac: Improve detection of devices from
device-tree") added a codec device instantiation workaround
unconditionally although it is only needed for onyx. Do it conditionally
since keywest has its own codec instantiation in the sound drivers.
Thanks must go to GrowlTiger from Gentoo bug report #469132 for
bisecting.

Reported-by: Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Tested-by: Dan DeVoto <dand1972-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Tested-by: Mark Elliott <txlitebeer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Fixes: 3a3dd0186f619b ("i2c/powermac: Improve detection of devices from device-tree")
---
 drivers/i2c/busses/i2c-powermac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 6abcf696e3594b..cad5552c0cd4e4 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -285,7 +285,8 @@ static void i2c_powermac_add_missing(struct i2c_adapter *adap,
 
 static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 					    struct device_node *node,
-					    u32 addr, char *type, int type_size)
+					    u32 addr, char *type, int type_size,
+					    bool found_onyx)
 {
 	char tmp[16];
 
@@ -305,8 +306,8 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 		return true;
 	}
 
-	/* Now look for known workarounds */
-	if (!strcmp(node->name, "deq")) {
+	/* Now look for known workarounds for onyx/aoa */
+	if (found_onyx && !strcmp(node->name, "deq")) {
 		/* Apple uses address 0x34 for TAS3001 and 0x35 for TAS3004 */
 		if (addr == 0x34) {
 			snprintf(type, type_size, "MAC,tas3001");
@@ -362,7 +363,7 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 
 		/* Make up a modalias */
 		if (!i2c_powermac_get_type(adap, node, addr,
-					   info.type, sizeof(info.type))) {
+					   info.type, sizeof(info.type), found_onyx)) {
 			continue;
 		}
 
-- 
2.1.4
