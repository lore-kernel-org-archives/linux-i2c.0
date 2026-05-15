Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21248C8C0
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858413; cv=none; b=HhVz0+4eu31TFo1fjQ0fgGt62LEYC07pzltslMZOJ3OMJGaKsSE5yMX8dLw/O26v9i/hNDhdUEDbXlqfoY1VDbNWnAEQdVrH5BCh1FuL+JTuL7SoZhRfvtfsqj/TUvgvlkAs5nI+PtfVH7WnLCcvRT/g+H36CXfj8h8TBTTupHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858413; c=relaxed/simple;
	bh=mXltyvse+gt9WykHy6SVnq37KIlEwWc4char3Gsh2FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dqx4lBrt0UsglDmMqHTPb+O1nMjoZ87doPigMK8ZAgdgLNB1mpOgI+CriRxd5r+A2jYxBbEnfvpdL7UqHsMJDNhCvVzlz9uF3hYwqD9p3ybf9eV0rFerM6cKIHnpEmqTQ7cQkTXBVQ9vVA/pHKKXH6Es1Gr+kJxBC2wxyKJwjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=racU4I5K; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="racU4I5K"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a409f3f2dbso457738e87.1
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778858408; x=1779463208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2IaPJZkrFxEXynNS/UOEiH1OUbqJbyKhqhbo2jqolk=;
        b=racU4I5K+m0Hx6Ak1LYIzKV2gHVMnug7JSWZCOYfwaay/qpij+Ktzje2TO7Hq1NXP4
         IH84lZ96Bi5OBpQ5GIWtafCyD8XSNBYzqAevTRKBs4wFyJ/6VExQRFG5WBNkMPMWnauR
         DUfeg6I1tv0S7av6DnDlvnN+jkttymAzzbeFJvlVhe07UhRyJxk7jnT+b8wev0z8e62+
         sYN3KZPPvU3mlq4+ry5eGeg2/VaSohG9cVL8nHcqOcWDlOkhmC+cHlOSH4qhvmFIi9Q2
         HHgVpo+LEySeFKuYiggA9LLvFhn/er76IibzKd4cupMSQo4r+h0PcMm1wtwHXysl+O6p
         4ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858408; x=1779463208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2IaPJZkrFxEXynNS/UOEiH1OUbqJbyKhqhbo2jqolk=;
        b=LPrNQZUcBvTvU0R2a2Xa3UeDSRS8R+22FDjqibz8GFoosQZMaUdptxCDB3IBR1uVgh
         xO9GbbDKCXBPDCtlyMSED5GQSXTOC3xb+d8/Il5RVZWTlou68Xso4kQMaUBrCbOw+TAO
         nTA3ia9p7XHU3k1ghJkCD1e+9ZEiZ00M8rR/fzmUzUsb+esqJwE5pcPvZ5+fgl9KG0Ye
         P1ar++0hCw65k3dzTZVP8gNyfnaie0hcmvqqIyGHuoMxYATCeQ2m3Lv82El9Nk93oKro
         NZIWZJPjpB0SI8vOP0pY+/ZeZH3DYUSDjA6vvM82pyyuAA/f0IQ0pT9JJPseZL+Bugd5
         prtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/scACa7FFl8BAVvQWzTTlaSlFKw8cI/xsHL6Zdz/FL0UOgqnlNQfFC/yHkrfnz0wEeAzNNQklD7O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYbhdS0qSiw0vgbqBL815PG9O1mHVucvjhpO1r9tpfz6IhQuNl
	Bf18Jh9nqg9VJ9ttAL1+kGvtv1xS6Ou4OGkWNY+y9tZPEvAzof89eWw2aUy4onQsClM=
X-Gm-Gg: Acq92OH20iLOaqgDuGfsjp7XZzwP4CdThjiD2xz/6JHDNR8ZipR88shF+EJAh+VMP4V
	XRja2x4+c6y0VwZBY/5+sUswx+BrzKFcQJuNaF1H6vhVztfRMKGlGZ7NhNRvPSGQg2mbcwd0cUb
	Gq5A30wY6Vrfn4l62CtgVhYIHyHIcTSn4U3t4ruqXUCEhvfvZFTxgxqr9SUX5kdsaPfLAUJVvcW
	9La/uw2xSq6gDPQ3ehUt5ZP/aIwFm+vpMTj5x+IPA90Zobdm5K0e1OWOPUVbs+9XFv+Hqqk8r5L
	AeDrC2vFZaQOXAYDX7N6yny1HUpmiDgXOX1KbuHhtE668T+zSs21TrSXaV3iVcSqskxO3noYwSZ
	/aCZxENZqaxSK5VPS5QLqQFAjlaxJEsprxl0HcZQW/yTXSf1uvQYZaarzZuPKzwS8xmUk4nEZM1
	Hg34EbSrA+cJsQLnFt5V2RfLoZZBjlNLs/Mjw9pOW1GF3MjPzdFOPaNKxfKwDptGNsyA==
X-Received: by 2002:a05:6512:3409:b0:5a4:1099:b16a with SMTP id 2adb3069b0e04-5aa0e5d8440mr583093e87.0.1778858408333;
        Fri, 15 May 2026 08:20:08 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc20fsm1392418e87.43.2026.05.15.08.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:20:08 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/4] i2c: qcom-cci: Remove overcautious disable_irq() calls
Date: Fri, 15 May 2026 18:20:03 +0300
Message-ID: <20260515152003.1604187-5-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260515152003.1604187-1-vladimir.zapolskiy@linaro.org>
References: <20260515152003.1604187-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cci_probe() the controller's interrupt is requested using a devres
managed API, and in cci_probe() error path and cci_remove() it'd be
safe to rely on devres mechanism to free and shutdown the interrupt,
thus explicit disable_irq() calls can be removed as unnecessary ones.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

	0001-arm64-dts-qcom-sm8650-pocf-replace-custom-regulator-.patch.hmm
---
 drivers/i2c/busses/i2c-qcom-cci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 2d73903f14d3..4d64895a9e9e 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -608,7 +608,7 @@ static int cci_probe(struct platform_device *pdev)
 
 	ret = cci_reset(cci);
 	if (ret < 0)
-		goto error;
+		goto disable_clocks;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -638,8 +638,6 @@ static int cci_probe(struct platform_device *pdev)
 			of_node_put(cci->master[i].adap.dev.of_node);
 		}
 	}
-error:
-	disable_irq(cci->irq);
 disable_clocks:
 	cci_disable_clocks(cci);
 
@@ -659,7 +657,6 @@ static void cci_remove(struct platform_device *pdev)
 		}
 	}
 
-	disable_irq(cci->irq);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 }
-- 
2.49.0

