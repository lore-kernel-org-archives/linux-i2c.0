Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E138D00F;
	Wed, 25 Mar 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432200; cv=none; b=bBu6fLpkx/NfYOv0ZUNtA7kvRwKNgkn9CbqPDdu5eu1MRTgCv2bhDLIZ8vHkrMjtLHG0fIjcyir9ZkAZLkgKVsdlwT3saB46QFgoYvi3BJKMIHvJIWVYkU376uEUdcJcPjlc3VX4wofDMw8c9IRgqT9VOmHqyjvYJvbE/5wgcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432200; c=relaxed/simple;
	bh=X1k4Y4EE4YQHMjaQk+NB75V1fsruJnokoLSnoO0Mz44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QPOFYaR7ubLAVQmAn9QbXYnHmEGnVcSIQPFrRkHGrd1jByKPX4sEKyWVwtRG9j9L2pSFiDh9DHyktjbmA17uSwmr2lrPNVbibx71GdEnw6hzFQA/4rkRaB3QDai0/v73hHp3w2z8/r/7OafrlPUMLD5LH2md+2PkyPzdBmS19Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhgqgzL5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhgqgzL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAD0C2BC9E;
	Wed, 25 Mar 2026 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774432199;
	bh=X1k4Y4EE4YQHMjaQk+NB75V1fsruJnokoLSnoO0Mz44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XhgqgzL50hIGhXpz4uMEVwMJkvcl+Pbi8YextVbKeMJSz5QmWv3qujNvSEcpoewr/
	 nbLcC6FgxuZGMiuVGXrFbHGhFc2yAbic5xrl8p6HcHRUpSIkToAgMWijJ4rUTOKpc8
	 xRrEBXOmBjwcvU+LdPcSbPMk1LEbCVpZ98Q/GGuuWfJxIAQKlZd9iHWrKWmDNOXYS4
	 1wdexkB4HDkdCyOzxPF1CHEr0mVR6+EzSGoijbw5kVcgWZMPpFLYz+NQNOcPl+tFyB
	 fnmRy3/YNIbZLLTgeR1ZpC62SzJrvX0xhzCuxGIJlXiMIIzah0rxtZHdJlOubEA701
	 Yzh2N2i8sRbTQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 25 Mar 2026 09:49:25 +0000
Subject: [PATCH 2/2] dts: riscv: spacemit: k3: Add i2c nodes
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-02-k3-i2c-v1-2-78f29c83d9ac@kernel.org>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
In-Reply-To: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4203; i=dlan@kernel.org;
 h=from:subject:message-id; bh=X1k4Y4EE4YQHMjaQk+NB75V1fsruJnokoLSnoO0Mz44=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpw6+68B4Ynmk/4vmUI5pb9NNMYuq/KGssGHfec
 64a8hi4ZcuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCacOvuhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+16Qg/+J/xjfwMHNZpV14qZa7xQXrQ2098qMROtZsPA1luX24RsYITtn+k+5
 9nJqLfC5knQQnpye97T35CFzkpPAsCpIIG83kOnJMa/OLoCbxpW3KE400ooceT5v31UQKGmBd1a
 QT2DbExx98ybViap9BcShvLrtbv+TjiGIY/mOngjRLkjvTmCSJa/32JkjPMNOdjVqmbdbH9PYVN
 7EWkEK+XOaZ/GUT5XBUYyAY3887WxpD4P6SVxRrocRVPx52hWbQhXdxbnmF0Vj0EF6R8KzmFYBc
 z2JZG5jogqWjEaK4oQ59++Q6Ice7MZrdQfBL/pN48tl6gP70UEexBEAhWjG4jIkYpj/ZYz0WLc6
 O8C8R6f5YULYPiQT9K132JTNnNtyYZLs3L5P2TYH3n0iegaqlHaYwp4YEy6aU0vJEBpcnXyOtGT
 yFQyYSfkT/PiUsj4RYRCQQaQ8XKWJyS4GvEY2cHAmuQhGxbA59G/CZoliUOPQmiJUTfEmTjU4NZ
 ffS3UoLfwlLy8xy5OOrl2o4Q8MvU56rQmnbXBmdRgADDMswDhkfkgY0vvunMK3QRUPqvdsx0KFc
 HoZsIrro70rEy733o0yBngAfE7wT/ytMN1aQ+R7zLyp7LNuThRAZX75cNvKlmSGc1+hCTngO7yy
 Clrp5exweEXT3Th4yaltXgnFAJLjDA=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Populate all I2C devicetree nodes for SpacemiT K3 SoC.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 arch/riscv/boot/dts/spacemit/k3.dtsi | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index a3a8ceddabec..cab72591b7f1 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -438,6 +438,76 @@ soc: soc {
 		dma-noncoherent;
 		ranges;
 
+		i2c0: i2c@d4010800 {
+			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
+			reg = <0x0 0xd4010800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon_apbc CLK_APBC_TWSI0>,
+				 <&syscon_apbc CLK_APBC_TWSI0_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			resets = <&syscon_apbc RESET_APBC_TWSI0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@d4011000 {
+			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
+			reg = <0x0 0xd4011000 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon_apbc CLK_APBC_TWSI1>,
+				 <&syscon_apbc CLK_APBC_TWSI1_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			resets = <&syscon_apbc RESET_APBC_TWSI1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@d4012000 {
+			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
+			reg = <0x0 0xd4012000 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon_apbc CLK_APBC_TWSI2>,
+				 <&syscon_apbc CLK_APBC_TWSI2_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			resets = <&syscon_apbc RESET_APBC_TWSI2>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@d4012800 {
+			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
+			reg = <0x0 0xd4012800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <40 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon_apbc CLK_APBC_TWSI4>,
+				 <&syscon_apbc CLK_APBC_TWSI4_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			resets = <&syscon_apbc RESET_APBC_TWSI4>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@d4013800 {
+			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
+			reg = <0x0 0xd4013800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <41 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon_apbc CLK_APBC_TWSI5>,
+				 <&syscon_apbc CLK_APBC_TWSI5_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			resets = <&syscon_apbc RESET_APBC_TWSI5>;
+			status = "disabled";
+		};
+
 		syscon_apbc: system-controller@d4015000 {
 			compatible = "spacemit,k3-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;
@@ -564,6 +634,20 @@ uart9: serial@d4017800 {
 			status = "disabled";
 		};
 
+		i2c6: i2c@d4018800 {
+			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
+			reg = <0x0 0xd4018800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <70 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon_apbc CLK_APBC_TWSI6>,
+				 <&syscon_apbc CLK_APBC_TWSI6_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			resets = <&syscon_apbc RESET_APBC_TWSI6>;
+			status = "disabled";
+		};
+
 		gpio: gpio@d4019000 {
 			compatible = "spacemit,k3-gpio";
 			reg = <0x0 0xd4019000 0x0 0x100>;
@@ -582,6 +666,20 @@ gpio: gpio@d4019000 {
 				      <&pinctrl 3 0 96 32>;
 		};
 
+		i2c8: i2c@d401d800 {
+			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
+			reg = <0x0 0xd401d800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon_apbc CLK_APBC_TWSI8>,
+				 <&syscon_apbc CLK_APBC_TWSI8_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			resets = <&syscon_apbc RESET_APBC_TWSI8>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@d401e000 {
 			compatible = "spacemit,k3-pinctrl";
 			reg = <0x0 0xd401e000 0x0 0x1000>;

-- 
2.53.0

