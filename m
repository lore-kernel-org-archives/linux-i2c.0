From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] i2c: pmcmsp: constify i2c_algorithm and i2c_adapter_quirks
 structures
Date: Sun, 9 Jul 2017 16:20:35 -0500
Message-ID: <20170709212035.GA28642@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-i2c@vger.kernel.org

Check for i2c_algorithm and i2c_adapter_quirks structures that are only
stored in the algo and quirks fields of an i2c_adapter structure
correspondingly. These fields are declared const, so i2c_algorithm and
i2c_adapter_quirks structures that have this property can be declared
as const also.

Theses issues were detected using Coccinelle and the following semantic
patch:

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct i2c_algorithm i@p = { ... };

@ok@
identifier r.i;
struct i2c_adapter e;
position p;
@@
e.algo = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct i2c_algorithm i = { ... };

The semantic patch for i2c_adapter_quirks is analogous.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 217c787..2aa0e83 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -577,7 +577,7 @@ static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
 		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_PROC_CALL;
 }
 
-static struct i2c_adapter_quirks pmcmsptwi_i2c_quirks = {
+static const struct i2c_adapter_quirks pmcmsptwi_i2c_quirks = {
 	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
 	.max_write_len = MSP_MAX_BYTES_PER_RW,
 	.max_read_len = MSP_MAX_BYTES_PER_RW,
@@ -587,7 +587,7 @@ static struct i2c_adapter_quirks pmcmsptwi_i2c_quirks = {
 
 /* -- Initialization -- */
 
-static struct i2c_algorithm pmcmsptwi_algo = {
+static const struct i2c_algorithm pmcmsptwi_algo = {
 	.master_xfer	= pmcmsptwi_master_xfer,
 	.functionality	= pmcmsptwi_i2c_func,
 };
-- 
2.5.0
