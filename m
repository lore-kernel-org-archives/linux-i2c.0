Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BA371CEC
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994220; cv=none; b=HzBYXRxry+zA2TjSA5UH3wVYr+osKLuOSqVFdi26DoQxKPa1yeDHyYOiiyQoccSI9b4WNAJmP1LtF8P1HRzrjc8xgTF8C5SFurSG0EUhzH8dmS11DpmKUGLdVhgGNbRo/DBrxfHllYyNktmA8b2klN/9CfApL6/YFxgPPM8tkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994220; c=relaxed/simple;
	bh=6dtGZbRSVFWRCcAZr6CS/BmuG6zhDBUqyFHzgT0ZE3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4QV+kZF+Fu7I0GUjr4FANxpJefWjHE7pK+EXfpUdbaQqfBAfT5szYshjC0vhIHO2OlFNgrBQp6DkcLxC4f7uaeqnTOHojYFoEuEgDM3UNKuKWOVMFrCmhXztMAqrxg8EojFHhQI3o0Bl1Gz7rKEHsa61RUwAXIAjDhnZFYFahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ITfFca0f; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ITfFca0f"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9793fa5371so211506866b.2
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1773994217; x=1774599017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BxUoG301RPYcoM5PiwD0xgoq1X+VWOiiJLhYwNLDCc=;
        b=ITfFca0fryZbQjsoaTVOK5meLa/1wyj8MwO9rvKvfZrCOQS6sl9PS5SoYfEp1fRVEi
         pWCPlBEbm0r216kPMJMhniYrPyJoDMFAJOqyq/x5fSn4M3BaBwnxmqKUWQgM6mdsbAmM
         n3X6URMeb2XP8DlbqvlweBy2OvcxUOnEVJEY/UXbohO4J4csTcUK79T41/UJxH6rZRQ3
         OVlCWxqzpfZ0Ok5m++t8JYCEo3MicFy1PZxUCwzh9YSGFRX58uRDETglxHxMtIuLJObK
         z+498bW6aCa2LN7CifNagbdg9w1R00pixxhAnWmHB6wjRM3XexMaqG6pQZ7eMgcPzvkn
         xKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994217; x=1774599017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5BxUoG301RPYcoM5PiwD0xgoq1X+VWOiiJLhYwNLDCc=;
        b=KHsYoChowS+cn04n/hMMn1xjKm4+tczD46tQ78QXuTg1AEqknoVDm9UhBRFmxQhB5m
         74m40KU0BdhQCpmqD9/wLm1fmIOCrKwsu7UG+3zHhhOdTJit33T+RBLejTNKHjanOYjI
         K3IP0/uQov/LMeLJ5/nq7Kv56UA22mf0yJE0asnOHxdS4fe3f2PpDs2ePDZ57SbNxViq
         MDYBerjkdXnXCRzwQfGjYmgTjUlzMyD1qXtvZr2zR2+aTqhDAe7COqA75Vr9z2LFlIrd
         1fVEys4QWL0nc48d49T8IGATOpnRzw/NwFNzxv5PzCM6zqRT24uXsTBVwruFpqQwsC76
         mTUA==
X-Forwarded-Encrypted: i=1; AJvYcCV7HGmcwG05d+SyIGwmNRIavHilSdnxJCevzX3ntJqhrUMAqdpTKD5bu35g/fzjaaT3Mt4lvs70LV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoiYtGevHY/9NGzIS4gRJcb/2E7Osf5J/+l+mqEpyjYJpmZ6J
	bgB6Lgehl1gQPDHL2UbGoFXnfl8CCPdmERo1f5NvZu2OKB//bH+vBY96/ybkAWQ2zfw=
X-Gm-Gg: ATEYQzxfu7IrtfcbXO5rgiYQp/FzCbT1kqF1v6QxZtU/ybcwz2zplRq1oBnGSJB+0tH
	kXBA8UvYJ8dWGG8ujFnBCMTyivpAbKGodyDuZAq8EHHLzI/fk+oMpI9vybP83ak852w26LrFYXx
	Q79l11owsei2wwbKsTNfZq5ZN9t55JiAtEyn45CYhuThYLU/f/q+F6WLe8ap6Vvi9heFXRzrMQX
	iThzA/MS7N10xJzaGtTXirDS5mbs0Jc43uj5KaSHOaX/5jBjxJZD4vHKcqjEDl1Mgf02g5SUpG9
	3Jw2n3965fWlkMKCm9nSvqJpxEgCFzY2wjIgdo0LxFwIrxDbFKGnYiZHCZtLPJEbLQWScjixsv1
	ecA6G81S9N4LSrPIHJjuvz90qQMJI7mqpZJONnicLxr7chFviEgNcZ03DctgYNNYFA9ZuoC6elK
	MbWPRgZBw5+v0OjKCYwUUgJz6SS/DGhv2c+hv7B4gjmME37qxwcYPY9+8e/S/rxEak+LWJAwA8m
	0txIQ==
X-Received: by 2002:a17:907:a191:b0:b8e:fe3c:2255 with SMTP id a640c23a62f3a-b982f0a94f0mr106385166b.5.1773994216560;
        Fri, 20 Mar 2026 01:10:16 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43b5csm121016466b.1.2026.03.20.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 01:10:16 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Mar 2026 09:09:49 +0100
Subject: [PATCH v2 1/3] dt-bindings: i2c: qcom-cci: Document Milos
 compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-milos-cci-v2-1-1947fc83f756@fairphone.com>
References: <20260320-milos-cci-v2-0-1947fc83f756@fairphone.com>
In-Reply-To: <20260320-milos-cci-v2-0-1947fc83f756@fairphone.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773994215; l=1353;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=6dtGZbRSVFWRCcAZr6CS/BmuG6zhDBUqyFHzgT0ZE3M=;
 b=HSxUaO9sCaviuTGLssmZ8jeEeOxakzeYqv1aIQWxIlpi2X6V7G8CHUAT2UYx1zXBV/IKgZDFH
 LJnoayH07leAU4f1eWpCQ+/7SY+3bIxZ7xRBhwiaAHwfs31WCyV7avd
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add Milos compatible for the CAMSS CCI interfaces.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 399a09409e07..816c1a48edd3 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - qcom,kaanapali-cci
+              - qcom,milos-cci
               - qcom,qcm2290-cci
               - qcom,qcs8300-cci
               - qcom,sa8775p-cci
@@ -265,6 +266,23 @@ allOf:
             - const: cpas_ahb
             - const: cci
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,milos-cci
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: soc_ahb
+            - const: cpas_ahb
+            - const: cci
+
 additionalProperties: false
 
 examples:

-- 
2.53.0

