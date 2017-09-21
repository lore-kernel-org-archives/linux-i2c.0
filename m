From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 2/3] i2c: Cocci spatch "of_table"
Date: Thu, 21 Sep 2017 08:24:27 +0200
Message-ID: <1505974912018-1581728551-2-diffsplit-thomas@m3y3r.de>
References: <1505974912018-1637125348-0-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505974912018-1637125348-0-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Make sure (of/i2c/platform)_device_id tables are NULL terminated.
Found by coccinelle spatch "misc/of_table.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -627,6 +627,7 @@ static const struct dev_pm_ops sprd_i2c_
 
 static const struct of_device_id sprd_i2c_of_match[] = {
 	{ .compatible = "sprd,sc9860-i2c", },
+	{},
 };
 
 static struct platform_driver sprd_i2c_driver = {
