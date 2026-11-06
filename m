Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990199;
	b=oxT9M08eGc/uqgdU4oB/11V7yjkYqOYnYyTgN3pTr1CQBpQhobhHkN5XY00TAPFzoFZd
	 b2niQ95mXomoZuk4Zhqh7yufpeVKORdOilHels8qdf+bNyqVWjh9WYbX1PvzISLIJ/1Ji
	 fS3kOrpQdMG170NF1yyOIakHU94GMVv6e22hVdCOvRnFfI4u0Fg5zkrW9vl3AhOKccirs
	 Rr6ASzUpu05Lli00EEdA+H7+oFPKUeaQRutey5nFA/v+eWrrdx86vMUcT/WTPzoVQjGbb
	 v2r5goe+bXuPPXZLuNmdrbkxesesw1SN6GpxCSW0qL8JvufARPaHl2m1Kyz+W2bMTJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990199;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ctcEZ6a9ns7YHknubQjF7OevDKpWpr2m6oZDDAn2eh4=;
	b=jclkzLUvE4m1U1zAi7V+ZtfS/LSTBFac800DwN5EnWLqWx4i+xknvPr6JkvUK71rKTBM
	 cvfb0fqRsuBQH0uYFeyh+IOoF62HCNmrTen9f8/AV1VzZ5mjdGrnkPWp3Y3X4Nv+d4Xve
	 Z7a9uqSjIY5bpX6GdwJfIYT8SYho82EouSNWj01NlxJ5zUB2ILwMH5Yd49yvWEoBpvKwI
	 yqbiaeGIUUSKQhruyii4QTm3FlSHcmyHbO4nSB0h9FDCYtcAf6fpRP6Ct7dMfq0Q4rBng
	 r61zS8dRXbN+7sezg0hd/iGmJBG37ASyBKbeeGD2boV25hNt2umpQCmgGKcUSDNWJTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/k9mSlw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE78606A326;
	Fri,  6 Nov 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/k9mSlw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793990199;
	b=tXBsJgY9QvEXjgC9mZ1oqGwSlI+y72oaom4PN/BJY/xOYFIx3cBeL5wZiTbYYYoma5Ra
	 xN0YlWae8kr4+1BQSqTKdjjjOi+Pzjqlx4wTffIN427D18yr5loDprYMfRCDCPm53YfVN
	 RjLg8NoWsmYbwOfIWW1j4osgfRwmewhGrpHcHAqbuouk1yaSEh/7qkdUFa6IYAll1e8SI
	 CHGihSSiwWPo8aSnHaj6wNVKKbv7B1gdNQNgQXanBquN01cECD10n59J0QPI08csz1aHX
	 l6ahw3Qt9i06hq10vlV5/fz00sXSfEycKc2cd74hV3KDZL+P0M5yjkg5kln8jN8eI8w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990199;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ctcEZ6a9ns7YHknubQjF7OevDKpWpr2m6oZDDAn2eh4=;
	b=vdGVdVJ5JTC6L9hs6m8zRhVLozeBRpbY5ALGEFAAd+tNjfQeq3phdzvW1b8/QhOdcU+0
	 OwJupksT1UO0BsioEZYHby0TOYNFtYrSxpPSlGP4yzV9IaXel7N4nRv5t4CjV+XX41I7Q
	 MnrLsHxKwRVDuWE+lJpmUdLSh5IGUNWqHwU4G0JfV+8Cjr2x5U0PsbX1j3dolwILnh1JH
	 qAuaeRZoOv7PNWjPDNho2AicfK/HttXs2tDOuggcjS1k4YWh2HOrMyKP7sy4gm0CP0PYH
	 xq7gSAg5CR4TTlVAU/99D5oH3m4Wmg2pgiWlhnINaBMH857BnwUQOW96LqNxThsGfMw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C727D1F008A4;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990199;
	bh=ctcEZ6a9ns7YHknubQjF7OevDKpWpr2m6oZDDAn2eh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=J/k9mSlwP4hSYZbvLzAP+h6oNoyZPOKWihxOytxj4qPc8doXB32kV94YgNNscClP2
	 3Kv5LZLxDCrO6A8svDNghrDcI2Dkga5+OiSBCp7XXfkgmdWL4GKaM/1wVCqAhtoCwY
	 Xq5JOIVptT28lnlgQSqMf3vDDREE20DCPdDrPOyB7hO1JcBkuYQbyFCKhWty/vXR7D
	 XsIXW8rIt2ddnG6aW7c7ikJXlqOnm2P1N5PfABGa42amsVio9zE1z21qYUoFegmQGZ
	 XF/fce3TWpUiJtGF4pHz016wG6qCh8nxcUl4kIj6KWwlM9/XT+qHIA5+hksjdeeLuQ
	 ug7RidFENmK1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4F5A94781D;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 18:35:36 +0000
Subject: [PATCH v3 4/7] media: qcom: camss: Match VFE lite clocks by name
 prefix
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v3-4-0103e8a0bbcd@andrewgigena.dev>
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
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
 Andrew Gigena <mail@andrewgigena.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793990195; l=2177;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=RKXBqJzp5jx1oO13mVy3JGt1LTgj4JwjvJ23lzdf2Vg=;
 b=pYp3wGGx24nx3RQs/uM68jjw91qjhA54KzVks5zInjKDvgsrjRK40Pq5jZGxUGXkWe0RqKT4s
 kFoiJZYWW+9DN1jzG0xNruH04CTSWPOBKwBxb5v1kw7COZqtwWWOPJE
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev
Content-Transfer-Encoding: 7bit

From: Andrew Gigena <mail@andrewgigena.dev>

vfe_match_clock_names() builds the expected lite clock name from
vfe->id, but vfe->id is the index of the VFE in the resources array.
On SoCs where the lite VFEs come after the full VFEs, the generated
name is vfe_lite2, vfe_lite3, ... and never matches the actual
vfe_lite0/vfe_lite1 clocks, so their rates are never programmed.

Restrict the new prefix match to numbered "vfe_liteN" clocks (digit
check) to avoid matching aux clocks, leaving the pre-existing
vfe_lite_name and bare "vfe_lite" matches unchanged.

This affects SM8150, SC7280 and SC8280XP. On a Pixel 4 (SM8150),
streaming through VFE-lite0 left cam_cc_ife_lite_0_clk at 19.2 MHz and
failed with "VFE reset timeout".

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 2680a9914765..29e04d097116 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -9,6 +9,7 @@
  */
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/ctype.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/mutex.h>
@@ -346,6 +347,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_6350:
 	case CAMSS_7280:
 	case CAMSS_8x96:
+	case CAMSS_8150:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
 	case CAMSS_8300:
@@ -914,6 +916,9 @@ static int vfe_match_clock_names(struct vfe_device *vfe,
 	return (!strcmp(clock->name, vfe_name) ||
 		!strcmp(clock->name, vfe_lite_name) ||
 		!strcmp(clock->name, "vfe_lite") ||
+		(vfe->res->is_lite &&
+		 !strncmp(clock->name, "vfe_lite", 8) &&
+		 isdigit((unsigned char)clock->name[8])) ||
 		!strcmp(clock->name, "camnoc_axi") ||
 		!strcmp(clock->name, "camnoc_rt_axi"));
 }
@@ -2006,6 +2011,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
 	case CAMSS_6150:
 	case CAMSS_6350:
 	case CAMSS_7280:
+	case CAMSS_8150:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
 	case CAMSS_8300:

-- 
2.56.0


