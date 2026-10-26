Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014612;
	b=sc+QedfxZCNWkpukkASBGgn0HQOJYp1oPZ90dH60fpCTed2XDLXW8DcCYQS6ZLH1d4yC
	 KH4pKbXHMgacGFZbK/Rw4nK9w+Fgj83JS+fI0TfXJLhBxyy2LgOkVzZPU02Q7enxjGMCP
	 h86RDUmuAImJqRBv0wC7r8Yk5uk0bjsOMDvThYpLxHDOZQYgVBUguKw5aHWEmnR/Ihk4T
	 DoCeVhzDn2wiPm7mGTu95wkqo9XAgDx8AT4jtr7knGeDq0HumkYjawW/t7Ico5X4q3nBx
	 id/MokAxywlmWUsRsQMXwh1wo5gsff4OihDSq7ZMKo4bdWD1yoN8haGghMeBOQlVfkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014612;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iQhgsyUGgRThP7MeTZ/qzQIw3pgEbEeRs8S1jXKQ/Sg=;
	b=SEn4llvPZKgrjGx9AE/Jz0ZirQDg9+/2GklCrxvg3nX6OMkU6L5LbUIva9erFtHF6n+x
	 FtqPHVKIMZJM0QgWAOYM/kO8pVV/PbD45Ci4cja/9hx1llVuwKQxlEQb/1rrtJOa+fq/x
	 hrGAQMxOnGgdImZEtymXb2+/f9kizBJ8k3VI13YlVJ+QMqHLOZihFZcUgWvmz3yzR9Rwh
	 NgR/u9PLrIFT3o2cvAwSaqtLwcX3xPnusnbcKkGMdLRqHR2tsuyItDqi9++GVpzG3hl1U
	 2OXWR+lgGR8XVyPv/I1M16ydinGYcjiNWgBSLa3PncBPwjzQvPy7TDyDS6f4vTYU/Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nIubllTR;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D839606A335;
	Mon, 26 Oct 2026 11:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D839606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=nIubllTR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=nIubllTRlpmXKc1rjWFtNEwaf76t85jSvPPWzZXFNL+5IQhsehfDDHr7xNorZxevzqIWrIbT1auN9
	 rmPTufWhhS0KZ3hbkfBdsSOIoE4KtD6459e0d1vM8g4a//GIX6vmN8V4VnnsiQgWqixw4g6OipNjM/
	 xjywYrdc/VLPL3zo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16adf3b4796d-2a33b;
	Mon, 26 Oct 2026 19:36:48 +0800 (CST)
X-RM-TRANSID:2ee16adf3b4796d-2a33b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W6400298 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96adf3b4e5a4-b0856;
	Mon, 26 Oct 2026 19:36:47 +0800 (CST)
X-RM-TRANSID:2ee96adf3b4e5a4-b0856
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: gregory.clement@bootlin.com,
	andi.shyti@kernel.org,
	p.zabel@pengutronix.de
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangbin@cmss.chinamobile.com
Subject: [PATCH] i2c: mv64xxx: Check clk_prepare_enable() return value in runtime resume
Date: Mon, 26 Oct 2026 19:36:45 +0800
Message-ID: <20261026113645.2858-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv64xxx_i2c_runtime_resume() calls clk_prepare_enable() for both
drv_data->clk and drv_data->reg_clk without checking the return value.
If either clock fails to enable, the function returns 0 (success) and
the driver proceeds to call reset_control_reset() and
mv64xxx_i2c_hw_init() which access hardware registers without clocks
enabled, potentially causing a bus hang.

Additionally, if the second clk_prepare_enable() fails, the first clock
is left enabled without being disabled on the error path.

Fix this by checking both return values and properly cleaning up the
first clock if the second fails.

Fixes: e5c02cf54154 ("i2c: mv64xxx: Add runtime PM support")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1acba628e..62a564556 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -963,9 +963,18 @@ static int
 mv64xxx_i2c_runtime_resume(struct device *dev)
 {
 	struct mv64xxx_i2c_data *drv_data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(drv_data->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(drv_data->reg_clk);
+	if (ret) {
+		clk_disable_unprepare(drv_data->clk);
+		return ret;
+	}
 
-	clk_prepare_enable(drv_data->clk);
-	clk_prepare_enable(drv_data->reg_clk);
 	reset_control_reset(drv_data->rstc);
 
 	mv64xxx_i2c_hw_init(drv_data);
-- 
2.52.0.windows.1



