Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A92D23B1;
	Mon,  2 Feb 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064656; cv=none; b=sOFwZDfxenump7WLo/bmcNAD6Odc7C16YHCDPYMjBlhgxEKLEdR5QYPvdLG6J6G83b8PtL9mftHe0dG9ug+zZSe55K7doRLNQW4CQU4LLkrmG6XjZzMLmww4KlzwD2EDf0jrzm2HmnXd6gj8bsdp9rLsQZ/AwGXjrjc0L0FtJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064656; c=relaxed/simple;
	bh=9NOBASfi7anGmRe6t5aBWM/Ma9uXjL5J+KNCF/CduQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vhno5LxkvOI4koVWzqIFljNALR6ywGdANl63hsdg+kH2LWVzrYQby5YKX5Nar5j966TrSG8NViMpcQ6xEjELnCv8onA9suQ6UDtaa8ml4ESadnf2rZyDsZN8CiGZKDchAZW/dbPY9qnyKt/USBn6gGg0Zb9Au+wA7Z+O89Au9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsxScTUT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsxScTUT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8DAFC2BC87;
	Mon,  2 Feb 2026 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064655;
	bh=9NOBASfi7anGmRe6t5aBWM/Ma9uXjL5J+KNCF/CduQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tsxScTUTlOEAqZ97j2Hn2QFpHbZZJVMJRrdYYigEQrGrY2X9UtAU2LSG1Xna3KLun
	 Y3+i8+zvmWmnQo/Nky7WELDgdc6hwBA8dACXUTSbiZTvUPWnSUtM4Mlxbi7ikIF/cy
	 4kagBUCRo4SWUvV57JADjJx4baKANxV8OygN+PuJ185toKFCrjIXVHs4plakUfS8Cg
	 07fwLYLOmR2bb3v3MNsVs1FkyaOUf0BZyHzXv8XWjmBun3IIPUp/tZciNU5RIWdV1s
	 VWy9BBkKsInuJRTf0abGiAJ7nh0QtfYO13hRTPeshjzGtLHnlg5hqOYHc08zgjQ61N
	 WyzGC3ia30Nvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E2E7FDD3;
	Mon,  2 Feb 2026 20:37:35 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 02 Feb 2026 20:37:19 +0000
Subject: [PATCH v9 2/7] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-i2c-xiic-v9-2-ce4695f5267d@nexthop.ai>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
In-Reply-To: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770064654; l=958;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=KsvKdIRhjvHhQgBTA+p4IEJ0A4qmuGyZ80lYOv0Q75M=;
 b=EEY28N/1o9/YOJt+nW9+75JCikFRsOTVy+BfwG01Foue3FFJy82CDVuihkRN1WEcZEaHSXx1/
 p6Ord3CnmnRDxfCiirRlP+RvS8Hof0sZ4sX9ikz746fJ1E7KGuMLCv+
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The devm_request_threaded_irq() already prints an error message. Remove
the duplicate.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 16ff83fe280b..4cb7c40fb565 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1491,11 +1491,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					xiic_process, IRQF_ONESHOT,
 					pdev->name, i2c);
-
-	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	i2c->singlemaster =
 		of_property_read_bool(pdev->dev.of_node, "single-master");

-- 
2.52.0


