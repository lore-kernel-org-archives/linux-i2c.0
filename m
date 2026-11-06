Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793935536;
	b=pIGI2P0Omt/vwiWv7kGUWhdZsDrNPrWFWmySxqHRkVIJKg9wQ2HlH/bcWXdvUg67X1p4
	 MncT0wNODsrLWfIje+bQBqPPAKujxLYVQdmE3b1yU6uEX+UwoT0s9lh9UAHBnA0wW0t6L
	 v701eCkZj43ZNNJranT1g1HBTm6TvgBotoThcnmp08mf7BSTBL9D60UqIJgSBI91MTisv
	 7Ux9/USkpjQYQ/8RDZhJn4xViM5lFkgLLRyg0shn23nv4PY7e0c7MI4tNXsl6aY45gVmG
	 Y+JummrftqQdX5R2XJDNSwAa5kyt9xFOvqS6vbkAdwsI+wxxPAUU2CTgVbjPf4pEhsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935536;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fCkBGL/Ry4JoxzlNGD0aPTm3KjBz2wUEWPGGytJX+1s=;
	b=jaKDZbiUrg+WakowjXyrpo49kOq8wDRjs1IUWkucf+PQV4aN7OGvfNTtXcoPBT5Q4Kb/
	 tRsw0RpGJZ0aKDnAbOf3iEAGYgVsPjRmucR28X+In3xPjwLkOyAPQzZltBX9ze23ERiO5
	 wh4P6eHta6LJCwTJUV7fS7CI69e8FiO+/0+kc0bamTGkScjsThnNB9g3T7nvmQP1AGy0n
	 laYMQacO9SoNW25cYZtYbfCaDanmzCNsxbhxmoKEsdjrcuuZIuiQiW8NQE+yhUTSi5LE5
	 Vh4xHqoFkxPVYi4FEpFT1mZHhLlGMuWJWHRIxEtqAAafPlQuVl3EjpfCPnT00Pj0HwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmCnkCPb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B056606A33A;
	Fri,  6 Nov 2026 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmCnkCPb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793935535;
	b=G+jcd0RPEvwmOr3N2Q5PA6hTAgMZw7XGGB1NHGIJprP70kyu+A7P7jK683ptZolZBEsb
	 LmRa8NoMPyFEVU+LETWSj8zp1qBrcPZcMzSTHEzng7GM0sSLwvfvjIdYaT6A1gasxCoV0
	 vBIA8NX3R0rkjoIeA51ikszqPS9PvOQ2mJCT7mxyu8F9yf7ZQLD3Cu4WBPdiI6Fbt8VQ4
	 bcuuXzafj1nw5QIAi24BlonCPzGqJn5fym0h7vJ50MRUkW1hSnznbAihIQGZKLduzMi/Z
	 h6JwZvY3wmmwNWjudHtJYFT/IgQ6Xn98QT/B9MA1nxapMoikF1bfmvg8lAvVi51j9Vw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935535;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fCkBGL/Ry4JoxzlNGD0aPTm3KjBz2wUEWPGGytJX+1s=;
	b=qEJwfuQfCLOs9XnEPhhyIhFYtdIu70Y+BNt4PyEXoIglWxHLCsmaffvSbTwfJCy65Lm/
	 K52QMvorteejJCDgV2P7XG3addL3mZ7Q1KdaBz85uKzawKCvwKaximTRxo5bm5sPOgrHX
	 bRnf7I9rpeSEqGnOLxJFwj6Gw/KnUL6kbRFQ+OvIjKed92dKZ5sCeT7FEWBiv8d1Ya5RE
	 9IIeugnbf00cQ+oMqIatfR7aQbJlRJPzE4GG7yBEADbZ8EGpwU4gOmm8e2S3aYwQD3D1E
	 RBn0zBNW0h1feb52errTtG/J3HV4gKnNdLpWON6v2KUm1StayM1MO+VWtS+diiAky9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 44C081F008A4;
	Fri,  6 Nov 2026 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935535;
	bh=fCkBGL/Ry4JoxzlNGD0aPTm3KjBz2wUEWPGGytJX+1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bmCnkCPbdK1sTbwXj4l7g3sFo9cI2mAJo8zHcZXUxLOojjQ/n668z3q4Dn2EsZ7jF
	 V/Ti7Nk1MjJxJjraTTD2o+8A98MRttWyGQXB8Mw+1QV5VQuXlNZkX1Z1VgEChzrAjM
	 I05fNOlO0tb79h9xljhX3dQqCDaYm5m3yCWN9xSPtXzbLiF5F8rwC2557ha11IhkqR
	 n1R02GBtM6PLOt1qxeJ6POllcldd8E3+kymhIVcw5BoErgxGiFQqaPw8UtYk6lo3T9
	 p7QODhN5IvmhXcSdZUo9mmfsA5tgrSZm7BN7pwt+xA9JpnsrvEsDNoCkiqqZTii0Uu
	 +As9Kk0fd5AKw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BD16C45B96;
	Fri,  6 Nov 2026 03:25:32 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 03:24:55 +0000
