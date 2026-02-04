Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219E38B9A4;
	Wed,  4 Feb 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188527; cv=none; b=vDOfzMqIleuRvrZaXTKhKGv9jUkdYAiI0RPnQ67DwOQ7z7TnLRx9VtCQVT/87JRanVs3Ra+G8Ab6d+THkmnTPubM8TDH1Hc+Rd07Rs1mBoPkDRF3CmLt0kEpICGN5/mowmnO81GBNovlatR3brV6r72qaPf9b/3QdFLyxGDE3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188527; c=relaxed/simple;
	bh=4+G4utc/06tDm3FrxJFapDNzuA7QGnO1MVuLuQtaqfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThBKLFbN72GyCD/n3cL3BngSZ8aJ0z8+RfpnP4ww47EaaFe+jlSli71OA5QIXR/umuDE1rqhvHIu/k5kU9hU0mDjJNKukgq2DkZiiJ4MjaYY6uzthf97c7ZsdoZDwRG0UhP0UC8SOZQsunX8MJLf2VdxiybpbUvtCe2BcLPw+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDh/nPqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDh/nPqy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0906C4AF1D;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770188526;
	bh=4+G4utc/06tDm3FrxJFapDNzuA7QGnO1MVuLuQtaqfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PDh/nPqyJLw/v8SJSfIPqaysVcTa4uLnhPgy3O95qxubpfSA3abPS3dj9hFmEw+f9
	 oiBB/EEizPG3hjTco3msTreR2KCNkVLlzdEy61bp0CpgY2h9HzAx4Rs7+FGVC1lqmx
	 RJ5Cm39irNfTfEAUM/UdYmPDFTEurfOAnkAHg6wQ10kb3iYTGhbWp9VoXTX75cFe0U
	 C6S/mXyiR8GzRyWxEfAWDT/qE0oOmZ6Vh401FeTPZZqGXfggMGeqaJK9MkBwwqS2oJ
	 9PtHmdPLkL53UExBPsf0rMfEuhy7L2CLcY9I78BqqXA6xIuAm8nRDMrCUjb9PGwvWi
	 fgtVXKitv5emw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CD7E83041;
	Wed,  4 Feb 2026 07:02:06 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Wed, 04 Feb 2026 07:02:04 +0000
Subject: [PATCH v10 7/7] i2c: xiic: skip input clock setup on non-OF
 systems
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-i2c-xiic-v10-7-c2b996425235@nexthop.ai>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
In-Reply-To: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770188524; l=1203;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=tYS/VjjyJSR7laAGSOlbLWbUAEEO7GSJdraxofdKYu8=;
 b=reH74jvc9iL/OqdvmPi42fqas2VeKfyY9DxbAVuLmBwi3xnNMpx8UHSJJ9L5TMMcgviHbDYj8
 0aU2eko7nQnDAICiEOQKoTKw5iHIV/jk8V9JygEwS98ZQ8s3sFNcHeX
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
index 2c0470452221..223074e263ee 100644
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


