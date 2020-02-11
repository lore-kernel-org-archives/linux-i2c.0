From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 03/14] net: davicom: dm9000: allow to pass MAC address through mac_addr module parameter
Date: Tue, 11 Feb 2020 22:41:20 +0100
Message-ID: <4e11dd4183da55012198824ca7b8933b1eb57e4a.1581457290.git.hns@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1581457290.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>
Cc: devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-i2c@vger.kernel.org

This is needed to give the MIPS Ingenic CI20 board a stable MAC address
which can be optionally provided by vendor U-Boot.

For get_mac_addr() we use an adapted copy of from ksz884x.c which
has very similar functionality.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/net/ethernet/davicom/dm9000.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 1ea3372775e6..7402030b0352 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1409,6 +1409,43 @@ static struct dm9000_plat_data *dm9000_parse_dt(struct device *dev)
 	return pdata;
 }
 
+static char *mac_addr = ":";
+module_param(mac_addr, charp, 0);
+MODULE_PARM_DESC(mac_addr, "MAC address");
+
+static void get_mac_addr(struct net_device *ndev, char *macaddr)
+{
+	int i = 0;
+	int j = 0;
+	int got_num = 0;
+	int num = 0;
+
+	while (j < ETH_ALEN) {
+		if (macaddr[i]) {
+			int digit;
+
+			got_num = 1;
+			digit = hex_to_bin(macaddr[i]);
+			if (digit >= 0)
+				num = num * 16 + digit;
+			else if (':' == macaddr[i])
+				got_num = 2;
+			else
+				break;
+		} else if (got_num) {
+			got_num = 2;
+		} else {
+			break;
+		}
+		if (got_num == 2) {
+			ndev->dev_addr[j++] = (u8)num;
+			num = 0;
+			got_num = 0;
+		}
+		i++;
+	}
+}
+
 /*
  * Search DM9000 board, allocate space and register it
  */
@@ -1679,6 +1716,11 @@ dm9000_probe(struct platform_device *pdev)
 			ndev->dev_addr[i] = ior(db, i+DM9000_PAR);
 	}
 
+	if (!is_valid_ether_addr(ndev->dev_addr)) {
+		mac_src = "param";
+		get_mac_addr(ndev, mac_addr);
+	}
+
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
 		inv_mac_addr = true;
 		eth_hw_addr_random(ndev);
-- 
2.23.0
