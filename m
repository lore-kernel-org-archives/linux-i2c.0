Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C3349B0D;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447301; cv=none; b=iG0WHeZxBWThv6hFZcYca2Vn45YYNerRd4nT8ZCmp7IHbqJAjJJl6O6V4q1CGl9HhmvamVe8ZyB+tQA+sKXSkruCXVn+jmgW4KcgPLWZBED5uh8rNoqaUJ0iEF4tY8vzLzNeVs1LI+2QS6EHgq9DCWHA6ELyOSDC4x3BaUxbGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447301; c=relaxed/simple;
	bh=OybWCogfBgN8xZ/i/vgh3wMiiMXnvU+ML2P4SNzVv2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZMx4oTdwVs49rZFqoDvo477cJckyDQwA4Q9JkzM6Q6+rYVzfKz9PHyIrN0HRhEv0OfDjw18XKNKXW8M7JdShefZt9nrLo3/5pRdMJnqPDDHFgQvUKEYwoog8SszExxi+qpyGzvF0OD2vZdmfZjNOXohD+BCzjZVv8Az9iABwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgXJh0jN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgXJh0jN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D74EC2BCB1;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447301;
	bh=OybWCogfBgN8xZ/i/vgh3wMiiMXnvU+ML2P4SNzVv2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BgXJh0jNFHyZBMnwZSQNNXMcbKEsjmN8odwDmWldh9wwA7NfX8xjmFSB3mnqysurv
	 t8RpdNGaF8JTq94mXsbgaFgZr3e7ZpWQMDGyQPqWywpDw5B7tsQ7vN5w9zSiS+0SqS
	 tjJcEmnWb5NUSdxbY6SCuFEE7cYnafPydtwbyeQXI5MKfuQPvGYSkkQt0aIHbxIQIE
	 UENi2/lf2igbuT+cMcgLhFNb13ppttl2P6nEo5vu5eMfpHg/S7SPxG6/YJDoT+GElB
	 xZJcOYAQWco8nTHltAKI5+qeyPdShqJL78z+ORckzgvR7wWwhevy1MTS7aK7v7/S4K
	 kO+XRTXELhBhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F89D19502;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 26 Jan 2026 17:08:19 +0000
Subject: [PATCH v5 4/6] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-i2c-xiic-v5-4-88a16a28721c@nexthop.ai>
References: <20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai>
In-Reply-To: <20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769447300; l=800;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=GVZq2HmFuG7CNJnGoqYZGmD0YpSeA59LFKPs+6ye6Uk=;
 b=BoLKdz1mXkh+9FOaj+7RkXE2H3BzPV3zmnuidek6FzRj3sbPuBJucSaLV3gNgmDBN+gfkXHs+
 dFfCjnwL51yCViUTSELre9K3EJxfSiBA3C8S5XYuBJkdp6kiRYlz53D
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The devm_request_threaded_irq() already prints an error message. Remove
the duplicate.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index a4a8087c1407..a06597bbf6fc 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1492,10 +1492,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 					xiic_process, IRQF_ONESHOT,
 					pdev->name, i2c);
 
-	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	i2c->singlemaster =
 		of_property_read_bool(pdev->dev.of_node, "single-master");

-- 
2.52.0


