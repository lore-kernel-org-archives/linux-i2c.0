From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] ARM: mach-s3c64xx: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:14 +0100
Message-ID: <20200326211014.13591-2-wsa+renesas@sang-engineering.com>
References: <20200326211014.13591-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200326211014.13591-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and remove printing a stale 'ret'
value.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 937d0a83f8fd..34f1baa10c54 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -405,10 +405,9 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
 			 gf_mods[i].name, rev + 1);
 
 		for (j = 0; j < gf_mods[i].num_i2c_devs; j++) {
-			if (!i2c_new_device(i2c->adapter,
-					    &(gf_mods[i].i2c_devs[j])))
-				dev_err(&i2c->dev,
-					"Failed to register dev: %d\n", ret);
+			if (IS_ERR(i2c_new_client_device(i2c->adapter,
+							 &(gf_mods[i].i2c_devs[j]))))
+				dev_err(&i2c->dev, "Failed to register\n");
 		}
 
 		spi_register_board_info(gf_mods[i].spi_devs,
-- 
2.20.1
