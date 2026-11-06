Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990199;
	b=zHzkx7Dk/ojzUXibCbSIz/q0AimjUPGU8m/jj2uQGxSwolP2/S5re8flm8yggCXKP2w9
	 5hMOqxMVbo61n4gcMPh7qAZTwrlxVJpYC9vq1DLsS/KjV8kPONCK97X2JBaIdWrhW0Yu3
	 KecTgObLuVXomProqhAKiIHYSbZTUbo9pxgfQjdZOexHlBjqvjNjskQxnqxu1gFstcBrc
	 WrkdTJBbXKtk/vauh07yopjlBF5w2sbrZ0p5rY82lSW7nXA5ae8MPgh5Kjm/qYsum4s2D
	 pyTk8w2ADzGNp0pFuuZ1fO4qxUQ2oCeTkJEYkLd7U/ujWY7P3zyxOniuZId16qiqbHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990199;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=trCShAN2Aq+u9nvEju3DZ2+XKEVQIl0HoXTDcK3/du4=;
	b=U/V+3OMJZYA9x5LR4SMO8xGOzhWl6zAUz/nJIzyQgK9GqFX8opcEO0MBqGDoT3pYcYV2
	 BkxqmGf6dXbQpJtLA0DfhnVQ/OBazJ20ctbeOcqeEuLmni+40U7JC8CaBrAXUiFtLM/20
	 BFcbMzOAMIVbVi0ajEdHejILODqvaM/54O3gLJHfNBM2CrwwM4qCNiAij6+gVJp/GQkJJ
	 GwT0Uz0P629+TMLv57CwpLt3d/VIHnpytU7BMOiigbcUGkIcSrVfZ0a+uljc3NIK4fnTf
	 gJ3FQjygE1ooaJEqqqUCfdLHms5thc1MaTZqN6ZcZcJwDL8iK9cfZudRbkbWYiicWvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY9kHeVM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371D606A32C;
	Fri,  6 Nov 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY9kHeVM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793990198;
	b=qh9Yi8EmZ4M+YgU3tACyXNo2wLFAf6dLFmhpcbcTcKD0Fv5+3De4mY9qaaTH5KEMa4eR
	 nUulP4jDtNYte/wC6eny2Pc9TXoqkFHLN1TUZ8/N4cmO70W8G3SGD8yVxwxfGOw0yp+/k
	 ZamM8XkdlQZXDDrVAK8UUN8gTozaKJy9dTLRtkJqBDPF0HrQ7hE3/MBqQn0rc6TRLpB5h
	 b+6kBJNQr2SBmcRhLq1SppDcIOMzqdlW9wC+fMOPcJc0SeWG3eTsrXY+JI6M/FOXBZTGw
	 UNM7sQk2NL5AFeEI76pDg3C3GrQoHCsQ7vrM1tpv06/RGSi3vJKI5FHZ9t5wWqjGR2A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990198;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=trCShAN2Aq+u9nvEju3DZ2+XKEVQIl0HoXTDcK3/du4=;
	b=ZJc12AMfvK5asqGZtu2rBIpXdbXaxD5eHEb58k69UjYMRXB0Kv5iIBYXj9SPiAeblRDa
	 5gAF/LlI7mcAIcm5YOfvI1Np2ngC5PSCart1gZQOt9VNRCLgbJ3C4B+7Pdi/eKDCZ51E9
	 Baz9JnBc0tZJthe7yIKBYH6wwsNcGTmxxJ1JTRCIE0Q0rI7CGo0BnP7g4w25w0MK9kcul
	 HlimvC9daBWtCLj73s3LQ/hvGTwPxND0fkvOtZfGCTNe5itGZz8y3prUymwurrXwMNVoE
	 tAP1YF8ZvYJ6g7tVpulUlexGYC/wxktf1RcqxJv25vrAfBInJ0JSmBGyKfBZK32SkQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AD3991F0089F;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990198;
	bh=trCShAN2Aq+u9nvEju3DZ2+XKEVQIl0HoXTDcK3/du4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=IY9kHeVMQAYIzY6S9B8wQ3XJvyNC5JXCWJoheIlrTk00qxL/dpTywK9IvgfZ1MzxG
	 iQh68/rlQOSbTzP1+DhTpJrnAfT4rERCFUeOkT41nEjFxm3+lwYtEGbABmLx6kIPbC
	 YNeAlM+lES/DKGeq3glBNyne7z7uJzr87LsmXT6v+R1keIr8lAV+P1Y4beyog2M8cz
	 1+H4bBFCAu+AiSMP9taBz8x4RUXpvm8ES77A8WSpBQangbGOp9zv8gOkJ7YKWHAaDP
	 ZUa1kl+TwEioJmgXwbbo8MvVPodQa7w4zTBa4P36SZVSJWL70sR1nKqHpfqROoT8uH
	 YOVYxI+yrySPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0946E47016;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Subject: [PATCH v3 0/7] media: qcom: camss: Add SM8150 CAMSS support
Date: Fri, 06 Nov 2026 18:35:32 +0000
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzQ6CMBAGX4X07JL+AAVPvofxUOgCNQFMi1VDe
 HdbvHDA4yTfzuxCHFqDjpyThVj0xplpDCBOCWl6NXYIRgcmnPKCMZqBG0qWU/AyzcA2DBo1OAd
 aaJ0j5YpJSsLtw2Jr3pv3evuxe9Z3bOYoi4veuHmyny3sWdwdNGDf8AwoSFXlIlOV4ry9qFFbf
 HWmw1GlGj2JKc/3suLPw54HmagQhZSlrCk9kK3r+gUaJPuWIAEAAA==
