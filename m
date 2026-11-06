Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793935534;
	b=rYCDnhHApiCcGvq9xhXn8AnKqihp+6+OSxZYMhMiM4rMXHGr74nkHET44fqIHbzXZezl
	 RLvof4eYs1DxyRLim3jR7iYFyS8ShfOFSIR2wovUx0AKOnA3/Ofm1ljMMV+lmS39yIK30
	 hEabPHogs09PN+6WHyq6d41LjdvCm8+fATv93YlhHSkWVrEG1VDiqYurD81yUhSHmZf9L
	 30SWtcdFxZSD+ukLNBWFRdYO0BN83rs0GJS+abbA7aiR1YUiBhz+bJ6WdmXq3LOurc7TP
	 QnEZeSotxpR003Jm7r/p8m0V1vJTD1H1nOv2brDRbLWpmV08RSHKS7TgfK+57/MkciQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935534;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4FAtyZ6cutU5gi2YegQDVpl3eipKNh1GuYURLgtFckE=;
	b=naCusciG1uLdQrw3x1SjF6nVKM9uRCgOcKdT8t6YwA4qpo6Xh0wVJEbI227Eln4lamSn
	 KgK+bGtu8u6ZvxZ3IU71p/YwQQE7ToMrFb4shpDjpz2sLxUz6aN1NzYJOCSPPZwvm7fwt
	 C3+hLCk39QChQfJqtKrtvTQ6h5KS6k31SSkou7SKsVhxz3Mtxd+GO9sjxisHv3BCsdFF6
	 7/V6pX4bP41ViLfBreXvMjip07/jnwGKIwZIYZYBqrKh4CEeFO4r2E8MG4CSZqaIUfYZR
	 DblrtLlAbOmllDEneplOFRaSWCLbvATZIOJ1njOcdWQ6b2jQCXDOqLOKYE+2MFbLwxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isyGNlY7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548E606A329;
	Fri,  6 Nov 2026 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isyGNlY7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793935533;
	b=upS72JLRva6R3g/rYdZ+oxsUs7O7x4m/E2TAc48JwXST6BkTnFN6bha8+sLnMIZH+Whs
	 LTd5Hru0pM8h/d9NjADO/YkLOoUGIv6yldkZ/w3L3mru9zCtnAbRVPnYpigzMEbW2hKYU
	 Cchmjn0rV3UYQYlpw2Q37yrLO9pmU3mOw9RVESQD9NDCVOGlf7WPO88IYOL5FhOJWvwqR
	 o1ooCjN9kGonONEkRArvhr4ULwm/+VMdq/so8MA2O24EVVeVcvQRLwLn/0pkhKY2RDE7v
	 yXqwBWyka7Yhb2ToZ44PCF3x1gKxAoj1yPc8XOuPSYred3FED35+vqMBtWaVAfUfDrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935533;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4FAtyZ6cutU5gi2YegQDVpl3eipKNh1GuYURLgtFckE=;
	b=Wh7RRu8tJCkcvIHg0GzSX+JHKU3gSwd7MoreajekX1IV9NPzvYfOpI1aofRMG3fAEwjC
	 /pV0Ddl2YSjnoBvPsOFsPFzxaSx6Gt4VXGtyEpRoF9JYwKSxdpA+kRFUCGLulcC0RACnl
	 YqN4dSDpR3A0eClID2s5KgeRuXHOUBkF1bOK4ewVbEwH8/K8eemgxz5zpO6TaRCCgILaQ
	 r3ZXRy0lXPMFYa2uEI1at0tThPiGfE6/ODmnRByvF/4wQK/Kow2rAsy7V8u6AxsKSMG/7
	 gUnSHFUQBdVzcGpi8KnCwyc7P+sCublfEnFjvsJfTjKpAN43dH3X5H/k4Ck4erchnZg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 31FCB1F008A3;
	Fri,  6 Nov 2026 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935533;
	bh=4FAtyZ6cutU5gi2YegQDVpl3eipKNh1GuYURLgtFckE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=isyGNlY7KOSY2sFcsv/BaK1827bzwgKcXCoaacLKdx2A+aLViDMNfvf4geW98Q2V7
	 dl0oQMI1DRfM10OFqZNbx0nPdFOM+jPCoDxqUY0/oFTNj5IAaT2qtVDz1t0GG5cbFI
	 s5NcjpqxdhNMa5k8gsUttPqZT4oaDomBpPeFBJ/3ma90obpMK6KkkJDtfcYUM5zkz/
	 wVEyDP+pNTbtYVSMG+7qnTkY9Dof/VHcHjct2DgcqcfiFin8x38mog9g8CuBnRht9u
	 AX9nEDEgL0HCOsSGXPOX0B+75BQZb49dcqwSAIA3ToL80smUGnbqbRNbyOHavm5QJn
	 l7S9jZW5NbulQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF13445B92;
	Fri,  6 Nov 2026 03:25:32 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 03:24:54 +0000
Subject: [PATCH v2 3/5] media: qcom: camss: Match VFE lite clocks by name
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v2-3-39ee37787b00@andrewgigena.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793935531; l=1422;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=2iraXBb5zNtm/r+ImYDkshzAf5Ek9NUXiemEdTIIU6Q=;
 b=LTtcKd0GgAp9XbWN+VH8CNJQKE6a/Mh1li3LvFsoa+Rw8EwOlPtbH+gEXH8PTiXfvlNNw3JdU
 15P1RDicxrSDXb/66oMyY2IbHMK+LdgpJw1cw0IbWNmmPGzKohhGUFt
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

This affects SM8150, SC7280 and SC8280XP. On a Pixel 4 (SM8150),
streaming through VFE-lite0 left cam_cc_ife_lite_0_clk at 19.2 MHz and
failed with "VFE reset timeout".

Match any clock whose name starts with "vfe_lite" when the VFE is a
lite instance, in addition to the existing exact matches.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 2680a9914765..9866ac09eefd 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -914,6 +914,7 @@ static int vfe_match_clock_names(struct vfe_device *vfe,
 	return (!strcmp(clock->name, vfe_name) ||
 		!strcmp(clock->name, vfe_lite_name) ||
 		!strcmp(clock->name, "vfe_lite") ||
+		(vfe->res->is_lite && !strncmp(clock->name, "vfe_lite", 8)) ||
 		!strcmp(clock->name, "camnoc_axi") ||
 		!strcmp(clock->name, "camnoc_rt_axi"));
 }

-- 
2.56.0


