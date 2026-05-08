Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC31F4C96;
	Fri,  8 May 2026 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225204; cv=none; b=hqR75SmBKg9NSCy+IMgwPLlsmOsMCQWUdAEdAQKFjW4SyfT5AYrFsQr7mgo/xvLHzhqsagGRtcP2q6+sgA/NfL6aN7/cIBi7oGQYGQRGIQLDq9Q49UttU3d48fMzhIn6+b6f2BRcnGHpNHKccBkfysHqAhOxzV1w8VesFwYtLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225204; c=relaxed/simple;
	bh=t0iT1saDNopm8N/Dw0qzpSNK32VVGz1bHAzuKx2zHbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jgAnGpEs7FXqA39SQZBcUAD78VW8OqO/5F+o/mOuKQ3yejnsfym7PerG5pPpDNFr9yKVTZ2d8exJM0Ibgq4BCWv2r5YMR7RKigWmWzh42AiPac00WcWK8pgSaL1sHsauB2T1j5BnDIietGKYG7/RWcvr5u9ardfDD8WGyBsH6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Gzql4u53; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Gzql4u53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1778225135;
	bh=aDafb0KThGoqOueki83VGOVa8B/S9bZP2j/TNRMvg7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=Gzql4u53bknGCFHEU8YK+ATkJw1FMDjXeccmTzW2824yTe8yaeN9j0T4txiyk+ijk
	 nDp2Wyg25oAvUXH2FQ3R62oRHkVNssoqYbQar9+rXRMm/XQVMT+pKIem5/XOCdYKyY
	 50wUwz441+DAzonWhX5ox16ossQGV6A3ar9M/MHQ=
X-QQ-mid: esmtpgz13t1778225128t866bb93f
X-QQ-Originating-IP: ouTyUzmBkrF1W39rEIzn8KMC43v4OoeI/pgFflwPQjQ=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 May 2026 15:25:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9382545522023586711
EX-QQ-RecipientCnt: 8
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v7 0/2] i2c: spacemit: improve clock handling and cleanups
Date: Fri, 08 May 2026 15:25:23 +0800
Message-Id: <20260508-k1-i2c-ilcr-v7-0-8c2dde5c3ed5@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMywrCMBCF4VeRrB2ZxFxaV76HuGiTUQd7kUSLI
 n1304KIoMzqHzjfUySKTElsFk8RaeDEfZfDLRfCn6ruSMAht1CojETp4CyBlQdufARfqiIYJI3
 uIPLiEunA91nb7XOfOF37+JjxQU/f386gQQJR0CWuyYe63Dbc3e6rdKk8tXxd+b4VEziYD6KU/
 UYMINSmQFe7EJDsX8S+EYtald+IzYj0rjL5ilrpn8g4ji+CWZepOQEAAA==
X-Change-ID: 20251017-k1-i2c-ilcr-c928d50e407f
To: Andi Shyti <andi.shyti@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778225126; l=1169;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=t0iT1saDNopm8N/Dw0qzpSNK32VVGz1bHAzuKx2zHbE=;
 b=atO3d1QAKpNiW7EeJk+pyAE7fkechb/xyiVyTRZuANNFdwFz22JpsTZ7PvViZGUb1z9Wgx1N7
 qljNB8HAmOhDdEFOL0paonoHSXrQuhj0/pIyzE8JR+kNvofIvKUIL6r
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NbSHHwExauhJl9MSvgO5pMTq6cDn06f3nu8ha6dgkWRsvn/pCD412Gvl
	f8x4KAI4CAlRM5KiuwkiG+gNMpwsL8OM9No7Y1pY20Ru7x9n94yjvt8VMKB4V3g4dlANJ6g
	Erl0p9RoXeqP4hwDDw+WoTxcKkg3mf/KE2UzcdRaKpdnOYkb/JJ/d4boT8z5QoNu1Z3BGYw
	qREVu4pI9w+x1GU4LJQ6PQ8ws2Iy0cmKZaS58pmh4DxmuiX8LRbLnWU2kWTTdgQUjPcWrjc
	YpDuCIuI4ZbIAlPeJkhs1jCGeU7L6RAboq1px3UAGfIIIqO5kIrgfuYi81JwU28G4VIlH9Z
	xOSJVipu0PdEfBsVpIRfsb/uURzihbZQYFXQy2QkP40oY7Wrl3siQdJv8GPUgnoHKBGByPu
	/z+FnC7eVYQf2LKnYyfGSV8b0KP0G8ZIjBi/Qw/M+NUuzZe1BhCdVGCWdiFzs6GKU5215bt
	8tssFM+nuSpVxVa3XaG0KeVn4EAn30F+hE+EiXoQ8DXgBxQh/ZePRLIIDtn9i850x+rOsFA
	T1ZrnxeGcCXWGxW6ikd2Mq11/OBCSDsS+A58LpLgiPgr27Gax1n/HwIfeJp7wcpK/DwU0UU
	iziEWL7u+As2ZDrm9ucJ8kW41+SiBg+pljpfRHC3ZpxBWp3IfLySuQTXTkx01DH0s+tVRXc
	lMouKnlqKKv+UGcUskh46BXx2UvovS3/FhGavrvXv9bLfu7rNoZy+9Su9MbhUVGnGSAOfhL
	u+9jUvl3FW2MlbI1KSVwKySHBwUcZDYr8vliw39NmHuFxt2LJWpjy+6ZEFT2zpEcjlww/ax
	KMuwCPNa3DHrV87nPiZohCg/3HRpDzr/MrZRbEgT+mPOozZoIOd36XEia7MG53US4E0Y5IR
	kufTXR6NkkIxfk4whD+AySonweZVGu5HPzlAPyzFtTjD+79ISJEaxw4HBzKSiDG1AYXIVs9
	J/2lAeY7wxcDkWM2L6kTTj1zHxvJiFwLvit8Dpy+rj++N2FDVupXGIqUBL56DS2SJ86yQD0
	4C249ms3t5ZGUtz+70H9721w7Ns/4ZOGFbNMikPjmHCJ1ysUOA8cVZYdS3UZ9dQO507zS77
	gkhe8lO0CckUhjCNOLEGiPq/VzM5WUhwXNqZpC7C28lZ11ErsEljCLMrNUOAKfmGrX3aUWr
	H4y1oqJH5x8EyZNvTwS5B4G1Jg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

This patch series contains a set of small improvements and cleanups for
the SpacemiT I2C controller driver.

The main change in this series is to improve SCL frequency accuracy by
configuring the ILCR register based on the requested clock rate, rather
than relying on the hardware reset defaults.

The ILCR is exposed as a managed clock via the Common Clock Framework,
allowing the driver to program appropriate divider values for standard
and fast modes.

In addition, the series removes a spurious warning when the optional
clock-frequency DT property is absent.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Troy Mitchell (2):
      i2c: spacemit: configure ILCR/IWCR for accurate SCL frequency
      i2c: spacemit: drop warning when clock-frequency property is absent

 drivers/i2c/busses/Kconfig  |   2 +-
 drivers/i2c/busses/i2c-k1.c | 178 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 168 insertions(+), 12 deletions(-)
---
base-commit: 9b45dba17a6b3cede80706d287d8d2fb9087bfa9
change-id: 20251017-k1-i2c-ilcr-c928d50e407f

Best regards,
--  
Troy Mitchell <troy.mitchell@linux.spacemit.com>

