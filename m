Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390133C528
	for <linux-i2c@vger.kernel.org>; Sat, 18 Apr 2026 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490669; cv=none; b=PmOUt/c8uacBfS4TjEs0O4MCRsywQHbhLzAIXl3qpflrjE5yZJtXT+l1sTpNdsCltpGgfUxDC1QpRVjuk6Q5MMC/ynw+UBF5YpN3zAqZEvORGZy+Dblqvp4sSCSqgvEol7mTH56KbB5wfILRUpCJGC8kkGNxBo4JPlnZ71+YFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490669; c=relaxed/simple;
	bh=prW9Ym1vKl2hLBI+UbuMXxxNt2Sy1yJhvMrFoNFpczQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Om/vYM+K5FHyWQFoGRZAt75ETjvdmjRt/LP5hdpMqzEPa46xAlnu/OzREVtEvvRWlsNxYJg4n59k+i2GTjfOOa5at3/vNujpFe/8FgaWAxWTDXpGXfa91Bw6zKiqj4WXBaAJDS10rf9uHQS8NnhpQieAwKSKXHJC1HmfXf04nCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKu7uAtK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKu7uAtK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371104ffdso1704775e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 17 Apr 2026 22:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490667; x=1777095467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IohdsypP3r+7DTKppzdm/+A74a+kqBF/x1lFwg/446s=;
        b=dKu7uAtKFFytQssDpzNJhgHxbwTUeDoBN34lwDqpd9U00+S+q9Tvl2PwcNqqmVk3dh
         4U3wdLOpet8OBsFJSfW6aRFlSb7LzdpfTM3J/zPJ3n0xCx5cn60WbTS+U8F9orKNQe9a
         t9z4CdsGNQgPTNrbugsIr7SIZ2qDad6yr1e4r7S6sN18ZkvfrkS//IMSb4m6AobLW+0o
         2LaijCyGDQX0PailV36tcH10dnN4WPeAGMvMw541Co90nqE59R6KiMM5yEclLNzI4N3E
         ft37dDX41Avmvql5XyqJi2wE5eq5a68oP63zKTi5OEt4t5PlAgUvb39vC2Yhi087ukm9
         mCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490667; x=1777095467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IohdsypP3r+7DTKppzdm/+A74a+kqBF/x1lFwg/446s=;
        b=TU+jHXrQKpYxVPemiO0PdaeQn9BqX+7bgd3vurXoZ2lAPQu+iEbrw6w4vR9guHFhNr
         DB7g91fYYST9yqPl25fBvI1W84D6UswTh4atW9/eGtkKKYDtAo17inqlk9w2MdISC21t
         e0NIZ2ArI70MLV4OSktsglKBLO++RebQN0dKyungM1TVduDLJHvQo7iUGUWgKlJflp4g
         /NHya6y5b/S9dTi+oPiNlbEeaWH7wywbgh5UGCuWeFiIiR6M5+QD1ntnaNELFrKCsIz/
         BE90iL+vdi6VqCftuytDYA2H86+wPrCKYT+iSizwPuCTOM6UcrNWXd/PxEfOdaBKAgHx
         s/ow==
X-Forwarded-Encrypted: i=1; AFNElJ+OQNBDKdKwN0IIByOVvryVR4Ai+DWAGR0gkfh086v8rOvVi+ARiKlpHLBZ5W360rm3g6D/xXw/Tvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+8Q8fn0Bvn5sJxsPiWWmec0hGWm3w4jYdZgUrLwXNBg0W3Sk
	58QkhM04pVusHF0GYc8XXO9KIRpZHRDuhtl3WSQyaGB993Fmx+7oSEUa
X-Gm-Gg: AeBDies0VsiWh18d81txVUyRxgn2jTkive7ixl3kBcAKk2uD584uyiXQYklBtRt1Y+F
	xr4A3hoyV6GO+/E71++kgkAvl5eSjfnzCzh2Tf5kQZcQPqTPPkr9b429T3yRFee9u6Kbg3rY0Lg
	4iHOlGJWFnXTt+rvk8zlPwssKLxwA+pDZCNuERDdHSL041A+ibEHmVPNL8ApI2gl4w2Qyy1kRwE
	o3+JhJ975mBb+jS/8l0FmVhKhCyFTKuomb3Ps5lfWpYjc6kaI6jGGGN2lk5JT+OAFrV4sJ+EPAw
	HjknOAJk4CTPlGeBR23op6sIb92CE7+7LHYw3N2VKsfT7oXO52C1+ZUGr41oNUgGxpLXp3ZylQT
	rtNuVaRRWxcCE22sQAdc9JaZ1BUtWO4yt88F9yebK7oFr2XPkgC2y5+V1bLOD2mBS3Jqe1u3WG9
	XsLHCeS8x/Pvi6C8YTzadX9tBkydtuj5mS+DxCL4CXz/77zp3pssj4N7jXX4icQTNNCp4iDTCLQ
	g==
X-Received: by 2002:a05:600c:3b85:b0:488:a39a:24c2 with SMTP id 5b1f17b1804b1-488fb73e120mr45995315e9.1.1776490666619;
        Fri, 17 Apr 2026 22:37:46 -0700 (PDT)
Received: from thinkpad-cachy (adsl-178-39-113-125.adslplus.ch. [178.39.113.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c7a2sm33871755e9.1.2026.04.17.22.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:37:46 -0700 (PDT)
From: Niels Franke <nielsfranke@gmail.com>
To: westeri@kernel.org
Cc: wsa+renesas@sang-engineering.com,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niels Franke <nielsfranke@gmail.com>
Subject: [PATCH] i2c: acpi: Add ELAN0678 to i2c_acpi_force_100khz_device_ids
Date: Sat, 18 Apr 2026 07:37:19 +0200
Message-ID: <20260418053719.15766-1-nielsfranke@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ELAN0678 touchpad (04F3:3195) found in the Lenovo ThinkPad X13
exhibits excessive smoothing when the I2C bus runs at 400KHz, making
the touchpad feel sluggish when plugged into AC power. This is the
same issue previously fixed for ELAN06FA.

The device's ACPI table (Lenovo TP-R22) specifies 0x00061A80 (400KHz)
for the I2cSerialBusV2 descriptor. Forcing the bus to 100KHz eliminates
the sluggish behavior.

Signed-off-by: Niels Franke <nielsfranke@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 2cbd31f77..96d339df0 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -372,6 +372,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	 */
 	{ "DLL0945", 0 },
 	{ "ELAN06FA", 0 },
+	{ "ELAN0678", 0 },
 	{}
 };
 
-- 
2.53.0

