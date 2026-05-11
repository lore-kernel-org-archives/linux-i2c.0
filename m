Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697620E334
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529992; cv=none; b=JP7xzMMinzgHR44tdXtRpkbd/H9ijZ8oKpM7YB/AsYoFD8vo3+skNMSmyfgRsEvTmZRtRfMMJzouwmcKbHaqQNH2N6Ohv4p9MFvRrA5q19I/e0SACNCLSdJHPDmFxmhj3ucUROEJbCT1FsPFhFV6z9nC41ebnHXjMwe7LE10nFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529992; c=relaxed/simple;
	bh=BXyygT6KooIkATSpczru2FP9H3alp+SSLbQ+JG4TMVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P876ymkTCj0NzDL6QYajgtUD3t0hafpOeNWHyfzAgumt0owrLMIHKhTxDEAqIU+8MGa6IawKw8uxd/FoA3fZUj2RqdyExtGgiDe1Dp2LstP2UMhexhRVqFXwYa0HMtg8dCkP/hZxhlAFSQzBffvdjj5yrkhwLgFoMy0q3rLzQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=nS1/Twbu; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="nS1/Twbu"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f33ae12f97so5678655eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778529989; x=1779134789; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZMqsGGe14qMX5APGY1G/LDeh08IMnWvkF2G7ulrX1w=;
        b=nS1/TwbunrcxDCt3SzY9Mfc1CleKwc9H2CuxbcWjTUbyuHPknWu9eq2kLv/NSYtH6R
         wja0V0pwy3lZbghii64A3VtbBRfOlQAJe1fj6upgO39waAf53B8J/NvdwXfwPN+AcFUH
         7/pn7qlo/ux/YgbU3CNLhIgyN4CaIEP+fj4YybQ6DYxV8XWFngR++JRdSdaeNSgoTod6
         p5l+n7cJqc+cimzwZM61p9TZcSoKRE7VMzz9LG4RZhhPoRzxIAWml02Gn1TSljbAxx6j
         Y8KTgTejE32JDBqJf4eID1NHswA6cbi7NkMwbTAftwLJLXl3+LPe7ZSwNsuPgDHyNgEb
         ODpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529989; x=1779134789;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZMqsGGe14qMX5APGY1G/LDeh08IMnWvkF2G7ulrX1w=;
        b=HCzzvW7AzokJuWn0qtiz69aDxuNw0mZxGuidB/RvuLxNIU7AB3N9E9AZrsB/qywAP2
         +kCcKB4NCXA8BdgX7ohNQwF/WZZP+D+Y6cxVthfC2juvcdUI/MnqKvT0ywnhoH26AWOD
         KGDRhFYnWG0MX0En0C47ocdZ92dVnEpx0dxq8S1h/iX2ICaXBPwdcWrF4FNG64E5D5O6
         M+xxNJD4wnfRcGDp3EKeNUtAz9+HZryz6qda6KQTrIKNvJAQZKAf1dBPPiXX7F87uXad
         qRa7t/DeqpXWCtzbVwgOPum3KKpK8jwjR9ZIFrHeOgS0KwNy9HILftceVZlaKLza7BBL
         8mvQ==
X-Gm-Message-State: AOJu0YztYMVl2nuyKm45W5V2G1eekJwLk/SVIaAHOmVH/sWQj42jMcrl
	RYzbVDyvDFOjUbU5X9Ex75kUIX7aYZss7mKj7SbQySR2XOK1izs7yffjS9HaoZnyA0aFpzoi5RB
	Cm8dxqnw=
X-Gm-Gg: Acq92OGoTWcQjmNGDOYVg2Q7JC/3/CnewHcV7CiZd9/tL1I0rPZYJYWloXYR1tZih6V
	aPYjUQLcxn8p9OwbwHYry+CogiMO0ZUHtQXJlYwUPVOBQNIVBBkxnIyrmDKdgmYDufbK9XfbRAk
	Lo6lWtNg2OAmS8dDm2AKq/Z/A+I8Xi+tYGRfjyY468EUvAdeEsC72AyQXaqSJ7isoj4EwMTgJt+
	RbJ9l25LquMKc2OQSdvQtMR6qLN0vz4CFJBYsn7sFIqtilqGKZRs79uSK/bzdhbgaeaPueiQK02
	rwcc5X+/9xNu7wcH8ta4VqiJoc4CYi/Oqai8xbJfyqojvPhFM5EedgGRxIgqr6ix3qESQ5ORYDg
	fAiucCVgRhSJtLZ3EwzMAeE1TG7x0ZZdKboW3u5HCJx4fMO57ymRQsmOnm7zZ0kLqfKOrnxvAfN
	+s1/eKi/0bExbisrCYS6LvCuLIa40eXi023ftP3fIxOYJcZART8/6mk6NHmigJRes2RaOKPruB6
	/Zhndz1kzDzzmGoIuyl54Q0og==
X-Received: by 2002:a05:7301:3d1a:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-2f85d94b337mr6769976eec.18.1778529988516;
        Mon, 11 May 2026 13:06:28 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm15066942eec.24.2026.05.11.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:06:28 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH v5 0/4] i2c: designware: Improve device disable handling
Date: Mon, 11 May 2026 20:06:25 +0000
Message-Id: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAME2AmoC/2WOyw6CMBBFf4V07ZjpC9SV/2FcFFpgorSmENAQ/
 t3iQk1YnuSekzuz3kVyPTtlM4tupJ6CT6B3Gata4xsHZBMzgSJHjQrsBCQqsNrwkhtEmRuWxo/
 oanp+Qpdr4jqGDoY2OvPTlZCIWii+PxxRK+Aw0f1OpjtPN+c9+WYIfl+Fbg221A8hvj7HRrlmN
 x9GCQi6cDrnUtscxaazPhnVv1x8ZZXko1GqKIUsa1tv5WVZ3hQZJ9YgAQAA
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
Changes in v5:
- Fixed one last inclusive language mistake
- Link to v4: https://lore.kernel.org/r/20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com
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
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260504-dw-i2c-d5a1b1a0036a

Best regards,
-- 
William A. Kennington III <william@wkennington.com>

