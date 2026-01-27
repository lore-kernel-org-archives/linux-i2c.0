Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750A23A9B0;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547845; cv=none; b=hSCcsk+8IxP5ZGUIDn9dXhqttI8AaX6Wqx0MgtX6DlT1Pc7m8PGt0HD9ZCF4Ri41SE/e/vm8NRRbIiVSqmZfkoFrj2NOAAoTctid4ezF7c6w47M7SVhIDl9Zx1U7EDGnkp3wbofaS7jxsF+GJ4fyQYHOAa3oPun7qP9A8JPPs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547845; c=relaxed/simple;
	bh=bRJsBVhV2cTCTGqXXoRRmJ1NBnZdJqFem9P0ZfHUxu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfR8FN4pcB7FNM+HhYpIqLb1IpNgjyH6f/vz4p9sWUaS2jU99AEKy3AcKDisGThcVHd08dL3bIPvA30LJ8RGrSPD+LsIWIQv/pLsy5kgV+rVavFbU6kKk4ni/TVYoUglF6TyuhbgF1H2Q3mgHcTu5uOntu56691EUwVT+PAueO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhcEuMeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhcEuMeR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F2FC2BCB0;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547844;
	bh=bRJsBVhV2cTCTGqXXoRRmJ1NBnZdJqFem9P0ZfHUxu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NhcEuMeRBr9AO6D1JYMO064Q3vTHWgc7mLHuWxvsISIW+Vx5wqfKVdojFu38d/UuY
	 fLtO9LagFmLeHwhsUTGR6TPb0s+SnIO4WIhwpqnSYWupBPNYQanYRXnqFlFRV0DRex
	 Xnqp4l14h9sazkCyvFmWspRI+aPEs2yu3k0WFVPAd+XgAy8SAPrqVo+EJzxjNapjMc
	 c9ilocuOQePi0joqrzs+/edeRlHRoUmaukYue0xcEY8AUPgPIsZz1kh4hzkSIzd92K
	 jFCg0NffPDOEh5MnbgktlrNtwMN3YTNloq9MBFYYww4MhYviAzWjWQsEgNw9CezXGT
	 kCtEXXymy2u8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A29D2FEE6;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Tue, 27 Jan 2026 21:03:56 +0000
Subject: [PATCH v6 2/7] i2c: xiic: make the clock optional
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-i2c-xiic-v6-2-e82e2f6f657c@nexthop.ai>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
In-Reply-To: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769547843; l=1430;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=MFPKI1awSXPDHMhgBtmEFE5/b9Lhx4gVN3sZslxmYUc=;
 b=+FtBJZg8geOC7XQNZZg6dApeNX1NUbt+C210icp/0ttg9ATCBS02Ux5PPYQlE0WcbPTnx3R3t
 47XJchi0O30CWbi/IEzFJdUXMuB2GAQVBQWdfWu+bd+wOGA0X0BU8bW
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The xiic driver is designed to operate without explicit clock configuration
when clocks are not specified in the firmware. This functionality is
already implemented in xiic_setclk(), which performs an early return when
either i2c_clk or input_clk are zero:

This condition is satisfied when clocks are missing, as clk_get_rate(NULL)
returns zero, allowing the driver to rely on hardware-configured timing.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 28015d77599d..16202fb89271 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1423,6 +1423,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
 
 static int xiic_i2c_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct xiic_i2c *i2c;
 	struct xiic_i2c_platform_data *pdata;
 	const struct of_device_id *match;
@@ -1464,7 +1465,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	mutex_init(&i2c->lock);
 	spin_lock_init(&i2c->atomic_lock);
 
-	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	i2c->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
 				     "failed to enable input clock.\n");

-- 
2.52.0


