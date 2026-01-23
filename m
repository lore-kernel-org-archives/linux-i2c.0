Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486F318BAE;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155385; cv=none; b=p597Fi5Capce4YrwhQHaO9i/mgpZx1sl3+iLaGI6DbuAyUhb432xilzTLfvCnD8HIzKN9ICH5kQGc0g36hQGLTo3KmAdySYwQBwzpDSVkaNTSBswKjaUI07nqg1N2i8LSTBCxMSC2edCG9xpOVG/27Sw/b7ucG4cAi9/fZK78pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155385; c=relaxed/simple;
	bh=21QgVWJxppsy2WfrsYHM9rd+SKv2elfyVdfo+LCNaKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IM8rwk8YpXquBqPtaf+w+nrhr0QMTTPD5Ww9LQXv0WUC4f/qYeFDffmH+ARN4UsGj09UilGfBhV5kACqEsUiOvApBUCChozinoOoDg9UyQjD95qsCbfuQ62HhC1p4+vhFy+QbAIdRFiKN1RoDOp9XNLlyA2g/eikcAms0yyfESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ4S7yRW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ4S7yRW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30EB2C19423;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155385;
	bh=21QgVWJxppsy2WfrsYHM9rd+SKv2elfyVdfo+LCNaKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gQ4S7yRW9jBcirtXQoDLxxXQ7OFrg+v8oC47p1j0unAgKueMJKV1TAWOdR+sOjZ0S
	 65462ojbeq2hfapQjw0ZSdz9BG9ORqZDYsx8s2ee4W1T7UMAoEYG1+cvR8KAz6Cc+j
	 ibr3hZw2miCPaIjcDP9AliL+oHibDWrSY57zjzE/wtX2KFtUXKxJGhDq0RaBPElYrn
	 vHRfKT3pt1ZLTNvaR1VvnDClTKH4wYvG4DjhhXcg0UftGt0/y6Sa783jFLaNvowu1z
	 on+PxUT28epixXzAPyAsOlAgFQTBktayxcclGiet/OPMZthJ/3biyiwXrAo4+ghsFe
	 deGtO5u5U5Jzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D7D72349;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 08:02:46 +0000
Subject: [PATCH v3 3/5] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v3-3-eb7cd4254dfb@nexthop.ai>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769155384; l=651;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=8+foX4oDtm5Uf+NftOW1CSk/aI5wtgDdkEiHVL5041E=;
 b=npVAlHweINmY0ziepQn7v7CkJ6Z4uRPbzWZINnPl2eVl5qzOMUYQXmJq17nhmPsl1DCkMUbA/
 CQXJFwhdHIyCQAvwsNUCr5F8odKG29+++McehkKAwVUFaTtl5PTuw4w
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
 drivers/i2c/busses/i2c-xiic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 79643c27e75d..52d5c0c5c5c8 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1491,7 +1491,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 					pdev->name, i2c);
 
 	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
 		goto err_pm_disable;
 	}
 

-- 
2.52.0


