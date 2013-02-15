From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] i2c: fix i2c-ismt.c printk format warning
Date: Fri, 15 Feb 2013 10:51:40 -0800
Message-ID: <511E83BC.3050007@infradead.org>
References: <20130215184255.5ba8a085004f4aadb9faf82c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130215184255.5ba8a085004f4aadb9faf82c@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Bill E. Brown" <bill.e.brown@intel.com>, Jean Delvare <khali@linux-fr.org>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warning.  dma_addr_t can be 32-bit or 64-bit,
so cast it to long long for printing.  This also matches the
printk format specifier that is already used.

drivers/i2c/busses/i2c-ismt.c:532:3: warning: format '%llX' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Bill E. Brown <bill.e.brown@intel.com>
Cc:	Jean Delvare <khali@linux-fr.org>
Cc:	Seth Heasley <seth.heasley@intel.com>
Cc:	Neil Horman <nhorman@tuxdriver.com>
Cc:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-i2c@vger.kernel.org
---
 drivers/i2c/busses/i2c-ismt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20130215.orig/drivers/i2c/busses/i2c-ismt.c
+++ linux-next-20130215/drivers/i2c/busses/i2c-ismt.c
@@ -530,7 +530,7 @@ static int ismt_access(struct i2c_adapte
 		}
 
 		dev_dbg(dev, " dma_addr = 0x%016llX\n",
-			dma_addr);
+			(unsigned long long)dma_addr);
 
 		desc->dptr_low = lower_32_bits(dma_addr);
 		desc->dptr_high = upper_32_bits(dma_addr);
