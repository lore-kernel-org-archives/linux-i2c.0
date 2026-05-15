Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34610492184
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858409; cv=none; b=WAS96cgGOFZJydWtz+NpsPOxFZMx624ict+PI8xhjPTCCHNo+MwYiCQIhbX15Jgl2EWoznv+oHNG5XO3v8/0eW4C5zr1zKBhiOhcqmuxhK4TOEy6JysEflgUybYmhA/7iWXRpNvcGC+AeTazildNcbyDduRJbesee+4rGq1im7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858409; c=relaxed/simple;
	bh=0BWXFDvPgI+Np48+9csraRfI7pKcwMDI7s8TwCEe03U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4AB4QHTOtcHuwwdxX415OU/0PmHQm2dGeDgSravdFq3P0PQsff1P1HFK1TjH/PsqE65Oda46csHBCqdnXyiPoMmhNghk5ux78RjGKDge06Le5/NUNpk25XYaESiCk5SqNcS2k5XQiKJN96jU3JjRAGtRc9v4zbv06NFTUcd8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CcP9Gb5g; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcP9Gb5g"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8e387baaaso364247e87.2
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778858405; x=1779463205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEi0p8nbFYufjDm+4UA/kgPv2+YsfKpBCH2UEhkLavc=;
        b=CcP9Gb5gpimkAoCTBdeRoFOpHzpJ70q06Qq1y9uVCyHUC5aMwdwnt8fmaFxIfDcMk3
         F2vfWWRHU72BCuMNNE02Sx7R+hzyZPi0W7J5FPE3NQXXFJj5MWoYA3aVY/uz205sWpTL
         O7o3+QM4pPM/wBPbjVSPJvr/LlwS/mhXQyxqQ3I2ELo+q6sqOk6bly4DoRwNYLigzP67
         84jaWSBo2LFSZJ7F4OoxoJSFOygP4vfTMAbySpl0miO9HuaR+DQmTljGPypXgNOLLXqU
         W/ulrMy1tLZNMIz4gUhIrTaZXJcz+lXm0BdTAoqMZvfq95H1saQvzwp04rYwxAMi8at5
         FvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858405; x=1779463205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEi0p8nbFYufjDm+4UA/kgPv2+YsfKpBCH2UEhkLavc=;
        b=aJvil1CY6GO8otNGmoYyl4bZ8UHXaKq9qdqw0rL3JAcLJtxhfiy7VGoxqctBk8f3CT
         7hbz3JydKF7aPxHVKgln6qsguB4B0KG9XgYwcdk/1FIn0nv2b3OiKXUfwauWMdiPiLXu
         RM1sxJznVu0QxszMSsWoidOPTdcTOW5l2qg4S4UTkeRYxkT9QuUEsXkXafORqkIe9LCg
         xlR018bfsjf+wy+REzB7yOH2B30X7/VEks7Z5QRx3u4xygHbOCwQZamkh7EcE+tfdM/1
         lUI1+ic6OR1M5BQSvaJ3o2CWb1n/KCw/O/vuQzGyEXDgvxjMZIjgoT5uHbHT32aJUrNv
         +1LQ==
X-Forwarded-Encrypted: i=1; AFNElJ8i+LEEZiFlWw1xuwu442rKRxKaoZB9rka0cspZ7UYk3HJ1gqo6FconUy6z+fWlincdh40KoaC8QIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuMgIBN8KinhRCQcCrRDmI6FjpEt9WhyPilkLTTL3jwmWOstD
	XzqYWS4B3D9ylu2lrg4TTYi2Rb6sYdn5h6+UWcebb8CYC3+KXiBNiyUoHmSDGF1vLibSrWoOIj7
	8j3u0
X-Gm-Gg: Acq92OGSesHBefld+R5bsCIQRdYtM/CO3sAkZdXzqpxED+zEhHYnVaNF6EWWVr2KtNH
	2Q6ZCaQBM5/LO0YQM/nrdakbVLAo8DWjkxOg/QOma/4NZ6dVfWwHD1BI53LNMwhT7SxMyQekGGJ
	UduabFZGxcMF1vB+kf4oQcvnAlSzQrihnkjtYwY9lAP5QJA6t6wQ48FABkGPYEf+s/WNu4Ro8Ap
	22bLsSLHr40QdJw1VispiMn589OK/WTr8QLx15kVPMzASdo5S4K2k2CSmQjAV8XtUwZ5xOPs1iU
	ZZfg7rdRmWbSnlQQAxsMyznI1ynQIRxnkp84Tl0IO3wBpZKqVxzsVBUIATX2jkNPhMBHTrqIgD1
	FOelJs1BD4WEHJkORT31Ygo7ON7HfIDnZROlc+SAVM972fiGQXYf+Mso8aFnk+cryJen6WhPrxn
	Oj6Oyng4zhkis4w+LQ+72tYDHfdGSiCyw3kjYVNe0y1RdxGhQTqZJ9X9bWpfzrx6JTWw==
X-Received: by 2002:a05:6512:b95:b0:5a7:46f9:be6b with SMTP id 2adb3069b0e04-5aa0e5d8f3emr757891e87.0.1778858405308;
        Fri, 15 May 2026 08:20:05 -0700 (PDT)
Received: from thyme.. (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc20fsm1392418e87.43.2026.05.15.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:20:04 -0700 (PDT)
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/4] i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()
Date: Fri, 15 May 2026 18:19:59 +0300
Message-ID: <20260515152003.1604187-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.49.0
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
dereference, because cci_halt() is called for all I2C masters regardless
of its initialized state, the bug is present in the driver since its
inclusion to the Linux kernel.

Along with this fix a number of driver code simplifications are added into
the series.

Vladimir Zapolskiy (4):
  i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()
  i2c: qcom-cci: Do not check return value of cci_init()
  i2c: qcom-cci: Move cci_init() under cci_reset() function
  i2c: qcom-cci: Remove overcautious disable_irq() calls

 drivers/i2c/busses/i2c-qcom-cci.c | 50 +++++++++++++------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

-- 
2.49.0

