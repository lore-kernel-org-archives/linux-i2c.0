From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/5] i2c: stu300: Use proper printk format for iomem pointer
Date: Mon, 30 Dec 2019 18:27:50 +0100
Message-ID: <20191230172751.17985-4-krzk@kernel.org>
References: <20191230172751.17985-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191230172751.17985-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-i2c@vger.kernel.org

iomem pointers should be printed with pointer format to hide the
actual value and fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-stu300.c: In function ‘stu300_wait_while_busy’:
    drivers/i2c/busses/i2c-stu300.c:446:76: warning:
        cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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
2.17.1
