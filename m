From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 31/37] drivers/of: use .of_node instead of .archdata.of_node
	in struct device
Date: Thu, 11 Mar 2010 11:06:39 -0700
Message-ID: <20100311180638.4824.71650.stgit__25086.4150505096$1268331158$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dwmw2@infrade
List-Id: linux-i2c@vger.kernel.org

.archdata.node is being removed from Microblaze, SPARC and PowerPC.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

 drivers/of/of_i2c.c  |    1 -
 drivers/of/of_mdio.c |    1 -
 drivers/of/of_spi.c  |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 43f803e..ab6522c 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -42,7 +42,6 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.addr = be32_to_cpup(addr);
 
-		dev_archdata_set_node(&dev_ad, node); /* temporary */
 		info.of_node = node;
 		info.archdata = &dev_ad;
 
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 64e08d7..794fbc2 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -79,7 +79,6 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		/* Associate the OF node with the device structure so it
 		 * can be looked up later */
 		of_node_get(child);
-		dev_archdata_set_node(&phy->dev.archdata, child); /* temp */
 		phy->dev.of_node = child;
 
 		/* All data is now stored in the phy struct; register it */
diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index 433d76d..5fed7e3 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -80,7 +80,6 @@ void of_register_spi_devices(struct spi_master *master, struct device_node *np)
 		/* Store a pointer to the node in the device structure */
 		of_node_get(nc);
 		spi->dev.of_node = nc;
-		spi->dev.archdata.of_node = nc; /* temporary */
 
 		/* Register the new device */
 		request_module(spi->modalias);