Subject: [PATCH v2 4/5] media: qcom: camss: Add support for SM8150
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v2-4-39ee37787b00@andrewgigena.dev>
References: <20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793935531; l=11048;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=pJhd7Fln5I9LUAnCmRIaQqU5Ch2OcIMkZJ7Ekz+456Y=;
 b=Nfis3ym1amazdKubNMGqYWklZymNHy1Z+EwTi0MD8Su/vd3HT/GRp9F7bXZfxxeoY9fzo0mI1
 6IFCgI2VUEaAxQXh8PaTBpyqVWSasMIxO2SyfYpEmFr9qslWiWjroax
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev
Content-Transfer-Encoding: 7bit

From: Andrew Gigena <mail@andrewgigena.dev>

Add CAMSS platform data for the Qualcomm SM8150 SoC. The camera
subsystem contains four CSIPHY, four CSID (two full and two lite), two
VFE and two VFE-Lite instances.

The hardware reuses the existing 3-phase 1.0 CSIPHY, Gen2 CSID and
VFE 17x implementations; the CSIPHY uses the SC8280XP lane register
layout. Add CAMSS_8150 to the version enum and to the shared code
paths, then add the per-block clock, regulator, power domain,
interrupt and interconnect resources.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
 drivers/media/platform/qcom/camss/camss.c          | 267 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 4 files changed, 272 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index dac8d2ecf799..5e7c2e67ae88 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -1133,6 +1133,7 @@ static bool csiphy_is_gen2(u32 version)
 	case CAMSS_6150:
 	case CAMSS_6350:
 	case CAMSS_7280:
+	case CAMSS_8150:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
 	case CAMSS_8300:
@@ -1235,6 +1236,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
 		regs->lane_regs = &lane_regs_sm8250[0];
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_sm8250);
 		break;
+	case CAMSS_8150:
 	case CAMSS_8280XP:
 		regs->lane_regs = &lane_regs_sc8280xp[0];
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_sc8280xp);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 9866ac09eefd..62b23bb2cb2b 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -346,6 +346,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_6350:
 	case CAMSS_7280:
 	case CAMSS_8x96:
+	case CAMSS_8150:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
 	case CAMSS_8300:
@@ -2007,6 +2008,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
 	case CAMSS_6150:
 	case CAMSS_6350:
 	case CAMSS_7280:
+	case CAMSS_8150:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
 	case CAMSS_8300:
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c54185c93a8a..b45a34d2229d 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1940,6 +1940,259 @@ static const struct resources_icc icc_res_sm6350[] = {
 	},
 };
 
