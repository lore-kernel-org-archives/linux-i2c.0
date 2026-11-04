Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833547;
	b=AMp6QPOipwIraY6gKBkE225dBWuvepKWclBTTLd8uHP9qSbjTb84fK61khWOlADlEvTR
	 yuUw0zrYV7l9TbCf2/zolNkskZo2Qrjn7O2i/e+isr7idoETCu0eSi2xi4yqmUz4OPEB4
	 D+casBShvI1eMDS5glt+14//8KPl+drcpR2QwyNAeivhUH87ff+/qe9simYA6w074Qgyx
	 tN8gGaKgUTJOdQrJ2VQ+2H2KUbhoEw35KKQFwQj4aztdJCLgiBhIHPqwAv/aGPhVP0V/W
	 OK5NXyYyhuLety57WEnmFaJmxoRHeukZrngvWarUDmQIbh9zUHtNUw1kAgFH3Mt6XCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1l4cFks6kYYHiLxPoo91N4PwaPPSiDd+NNG1IyBeBt0=;
	b=QyGr9ckNcZCiRqdpqPLx806bksDyo4JfFXNa6YGaC5LwqiSE/oZZlBPzYV59tsW7YTOD
	 3kyQQTtfr5ohCPHGSyzz3jYiiktTWLj4lk+mNukcGfj0ELOu97h+vZWdlDmJpa2/PSvUf
	 ZpROs2CTN8DNMjaVrN7w/DK2xWqmzqNjTzawhqxIbg42NTqhBZaYREEWE/7MkNZb50X/j
	 DJBPhccxcnYQIqTzETjxIZ2PnsFiR6oFEYps7vY+J3QJvplkKqmURcoHvlopwGN/6COZB
	 tXRwrvl13gvivI+h0NkvQbY5ee2SXcZavzJwr7eYuxAa6R226c7Kl6Co6hv37pqpFaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SySy8x0L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD803606A33F;
	Wed,  4 Nov 2026 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SySy8x0L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BBE1F00A17;
	Wed,  4 Nov 2026 23:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833546;
	bh=1l4cFks6kYYHiLxPoo91N4PwaPPSiDd+NNG1IyBeBt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SySy8x0LoC24OkegHpetl6GqQVNk47yIpv9B8sP1dst1sgsMIC+rc76R6VpzlDL6U
	 YCyHNwXsm6KGTOMVJA5U8yvdRxIKmGWAOBoRNHIApmfXU9TYTiarPhMZzTyfCFv7Wi
	 h6dva5rKF9hF1EGYvMjpxhhn8c1YB6SzueiPO7yr2/fLE6MvgD0Ycr/ug5i8RBudO8
	 UIKxCxx03WVGgRaen1ZaXSYMes4EtiyloL0JjuPTvjkv5voc2jfsbhS6VWo5iqGff+
	 GonZZaqXm1B+2cqYuxjVdsdF+EtPKSx5PWSdULYkMJJcYmdWhmLuYNjzp/g+lZwbyH
	 X/Wc1KkwZdLbQ==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm8350: Add camera MCLK pinctrl states
Date: Thu,  5 Nov 2026 01:05:29 +0200
Message-ID: <20261104230529.3040285-4-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261104230529.3040285-1-vz@kernel.org>
References: <20261104230529.3040285-1-vz@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pinctrl states of six camera sensor MCLK output pins found on
Qualcomm SM8350 SoC.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 84 ++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 41dff3736061..437ceaa28fbd 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3431,6 +3431,90 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 204>;
 			wakeup-parent = <&pdc>;
 
+			cam_mclk0_default: cam-mclk0-default-state {
+				pins = "gpio100";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk0_sleep: cam-mclk0-sleep-state {
+				pins = "gpio100";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cam_mclk1_default: cam-mclk1-default-state {
+				pins = "gpio101";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk1_sleep: cam-mclk1-sleep-state {
+				pins = "gpio101";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cam_mclk2_default: cam-mclk2-default-state {
+				pins = "gpio102";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk2_sleep: cam-mclk2-sleep-state {
+				pins = "gpio102";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cam_mclk3_default: cam-mclk3-default-state {
+				pins = "gpio103";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk3_sleep: cam-mclk3-sleep-state {
+				pins = "gpio103";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cam_mclk4_default: cam-mclk4-default-state {
+				pins = "gpio104";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk4_sleep: cam-mclk4-sleep-state {
+				pins = "gpio104";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cam_mclk5_default: cam-mclk5-default-state {
+				pins = "gpio105";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk5_sleep: cam-mclk5-sleep-state {
+				pins = "gpio105";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			cci0_0_default: cci0-0-default-state {
 				/* SDA, SCL */
 				pins = "gpio107", "gpio108";
-- 
2.51.0

