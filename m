From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v3 1/6] i2c: core: Allow whole core to use i2c_dev_irq_from_resources
Date: Tue, 28 May 2019 15:28:55 +0100
Message-ID: <20190528142900.24147-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

Remove the static from i2c_dev_irq_from _resources so that other parts
of the core code can use this helper function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 drivers/i2c/i2c-core-base.c | 4 ++--
 drivers/i2c/i2c-core.h      | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index d389d4fb0623a..84bf11b25a120 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -687,8 +687,8 @@ static void i2c_dev_set_name(struct i2c_adapter *adap,
 		     i2c_encode_flags_to_addr(client));
 }
 
-static int i2c_dev_irq_from_resources(const struct resource *resources,
-				      unsigned int num_resources)
+int i2c_dev_irq_from_resources(const struct resource *resources,
+			       unsigned int num_resources)
 {
 	struct irq_data *irqd;
 	int i;
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index c88cfef813431..8f3a08dc73a25 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -28,6 +28,8 @@ extern struct list_head	__i2c_board_list;
 extern int		__i2c_first_dynamic_bus_num;
 
 int i2c_check_7bit_addr_validity_strict(unsigned short addr);
+int i2c_dev_irq_from_resources(const struct resource *resources,
+			       unsigned int num_resources);
 
 /*
  * We only allow atomic transfers for very late communication, e.g. to send
-- 
2.11.0
