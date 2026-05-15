Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39513F6C30
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888492; cv=none; b=meXkOKacj40vCAAGM/GLltz05IBReR1oSdN3g+msbhtbYU3AwycHaGYtnKy4ka4PY0Txal42Clo225ZMpM5vR+V/IPb2NLZWZ+YLzjzzKVdxnaEkL4bvDMn0tD+SSU9jURwypP256AFS3WqukkAb3AsBpuyQ+tgzeFLBiLSmvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888492; c=relaxed/simple;
	bh=EsKzy3a3w2QB6ciWVXrskdcLX96Jst2IB0ykM6mC4r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ8o418Wnk0UST10TfGPbuOljlvFf12P6yx7CGX0l3H1PPeIaqlLpeN6ZLs7DrZoMtOdpDGx8AHHwrNNeUCp0pygOV+zAuJV8DEBa2xtyTwMwV9mupY8hhSnY2eZphjrtVZ9x14UDY8oZ1TxHddT1piNv4zDb7Ra66H/cz0n4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m13L0CPC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m13L0CPC"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-393933b8c6dso468331fa.3
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778888489; x=1779493289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDeSMFVFW4O/ySYbhcOTcvBHuoesceFJngMVL1LKDjc=;
        b=m13L0CPCH6GGrqZL9JpXXb7QwANaVMKrIRFcFF1LLHbeE9v21sUrIEMOxazqROJqTO
         qJfBhT6ngQAnVdmziv/FS0hFBS3S0rddeqfaIUJA8ohlOmuBVxeHBoYick3Nex9vIubV
         olWtUSD6FIavkvoyNZ8kY6L6E/E6TxCjJf2IbhH08nUxjaskxcnMT+zzSS5rzXNSu5xW
         8jT+zwVegbKBxf8VSpI5f9A1t7pfcpG/8jVmFLsBypB96A3/jKkcTo747phYxLTMMxRe
         4DOXS/WTeH7moRT9OXqMeWdqGq2hAEfuesoBBdLsCLn9hkW58BR+CzirstAXhRZLtWDl
         Lt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888489; x=1779493289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDeSMFVFW4O/ySYbhcOTcvBHuoesceFJngMVL1LKDjc=;
        b=Kh4MjGJv5ts5TGOsqUet0n4shHzVqrBPwKkhb3SVfWeEHi9LS+o6A7nxo1w2ZMF6iq
         PL3exrOaovnlmRIVrDSuDr5gYDZBWuNo6SAuE2JgPkcy65axwh0wpb45SIxXDDoSUi/B
         +1nA+dCNxSjezSPMd4U/8rh540QOiRhLdNbVp0S0EDzjCDtaX4q0l2zoPRK7Pd67iYty
         08IiKZzFh3jbzgPORZGi2WDxblP99SbSU+nr1Z2KAm7G7bXXWImLWDytdNBpgCPnYeHl
         kEvPFL9O8DSK5WIcZcoq7m4pc/yuzWpj0+H9i5YTVt1qF+rYCQGhsLi0+gWMklW3Ky5m
         iwoA==
X-Forwarded-Encrypted: i=1; AFNElJ9rAQf89mZ48Ybd5mGLMaKoySEYmv5gQfZRAdbaDDUfBrMiiAxxpcPqI1gBNvc8KrXlfSEfJtmHeEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8Gfgl7RIgtPuoVynaP7F96puHLZOWd27bOpyOftrREc8moVy
	dqD2anMUL0G3o8P2fotrExvgeAr6fu5aXcNqoZkO6z/syFr9OAexIArJT5n2PoXlY34=
X-Gm-Gg: Acq92OFfTTZ50DPkWORRbfkXvCdkGWkLmQP4+hp9jZsZsPjXhviajTNfSoX0hnmR5Xa
	s8/QXy6GiJ+FSJtkMiGNjj+pSrTOmUTBumf23VozaH8BW9EMN3Hc2xE88xTLkJzxVo/vHX6RCLL
	lW6BZCWs6QqHEHxIiNahAchLpSaoU4cX0xoXXyufEi2HabjMi0Has2mtoWjIYkyEKXSIWGj9Ztl
	Tw3cgq4xf9CBi2fhBhZpg+cziKVFMuTTEXVBsMCSWzmUdghCI1N1LhjX3HaFkmz1KeR6VJ/Wbn5
	0WSS34ze6QgACzPZA8ReNxHKjYJtrG7UvZyeWvAxUXJ3s9+6PPl+8Vkzxg0qAzMKkqgv76xEXXo
	D8NuNs8iJZZHoGSsoYmxQsAqn13p1RpfruFNmFSOiGIhqn6aFQs0FFL2bU8rT11LCkLLmLanq1S
	naHQDaxme8CkuBjdx/4tAqYKrVbKx54SdEitO3gaO/Rwb02dMFFrGRWAQ6iik6QSFCGg==
X-Received: by 2002:ac2:4e06:0:b0:5a4:6f3:dfc with SMTP id 2adb3069b0e04-5aa0e990ad6mr823387e87.6.1778888489172;
        Fri, 15 May 2026 16:41:29 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c710sm1631384e87.7.2026.05.15.16.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:41:28 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/4] i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()
Date: Sat, 16 May 2026 02:41:18 +0300
Message-ID: <20260515234121.1607425-2-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all modern platforms Qualcomm CCI controller provides two I2C masters,
and on particular boards only one I2C master may be initialized, and in
such cases the device unbinding or driver removal causes a NULL pointer
dereference, because cci_halt() is called for all two I2C masters, but
a completion is initialized only for the single enabled master:

    % rmmod i2c-qcom-cci
    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
    <snip>
    Call trace:
    __wait_for_common+0x194/0x1a8 (P)
    wait_for_completion_timeout+0x20/0x2c
    cci_remove+0xc4/0x138 [i2c_qcom_cci]
    platform_remove+0x20/0x30
    device_remove+0x4c/0x80
    device_release_driver_internal+0x1c8/0x224
    driver_detach+0x50/0x98
    bus_remove_driver+0x6c/0xbc
    driver_unregister+0x30/0x60
    platform_driver_unregister+0x14/0x20
    qcom_cci_driver_exit+0x18/0x1008 [i2c_qcom_cci]
    ....

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index f3ccfbbc4bea..01e440b6585d 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -660,8 +660,8 @@ static void cci_remove(struct platform_device *pdev)
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
 			of_node_put(cci->master[i].adap.dev.of_node);
+			cci_halt(cci, i);
 		}
-		cci_halt(cci, i);
 	}
 
 	disable_irq(cci->irq);
-- 
2.49.0

