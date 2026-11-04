Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833541;
	b=jV4nvPMGFciKXL1p47Qozps6TbTPI6AuIyNvEgVbQV0ADwzNzwn8OEf4qPDrYls0Uk8g
	 RP3uqPIblpoiYeZI1vl+m103pFVnVug08fItKVuR678K8pdd4+8MVO1s7e5HZeGyCrO8X
	 BSqumwvONxkSzKFqd+cbXshSflLu2f0tQ9VkLJWuaXIVKM/SwMbr8RpgcvPj+KTeHOfLR
	 MS4DoUut7cAwHfn6JC3R9DVwiBVsNNXX9IZi69n81FgVbvMZU14BzXEPszVKGLshLltAN
	 s+ggHB9JFroeFi2j5jjeUaA4MKizrIbfW0o82QgDdj9GIZxglQ+culzvi2PkX7NLz6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vRAb5C4LgsfKN4WR17ntGx2TTB2a/3ZahumEshj4Tcw=;
	b=4ynxyvUrODpfuD82DI+85kloU+7z0o+I4Al8Z5X8Fz1DkQYX4rl+s8AXWLgezGeBhIKh
	 QSGcYT47OatWE9eICHC4ep6QfuRH9wMd85Cmd9yW+WuDeV0FZ9MfxtJqz37dPCd5fkmvg
	 pWnPerhZbVRjCDgPDHKnPNps8AjsgpdF02IO4ma3GULN3V1h1Dw5rjL0KYVGuzDHRd4ls
	 CHjuYQRc4o6mXkAw2zfbokJd2/jploIKPMI1CzGB1ooexdXiBiBNhau3/zLsoDZmqG1VJ
	 2/Q4Et6gItCkEorSkxN0CjOUmAbfp8bCj2VH51ss+BGIo7BN0Q/vX5lOHXvecctqQYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l8GMNwn/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF645606A333;
	Wed,  4 Nov 2026 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8GMNwn/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1E81F00919;
	Wed,  4 Nov 2026 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833540;
	bh=vRAb5C4LgsfKN4WR17ntGx2TTB2a/3ZahumEshj4Tcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l8GMNwn/Jpi9quR6ywZmkgQDS00tonzszGOlKDK/rqbb0ubzp7Q/tAv6kom4eCy2/
	 IT0dztYtkbFaTvruMnCRPrX9N3E34tPgdsYoRhPpcQffudHEKOMst390wgej1rQmRF
	 CXz8jDsHkbIlSMm2oEZrOHZrfGfL481JmUPII5BJ6IrvXNx9b9rr35tkS5EsWk214u
	 cI3u+vw6VUtEPPX9tz8Fy84pr0ZaYDiuqcKd5+IEbNl4/UIGMNQ+Jfdf2oHx7ALTCm
	 xpu799XFQPB3r7I6vKKG11tf3u1XxkXWocf6URZq0nIB09yavuDOgjIHIuNAP+/rpe
	 MZaTNONR5Hwag==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: i2c: qcom-cci: Document SM8350 compatible
Date: Thu,  5 Nov 2026 01:05:27 +0200
Message-ID: <20261104230529.3040285-2-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261104230529.3040285-1-vz@kernel.org>
References: <20261104230529.3040285-1-vz@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Qualcomm SM8350 SoC compatible to the CCI device tree bindings,
SM8350 CCI is compatible with CCI v2 found on MSM8996.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 1e8def25ec0e..63083e0bdd9c 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -40,6 +40,7 @@ properties:
               - qcom,sm6150-cci
               - qcom,sm6350-cci
               - qcom,sm8250-cci
+              - qcom,sm8350-cci
               - qcom,sm8450-cci
               - qcom,sm8550-cci
               - qcom,sm8650-cci
@@ -219,6 +220,7 @@ allOf:
             enum:
               - qcom,sc7280-cci
               - qcom,sm8250-cci
+              - qcom,sm8350-cci
               - qcom,sm8450-cci
     then:
       properties:
-- 
2.51.0

