From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH] i2c: gpio: suppress error on probe defer
Date: Tue, 10 Mar 2020 10:16:18 +1300
Message-ID: <20200309211618.25535-1-hamish.martin@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:57069 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVQd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 9 Mar 2020 17:16:33 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa+renesas@sang-engineering.com
Cc: linus.walleij@linaro.org, linux-i2c@vger.kernel.org, Hamish Martin <hamish.martin@alliedtelesis.co.nz>

If a GPIO we are trying to use is not available and we are deferring
the probe, don't output an error message.
This seems to have been the intent of commit 05c74778858d
("i2c: gpio: Add support for named gpios in DT") but the error was
still output due to not checking the updated 'retdesc'.

Fixes: 05c74778858d ("i2c: gpio: Add support for named gpios in DT")
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.=
c
index 3a9e840a3546..a4a6825c8758 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -348,7 +348,7 @@ static struct gpio_desc *i2c_gpio_get_desc(struct dev=
ice *dev,
 	if (ret =3D=3D -ENOENT)
 		retdesc =3D ERR_PTR(-EPROBE_DEFER);
=20
-	if (ret !=3D -EPROBE_DEFER)
+	if (PTR_ERR(retdesc) !=3D -EPROBE_DEFER)
 		dev_err(dev, "error trying to get descriptor: %d\n", ret);
=20
 	return retdesc;
--=20
2.25.1
