From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 4/4] i2c: stu300: Use proper printk format for iomem pointer
Date: Tue, 14 Jan 2020 10:06:05 +0100
Message-ID: <1578992765-1418-4-git-send-email-krzk@kernel.org>
References: <1578992765-1418-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578992765-1418-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

iomem pointers should be printed with pointer format to hide the
actual value and fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-stu300.c: In function ‘stu300_wait_while_busy’:
    drivers/i2c/busses/i2c-stu300.c:446:76: warning:
        cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---

Changes since v1:
1. Add Linus' review tag.
---
 drivers/i2c/busses/i2c-stu300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 8c3e2d409d63..42e0a53e7fa4 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -444,7 +444,7 @@ static int stu300_wait_while_busy(struct stu300_dev *dev)
 		       "Attempt: %d\n", i+1);
 
 		dev_err(&dev->pdev->dev, "base address = "
-			"0x%08x, reinit hardware\n", (u32) dev->virtbase);
+			"0x%p, reinit hardware\n", dev->virtbase);
 
 		(void) stu300_init_hw(dev);
 	}
-- 
2.7.4
