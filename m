Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB740A92F;
	Mon, 12 Oct 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805970; cv=none; b=V/AECGcPYXNwf8Kyhy9RtbnhHppNl+dE94VB9gkct0vZlOiDdSC7QHiQhaeVj9rOX8SmVJtM6DKhrOYoYnNX33wc9W/2tD7OJtI0b8WwJEJJo9C10Rebta5TQYq0azzyrqQGAj6rKTUYgLS5bdIl88hW3AXaNe1PPbOSsJ1f39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805970; c=relaxed/simple;
	bh=rlGRbnPfNKIG0w/2283L6L4LTzqHTGGtQxHZBSE/7lI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUtWTuXhfYFLwDN55DN8aWFgHl6ybWg2QbiTT6Kq+o6TKiupvT2hStFDLDyEVcqaMqRg2e/bx7BiVMc3VAhEF66jca2dyHMRPSucamRRDZTQ3RrslfgV+OrJ7gEhCLPeHau/o3wSpQLZIsL2W/tZIDeCeX3Y/WURq1rB4ZQeexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=QRIn5kuD; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="QRIn5kuD"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791805961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQyn13FvDSEzRYwvK6acuY5FUVZPqAwaJjsc3VK6GTc=;
	b=QRIn5kuD4Ot1gHvrq7H2NFtzsiWpUIggAbXDGdquPxy1iEqmONJR/vvMZq/c+ynmlUH9Mk
	yTMj41LNtkAkqDnYjPty6wO/mHXyGKneKDUQ9Nke7Of57aUE9rwW1gQMwhISnjCgox4W1Q
	azD8+FYu4iwb1ZlCQ99D9j3OK5SAP2g=
Date: Mon, 12 Oct 2026 13:52:32 +0200
Subject: [PATCH 1/5] arm64: dts: apple: t8140-j700: Fix property ordering
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-1-6c757966a99e@cyberchaos.dev>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The ordering requirements changed between 7.3 and 7.4.
The original t8140-j700.dtsi was developed against the 7.3
dt-check-style rules. Adjust it to the new ordering.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t8140-j700.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8140-j700.dts b/arch/arm64/boot/dts/apple/t8140-j700.dts
index 227b58a7ce64..15c21c9e3f2b 100644
--- a/arch/arm64/boot/dts/apple/t8140-j700.dts
+++ b/arch/arm64/boot/dts/apple/t8140-j700.dts
@@ -12,8 +12,8 @@
 #include "t8140.dtsi"
 
 / {
-	compatible = "apple,j700", "apple,t8140", "apple,arm-platform";
 	model = "Apple MacBook Neo (A18 Pro, 2026)";
+	compatible = "apple,j700", "apple,t8140", "apple,arm-platform";
 
 	aliases {
 		serial0 = &serial0;

-- 
2.55.0

