Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136630EF83;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064656; cv=none; b=Bc2zFWfAogsfXg6mdkXx+pUKF/Ka/RTc13oxRpu9564NPgF+6JiqU5N/MEOzULf54kwwCvczKenmx3dCnIfxUUTclNdqGXhyjI1+Fy2K739VnIlX3ys+tN//mkdNpE4bHeStdD+AtzhnIxnb9TReh9G7y18DmgQ4Qb/SqtJYXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064656; c=relaxed/simple;
	bh=EQnetrtHFK2rEBzsiSIHup8oVhTEzY0ph1INzOphpyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qePDuy4JNsLk6/qjQygKxSNOl6dGuBvlcItb7mx7tA/2WRmErIDCIV/CbAVDo2c6T1i/P4/E+V2HMAtjUsICSegVNNVDLm+O/CF2z185RmNZFTn/RDCSQD+n2bK0AYxJ+8iDaeo97K+iY/ud21og5gMw7ZkNlxAdSgH6z6sGywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVs0lrsT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVs0lrsT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D10DC19425;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064656;
	bh=EQnetrtHFK2rEBzsiSIHup8oVhTEzY0ph1INzOphpyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mVs0lrsT6Q8iv11/hUkqq8F6pK1qito6+AOxXu6XThaE+hX3IUVzmqFrFz5MlxpBe
	 58RBCk38RWthf7aDeq/tUgPjld8mTooLO3viTeIklH3GTgjZLygIqzm6xV4LharqCg
	 O8C71UPsWbmoKkivbdTdjlDboJBVxnywBOJfD1Zl2zekvbEI4vfmA+/MPKxvhNabq3
	 7mi183bXvrdyp9wVNU1iZEJdSUFOfZAsqx9IbRlNU2ln3JuKYQw9mp4GXfMFSHgRJC
	 bewWHGv7LOhbRCdWdhQOr/beiMoGOhpDTI6mfrDDWrc+R4OE4BBoAqASmxOvfGg1+p
	 AoIhgHc7k1cGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E3CE7FDD3;
	Mon,  2 Feb 2026 20:37:36 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 02 Feb 2026 20:37:23 +0000
Subject: [PATCH v9 6/7] i2c: xiic: use numbered adapter registration
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-i2c-xiic-v9-6-ce4695f5267d@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770064654; l=1108;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=RLQIf1A/Hfhfj6sGMEhyze1brD6x3yYtifNZ+L92dP4=;
 b=Pv2jgLeasoQVQ/mHZBmVLZKipUHNjCA59kwN3eQa9PgZN51zKu0N7s+U/mc0h0C5qL+qQZ+/7
 AxI21/tBr1hBWozpraAV4N1nqfZ5knMK4UZ1RMS6mAqM7yaxWPfX/gz
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Use i2c_add_numbered_adapter() to allow platform devices to specify
fixed bus numbers when needed.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index eeb8ba8e131e..2c0470452221 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1450,6 +1450,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
 	i2c->adap = xiic_adapter;
+	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = dev;
 	device_set_node(&i2c->adap.dev, dev_fwnode(dev));
@@ -1506,7 +1507,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
 
 	/* add i2c adapter to i2c tree */
-	ret = i2c_add_adapter(&i2c->adap);
+	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret) {
 		xiic_deinit(i2c);
 		return ret;

-- 
2.52.0


