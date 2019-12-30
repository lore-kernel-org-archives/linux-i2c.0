From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] i2c: pmcmsp: Use proper printk format for resource_size_t
Date: Mon, 30 Dec 2019 18:27:47 +0100
Message-ID: <20191230172751.17985-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-i2c@vger.kernel.org

resource_size_t should be printed with its own size-independent format
to fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-pmcmsp.c: In function ‘pmcmsptwi_probe’:
    drivers/i2c/busses/i2c-pmcmsp.c:276:25: warning:
        format ‘%x’ expects argument of type ‘unsigned int’,
        but argument 3 has type ‘resource_size_t {aka long long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 4fde74eb34a7..5d3a12bd420b 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -274,8 +274,8 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 	if (!request_mem_region(res->start, resource_size(res),
 				pldev->name)) {
 		dev_err(&pldev->dev,
-			"Unable to get memory/io address region 0x%08x\n",
-			res->start);
+			"Unable to get memory/io address region %pa[p]\n",
+			&(res->start));
 		rc = -EBUSY;
 		goto ret_err;
 	}
@@ -285,7 +285,7 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 						resource_size(res));
 	if (!pmcmsptwi_data.iobase) {
 		dev_err(&pldev->dev,
-			"Unable to ioremap address 0x%08x\n", res->start);
+			"Unable to ioremap address %pa[p]\n", &(res->start));
 		rc = -EIO;
 		goto ret_unreserve;
 	}
-- 
2.17.1
