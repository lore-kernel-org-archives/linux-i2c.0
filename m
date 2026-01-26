Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E0349B0A;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447301; cv=none; b=emnW++qlwMT5CXdEOOdF/XlJVJM+Ok+fR6MDd086aPg6oBhjOtxV9QqeVoMnVPKax2JeC2B4QidHf0fvmR3YyYku26pm4LFQOfvi+pGEqgG/LaNnRvEH6hjeQvJ5+U7tN73JIg+v3dEtL8/A6//F2zNjS8vsFFHd+ZVsjNOxsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447301; c=relaxed/simple;
	bh=2f258ZKMGjMDX6rVeyYTKnl8hXsCenCR77UWDe3H8b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTroUmophkaRmn9PnOYUdrY9PO5krW2iuUb88ZSC4c+EsmLmM3+MYLkpSNIN94DoF5qAXS0Jfs9esCjPtNtcdkAHci9/LwmacJnRKTOhOxtwNqGbjOdGwgyCKZJUqoi2HLe7whHGOVlSkqyIy9/DicyIQiGudr+5lmqzV4xspsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAXvlt5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAXvlt5n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 320F3C116C6;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447301;
	bh=2f258ZKMGjMDX6rVeyYTKnl8hXsCenCR77UWDe3H8b8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CAXvlt5nIri4w61xbzMTvJtIsULNx3SiGa06J6N4nlnUzCwNYdbcSBbatcd5vrgD1
	 RAdGSlWOY3EPc2sI1bTAw+UnC20h6U8S+vaSiGTjDaUnIY6AIkAMgtXl+uxEi6scEY
	 ztArCqDe+qQrxeoJHGSzVH1QSyULZ8s98NyfYRoQx9JXnaHepNbFDxi0tfZDM0rFDl
	 0yFZUnfwj/NjTzVv4eNsoAWUrwAXBlqyOGzeY4OQj/ZC0BSowHgqcCx7waKDQfxE7n
	 kqEbJIBCPtdTWcwYVIVU5SeKNVxAi8RJKhaYTJlWeHkk7fMJXA8osE7FHdMCC5bvQS
	 +c5dH5uJmhESA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20368D19503;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 26 Jan 2026 17:08:16 +0000
Subject: [PATCH v5 1/6] dt-bindings: i2c: xiic: make clocks optional
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-i2c-xiic-v5-1-88a16a28721c@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769447300; l=759;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=Jp8L32rGkddXyWP1kCRtOWV6Txgpa0+B9TbjL9V4o78=;
 b=u6lMnREI4xoLQT48ikHXfh1CX+SaIP94RfXSOXgGbgcPNt2mLRPhh8b4Swa6nuKYUYgIQcLhI
 spVSC5M2KWRBYyWHhxwbnmMEd81osgmhVWla1QhhLaVWKApEQpujUva
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The xiic driver is designed to operate without explicit clock configuration
when clocks are not specified in the firmware.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
index 658ae92fa86d..cc500130f41f 100644
--- a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+++ b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
@@ -43,7 +43,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
 
 unevaluatedProperties: false
 

-- 
2.52.0


