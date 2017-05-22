From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] i2c: designware: Fix bogus sda_hold_time due to uninitialized
 vars
Date: Mon, 22 May 2017 07:46:55 +0200
Message-ID: <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

We need to initializes those variables to 0 for platforms that do not
provide ACPI parameters. Otherwise, we set sda_hold_time to random
values, breaking e.g. Galileo and IOT2000 boards.

Fixes: 9d6408433019 ("i2c: designware: don't infer timings described by ACPI from clock rate")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Affects 4.12-rc2.

 drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6283b99d2b17..d1263b82d646 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -94,9 +94,9 @@ static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
 static int dw_i2c_acpi_configure(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	u32 ss_ht = 0, fp_ht = 0, hs_ht = 0, fs_ht = 0;
 	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	const struct acpi_device_id *id;
-	u32 ss_ht, fp_ht, hs_ht, fs_ht;
 	struct acpi_device *adev;
 	const char *uid;
