Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793935535;
	b=Sj+WIbwZao7f5e2JhANBkzcWExb44LsB7jDHYt9/ZQeGdXt2IgJozv9sirM1x9ruwCic
	 2dvmyKMl5n7Kk49BblO4V45YrJp2n/k6G7kgfPwBjVveBheMMn05ichbOxwo6jIDMUOS8
	 8jllI3tIvde9NsmDCoSxqiURFEokfS7iCKNvJwF93BjN3qKHxMTUi5a8KXH/pem32A5EC
	 XzEOXWwKCBL4PDZbdILfgK1jc3w/Ir9P6xWl9CugxtPPiKQVZyTSeSWfvlYuycNG8U2oB
	 sHuzqu64oPFV2fiDa8BrIJpv7HeSbGz5+7kM4krqrHOaq99O0oFTl5Qaqxi907hLcpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935535;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=UGUXLH1WriYi3S3fHZ4G+RtgsHLbzdQENfqGJ4Ij2M8=;
	b=swYHMkTU/2a0om9RUitVXdiV6o7N/9RNBQWBxUboBUk8z8rp6hvF5ZBZNAmIOvREnyjS
	 XXntrlo3p8NVWzuC7QEvcIX+nR2tySphwyTWChWNDzQ0+GxL1+1m6JVjnX50JMeGeAJNB
	 rMNNpTWzJsv/C0EMxY4wdhrhAnzssPfjxhsb05Mn5EAgCyf1r13RZmN9KX3Dp0+DrF3yp
	 BzrAXlIaK6cQduNtnuf9PWSjt1O2X4YgAK5Yftm9HyeUKDUeHkwwE5F23KDCW9fFo+MKF
	 7Pp7B/zRI2nA4dIkhLlmOmt0qn5qO8O1bOlCNuEtEwOcz6gjt5Ch3OxECdA3QT7ByFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzU9QK71;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB003606A326;
	Fri,  6 Nov 2026 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzU9QK71
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793935534;
	b=Oall/iB4qLeI4mRD/Zp5aPdhXrWVRkNPdsb6tKQS1J1vLbXDso7BxKkuumsp82sQZlx8
	 n5UcKuQgaB6Ji+2mWTyFHvPRkI5mXO3et7/7IltD2JW53ljxWySot+Es6Y0orE2BLFKy5
	 V4Oi0SkLLtkuG+qiI9IDwVRmYluu6uzBeOKZwdDzLOvprEhmEyruWG/SRLeZJKgPsGAbo
	 ZYFJDQ0cwvI13+ZHAJertTrVW8Kvw9ANoQYtyf/bRc+QFdiTCtmycRFxB3qxpxRYwaHjX
	 lcJD+9n6vI6tecAg6UNh0xxHwLEaV4/mG4TeR2naWds0brp9i1NMOWgK/etodTIuh6w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935534;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=UGUXLH1WriYi3S3fHZ4G+RtgsHLbzdQENfqGJ4Ij2M8=;
	b=nyPQR2uvZlXvs+ZWwVDp3usXcwD0J98e9eTs/yhr9Mdy9RFi5DkesymOrLAgnfs47V4Z
	 iMLxZqNAtrYF1GLWKZvPM19K0iSkC2Onv7bMOESqblJ+g+FhuvJ4e9kweeyZ8JQQLbiOJ
	 YS5YNqiKFN9PtOSdT4PqUyxy/Jas8cIT4jueAWwXX67B1dFEaXTVqCIe/bv6Ghb5fxIHA
	 YmaR3cxgfucqqfCQjaBvODH8D+prb/Re7+jrAr0TLIsbmdyNuWR7MLGrOxWoqRcphSABQ
	 dqO6lcdW7Fi/5I9YrcoyBF4mBKwQ3/jePRad8CO9l0iqD2k/I7HUHrP8gFgZQJeOrmg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 28D4E1F008A2;
	Fri,  6 Nov 2026 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935534;
	bh=UGUXLH1WriYi3S3fHZ4G+RtgsHLbzdQENfqGJ4Ij2M8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GzU9QK71AlaYTzjyjJyYRcKBnkxMo1OZ+54aqyIMfEasKnEK9x14DnKpPXG+0dQjU
	 RnmtKCWjIbhWckJirQc4NXIdqMi09HK1TJ9Fu8jG8kzqfwIYmV0kX9Ky8XGOUJPMxh
	 IWDUSch24Bwl7wtloxL8RGaIPMAesrsmqcxgg4DFo7umVERMwdG0mcQWNWb9tQiK8Y
	 BrQzGGaKW0HNElUr4zBggVvyRIi6FI6U69G5F383xC1uTvdVaijci3h43lYRmF/ckJ
	 Yw+uFiaVo0GT/SgtwWc6KWOr/BbEECP2R9wa2VBv2oBKLzqouadusTBBmVwb6Z+uU4
	 34A9vAn+FwLOA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 789DD45B8A;
	Fri,  6 Nov 2026 03:25:32 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Subject: [PATCH v2 0/5] media: qcom: camss: Add SM8150 CAMSS support
