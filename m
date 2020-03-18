From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 52/73] i2c: gpio: suppress error on probe defer
Date: Wed, 18 Mar 2020 16:53:16 -0400
Message-ID: <20200318205337.16279-52-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgCRUyn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 18 Mar 2020 16:54:43 -0400
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Hamish Martin <hamish.martin@alliedtelesis.co.nz>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

[ Upstream commit 3747cd2efe7ecb9604972285ab3f60c96cb753a8 ]

If a GPIO we are trying to use is not available and we are deferring
the probe, don't output an error message.
This seems to have been the intent of commit 05c74778858d
("i2c: gpio: Add support for named gpios in DT") but the error was
still output due to not checking the updated 'retdesc'.

Fixes: 05c74778858d ("i2c: gpio: Add support for named gpios in DT")
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 3a9e840a35466..a4a6825c87583 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -348,7 +348,7 @@ static struct gpio_desc *i2c_gpio_get_desc(struct device *dev,
 	if (ret == -ENOENT)
 		retdesc = ERR_PTR(-EPROBE_DEFER);
 
-	if (ret != -EPROBE_DEFER)
+	if (PTR_ERR(retdesc) != -EPROBE_DEFER)
 		dev_err(dev, "error trying to get descriptor: %d\n", ret);
 
 	return retdesc;
-- 
2.20.1
