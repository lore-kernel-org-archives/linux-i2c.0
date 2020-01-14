From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/4] i2c: highlander: Use proper printk format for iomem pointer
Date: Tue, 14 Jan 2020 10:06:04 +0100
Message-ID: <1578992765-1418-3-git-send-email-krzk@kernel.org>
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

    drivers/i2c/busses/i2c-highlander.c: In function ‘highlander_i2c_smbus_xfer’:
    drivers/i2c/busses/i2c-highlander.c:325:22: warning:
        format ‘%d’ expects argument of type ‘int’,
        but argument 3 has type ‘size_t {aka long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 drivers/i2c/busses/i2c-highlander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index abfe3094c047..803dad70e2a7 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -322,7 +322,7 @@ static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 		tmp |= (SMMR_MODE0 | SMMR_MODE1);
 		break;
 	default:
-		dev_err(dev->dev, "unsupported xfer size %d\n", dev->buf_len);
+		dev_err(dev->dev, "unsupported xfer size %zu\n", dev->buf_len);
 		return -EINVAL;
 	}
 
-- 
2.7.4
