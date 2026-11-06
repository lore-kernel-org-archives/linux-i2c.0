Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990199;
	b=FoMAUi1zEa0+wZvl+369nlkGPlpf7qmGpZQD/Wq2Fz9/jkgE2tFaD8ot1TOojwRnfM5H
	 34eS3JXSFbz3ofJHTN8u/I9e8/wKY0a7PqhcuwiZVuypYMFJDg/cAVbvMobh6gtWi6jkU
	 6jy6ln11NZGEy3jCoc7IppnKROilBI2UrXGGmnj8TEeiMmzBbPX3WKpylRL95Qmd5moE3
	 4I0v/QGdGuNw9B6h6y19LX3sdIGG3LocKmvcgDeLEzY43UvVIkoPNj0OfK3RlMIeEYjT0
	 G115QbVz5uOMWXCpJWAWEKCgC7weirVqSszXmDuwiWAlQHeu8lQpVTS/H9lUYwHYjDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990199;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bxEDg/6uv6KvrjforzjxYgizKhspeJzA9yZhl63ubF8=;
	b=SuFjMOSFQz+9xzBgvRjtVylCKZsBBzuArYySrPK0NhuTBsY234rR7Lx9e1cPTdfxDg6z
	 ySYZfV/bmUTRso9DY6GG3aJFqM2nk9x4VdDqvCwxDap1MJfuOTvzTb6PF96pGNZwn6edn
	 QdeW7taLB4owaGtI4xf3SSoxdeu2YbKV3gr3LVRLut5pWRFyS8dgD3CjRE0GM/b8YLKnG
	 0cxdMR5ILNPAvpD/7jhKgsEnyEno0a1PygMdgR+2CBmXS9D0KmuySnVPkPRSzNgzFfrsc
	 6L2v0yGQq1bdnDOIEV5z6bdH1xnqY/LdjcMbVA0IbRsUT9q2BlAko6ToQjkwAXpytzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoSuu267;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3671606A329;
	Fri,  6 Nov 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoSuu267
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793990198;
	b=vXcPfdKhGehF4k4INYBYV7FjI64qzs2hwmjlyQb3ebmbNX87gqDgV7Tsb4x+v3ufnglo
	 2wRtiY+9kd6QNbOFRqfECmlFY+euMaVXmoTxmnn+4KdZdhAt9igDWWVoTXSQTFBfKOEzn
	 z+y67767gnqgrwv4/ALZiIjWMl/ArtjODLCMInESRSECm2VTOe3Xd2iSxu5s1MH8u5Nc5
	 xPdZ9u7XYAE4WaMPPd6A/+YxoKtK+k+4x2YWLA1ewqtnyny0WfzQ025sN4ZWms2J6XT2s
	 zMatY0XMjwV4O4IZ5s7turZTTgcEujpBhB22QhLHTy6iIKapkOQsAWz8zPMAdD5B7Cw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990198;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bxEDg/6uv6KvrjforzjxYgizKhspeJzA9yZhl63ubF8=;
	b=DVzhW72VAt3iSmKANgXUHoLxkyIhxD2R8QvfPtZscix6jas27/j6a6Z3CX2JZ0qXa/J/
	 R/8RrsYaUEMTUV1mB078rgvbewghp2dx65XQK2Uz94ObhsZQTAGzrP2gCLj82IsK7x3O8
	 86v9gSjd55iTF8aMBifLd6MZQGmjNEn+hpmvve5JCL4Tp1w2svrRGfWUiksJks5Ss+LTb
	 3itzBWH83/Z2khwAzeyYaJz2YeSKpMBVCPgCTtOoI/+SZYUM0Qw0cEqy+QQ6wRo47XsqL
	 U4ySE9TVFMeul7A8VNRjQZhDZUZT7lwUTNabqGIsoAjb79IgJx8Z49w8CicIPrfr/hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AD3AE1F008A1;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990198;
	bh=bxEDg/6uv6KvrjforzjxYgizKhspeJzA9yZhl63ubF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NoSuu267wYzQwsPu5qu93S6WluWrtIxj6uKFmmDx4RC46kAaRD4RG8+MfgD4o2HEa
	 b7wdTN3j6JKTEReZ7x9OAT1LKgxMq/5kcvgc4uWogYBms6U9f/DxpWkTHyM8MzRPze
	 NA4nIPj96SMmRghApurgVVuAf5hLtZaKDoYXanzGNd7EZhiU0ILukV73QJRGdZ8/hF
	 +gYcWK7MLNRfs1dR+Yn72LGHE/tmZ7VTHqX4mnUhbSFKyKUjxMPAw8xIP0ZI7+L9Rl
	 3X+4Np9w2lp4vO09CxIZ+jk6n/QMZwk6A080SEhz5CDTCvrmj7gZIlGe798WzCJYqD
	 w1ohcvlBMfmlA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1F79C45E3F;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 18:35:33 +0000
Subject: [PATCH v3 1/7] dt-bindings: i2c: qcom-cci: Document SM8150
 compatible
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v3-1-0103e8a0bbcd@andrewgigena.dev>
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
 Andrew Gigena <mail@andrewgigena.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793990195; l=1117;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=BOMUc49jkRpvHI7pH0yM1r2cOIOm5BH9Tmbbjx7uHKQ=;
 b=Zg7HdmgXglhlQfa6xWtHr8kw+NywDUDBxeoDowYbBv55cKCKnTzo2cuwpHcUkyrcFCogo5kck
 ed07u25+VzMA1dQf5SFrq7w2/XSyArRsEBHu2RHcnBY3bqQ4O4JnFSz
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev
Content-Transfer-Encoding: 7bit

From: Andrew Gigena <mail@andrewgigena.dev>

Add qcom,sm8150-cci as a CCI v2 compatible, with qcom,msm8996-cci as
the fallback.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 1e8def25ec0e..1e7a8efaa398 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,shikra-cci
               - qcom,sm6150-cci
               - qcom,sm6350-cci
+              - qcom,sm8150-cci
               - qcom,sm8250-cci
               - qcom,sm8450-cci
               - qcom,sm8550-cci
@@ -218,6 +219,7 @@ allOf:
           contains:
             enum:
               - qcom,sc7280-cci
+              - qcom,sm8150-cci
               - qcom,sm8250-cci
               - qcom,sm8450-cci
     then:

-- 
2.56.0


