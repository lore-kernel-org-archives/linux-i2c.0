Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB22F4A18
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779167463; cv=none; b=h7lHN4HT3Qwa29tvVw0tnq55pVaQP73y4DT5xoJiwPljSgXhbvfhY/3CQytz9v87yGVeJBG09L35X7p+PWOmQPOd6YvnTZwDg1U89NA1CPeOmUxkXRPPEwtNC44r4rYeH7JTPR+j4WvDguL0ZJWdECw2c6g6PHmTOsIBFY1CdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779167463; c=relaxed/simple;
	bh=lhtTz6r9h3gam08PpROtwyqAJ6lm3HQYUI3xZrXDqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWMtbw3iYEPkwsOMcrYFxYNtaBfJboxKAMVqD90HpuylJmj+b5SoLmkNnweBpDiyOBAPmEDdBzc+x61iaH1BvYc+A9Zgp9MckVzx4Bi+l3nN5Gk7bsRnTyvSgoJYc/A2B6kII/fjEVrlKznUpOKkMjjpSHKHis+P6a8EGiMsO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/ItlpCq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ItlpCq"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-911dfc86903so376172785a.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 22:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779167461; x=1779772261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=R/ItlpCq4oLyEFoxZdE23eqeQvJPpHM19VZ9Ty1WzV72lSKqPS//wMPtu97L+CnRdU
         e/iRj4/N4K2pAmZiliMU83AHOohTJsxYwRlvdfiV0Mlh5T17qrXjNp5tNG5VbCmrn7sY
         mSl387ENfGU6bHcY5m/JvpXylBA31RTQGNY23f/C9vXuelOuESUlZK0uyUHAHFlwHw2H
         UT82Yn1de0Af/VNSMauIjuLmfD6sPwS9lHHeXYCCp1+A4ZVyowpblsrLb9zofHGfYnX4
         YbPP+de8KxJE7QNcd/fkxjqNDZOQqiDZYGGMYbHeCe6pVXMHU0fVyXXd7aHsTTU7mQs5
         mwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779167461; x=1779772261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlSbwvOjgwkLSIAC4sw+jiTYmv44YqHx2Q9LfFfV2q4=;
        b=QZIiQWMu4kC1Yd5WwISvLakOf05+LrkTjxthFQzR4+QWaS+bhKeIYQe1P/ILH8ngEW
         aB7YBDH5XiGstDZ4F0/Sqc8buMAU4Jo9FKhC5vp4lLdVbSF2s1aDCqradJtIKDLqPHFU
         n/Ao5ez/RFNmZxM7HmcimHW3zeEUHrmAYJODAdtLQCLPYxZmNqHdT8i0XmSpS1s91ZuN
         s23GBOInlMb+Y4EdXt5qo7iEeH7gD/3xOFxpbPyddVImty1lvDvOZe9mzcJzgoJPGuse
         dLgw9bNd7i4TCFw4SaB1HNZ/D/je5mhrpeNQllmGqAQviqgjfCloicVSYtEdj/MJsAl+
         Zlkw==
X-Gm-Message-State: AOJu0YyzhfBhTiEJakypSYe/ec36Sp8lLdVcbreyJbddjOEwNsI1Zzso
	F7LzLuhLDqK3G6/KTLHIdIL9hf4/TF9WguDlx+Gj1m25V6hIxVe9X1utlIlF3yoJ
X-Gm-Gg: Acq92OHXMlFLIJEMgZ7ETYc9GMrz78Bi4zQ64tZBLLxRSE69nFhjRJHo5Pt5h5hABmq
	lC285sQ/tqFJRVmzv6i/s5BacWlL1+AgL4TKTUfYUZTNiWA2ixpedFcBG4AoUEDnkSyl+m9tXIZ
	MPoDZGFCL7UkKgRtDypX8YR28lJtc5DUIWYwa++0COlQ/QsYHWjmmxiNsKFE+A++Xrq76O6/mIu
	ISbyH2b3dIIMxkGm9iyxRT1B3t0Ssjri0u19MxWdbgxUNxKCl5+q1qunJprlzaBCeDwOrbP/OX7
	wGKO2pvY2R+qFEvZIBxELx3his7uGqJywCLl8uadakF5DW2FAyFQdikhhf3ImYDXT2yla44XeyZ
	dYsnu6IFHsoahghh2JUzJoFHTFYMC/rZCowq6Tp2tmKSss/uciSC7IZiPABDlMKyjiMc3GXb5Ro
	aOem4hYIk0uQgE9A1LYm2cDl3EEhyi9AqTis5mwAEcrsSUw2NSZwhnOdmOmg==
X-Received: by 2002:a05:620a:4713:b0:910:87f4:9a05 with SMTP id af79cd13be357-911cda50b31mr2665504885a.1.1779167461141;
        Mon, 18 May 2026 22:11:01 -0700 (PDT)
Received: from xps (ool-45718bcd.dyn.optonline.net. [69.113.139.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm1708612785a.5.2026.05.18.22.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:11:00 -0700 (PDT)
From: Jacob Bazata <jacobbazata@gmail.com>
To: wsa+renesas@sang-engineering.com,
	westeri@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	Jacob Bazata <jacobbazata@gmail.com>
Subject: [PATCH] i2c: acpi: Add VEN_04F3 to i2c_acpi_force_100khz_device_ids
Date: Tue, 19 May 2026 01:10:31 -0400
Message-ID: <20260519051031.6660-1-jacobbazata@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This model trackpad (04F3:32AA), found on various Dell XPS models
from 2023 including XPS 9500, 9510, 9520 and 9530 is well documented to,
at random, exhibit excessive smoothing with no obvious cause, similar
to other trackpad devices listed in the i2c_acpi_force_100khz_device
_ids struct.

Forcing the bus to 100KHz eliminates this behavior.

Signed-off-by: Jacob Bazata <jacobbazata@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 28c0e4884..512ebdfcc 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -373,6 +373,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
 	{ "DLL0945", 0 },
 	{ "ELAN0678", 0 },
 	{ "ELAN06FA", 0 },
+	{ "VEN_04F3", 0 },
 	{}
 };
 
-- 
2.54.0

