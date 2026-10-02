Received: from mail-ed2-f23.google.com (mail-ed2-f23.google.com [74.125.228.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943448875F
	for <linux-i2c@vger.kernel.org>; Fri,  2 Oct 2026 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951753; cv=none; b=Dxq6LgYp7A6okwt9RtUjTQrIEyfFpz7DBXReUofEfBDtsGCC/r33o+5bjvCO2/dBsKMbYbB6S616HhFeH51nksQSWw/ubEKeS629Jf1EZswW+LDXy2ibqOJ0UL7FKZGJcz0FB+jbXiyIOCcAAdIuOQLW0mL0T6Kt7/DxJWPqPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951753; c=relaxed/simple;
	bh=sEskR/3ExQTLHI71NqLlpzs/JE6M5OOwwHG9YZNTZAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qrfr+VR0VnSLU7V3JwgrRgSnkNwU3uTEgIJ3jIVlVIg5oNe81LINw7OoiHWMveObhrDnnQaa3nGafHFzhjsUFLiXG7S0AYmSVTLnOwa+gd7Sb7+SGRHpElEZw2qjS8K77+77ZCtDx32NX+MmLJ2zKQw2gzRdHR5qOqxEaadeeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OM7fjLjt; arc=none smtp.client-ip=74.125.228.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OM7fjLjt"
Received: by mail-ed2-f23.google.com with SMTP id 4fb4d7f45d1cf-6aaf8415866so1918876a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2026 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790951750; x=1791556550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnnaK1bgjoHXdx4TLwgBNAZANL+ZBN5rHCxr30tdrTw=;
        b=OM7fjLjthjUwEd0GpjeI8BQRE7H8dKViyY9tMVjlOk3mh4SRm1wpryj8WyanqV+qeX
         bc2PbvW09240D6r9g+3PRl3XtqISSfiCWEhTZ9Xdk5NU2C4KPil/aUP/NgzIypJw0eSt
         ybZsGUurjdNY6uXbz/+sU2EJVKu8Aci92SWB0+XKUZh+yw9fh0hsFi76LsyoJEY0QmOp
         gYANqf/kmpL6bpm22VIKnMFmlfk8vYTjYwaXjSEydMEzH6ows7TgL1yzGo7ZijNPSxzQ
         06PQxgreAxbPjVa80MvNyldbr+hB9vG5sjTifjO5fFiHF74F3BJvnejqLnEGYdz8XNGq
         BtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951750; x=1791556550;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnnaK1bgjoHXdx4TLwgBNAZANL+ZBN5rHCxr30tdrTw=;
        b=G/MO54bwfTPBLp+iKFVD9XxBxitDU2aJ00kRz1GfF8E/xj6jhoyCeMt0d/M5LzkerI
         0eNgbxXMmCegUgNvMlg6BK/RaVzVfl/nVkSv9dI/gJyvmPRs+J0+i1ecApfOuu+HtV0W
         gqD8/TUuOGa+K+Tax4INXJoDd+wm1/t9SwnUefPUe1R0L6Xpm5ryTYDigLjm0AL6MScX
         p2SnIanTyF5BEAJZU1kV/uQeJdRfKBrWaDT6+JDuIfv9cMYnmQqYMpmSQAbCxSHv2+Zd
         ADiiz5l3niCiUDG3blaQDAo2Qp80lPP5hEA2l7oKmj+/hub7Vxs86UUcsKFh3+hY+K0F
         gdIg==
X-Forwarded-Encrypted: i=1; AKwUvBxk5d8WUM/hC7/5tqIqKOKupbeSlS3KfSijA7pakOE+LkcHKcasdPJzANLgWwlu0UyN6MVUSUN3gIo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGMzdy8d3h+1vlDH56kgEtq7hmf5Sk0NgYUS+pTpR/9t5CKwHW
	Vu+JNodO2zMNIsVUg8EGovPSgoSdI7UQhR8Scid3WJyvpnU7M9Z0jT0Rn5EwVnxHNPY=
X-Gm-Gg: AYBFou0tJlenIeCNyiNkV+ViqXb6zdRLK2BN8HRlMvFwQGQWytAXzCzJCfiabvlpTux
	wEAtZ6P7C/Awfwbf8Nn/BlKgq1JwwHke3p9d+u+Xd0vVrIR0jR+QXehzssHGicqRWseCImmj1rX
	DVKdfmKYqYzhr4MuHgH+Ep34tJGDtbAwkYhRiIeXTo8LREJzagoPyMR1+O4++9X+ES3aGOa4zH2
	SsmnDg1HCkwqxSABbVI1XAY5I/O8qezcQN/fbUMS4wy3Q8MnYdZS9EKsJKGtGiZGVHyrHOQerK3
	suHA6qclr3laLK9HZD+N1ejBsHDDvnnVrZ/DhFroofMUsRwXFfafhEPQxAJqpDp+4JHINMYirrF
	7p6u3zSSOTWAkm5iVQt7eyarRVOZ2i5VI/umKU7YPLGCs5AHxlTeZxHszBcj29chupTjOreLaOM
	ERkOe3Vi6OZurljNHs2TXoJM5u97artO1oQvlb3BjtJ5HjRBrG+V1WVwEx1wTQp3jnAH7Ff2IPh
	n4hAWxNrxNr
X-Received: by 2002:a05:6402:254b:b0:6aa:fac1:3bff with SMTP id 4fb4d7f45d1cf-6af9e357989mr2066365a12.32.1790951749730;
        Fri, 02 Oct 2026 07:35:49 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.210.127])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d873682sm929326a12.10.2026.10.02.07.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 07:35:49 -0700 (PDT)
