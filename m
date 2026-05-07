Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8C33A9E9
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184325; cv=none; b=E4ijnKAWzWgWYWG00olmNu09WtG5UwBlGJPODcrcOWZWvt1Y1Of2nIiCgDRIUh+lt7iC4WVuRwdz3ySY31ThTigurqKpCB5lAiubGdejpyl+KEQZOFVUHZVBJdpGrghAeuMvttpVHNva83bqlqbuYEgwBF+a7FJ5Z1tlzQUaNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184325; c=relaxed/simple;
	bh=XiBF8qOTSINpTP10QsEcktQ96KgiUVOZ6UAXE2NIqVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WdxpRo5w4NObu+QPipoF96eGSODYPWlvJ8VwIOJyW7f6JG3Ve+Pr700qLl0A4fXtVNXsNkKnKECTC0N9sTIYMW5Z32KFgQyCLG/x5EgEmp76rNJMFiylFvgMXpIdMEyQatc/CmJd1jP3PhXNvoCK+RsU9vc0sZIUtD+fl/nEdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=NfPVmQQC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="NfPVmQQC"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so545507a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778184323; x=1778789123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip/5HPUHE2OHKD7QbPNg1xe8gn9QIP8/OvSeHN5LWDY=;
        b=NfPVmQQC2YeNju9iOd4031yoCbgRdUT2wk45WHwwTLFti8Eo1k9RFsdOqw63LV2Vfj
         lFSRkYhYoBu8FsyirMXeSjKVHNxmRc5Ul7fyKxaCUVmgk3qMUmyJQV4QmB/TzZSxrT3w
         v/VJ9pOjfug5qNgisG6iWu85iVHo9x//E7eNpQKIgeWM/E36rAPZn6HhVsxDLC2wPuOz
         Mj342xOklmZzNMv7b53g8xGKR6Nt17Yr/zYaLkFAEJgqBnY2MwcS+pYmqpy/AfU0oZFL
         zjlBjfcCXSELng0GxxtMOrMaH9tFSVJV1SHnViafVJxO4i0BdonwiVHJCjhah/JSGzsS
         zq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184323; x=1778789123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip/5HPUHE2OHKD7QbPNg1xe8gn9QIP8/OvSeHN5LWDY=;
        b=XVTa5bYDYXM+lxbnOelMySiVmOqkbh0QBkjZQ6mvOSDkul6IFV19urNZy/v6qf+NhC
         F8akTgoQji3i9BPrsjVWp4OHwkkZsZqUlR16NaPQL+620yDmziPEgsOSPYurf2sPxQ+Z
         hUS96F4AoPIf0MveNL7HKQNT2UH/krVaVYVN4v8G9hxIU261atyZdDVyoM4kbDaP0cgA
         13CtjowOF5pAbklKTTRTZuDJUaWc/yj5c+Uo5+vCszbHFq4pff6VjbPUYgJDQOv/bpvu
         VLXhVw/nD9Df8DXyp9C/vV6mhtTp6Tdxlp1jbOaPhVSggSRXZup02xCqdT6Ae7FU5zKw
         ybwg==
X-Gm-Message-State: AOJu0Ywy8KTXLQzELQtxJxUdmvxgzm+iWbdrTWxPSXkTlWk9ElyUS5sX
	dcGcMRrH53XbEPetDjypKwQFBdwLDqCLEEXToJHsf7LawtnqiAp70smYXn6iVXhO8+I=
X-Gm-Gg: AeBDiesJnULJlJefJptE1VAAo0PHrV7dMTPsvaYU8YpP7iagU8qPT2hbMax80UDtfJG
	mmrPL4mW709vUGn0TRIEdgpC28AIE1GkVUglZHuYdbwUUUqEwPoATVwpTdLvbHV+4mVH6Pxb0/r
	+Qe0wXgfUVfe9mzmp3BZHhxfaXCv2hs7SM7NukEkcxLBxoaXsiAYt6vqaoXAsw4u0QOpsbyOO/P
	ag7Cl0Uf9MWNeb9kMoQbrv1j7l6+RJfuaX/o2sf1cDDVTq8v6JDUaSjLncmYtpslhavzFuksokl
	aM+ZjV/gYXY1k6ziS+2LzRYFqIoKFyDgjOWtuPD4c9ItGMatyB+1CgW8eZoQzSBHmuUkgYxAC7G
	EQ2aYmqza/FZ5wH+eh162tfH6Yt6Dqzha4j24duTbnsdloAaAJ91UJQVceYuPlbIPb8Ge7gbTZo
	m5ILuXSSjD7igKhgLMY8np9doAEA2RaNQnzwLYLEVSlpAdB6eOnVO/3zmU/9jmqWBbuhm3Myum0
	FT1FcfCksoZtTQ=
X-Received: by 2002:a05:6a20:2594:b0:3a2:d316:de52 with SMTP id adf61e73a8af0-3aa5a9b0a31mr9602121637.31.1778184322983;
        Thu, 07 May 2026 13:05:22 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8263ff29c2sm443200a12.12.2026.05.07.13.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:05:22 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH v4 0/4] i2c: designware: Improve device disable handling
Date: Thu, 07 May 2026 20:05:14 +0000
Message-Id: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHrw/GkC/2WOOw6DMBAFr4JcZ9H6m0+Ve0QUDjawCtiRQZAIc
 fcATQrKkd4bzcx6n8j37JbNLPmReophBXXKWNnYUHsgtzITKAxqVOAmIFGC05Y/uUWUxrJ1/E6
 +os8uehQrVyl2MDTJ2/9dCYmoheL55YpaAYeJ2pZsd59ePgQK9RBDXsZuEzbUDzF997BRbtpDw
 ygBQZ+9NlxqZ1AcPMWyLD9UFuff4wAAAA==
X-Change-ID: 20260504-dw-i2c-d5a1b1a0036a
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

When the I2C controller attempts a new transaction while the target
controller is shutting down or restarting, it can lead to bus lockups
and system bootloops if the hardware enters an inconsistent state.

This patch series addresses this by ensuring that the internal state
machines are properly cleared when disabling the controller if target
activity is detected.

Additionally, it adds a shutdown hook that gracefully sets the target
disable bit before disabling the controller. This guarantees that any
incoming requests from the controller are immediately NACKed during
shutdown, preventing the bus from hanging.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
Changes in v4:
- Updated language to use inclusive terms
- Refactored some minor comment / code nits
- Link to v3: https://lore.kernel.org/r/20260504-dw-i2c-v3-0-57e56135d602@wkennington.com
Changes in v3:
- Split the monolithic patch into 4 logical patches
- Reverted stray formatting change in the PCI driver's dw_i2c_driver struct.
Changes in v2:
- Fix description footers
- Fix emails

---
William A. Kennington III (4):
      i2c: designware: Introduce shutdown exported function
      i2c: designware: Convert PCI driver to use shutdown hook
      i2c: designware: Convert platform driver to use shutdown hook
      i2c: designware: Handle active target cleanly

 drivers/i2c/busses/i2c-designware-common.c  | 32 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-master.c  | 31 +++++++++++++++++-----------
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 14 +++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 14 +++++++++++++
 5 files changed, 80 insertions(+), 12 deletions(-)
---
base-commit: 5862221fddede6bb15566ab3c1f23a3c353da5e1
change-id: 20260504-dw-i2c-d5a1b1a0036a

Best regards,
-- 
William A. Kennington III <william@wkennington.com>

