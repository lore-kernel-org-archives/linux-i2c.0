Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0230B50B;
	Mon, 23 Feb 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862360; cv=none; b=uUrfY/GohMOGdKVDmoeKkrN3eSH0/03GRPdRiBNwVThGVfPOd4oFdlNQ8Y0cBsl07X+YUVf4AEcoxLRU/eA+wasfg10BQjDkaPvLFRsZx93cB7NDLK4bpm8spugpFW9LvIWXMUPw9rfqbHgmbBdjA0RnQypL+CpETZerOcwxaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862360; c=relaxed/simple;
	bh=eDeGqWzfszSxlsa0dgDJoVbCF0RNmd/ZzVa697YK8KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWACghnl4fPbw62orCx4W5aEUokKsT53sYdCkSYoi6Jcj9t8b6hDfeEpjPEMPyUXt8Pm6I2HHrbBpgo6amme51YddlOdsv/sz582wHFSLh6guvCpSpAindrn4wjFeFobMiwlcMFmifnpFp6iWQ49UE+cOWteLgiO/EPucsksYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ6ZeCtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ6ZeCtL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0334C2BCB0;
	Mon, 23 Feb 2026 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862360;
	bh=eDeGqWzfszSxlsa0dgDJoVbCF0RNmd/ZzVa697YK8KE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RQ6ZeCtL9n4bB0jdne9IogDl7WOMZu1aVge4oisE82c/ew8EiVeUL7IVZFY6idg2o
	 ZdN0PbY3VHZa28FX8nTyXse2aOCgV4/nWbgpDO8lrm7Ovejbz9JjsHsVz2zNkUj/Op
	 NKkcQQFSf/qk1IgkNfB0bmYRiPtmHP68k97IQscYt+pxaf6vjMLevIVr4wFJBu5wA7
	 PZEqF4ymhhE2dO0xPDMgmPZHwj6PyGpg2tbeRTwggePYPbxfKlmT1NQ8gnYy8DsBko
	 MO89F1U+velR/Qf2hy1/MmsN0ESgtJQtEyb1//7ba30K+vgTHGr3heONQSkrN+3EqI
	 BtEpmAODggjBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60B7E98E1E;
	Mon, 23 Feb 2026 15:59:19 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 23 Feb 2026 15:59:20 +0000
Subject: [PATCH v12 5/7] i2c: xiic: cosmetic: use resource format specifier
 in debug log
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-xiic-v12-5-b6c9ce4e4f3c@nexthop.ai>
References: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
In-Reply-To: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771862359; l=861;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=7a+Jv/sysSvCd9GgBokRdDYOqlTm04F/cT7DP1ztyWA=;
 b=yUwadXileWxfaXhhsoyottKwsdmIg23ZJsFROqUlA6qIGvuEPkkkn3orZJN3IvkPzyirgjsLE
 MqZXzAIGXIzBhXzPkTyJQsVuGJJrH6BGWxu3m7oXuyi94i1l4xyzIAG
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Use standard resource format specifier %pR in debug log.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 463a207c6a76..80e183b6e4f1 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1519,8 +1519,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 			i2c_new_client_device(&i2c->adap, pdata->devices + i);
 	}
 
-	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
-		(unsigned long)res->start, irq, i2c->i2c_clk);
+	dev_dbg(dev, "mmio %pR irq %d scl clock frequency %d\n",
+		res, irq, i2c->i2c_clk);
 
 	return 0;
 }

-- 
2.52.0


