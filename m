From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 2/3] i2c: pnx: Use proper printk format for resource_size_t
Date: Wed, 15 Jan 2020 21:02:49 +0100
Message-ID: <20200115200250.10849-2-krzk@kernel.org>
References: <20200115200250.10849-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200115200250.10849-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-i2c@vger.kernel.org

resource_size_t should be printed with its own size-independent format
to fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-pnx.c: In function ‘i2c_pnx_probe’:
    drivers/i2c/busses/i2c-pnx.c:737:47: warning:
        format ‘%x’ expects argument of type ‘unsigned int’,
        but argument 5 has type ‘resource_size_t {aka long long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Remove parentheses around res->start.

Changes since v1:
1. Use %pap, not %pa[p].
---
 drivers/i2c/busses/i2c-pnx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 6e0e546ef83f..686c06f31625 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -734,8 +734,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_clock;
 
-	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
-		alg_data->adapter.name, res->start, alg_data->irq);
+	dev_dbg(&pdev->dev, "%s: Master at %pap, irq %d.\n",
+		alg_data->adapter.name, &res->start, alg_data->irq);
 
 	return 0;
 
-- 
2.17.1
