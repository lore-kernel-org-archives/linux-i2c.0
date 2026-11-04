Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793825662;
	b=UAkQk/gxQu7Die7PTGsqF0PjqKh1kZUDQ0dZU36EUedKhEcl8b1U17cAGqFDHPekV1bZ
	 H43sfrbTRl2HG9bQ0CNL+XjTDr6smpBNMS1HWh2hmUvERTi80NBOEqOnLk9v8+gWKalKe
	 BIzBwM7N4VJQv7ZAgpZLOiPk8uRvGFGE3z1h1nBu82TYd7S2nNJKnC7zM4fEUh0ZcDj5d
	 qFgu72ON85Cl9Df7Y6E5tJ0jRdGo5nBNTTrtQfSsVIUBx5tpjU22t5PpZ2YVBql8oT54A
	 WuHev1oq3C4gytp41mnr7J7BS9ZVqnZhemLZBw3k/fqSaeY1ECGJSuu6ebCKQp6roUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825662;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0spVq1KfEjBelIQmBdQYHBFemwr7GfRtl30xj3cCpBw=;
	b=IloJ/63xuZFBzLJYS7mCGDr9Cz4q5UGkAafrU1h3Eg1uAXyA+2HCxEMXCYBj8S3fzhZ5
	 mqhWrwskLIJygDhdj9a+v3ag01GkOTE3S/coYspKdpyN2Fl0laY3i0Zbrp+/RJpP7yMAc
	 F5gjSp5LmLsBh7Bka1AzMmUUB6a+IISkUpltUHmtC7NVWr51XQLThLzpQN7DqmvdXNPsA
	 iFvXRz5yUw6ZkY8HZsvtLlRwjR1k5CotdbbAV0VOiCQ8/YicYVFJIV9Po/Q7TDxx7wqar
	 E9Wh0/56FUWhUztCvEpry8y3BPFB5g40mI+j68+9bJc0TtTq89drc1srE89WBFJc3lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOvstBtt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE8607845F;
	Wed,  4 Nov 2026 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOvstBtt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793825661;
	b=1Dn82NlnC63jTOfihaO7KEsJcgn1X2gn+LhndpCP/8owixV3mmKXHa+1TmWBBJMVvCCn
	 /rqGDA9lfvxB2NNa9aAtjQMnET9Q/BnseCzYfzSvGnKLIxukFSjf/XC4GOcToGJ2UPgPP
	 DWXMJxABTzrzBcv4GLCmbSv1hZRe787BpoUp4vhNDhXd0DYnwOnXIGIfCJTbbHaEItrcg
	 QOccb7+JFhUA9WN+iU8n9+y6Y5Y1qjV3otis/QmuF0cvaio+yf2uQn1UGZ7IfINRH4QPW
	 YVFgdiKZhBReN3UW5UGa1/8gLXRghU2+e+Of+nQ1GyhIvynlVJm95Gido/r4ibZtoPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793825661;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0spVq1KfEjBelIQmBdQYHBFemwr7GfRtl30xj3cCpBw=;
	b=vGr/CxZ88e/m+pidt4NC55+CeyEM7DgBYiPKEsgU8aVHqWSaX9nSNgCbHEq8bt4klZoy
	 y0lgsK+svdn2/Yw/EpqsLKzFDDapzZWpFZIPbBUs4/S/0FRwZBM8X8MH8JmpUI0Bm6hRb
	 tkqm9SIaGA+7RRHoQCqlRxiUx040xQPNf0OKKYGkV94E0rokZGexmt7R1/ticJTF9M5cR
	 Hq1XRYP1DDGWWP5LIsalQcqxfV8WBRhMpuVvDrEHq7sQHzgYCq16LwXumawgf1NYgZvll
	 yJzJwKoBqll4GX2+yl7p/LFKV8RjaneN0sgrFsS2yf0PTMdRyWX5vXJpT5QL7TD3+2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A13951F00A15;
	Wed,  4 Nov 2026 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825661;
	bh=0spVq1KfEjBelIQmBdQYHBFemwr7GfRtl30xj3cCpBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MOvstBtt0wOVtJoRdFMGYoTxt4E1IHRON1qFLwFjYBnPJAQx/mknzDieQL5xgYsjn
	 hQESrcpTi5VEoXpGmpgtobG1QKFiHUSOO0WETWaVMPpHzhGls9vYKQwYCV1VbU0k6t
	 Zh94qUhQ9unPUTDbacR4IIxBwcmYbvHJt8afLmT+vXGtS+uhSBH5OORZa0jy/cYA4l
	 V9IJwVZq4drXnlBY7MTkuDeDqY+O3o/YnfE88lTm0J3KBX6/W5uh52m6C/45mxCpaC
	 Br9OLSt/vo3GBbTX/pOqOjRSDlDivPWeVxRnoCd5XLcEAmdgNHbG9HjA10Gt/3Z6M1
	 Um+dLo+0kfX1w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2DCFF46F8C;
	Wed,  4 Nov 2026 20:54:20 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Wed, 04 Nov 2026 20:54:14 +0000
Subject: [PATCH 1/4] dt-bindings: i2c: qcom-cci: Document SM8150 compatible
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
Message-Id: <20261104-sm8150-v7-4-rc1-camss-v1-1-7a9534a9a22f@andrewgigena.dev>
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
In-Reply-To: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793825658; l=824;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=XVSLS9H6xwSBH2lGXYB71v3KO52SQ4m6el0XgpZLD1k=;
 b=Z915qNsq3qCvxOBE7gkhR7XJf/ioLSll1yK9FC+POQEjF9HH38j/ZL/3XvZmMy3EqAWQRS3Sq
 vBZ0NOuYh+8D+nx8hRof2+J7yfsHzCJI4BizwxBUV+DJJAxS5hMabsH
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
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 1e8def25ec0e..b545fd2378da 100644
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

-- 
2.56.0


