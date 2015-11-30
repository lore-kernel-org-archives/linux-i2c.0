From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [PATCH v3 2/2] ACPI / gpio: Add irq_type when a gpio is used as an interrupt
Date: Mon, 30 Nov 2015 23:47:53 +0100
Message-ID: <1448923673-2582-3-git-send-email-christophe-h.ricard@st.com>
References: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>
List-Id: linux-i2c@vger.kernel.org

When a gpio is used as an interrupt, the irq_type was not available for
device driver. It is not align with devicetree probing.

Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
---
 drivers/gpio/gpiolib-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bbcac3a..cff8736 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -416,9 +416,12 @@ static int acpi_find_gpio(struct acpi_resource *ares, void *data)
 		 * GpioIo is used then the only way to set the flag is
 		 * to use _DSD "gpios" property.
 		 */
-		if (lookup->info.gpioint)
+		if (lookup->info.gpioint) {
 			lookup->info.active_low =
 				agpio->polarity == ACPI_ACTIVE_LOW;
+			irq_set_irq_type(gpiod_to_irq(lookup->desc),
+					 acpi_get_irq_type(agpio->triggering, agpio->polarity));
+		}
 	}
 
 	return 1;
-- 
2.1.4

