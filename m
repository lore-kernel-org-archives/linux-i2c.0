Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E62221DB3;
	Fri, 13 Feb 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941723; cv=none; b=V09UMHOMpdPbSGMkpazvMD1zKzOY1QiQmn45fY3kaenq80tA1pvFBAj0lmWVhnwZVswWqjOMEPcVcZRLbyWv5eydE0Nxg+pP6UGDoIW0wgm/fGMT3kaZxaD1Ke4vJPRbNdFDvIf7Mo9Ab0nkIiLQZaTv36SinaLURmiJ8xIWvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941723; c=relaxed/simple;
	bh=ktFNFyYb0Uq2CP/YIDJw0JUiqxN5uUvfLEqzzvmbA3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ik/S1KstLLKEQzW2+lnUHxtk0zdR7IRgAcvD0QtMM3PPb0LuY12kJgyG6Wvz6r+S8Jf7LFX8z1nwEapM46inQ5P+702vW7/SCZWZBayeuBtNWCyxLPIgo2sVzoQ9dj+mvyvL2Jmaw4O5yGAuyBLzrArOkAsCDLBc2VYT+oZjgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAJLwPxy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAJLwPxy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE593C2BC87;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770941722;
	bh=ktFNFyYb0Uq2CP/YIDJw0JUiqxN5uUvfLEqzzvmbA3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CAJLwPxyAGpEnyCJ9X50bSlJsJO3Nrm35GPhgvgTmZYRLKeuBlNlfJEyoBGdf9np2
	 Dgph9pWF1BoPcs5oNxn34F3caf9t4u2Vn4NT0bq3Rv7fV2tuFvzd8yF98pF6Tx/c/Q
	 ZN3E4fdpcAl3x5sOIO4Mnm9SBDWyHEbyQ1+nPTbVd4sPxXCBkgkxMFZtOf1FY9zXo9
	 PvI7bEyX4EON++iWHHC30Csd9x4NzbAoI7bubt3zM0nQFa+Jp34iFMoGg8Nhga3Lx2
	 L0geyFIzswShUKC8ksHIsiMnkRVxvXmXs+WyEul4MwySsn9TZnrUTevowrL3/Aa0OS
	 rCVlNvwb3N8FA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8CEEA870;
	Fri, 13 Feb 2026 00:15:22 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 13 Feb 2026 00:15:22 +0000
Subject: [PATCH v11 7/7] i2c: xiic: skip input clock setup on non-OF
 systems
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-xiic-v11-7-5d18aea11bde@nexthop.ai>
References: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
In-Reply-To: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770941721; l=1203;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=QbeCuGkKnN5h5Ohu93cG+bcDU57NUhxnJ+h/cgz+Owg=;
 b=ahPuuoyzgNrgiZHMsSNPsEPM2zxawKhDjYIy/l9O0JPv/Ev49NxOdwFTn9/lny7oLo4UvcqxH
 zT4VbTBiRoXDz5uZTAcdIDQ6cpd7w4vE8i5UWT7nKLNyZeOyhqMxJ2t
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Currently Linux does not implement ACPI ClockInput() resource to describe
clocks, unlike DT. However the xiic driver is happy if something
magically enables the clock before the driver probes, and does not
turn it off again. The clock should always be considered optional for
ACPI.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 2ad75325154c..e5574f2d97bf 100644
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
+			return dev_err_probe(dev, PTR_ERR(i2c->clk),
+					"failed to enable input clock.\n");
+	}
 
 	i2c->dev = dev;
 

-- 
2.52.0