+static const struct camss_subdev_resources csiphy_res_sm8150[] = {
+	/* CSIPHY0 */
+	{
+		.regulators = {
+			{ .supply = "vdda-phy", .init_load_uA = 17500 },
+			{ .supply = "vdda-pll", .init_load_uA = 10000 }
+		},
+		.clock = { "csiphy0", "csiphy0_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy0" },
+		.interrupt = { "csiphy0" },
+		.csiphy = {
+			.id = 0,
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		}
+	},
+	/* CSIPHY1 */
+	{
+		.regulators = {
+			{ .supply = "vdda-phy", .init_load_uA = 17500 },
+			{ .supply = "vdda-pll", .init_load_uA = 10000 }
+		},
+		.clock = { "csiphy1", "csiphy1_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy1" },
+		.interrupt = { "csiphy1" },
+		.csiphy = {
+			.id = 1,
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		}
+	},
+	/* CSIPHY2 */
+	{
+		.regulators = {
+			{ .supply = "vdda-phy", .init_load_uA = 17500 },
+			{ .supply = "vdda-pll", .init_load_uA = 10000 }
+		},
+		.clock = { "csiphy2", "csiphy2_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy2" },
+		.interrupt = { "csiphy2" },
+		.csiphy = {
+			.id = 2,
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		}
+	},
+	/* CSIPHY3 */
+	{
+		.regulators = {
+			{ .supply = "vdda-phy", .init_load_uA = 17500 },
+			{ .supply = "vdda-pll", .init_load_uA = 10000 }
+		},
+		.clock = { "csiphy3", "csiphy3_timer" },
+		.clock_rate = { { 400000000 },
+				{ 300000000 } },
+		.reg = { "csiphy3" },
+		.interrupt = { "csiphy3" },
+		.csiphy = {
+			.id = 3,
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		}
+	},
+};
+
+static const struct camss_subdev_resources csid_res_sm8150[] = {
+	/* CSID0 */
+	{
+		.regulators = {},
+		.clock = { "vfe0_csid", "vfe0_cphy_rx", "vfe0", "vfe0_axi" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid0" },
+		.interrupt = { "csid0" },
+		.csid = {
+			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID1 */
+	{
+		.regulators = {},
+		.clock = { "vfe1_csid", "vfe1_cphy_rx", "vfe1", "vfe1_axi" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid1" },
+		.interrupt = { "csid1" },
+		.csid = {
+			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID_LITE0 */
+	{
+		.regulators = {},
+		.clock = { "vfe_lite0_csid", "vfe_lite0_cphy_rx", "vfe_lite0" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 }, },
+		.reg = { "csid_lite0" },
+		.interrupt = { "csid_lite0" },
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID_LITE1 */
+	{
+		.regulators = {},
+		.clock = { "vfe_lite1_csid", "vfe_lite1_cphy_rx", "vfe_lite1" },
+		.clock_rate = { { 400000000, 480000000, 600000000 },
+				{ 0 },
+				{ 0 }, },
+		.reg = { "csid_lite1" },
+		.interrupt = { "csid_lite1" },
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.formats = &csid_formats_gen2
+		}
+	}
+};
+
+/*
+ * cpas_ahb is left at the CAMCC default 80 MHz; it is not matched by
+ * vfe_match_clock_names(). The VFE/VFE-Lite rates are set from the
+ * remaining clock-rate tables.
+ */
+static const struct camss_subdev_resources vfe_res_sm8150[] = {
+	/* VFE0 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi",
+			   "vfe0", "vfe0_axi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 400000000, 558000000, 637000000, 847000000, 950000000 },
+				{ 0 }, },
+		.reg = { "vfe0" },
+		.interrupt = { "vfe0" },
+		.vfe = {
+			.line_num = 4,
+			.is_lite = false,
+			.has_pd = true,
+			.pd_name = "ife0",
+			.hw_ops = &vfe_ops_170,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE1 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi",
+			   "vfe1", "vfe1_axi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 400000000, 558000000, 637000000, 847000000, 950000000 },
+				{ 0 }, },
+		.reg = { "vfe1" },
+		.interrupt = { "vfe1" },
+		.vfe = {
+			.line_num = 4,
+			.is_lite = false,
+			.has_pd = true,
+			.pd_name = "ife1",
+			.hw_ops = &vfe_ops_170,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE_LITE_0 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite0" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 320000000, 400000000, 480000000, 600000000 }, },
+		.reg = { "vfe_lite0" },
+		.interrupt = { "vfe_lite0" },
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_170,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE_LITE_1 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe_lite1" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
+				{ 320000000, 400000000, 480000000, 600000000 }, },
+		.reg = { "vfe_lite1" },
+		.interrupt = { "vfe_lite1" },
+		.vfe = {
+			.is_lite = true,
+			.line_num = 4,
+			.hw_ops = &vfe_ops_170,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	}
+};
+
+static const struct resources_icc icc_res_sm8150[] = {
+	{
+		.name = "cam_ahb",
+		.icc_bw_tbl.avg = 38400,
+		.icc_bw_tbl.peak = 76800,
+	},
+	{
+		.name = "cam_hf_0_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+	{
+		.name = "cam_hf_1_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+	{
+		.name = "cam_sf_0_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+};
+
 static const struct camss_subdev_resources csiphy_res_8250[] = {
 	/* CSIPHY0 */
 	{
@@ -5725,6 +5978,19 @@ static const struct camss_resources sm6350_resources = {
 	.vfe_num = ARRAY_SIZE(vfe_res_sm6350),
 };
 
+static const struct camss_resources sm8150_resources = {
+	.version = CAMSS_8150,
+	.pd_name = "top",
+	.csiphy_res = csiphy_res_sm8150,
+	.csid_res = csid_res_sm8150,
+	.vfe_res = vfe_res_sm8150,
+	.icc_res = icc_res_sm8150,
+	.icc_path_num = ARRAY_SIZE(icc_res_sm8150),
+	.csiphy_num = ARRAY_SIZE(csiphy_res_sm8150),
+	.csid_num = ARRAY_SIZE(csid_res_sm8150),
+	.vfe_num = ARRAY_SIZE(vfe_res_sm8150),
+};
+
 static const struct camss_resources sm8250_resources = {
 	.version = CAMSS_8250,
 	.pd_name = "top",
@@ -5824,6 +6090,7 @@ static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
 	{ .compatible = "qcom,sm6150-camss", .data = &sm6150_resources },
 	{ .compatible = "qcom,sm6350-camss", .data = &sm6350_resources },
+	{ .compatible = "qcom,sm8150-camss", .data = &sm8150_resources },
 	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
 	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
 	{ .compatible = "qcom,sm8650-camss", .data = &sm8650_resources },
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 7dc2fd9f03e0..74d8cc2921be 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -89,6 +89,7 @@ enum camss_version {
 	CAMSS_8x39,
 	CAMSS_8x53,
 	CAMSS_8x96,
+	CAMSS_8150,
 	CAMSS_8250,
 	CAMSS_8280XP,
 	CAMSS_8300,

-- 
2.56.0


