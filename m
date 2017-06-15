From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Thu, 15 Jun 2017 20:30:37 +0200
Message-ID: <20170615183039.22925-3-wsa+renesas@sang-engineering.com>
References: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615183039.22925-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/i2c/DMA-considerations | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/i2c/DMA-considerations

diff --git a/Documentation/i2c/DMA-considerations b/Documentation/i2c/DMA-considerations
new file mode 100644
index 00000000000000..92cdb6835ccf95
--- /dev/null
+++ b/Documentation/i2c/DMA-considerations
@@ -0,0 +1,37 @@
+Linux I2C and DMA
+-----------------
+
+Given that I2C is a low-speed bus where largely small messages are transferred,
+it is not considered a prime user of DMA access. At this time of writing, only
+10% of I2C bus master drivers have DMA support implemented. And the vast
+majority of transactions are so small that setting up DMA for it will likely
+add more overhead than a plain PIO transfer.
+
+Therefore, it is *not* mandatory that the buffer of an I2C message is DMA safe.
+It does not seem reasonable to apply additional burdens when the feature is so
+rarely used. However, it is recommended to use a DMA-safe buffer if your
+message size is likely applicable for DMA. Most drivers have this threshold
+around 8 bytes. As of today, this is mostly an educated guess, however.
+
+To support this scenario, drivers wishing to implement DMA can use helper
+functions from the I2C core. One checks if a message is DMA capable in terms of
+size and memory type. It can optionally also create a bounce buffer:
+
+	i2c_check_msg_for_dma(msg, threshold, &bounce_buf);
+
+The other one releases the bounce buffer ensuring data is copied back to the
+message:
+
+	i2c_release_bounce_buf(msg, bounce_buf);
+
+Please check the in-kernel documentation for details. The i2c-sh_mobile driver
+can be used as a reference example.
+
+The bounce buffer handling from the core is generic and simple. It will always
+allocate a new buffer. If you want a more sophisticated buffer handling (e.g.
+reusing pre-allocated buffers), you can skip the generic handling from the core
+and implement your own.
+
+If you plan to use DMA with I2C (or with any other bus, actually) make sure you
+have CONFIG_DMA_API_DEBUG enabled during development. It can help you find
+various issues which can be complex to debug otherwise.
-- 
2.11.0
