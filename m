Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747445C6F8;
	Fri, 21 Aug 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306635; cv=none; b=pV6urhadpUsxN8DRvY7L5CII7Q4M7LEXAfzDjBBaNwc0ONqqbNmzFS7HGJiuuTQcUNB8WJ8+Pis6Yd7p/XANI6VhjYHKwItZz7Nxem6e23Nr2YbAvKfFN1OAtxW/6hSKPKZS5XOnwTGs94wzA4cyuGmr5tbQj22JzfvNIh5w/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306635; c=relaxed/simple;
	bh=kGwOCYnylb0d11Ed724J4+2MR9GfCX1MyDQkL9TqxQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5NNUBxR5jmMPqox4TgV275bLdpMPaUUL3AQPKSXEQuDccT7M6N9tfcxZFOqTg6/rDad3piBXaLFiOLfF/tPuanzdaMwBgGUTq35Cz43qBzwW7WFfXfYU63Kwa/+qeOoE6OLPr9x1XoS3nQCj/270jTMO9R3EH3U2Ih7H7/onWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C9C1F000E9;
	Fri, 21 Aug 2026 10:03:37 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] i2c: bcm2835: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:03:30 +0200
Message-ID: <9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

Part One[1] fixed all cases that I identified to be real bugs, in
response to a crash I saw on BeagleBone Black.

This patch is the I2C subpart of Part Two, which fixes remaining cases
that are currently harmless.  These are still fragile, and may cause
future breakage when converting drivers to a different method for
specifying the parents.

[1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
     initialized (part 1)"
    https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be

---
 drivers/i2c/busses/i2c-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 0d7e2654a534e92a..b30f7e0e45f160c2 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -166,7 +166,7 @@ static struct clk *bcm2835_i2c_register_div(struct device *dev,
 					struct clk *mclk,
 					struct bcm2835_i2c_dev *i2c_dev)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_bcm2835_i2c *priv;
 	char name[32];
 	const char *mclk_name;
-- 
2.43.0