Message-ID: <45d79c84-cc76-4bee-835d-ed11ce07bf2f@linaro.org>
Date: Fri, 2 Oct 2026 15:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/15] media: qcom: camss: vfe: Add support for VFE
 1190
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Suresh Vankadara <svankada@qti.qualcomm.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
 <20260923-hawi-maili-camss-v1-6-cbbb42e534ef@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260923-hawi-maili-camss-v1-6-cbbb42e534ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2026 12:02, Nihal Kumar Gupta wrote:
> drivers/media/platform/qcom/camss/camss-vfe-gen4.c

So I'd like to completely drop the genX.c stuff it is not descriptive.

For example:


diff --git a/drivers/media/platform/qcom/camss/camss-vfe-gen3.c 
b/drivers/media/platform/qcom/camss/camss-vfe-gen3.c
index 93d16b0951e99..f2001140ead12 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-gen3.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-gen3.c
@@ -12,13 +12,43 @@
  #include "camss.h"
  #include "camss-vfe.h"

-#define BUS_REG_BASE                   (vfe_is_lite(vfe) ? 0x200 : 0xC00)
+#define IS_VFE_690(vfe) \
+           (vfe->camss->res->version == CAMSS_8775P)
+
+#define BUS_REG_BASE_690 \
+           (vfe_is_lite(vfe) ? 0x480 : 0x400)
+#define BUS_REG_BASE_780 \
+           (vfe_is_lite(vfe) ? 0x200 : 0xC00)
+#define BUS_REG_BASE \
+           (IS_VFE_690(vfe) ? BUS_REG_BASE_690 : BUS_REG_BASE_780)
+
+#define VFE_TOP_CORE_CFG (0x24)
+#define VFE_DISABLE_DSCALING_DS4  BIT(21)
+#define VFE_DISABLE_DSCALING_DS16 BIT(22)
+
+#define VFE_BUS_WM_TEST_BUS_CTRL_690 (BUS_REG_BASE + 0xFC)
+#define VFE_BUS_WM_TEST_BUS_CTRL_780 (BUS_REG_BASE + 0xDC)
+#define VFE_BUS_WM_TEST_BUS_CTRL \
+           (IS_VFE_690(vfe) ? VFE_BUS_WM_TEST_BUS_CTRL_690 \
+            : VFE_BUS_WM_TEST_BUS_CTRL_780)
+/*
+ * Bus client mapping:
+ *
+ * Full VFE:
+ * VFE_690: 16 = RDI0, 17 = RDI1, 18 = RDI2
+ * VFE_780: 23 = RDI0, 24 = RDI1, 25 = RDI2
+ *
+ * VFE LITE:
+ * VFE_690 : 0 = RDI0, 1 = RDI1, 2 = RDI2, 3 = RDI3, 4 = RDI4, 5 = RDI5
+ * VFE_780 : 0 = RDI0, 1 = RDI1, 2 = RDI2, 3 = RDI3, 4 = RDI4
+ */
+#define RDI_WM_690(n)  ((vfe_is_lite(vfe) ? 0x0 : 0x10) + (n))
+#define RDI_WM_780(n)  ((vfe_is_lite(vfe) ? 0x0 : 0x17) + (n))
+#define RDI_WM(n)      (IS_VFE_690(vfe) ? RDI_WM_690(n) : RDI_WM_780(n))

In other words VFE 690 and VFE 780/880 don't share the same write-master 
index.

So they aren't the same silicon.

I'll go and find the Kaanapali thread but the feedback here will apply 
there.

Name the files per their silicon version not some genX.c moniker, please.

It _looks_ like 690 and 780 will need to be separated so, I'd like to 
move away from this misleading genX notation - it may mean things to 
qcom but I feel we are burying inappropriate hacks inside of convenient 
gen files.

---
bod
