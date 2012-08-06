From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] i2c: fix i2c-i801.c printk format warning
Date: Mon, 06 Aug 2012 09:10:47 -0700
Message-ID: <501FEC87.6060506@xenotime.net>
References: <20120806140109.b1a33b63686ef04f30139c9e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120806140109.b1a33b63686ef04f30139c9e@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, Mark Studebaker <mdsxyz123@yahoo.com>
List-Id: linux-i2c@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning.  ARRAY_SIZE() uses sizeof(),
which is size_t, so use %zu to print it.

drivers/i2c/busses/i2c-i801.c: In function 'i801_add_mux':
drivers/i2c/busses/i2c-i801.c:1043:4: warning: format '%lu' expects type 'long unsigned int', but argument 3 has type 'unsigned int'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: Mark D. Studebaker <mdsxyz123@yahoo.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-i801.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20120806.orig/drivers/i2c/busses/i2c-i801.c
+++ linux-next-20120806/drivers/i2c/busses/i2c-i801.c
@@ -1039,7 +1039,7 @@ static int __devinit i801_add_mux(struct
 
 	/* Find absolute GPIO pin numbers */
 	if (ARRAY_SIZE(priv->mux_priv) < mux_config->n_gpios) {
-		dev_err(dev, "i801_priv.mux_priv too small (%lu, need %d)\n",
+		dev_err(dev, "i801_priv.mux_priv too small (%zu, need %d)\n",
 			ARRAY_SIZE(priv->mux_priv), mux_config->n_gpios);
 		return -ENODEV;
 	}
