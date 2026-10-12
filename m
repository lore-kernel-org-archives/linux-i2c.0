Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FA43B6CE;
	Mon, 12 Oct 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805971; cv=none; b=cFZ8xbR5dxjjnjTPKcorAn0379jrkt3yxIrVc8LX0V3OSERVBao5D/3x1BMBu+cMp9isGwbpPN8/wtn5stvQSxnjCRynFxfzDtJ7Ww3LkZ+upHszK6MEInzAxP7hNxb1MdtJl/X98TXI5pz9MoWcsG7+pi07SkKvHZsaGRofc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805971; c=relaxed/simple;
	bh=pN2Spl3bOj4EMARvrHbeXiss0yT3R2BDthvf7IzL5Nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZp7BHk02ZQwowMuYS1OHm3gNHPIVpxBzMnrRbBE/0Xwxv5u206y41HdhcDKkBN8XCwekpCT4LDGwVXITgmOlog0JmPCgPysu4fmSFi338zgMnd/XVHWrV9apRVRe8l7N35S5Gjaf+LOmGgXwRCC7LUF8vKTbCBOmZyAo7TrvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=yubsY+Ys; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="yubsY+Ys"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791805961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XRtjL0/iwMeo8iuZcV+Re1/5O1DqBVnsRc9l0KWEZ4=;
	b=yubsY+YskhxkFmcm5Rn7jrQcwFAPvlo6QLrt62mnPJCZvA68eszGfJ8bD7BmvgMo+ZgjWY
	KY6m7Ep5ZxfquUjdkVpAHZw7HSINthzzSjEOJWiPx14cRLXlOg2Q5PFHeGj6P6TXxMfpUK
	MoORNx+cEInMFD6WlkICSRiExAe81kc=
Date: Mon, 12 Oct 2026 13:52:33 +0200
Subject: [PATCH 2/5] arm64: dts: apple: t8140: Group cache-related
 properties of cpus
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-2-6c757966a99e@cyberchaos.dev>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The dt-check-style from 7.3 raised an issue on the ordering, but
the one from current linux-next allows the cache properties to be
grouped, improving readability.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t8140.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
index 150d91bdf6fc..40559da62923 100644
--- a/arch/arm64/boot/dts/apple/t8140.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -60,8 +60,9 @@ cpu_e0: cpu@0 {
 			compatible = "apple,tahiti-e";
 			reg = <0x0 0x0>;
 			cpu-release-addr = <0 0>;
-			d-cache-size = <0x10000>;
 			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
 		};
@@ -71,8 +72,9 @@ cpu_e1: cpu@1 {
 			compatible = "apple,tahiti-e";
 			reg = <0x0 0x1>;
 			cpu-release-addr = <0 0>;
-			d-cache-size = <0x10000>;
 			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
 		};
@@ -82,8 +84,9 @@ cpu_e2: cpu@2 {
 			compatible = "apple,tahiti-e";
 			reg = <0x0 0x2>;
 			cpu-release-addr = <0 0>;
-			d-cache-size = <0x10000>;
 			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
 		};
@@ -93,8 +96,9 @@ cpu_e3: cpu@3 {
 			compatible = "apple,tahiti-e";
 			reg = <0x0 0x3>;
 			cpu-release-addr = <0 0>;
-			d-cache-size = <0x10000>;
 			enable-method = "spin-table";
+
+			d-cache-size = <0x10000>;
 			i-cache-size = <0x20000>;
 			next-level-cache = <&l2_cache_0>;
 		};
@@ -104,8 +108,9 @@ cpu_p0: cpu@10100 {
 			compatible = "apple,tahiti-p";
 			reg = <0x0 0x10100>;
 			cpu-release-addr = <0 0>;
-			d-cache-size = <0x20000>;
 			enable-method = "spin-table";
+
+			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
 		};
@@ -115,8 +120,9 @@ cpu_p1: cpu@10101 {
 			compatible = "apple,tahiti-p";
 			reg = <0x0 0x10101>;
 			cpu-release-addr = <0 0>;
-			d-cache-size = <0x20000>;
 			enable-method = "spin-table";
+
+			d-cache-size = <0x20000>;
 			i-cache-size = <0x30000>;
 			next-level-cache = <&l2_cache_1>;
 		};

-- 
2.55.0

