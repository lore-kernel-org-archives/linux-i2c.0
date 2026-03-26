Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15E40FD9C;
	Thu, 26 Mar 2026 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538862; cv=none; b=ZS+ZHcc+1GYgWBVjVzuhE8sQJhMR3oBJthreg4FF+t3B3VyUlUIUbm/u6EbdX++FSi5kzn4UJwCXzbwxAk418JNokeGo6mPuuviApWKaWOPGkl21UqNlD6pcrXEJNZw6kTjqM7WXGdQ50DkNyxjq/4KagixJJ93CndvYWhh7zM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538862; c=relaxed/simple;
	bh=hvgnFd6i8bH5mUG8809MkRlOdbcEZRveaBCGMvPKUaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nN0iZXNb+i1BzGfz6cLWl6j0j4ObPXZUSPgP3Nw8pd0negeGL5L66AGhqw4jkHSZSJ9b7wYARrsSou/ooOs51Dt8HnNGl4oWc2uWP1AJzDRPB8/mO4AFaVjrc09TJi0sbpa/wkEti8P2p3CEsbSy6NHG1O8m0Aqs94+8HWZqXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QBYXR2Nl; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QBYXR2Nl"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A9845266AC;
	Thu, 26 Mar 2026 16:27:39 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with UTF8SMTP
 id MxeIsOkcTS_l; Thu, 26 Mar 2026 16:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774538859; bh=hvgnFd6i8bH5mUG8809MkRlOdbcEZRveaBCGMvPKUaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBYXR2Nlv4HFhyuyuYTh+o18TMOd51Q201AlfHmS6GWzWPXqvxvzFRTgXg0twlqMh
	 DdLz17dTvczzoDZRRcoMpxaR0tZ+GfcwHGPOHMQXMnzAdbKCvE6B/T1wdvaURyx6/r
	 dvdUBgIKJo1OPJAn1Fvvw0eNA/bzsuS2vAC8NtmXK1b5HrZbcYDsEiVAX6FVsYVtsy
	 /bt8jGSBK+r2w8RZCl4HwkihtVd9hU2USuelFAZ0UmQDTY8wWhBNbwBz2ze4SgMg+l
	 s2Ad/cfzql9+yVjYeMGhDM3MHzEt9jfcQG5Z94KAhpumBqWgtPThkvjQAd7RlQPVqR
	 jeLJGJfd0kOvA==
From: Rustam Adilov <adilov@disroot.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v5 6/8] i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
Date: Thu, 26 Mar 2026 20:26:54 +0500
Message-ID: <20260326152656.14030-7-adilov@disroot.org>
In-Reply-To: <20260326152656.14030-1-adilov@disroot.org>
References: <20260326152656.14030-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RTL9607C i2c controller, there is 10 bit CLK_DIV field for
setting the clock of i2c interface which depends on the rate
of i2c clk (which seems be fixed to 62.5MHz according to Realtek SDK).

Introduce the clk struct and the respective F_CLK_DIV and clk_div
which are going to be used in the upcoming patch for rtl9607c i2c
controller support addition.

devm_clk_get_optional_enabled() function was used for cleaner code
as it automatically returns NULL if the clk is not present, which is
going to be the case for RTL9300 and RTL9310 i2c controllers.

Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index ffbc6c52861b..16af49ccd1dd 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/bits.h>
+#include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/mod_devicetable.h>
@@ -28,6 +29,7 @@ struct rtl9300_i2c_chan {
 	struct rtl9300_i2c *i2c;
 	enum rtl9300_bus_freq bus_freq;
 	u8 sda_num;
+	u32 clk_div;
 };
 
 enum rtl9300_i2c_reg_scope {
@@ -54,6 +56,7 @@ enum rtl9300_i2c_reg_fields {
 	F_SDA_OUT_SEL,
 	F_SDA_SEL,
 	F_BUSY,
+	F_CLK_DIV,
 
 	/* keep last */
 	F_NUM_FIELDS
@@ -85,6 +88,7 @@ struct rtl9300_i2c {
 	u8 scl_num;
 	u8 sda_num;
 	struct mutex lock;
+	struct clk *clk;
 };
 
 DEFINE_GUARD(rtl9300_i2c, struct rtl9300_i2c *, mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
@@ -432,6 +436,10 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	i2c->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(i2c->clk))
+		return dev_err_probe(dev, PTR_ERR(i2c->clk), "Failed to enable i2c clock\n");
+
 	i = 0;
 	for_each_child_of_node_scoped(dev->of_node, child) {
 		struct rtl9300_i2c_chan *chan = &i2c->chans[i];
-- 
2.53.0