Date: Fri, 06 Nov 2026 03:24:51 +0000
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dkhbQMSV9zAsxnaAmlBMB6uG9
 O4CHsDlS95/fxFMwRGLc7aIQNGxm/wK+pAJM6DvCZxdWWipj0rJEng8qUpCrPMSglFgcGQGW1h
 bkdSoainW7SNQ595799r+mJ+3O5l5i23G4Hiewmc/jmrz/n1EBRJqbKqixAa17i7obaBX73rym
 FuKok0pfQFJ665r0wAAAA==
X-Change-ID: 20261104-sm8150-v7.4-rc1-camss-d3dd5e02a170
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Andrew Gigena <mail@andrewgigena.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793935531; l=3089;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=qLVJbZNBqU02j9nDuuDniRv57jjqg5cA/kA8QxuVntM=;
 b=PYcC/EQh4zF8hn21EmdBlq17VpmgZQ2Cy3YQKqECxFxBxwEjdcRuRJvErOXRfOiPgGiLpqDCP
 3JJI6lxH6/GD/K7zuBWszqJYI4oiPWM9cN2uUitJrhKPBqzDL8LrtwQ
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
platform data and hooks the SoC into the existing Gen2 CSIPHY, Gen2
CSID and VFE 17x code paths. No new register programming sequences are
introduced.

The series documents the SM8150 CCI compatible, which the CCI nodes use
with qcom,msm8996-cci as the fallback. The patches are ordered bindings
first, then driver data, then the DT description. The series is
intentionally SoC-level only: it does not add a board DTS, camera
sensor drivers, or board-specific camera wiring.

Testing: with a local Pixel 4 (google-flame) board port and
out-of-tree IMX363, IMX481 and IMX520 sensor drivers, the rear wide
(IMX363) and rear tele (IMX481) cameras stream, and the front (IMX520)
path has produced frames. The board port itself is not part of this
series.

checkpatch reports no errors. The only warning is the new-binding
"MAINTAINERS needs updating" prompt, which is a false positive because
the existing CAMSS entry already covers qcom,*camss* bindings.

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
Andrew Gigena (5):
      dt-bindings: i2c: qcom-cci: Document SM8150 compatible
      dt-bindings: media: qcom,sm8150-camss: Add SM8150 CAMSS
      media: qcom: camss: Match VFE lite clocks by name prefix
      media: qcom: camss: Add support for SM8150
      arm64: dts: qcom: sm8150: Add CAMSS and CCI nodes

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/media/qcom,sm8150-camss.yaml          | 412 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 320 ++++++++++++++++
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.c      |   3 +
 drivers/media/platform/qcom/camss/camss.c          | 267 +++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 7 files changed, 1007 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-sm8150-v7.4-rc1-camss-d3dd5e02a170

Best regards,
--  
Andrew Gigena <mail@andrewgigena.dev>


