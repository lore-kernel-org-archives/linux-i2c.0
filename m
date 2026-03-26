Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FD399001
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544030; cv=none; b=NhjFrAk7xqRxWiq/efmOFOVscOrjxbFPSsXpOR6nIra1GIswhLnCr/NZh97A1ZrhO4V3E7nCL97wR1JEZ/+dIKFWzlfk0IJ+FGLHr5e0aYfIE+cCLvlTrD9a4qb7Sx1pylGtXYRRI+LV5YAhfcmG4LgISx11yT86Q/+wUMbIcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544030; c=relaxed/simple;
	bh=pht65ryf/SoqBX1Stz1wW8qdsgcvKRd5CptslYnA7iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3Py2Do8KEBDCXj0N8TssNfYNBmskKCEWJT7wR0qjrZMpnNLRMFrF44nDsPKMbqA3PxSl+288NI+EARNwMbf41nDbdcuYtG7m0rAe9ZExa9Fdpxd7v0/jaOkcANrM1nj21dTRY7zDpp9b9XoNxzlgUdQ/5rEx0qgY8svbiVU58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iaoa3MPD; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iaoa3MPD"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a3fafdec5so701801fa.2
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774544028; x=1775148828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nAVgAAmxy5RyoDPif/eI17zt71kOAmun/HAkn9gip4A=;
        b=Iaoa3MPDyXSd8hzkOJHwYmn2iTi5e730lrXfpEUdK6KqXMZ27DU5GOsCQHtaE8Bk9/
         QX4/i1tFininsQC5Fy6FJscJGui1hbhUbFnQuz5hbuTJaLTeFgGSpSdIe2Y14h+jrSl1
         EVa+v1sgbhWx6jqSwrPfHekRLlZQmcQxkLJl8UCHJ4/6Q3IpWZLxrpuV76s7meRMoA+e
         MfzMt4GhQ8BoFbystngj+5DY/9y4xJeZLOuivUQVY9/La2SKQxV4OeezxADFhZXwTf4d
         hWVGACZ/549rU//maYD/w4Ye2H4GHJ9fAhKLN0h0UJzT0wfcRxmvp2WuZgInJ3QLcoqJ
         brMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544028; x=1775148828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAVgAAmxy5RyoDPif/eI17zt71kOAmun/HAkn9gip4A=;
        b=LOO+DjPnC1CgnIOdBFEEchHpCx7cbYENHY/gasYr1AwOAUKmNZsaEHtV4POpdQqmS0
         T0lijouLnIj3SjyGrVjlrqNsV4sch4TzFaRcyjjNxt3PdulUv/x5LjPVYyvNozEW5/ol
         IwRGHXRBGAPO0oYJ+Ky6PvRBui6wUT1fGA2nTs2doTYgdRM49mXK3yyeIfbLSLNq2vl4
         xi0GDKQ8KJxr+rjfwhFPE9R1po9Rrjh90/ExPMuMKZUMaApbMdShM6kpQeLLyLv4ccvs
         KCH6CvbXyupCeJl22j8Swkq6h0d+cjnjOy8SN44lGdIaihSWW1+oCA6CzcHmkYNbTHeK
         JYUA==
X-Gm-Message-State: AOJu0YzY6x+sHjGKbyLJsCvXRr17I9cxXYIScglOVQr8xtwX/drhhN8A
	vfWAl2KCw32Ua4BQ0QhjoStVAgKV4rV9kROOdYOv2HrHQO0xXM4kaUHjyLoHYFEXHbg=
X-Gm-Gg: ATEYQzwrKud5uf0EkXcOJxParBlvKKxJq1USTnR6zRSBTYYfAqbFRn6Ht2lhVd6F4GX
	TZN/ppta6kxQW3fDWZYoUVyjR9qb0t4XWDYOw4hmwibYCgbQ94jttmawAG4LCefMAle6E/nJ3to
	iyAjYUoWWWhV1P2XsEi98wc8p1+ASUOT9ryULMdfjk2BGVlOiZTjK82W9xWauSIudNPbcIgvVXA
	3aCOF/E96agSOLci6iioC3xsV0ilREqQy3S5okk8hQBqMECculKTAUwqzO8TGPYbWKvi5cS0/gB
	+jEEjmknKYQfuc/30cKGE7jwhcCT6Thwg2kSAywdlfGLcvIdtCGBfRRkOURkhqjKQRSzd4DMPHP
	MPkVxoceUw25MjIeiP5F6t5EgdNBAx0lp5XJFZ9mQXS5XkUKVtxycFHrpn9U51LeGmUlq4eBG2u
	H0Rq8IKrMSXX/I6dpMDFc33Y802MeVXyZ6h5fz7fNpkZkV87f3WNuy/CsOJuIMkXHTwA==
X-Received: by 2002:a2e:ab10:0:b0:38a:4199:6b03 with SMTP id 38308e7fff4ca-38c432bd095mr13606801fa.8.1774544027588;
        Thu, 26 Mar 2026 09:53:47 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c52f84d94sm6630381fa.1.2026.03.26.09.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:53:47 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] i2c: qcom-cci: Remove unused CCI_RES_MAX macro definition
Date: Thu, 26 Mar 2026 18:53:45 +0200
Message-ID: <20260326165345.762807-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial change, a never used macro CCI_RES_MAX can be removed from
the CCI driver.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index e631d79baf14..7f146d02e5a5 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -71,9 +71,6 @@
 #define NUM_MASTERS	2
 #define NUM_QUEUES	2
 
-/* Max number of resources + 1 for a NULL terminator */
-#define CCI_RES_MAX	6
-
 #define CCI_I2C_SET_PARAM	1
 #define CCI_I2C_REPORT		8
 #define CCI_I2C_WRITE		9
-- 
2.49.0

