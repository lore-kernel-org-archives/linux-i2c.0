From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue,  6 Jun 2017 11:20:32 +0200
Message-ID: <20170606092034.1516-3-wsa+renesas@sang-engineering.com>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/DMA-considerations | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/i2c/DMA-considerations

diff --git a/Documentation/i2c/DMA-considerations b/Documentation/i2c/DMA-considerations
new file mode 100644
index 00000000000000..945ac5cfe55c12
--- /dev/null
+++ b/Documentation/i2c/DMA-considerations
@@ -0,0 +1,28 @@
+Linux I2C and DMA
+-----------------
+
+Given that I2C is a low-speed bus where largely small messages are transferred,
+it is not considered a prime user of DMA access. At this time of writing, only
+10% of I2C bus master drivers have DMA support implemented. And the vast
+majority of transactions are so small that setting up DMA for it will likely
+add more overhead than a plain PIO transfer.
+
+Therefore, it is *not* mandatory that the buffer of an i2c message is DMA safe.
+It does not seem reasonable to apply additional burdens when the feature is so
+rarely used. However, it is recommended to use a DMA-safe buffer, if your
+message size is likely applicable for DMA (FIXME: > 8 byte?).
+
+To support this, drivers wishing to implement DMA can use a helper function
+checking if the size is suitable for DMA or if the buffer is DMA capable:
+
+	int i2c_check_msg_for_dma(msg, dma_threshold);
+
+Please check its in kernel documentation for details.
+
+It should be further noted that bounce buffer handling is left to be handled on
+driver level because details like alignment requirements are best known on that
+level.
+
+If you plan to use DMA with I2C (or with any other bus, actually) make sure you
+have CONFIG_DMA_API_DEBUG enabled during development. It can help you find
+various issues which can be complex to debug otherwise.
-- 
2.11.0
