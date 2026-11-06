Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793935541;
	b=Cq+IONJGG+af916s50LZlhI6/s83sOh8aS09pEFpBV/OsAoNsChNbp4UGwDtmG/Sywxx
	 ezfUjnHKDRCRCvG/UGO3C8m5MI1XEOk1Gx3Kh8+wu4NmeRS0hB7L5Yd5WkUFxD7qnszhA
	 MqZujo9LWafhmehAhFISEod+f7Ql76PIiBvnWLSWYfuiolmDCMhcv/q77e4Ciw4PZDoQc
	 4igvnbSyLlxc1zmTych9xpRxZTgjzxNOSb48Rby1heUYarcQsUmFmeyFiZ4Tz2Rfk/4ce
	 lzNtD/LbbvJUd+tjB6QxvTFOzKtHEX+5mrMXgSl5nMTSCWIo+SLRfO88NOzbSxFE4RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935541;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YEq03Ma2RWRxBrKge2VYXi0I/KTbXWcD4AK6bpkqPhw=;
	b=UTxl2c4ftqf7jBZZ5Bf6EE6dZB0QEZOq9aGNww77V9evb/RXzN7UoQnrjHub0JZ/JvUB
	 Q8g+uIfQTXoa8obZUdvl6Rp0/ERHvgSCWBTMGUUh0hs3UDABCbmAfsUNvSskwsLqAIBDo
	 CZ7/aUbyGDRAvASZQDYWpfmwW055ce78f/VAfw8wPllidCox3w7/RX+FPxES+tF/oS5/w
	 eMytInAg2HjSNfXsg4XzS/RjDDgJ471U0f0FL/mKne30rhZ3F+vtWtum7WnVkym+iXMYz
	 3emgmqbGQGOPxQrlWG+jNtbpvwdIYeCZu3xA0F2IDdRnq2U29w+EyLEflp3+/e6zh9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVEwD1Mq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B8606A32D;
	Fri,  6 Nov 2026 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVEwD1Mq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793935534;
	b=XuuX3+iHaV89K18LC96tk9zBqt3z2vmVK0rmcmC6QPnIcNiR029/o9YzWhIGeWzWtRTb
	 wc29EylPx6P1XPwGwKkWCvAS4Dt1p+6iCH/ExHE5V4DPs4eUNDwaUKKoZ36lRqyAqvdMH
	 4K48PDtRB8ozNHPZGwX6w4zEyept4FcyFpkH3po41vhLpo2lfhKvNRlBLkDZ8itqPOMRo
	 FWAqvkTiNgNXtvJzZ7VaEpE0WRCmPE+UXGbX4Trf5BZzcRsAj61i9RZTbVNhC7mx6VTr7
	 r+KyqmONOXONOKfqzWNw7tuediF6zRDE64xtxv96YAECyRkIVy3EIiJkdUIvOILE1Ew==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935534;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YEq03Ma2RWRxBrKge2VYXi0I/KTbXWcD4AK6bpkqPhw=;
	b=z9elkvbFOaFOPp3dBOR2X5OOtfoiQSt4U6pfzRHOgtjEWaQ8Ac8JwyOiI55S9/7D6gDt
	 j0qM+jC9P2txvLffZGgqj+C8jmBLM2k5FxFbr0EB8zZC19IRI82/Xhq4UasOI/mLEIeiZ
	 1FBI/a5O5H/7Qd7YIWxWxmRHLqukHmjAxijF9mPaJyyhIt0jXVjp03fUZK9pD5uYXU9K0
	 Kuv9oR9xJW+b1Q6bbo5FUCwuIaSuZa35qt/wGehQ6n2MF8Mzlgj8Z7JDYjKk9G9NZ1Qno
	 sc7AH0BZutJ0rUbE4LVLe+SsnrHG2KfavoYDJDL2KFnN7sWiS6fHvmAUDYgBA+QybEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 28CF41F008A1;
	Fri,  6 Nov 2026 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935534;
	bh=YEq03Ma2RWRxBrKge2VYXi0I/KTbXWcD4AK6bpkqPhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AVEwD1MqfC/U2WvRjelxQsD/JoXNJ23dxBfdX0tVXZJwBXBrtXA9UrYB7eryyD4WP
	 GANu9RjeZb6cL5q5zOxt76RHzkWPWz7k5iAnkeZxQUvnwv7pJg0KwMwkfitXfm1yea
	 0A3H6d0xdqEVs/hDwe8dpWnt23dxVqbNFOwO36A3XVYhpBimlX4Tx32bktOpveBb0j
	 AiMdPeFJSxXdlnRFdACpBDwkGZapyFmEOjVmgsthGdDj669pxMxTsX3Xvn+2S+r0fQ
	 Gr/8ZyZDimAwdfBDMlmN+EeermeV+vQavH0RWtnlCjnrfsQwYKx3JmI+FLaZXdmVsv
	 bTMSxTlkusR6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8FE3945B7A;
	Fri,  6 Nov 2026 03:25:32 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 03:24:52 +0000
Subject: [PATCH v2 1/5] dt-bindings: i2c: qcom-cci: Document SM8150
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v2-1-39ee37787b00@andrewgigena.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793935531; l=1044;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=sa4H+sId6xjwTKga9V2ilYs1U4cIetnjPZQJfvPUFeM=;
 b=zKSBOehskHj8OCCfbZWVn/cYD5BlWB0dn8wN4oS57cGNV0bVlKjCgwg8PLDrx3yGpjagItAce
 58dtYbm8R/IA3K39QgxQfB/j3KfOrb5oiaIsYSw0IjSX3tKSrfwRWzh
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


