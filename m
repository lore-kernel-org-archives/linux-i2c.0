Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12730F7F2;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064656; cv=none; b=ZAn9waBjBBb+6iY8svGgVVrDNGSCOhuV3E16zJVdZ27GWXeUMDro+o88+K5cQ2gvWekpxaY/eBibLz4HHCy28I0xLgUbEUOvcLiAlacm5fpKIVlFCwHLxtOk9Hn7SGJeQ7jiRlUOdp3tBSTx/+5F0TP0XHH7ZwcYd3KA8HiKkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064656; c=relaxed/simple;
	bh=aIxdhfft82t0LR/tguShdCXtDz/e/UoBlZbo+TcBruU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaIxVOgfMdo/8Gn56Zfg3wGMwt20d4ZLT9Ix4bTlftv022VMthJ2VIu9MdL8UbMXS88x9qU5kzAY77cnGc/DIS3fKP16CKxeUqdSD1Nqcse6KzDP2fZpKPVNVUV9zY1Z1w7uXQbw2sf784J2GwDXHCrUHn9SipdqphblDTHQDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St01odn+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St01odn+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2BDDC2BCAF;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064656;
	bh=aIxdhfft82t0LR/tguShdCXtDz/e/UoBlZbo+TcBruU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=St01odn+LFAwYbWH3LbiGNi3o+cLVov3o26fCA5sA8v4cpazmtzXRzF2f5zXyZz8I
	 jGIHtxPKvFOJdddIJS5FH9uoXa2iw5lnFN7Qza1H0sB1jvh8EgqW+eIbszq3m+5mKd
	 QyYdqMxo0ZDzOGki3qA5sovLiuf6oP61HUeLG/rPLoJOeSjoOSEc0lfqhsDmXyCcT1
	 qqiuxCF1xMl0dgBtMxCQfurkYL0kWwpUkaYBk4LN+UGN148r1dQZtKOPN8gNpv96+x
	 JgvM4ooGiutEs22fVN3EofnHcMCAHQ79/7jpqvcz+xpchiLmBSV+zyoMpbiFgncwVJ
	 38EkKvhxWuVWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9C1E7FDD0;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 02 Feb 2026 20:37:24 +0000
Subject: [PATCH v9 7/7] i2c: xiic: skip input clock setup on non-OF systems
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-i2c-xiic-v9-7-ce4695f5267d@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
In-Reply-To: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770064654; l=1208;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=qAOgrbSGsxp0qSeRvLqeFzjiQ6yMVDZel5cRWAUzEco=;
 b=RvPUnGkIwT65/8Ukp0VGrxU1fvDeEccXellEgYK7PbZskP99R9ZlqKf/9m0bPPHIFsdSGi4uP
 AthFPKugAdRCbOREm48E4SZzQeeaoxdnyWVQUPfdPmUKm7w30zm8hkK
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Currently Linux does not implement ACPI ClockInput to describe clock
resources, unlike DT. However the xiic driver is happy if something
magically enables the clock before the driver probes, and does not
turn it off again. The clock should always be considered optional for
ACPI.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 2c0470452221..017e33d4309c 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1463,10 +1463,12 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(i2c->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
-				     "failed to enable input clock.\n");
+	if (is_of_node(dev_fwnode(dev))) {
+		i2c->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(i2c->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+					"failed to enable input clock.\n");
+	}
 
 	i2c->dev = dev;
 

-- 
2.52.0


