Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7D3A7F52;
	Thu,  5 Mar 2026 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721622; cv=none; b=W7pKLuE2D4TOe2Mm9Bfd22250LiEANB/RNaMN+Kr3Uo2qVhBZit9K3TvKZ7VBYL/HEnClcsl7ESbBu6HHA8wA+OEnPmmeobMJ+AhQAt8jttxg8e6GnVsb6ihXduqr0yv55BhTEK3rUQc0OM9Vygw4ddWxMMVnVGrdb2uoTiVXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721622; c=relaxed/simple;
	bh=xIKKatc20Q77KL2XOGln4Usht1nkpIZO/UE1oAYA5mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NF2VFfQzRI4L1CbFAB1Q07O/HJ0jQHkr4IfWq5P2reFJ9BJ7Qsh76RaSalEuCrTg1uHsFjxx2KRAhGsRpVKw8pBfHsy1TAjVRZkg6DOeMMAP3vboK9h4XGMZCa3Gp0CZLLax6VHTzdcmrMXAyHNZRHFw5YpE2V9PAdpAzZl4bAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlXrV+dk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlXrV+dk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7761AC19423;
	Thu,  5 Mar 2026 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772721622;
	bh=xIKKatc20Q77KL2XOGln4Usht1nkpIZO/UE1oAYA5mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qlXrV+dkr1IFkGIewStKdIuU5zACj6NPthdJ4/1fYpCS6+CrHibwC2wHfypcwuoyC
	 AkLJrMlXROiwXDtiGKqqxRj99v5Wps5CDth3DJ+RIKeeOIneEUnMzCMQL1YghCJgAc
	 hP0gyOEcs7nUMg/WrNBCSjxTipLchyIwj9KvTOksSrDzTWq4ybuDJvyVxLOuShukRl
	 UsjiHogu9AKGNnxirmoaMxVR6dLYhp2KqdLn+niO/jPOL6su7XgjH7Mli92N34SE3/
	 sNlu4qN6OIxXXECeJhkDVbTPdo6zceNEAI4j+ATSsRf8mkb31VoSdj+YN0SsOndmxD
	 2SmM/Z+RQQRpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6603BF33A77;
	Thu,  5 Mar 2026 14:40:22 +0000 (UTC)
From: Cory Keitz via B4 Relay <devnull+ckeitz.amazon.com@kernel.org>
Date: Thu, 05 Mar 2026 14:40:12 +0000
Subject: [PATCH 1/2] dt-bindings: i2c: qcom-cci: Document
 qcom,scl-stretch-enable property
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-cci-scl-stretch-v1-1-8412abc65745@amazon.com>
References: <20260305-cci-scl-stretch-v1-0-8412abc65745@amazon.com>
In-Reply-To: <20260305-cci-scl-stretch-v1-0-8412abc65745@amazon.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cory Keitz <ckeitz@amazon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772721621; l=1216;
 i=ckeitz@amazon.com; s=20260304; h=from:subject:message-id;
 bh=SEC34wu+SscLbukgX+vbjxvf9VZq9+C1PossueU0r34=;
 b=VA1yx/Bl2YXmKzeNq7V/WvDBPSwJw04soOHIVsHHluEbIUS+vB1Tdtukh57FFBTQQao/bYNbT
 ZjzXBxDbpGhCgvGZdPYTylW8bxeBhUJwBA0qPMDy004tT5q5DjlY6TX
X-Developer-Key: i=ckeitz@amazon.com; a=ed25519;
 pk=IWSPbPI9mzOdPU5zG2ROe/O75E4ckVxuBLNJVYVZCag=
X-Endpoint-Received: by B4 Relay for ckeitz@amazon.com/20260304 with
 auth_id=662
X-Original-From: Cory Keitz <ckeitz@amazon.com>
Reply-To: ckeitz@amazon.com

From: Cory Keitz <ckeitz@amazon.com>

Add the optional boolean property "qcom,scl-stretch-enable" to the
CCI i2c-bus sub-nodes. This property enables SCL clock stretching on
the corresponding CCI master, which is needed by peripherals such as
GMSL deserializers that hold SCL low to absorb forwarding latency.

Signed-off-by: Cory Keitz <ckeitz@amazon.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 399a09409e07..fea609fa2f05 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -78,6 +78,14 @@ patternProperties:
       clock-frequency:
         default: 100000
 
+      qcom,scl-stretch-enable:
+        type: boolean
+        description:
+          Enable SCL clock stretching on this CCI master. When set, the
+          CCI hardware will assert the SCL stretch enable bit in the
+          MISC_CTL register, allowing peripherals to hold SCL low to
+          throttle the bus.
+
 required:
   - compatible
   - clock-names

-- 
2.47.3