X-Change-ID: 20261104-sm8150-v7.4-rc1-camss-d3dd5e02a170
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
 Andrew Gigena <mail@andrewgigena.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793990195; l=5223;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=82w+gBOiHNZipuQ9Fpb3q+R7M29hG4hLN0t/RXBVzlI=;
 b=u/T0mjyls0ehcm82r7sEtXQAIREEeuflk4Fif2/Bt9mHv/iPjNQSe0cE8M/igKC0w1JS2JLSy
 p9r3bgKEcfnAnqh+5iVnk4j7rl5aA43nLKbXgDXoSxBEjGj62VW/gTN
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev

This series adds SoC-level CAMSS support for the Qualcomm SM8150
(Snapdragon 855), based on v7.4-rc1.

SM8150 contains four CSIPHY, four CSID (two full and two lite), two
VFE and two VFE-Lite instances. The blocks are close to the existing
SDM845/SM8250/SC8280XP implementations, so the driver change only adds
platform data and hooks the SoC into the existing Gen2 CSID and
VFE 17x code paths.

As requested in the v2 review, the CSIPHY I/O spaces, clocks,
interrupts and supplies are excluded from the CAMSS container device
and instead described by four qcom,sm8150-csi2-phy nodes driven by the
dedicated CSI2 PHY driver. Each PHY node feeds one CAMSS CSI input
port and is fed by the core and timer clocks, the vdda-phy and
vdda-pll supplies, and the Titan top power domain. No new register
programming sequences are introduced: the PHY driver reuses the
existing SC8280XP lane register table.

The series documents the SM8150 CCI compatible, which the CCI nodes use
with qcom,msm8996-cci as the fallback. The patches are ordered bindings
first, then driver data, then the DT description. The series is
intentionally SoC-level only: it does not add a board DTS, camera
sensor drivers, or board-specific camera wiring.

Testing: with a local Pixel 4 (google-flame) board port and
out-of-tree sensor drivers, the rear wide (IMX363), rear tele
(IMX481), front (IMX520) and IR (dual OV7251, patched driver)
cameras stream. The board port itself is not part of this series.

checkpatch reports no errors. The only warning is the new-binding
"MAINTAINERS needs updating" prompt, which is a false positive because
the existing CAMSS entry already covers qcom,*camss* bindings.
dt_binding_check passes for qcom,sm8150-camss.yaml and
qcom,sm8150-csi2-phy.yaml, and the new PHY/CAMSS drivers and DTS build.

Changes in v3:
- Switch to the new CSI2 PHY driver (Vladimir's v2 review request):
  new qcom,sm8150-csi2-phy binding + driver, four phy@ nodes linked to
  CAMSS CSI ports. CAMSS keeps only VFE/CSID resources (19 clocks,
  8 IRQs). Timer pinned to 300 MHz (SM8150 timer only supports
  19.2/300 MHz).
- Fix VFE lite clock match: restrict prefix match to numbered
  "vfe_liteN" clocks to avoid matching aux clocks.
- Binding/DTS cleanup: patternProperties for ports, reg/reg-names after
  compatible, sorted required list, redundant minItems dropped, aligned
  example (lowercase hex, wrapped interconnects, isp@ name), ports
  required, remote-endpoint in example, cam_hf_1_mnoc last, SDA/SCL
  pinctrl comments, remote-only SoC endpoints (Glymur pattern).
- Order SM8150 before X1E80100 in PHY driver (7 nm predates 4 nm).
- The new CSI2 PHY driver does not support DPHY split mode, so the
  Pixel 4 follower OV7251 (one of the two sensors sharing CSIPHY1) is
  disabled in this series. A separate patchset adding split-mode support
  to mainline OV7251 driver is planned.
- Link to v2: https://patch.msgid.link/20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev

Changes in v2:
- Address the review comments from Sashiko, Bryan and Val.
- Drop the internal CAMCC *_src clocks from the binding, the example and
  the DTS; the binding now lists 27 clocks instead of 42.
- Remove clock-lanes from the CSI endpoints and use an unnumbered
  endpoint in the example, matching the other CAMSS bindings.
- Describe vdda-phy-supply as 0.88V and vdda-pll-supply as 1.2V.
- Move the CSIPHY supplies from the CSID resources to the CSIPHY
  resources, so they are enabled before the PHY is accessed.
- Add a separate fix for the VFE lite clock rates
- Tidy the CAMSS_8150 switch ordering.
- Link to v1: https://patch.msgid.link/20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
Andrew Gigena (7):
      dt-bindings: i2c: qcom-cci: Document SM8150 compatible
      dt-bindings: media: qcom,sm8150-camss: Add SM8150 CAMSS
      dt-bindings: phy: qcom,sm8150-csi2-phy: Add SM8150 CSI2 PHY
      media: qcom: camss: Match VFE lite clocks by name prefix
      media: qcom: camss: Add support for SM8150
      phy: qcom-mipi-csi2: Add SM8150 CSI2 DPHY support
      arm64: dts: qcom: sm8150: Add CAMSS and CCI nodes

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/media/qcom,sm8150-camss.yaml          | 285 ++++++++++++
 .../bindings/phy/qcom,sm8150-csi2-phy.yaml         | 163 +++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 488 +++++++++++++++++++++
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.c      |   6 +
 drivers/media/platform/qcom/camss/camss.c          | 231 ++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c |  97 ++++
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c     |  16 +-
 drivers/phy/qualcomm/phy-qcom-mipi-csi2.h          |   4 +
 11 files changed, 1294 insertions(+), 1 deletion(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-sm8150-v7.4-rc1-camss-d3dd5e02a170

Best regards,
--  
Andrew Gigena <mail@andrewgigena.dev>


