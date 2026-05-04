Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B230C35F
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925706; cv=none; b=p1m7U58WpLCDqmm1VFWtLWystxXhdZ/qqnAP8oimyZi01Yvwp/NYM1ec62FNqkyORKlLIbww49Da5kEBwxm7muE0Q6LOez9fxMsRw8A0Q8frplo37FWx4NoZ7phOOQUg13VAhSIfobdJb0gca2eOIYnO/Er35lsFqpCVoU5ldWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925706; c=relaxed/simple;
	bh=9vn7X1cFXQhnVIX0+25jhvD6H8am0z4d2dfDWHkbYFs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BD84OdlCIgiD4EmtcouyGh3jSfIS4brGLB4Vrsmb45WJWteFWJ/q3TNu9+Y/mhqwuPW4LnF/bAG8nR8Xg6gGvzvqHrTL7JZfuwOLYJmzi4GxyYmWL/+zPA5jDSKg9bvE0GAxxi3zJUJpOpm5hDJziE3/Xec4r64G0i8LZDXPoio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=MmLHdK73; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="MmLHdK73"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso3602143a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1777925704; x=1778530504; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JncDsFrqz5GkrK7t2Hvf5Zk4e+tKDJkmbRfcl1fMe0U=;
        b=MmLHdK73/O7iOZ/IPKtJ3ejO33c8Z79kSs18UT80dnFNeCT6TkI9ncEDuLz2gEubQU
         ixMg/nzFVQYL47FImf02LA+BWs1VHq1o7XiPFVFJOjjLkTP60QaUGhTzN6J24xvb6ecr
         W7oaQ6DwW/L7FTW/xvNGW9v5cwW+RUyvMjVsVVLsGuM8HvpDuFOlHcJ/fx9+KPgXsQ75
         inT/KYoxRMraVTCfjagOsspVlogC7gV8gnYWaxgWTb6sOtHecT8hWez18KSf26Iu2ZiF
         MtaSVki7OTtbRS7gxDOh2oS6yMx8/s6vyBoM5atp3RwFlyNvi4FQI6J6xy5Kuw6WGWpT
         7r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777925704; x=1778530504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JncDsFrqz5GkrK7t2Hvf5Zk4e+tKDJkmbRfcl1fMe0U=;
        b=kvw/uTvbixkiIbXPXkZUISZq4Qp/AYjf531OsZQhydgSnz19a3t2julFKOQwoBbCdp
         l3BXK79WxAn9IIaAVPhZG9zDJQb33Ye+Sn+c8mneLofJaJZmFdmcBoVAINN6Jp6nEwwl
         j9FjznVV0zH+Pp8RqZNfsM9rGooiqwsjxy2zsMvBRcLnW/Z1Q4+arJkpuQUfTZjohdw/
         HdR2539I/10UXAnrMmVX8gSOzMWnbWGy6aw+/LHG6bMu99Xg18AdETdcua5xVGaTEw2i
         DdvITg6wu5T/96ucOvW4Cj+nnIvAZtk3MuccT5pXHDE3YZCF+oxzmJmcDcHG1ucePMcf
         E+3w==
X-Gm-Message-State: AOJu0YyLaGvnl92TzarcFgJomwzNtRxiKEeYioo/6fp7RxagSyhGxT+m
	F6ELRU9a6kEfqEOU1FOw0ZMh9oNUnhpwQsuEsnkxMfOmE5U6sEvd4uGBwM/oPyQ2tCE=
X-Gm-Gg: AeBDieultZiQdh4Yhk5OA5cbmVY/Z5piigOlQx7EyO4OWo10e1PQGDRng4zgfoo0+Jv
	crvVxGr9lWXPNgtqKi2whLGpoHcpFjpRHlVxty0ozwZ2hYYyK60DSXY3pFuq5htMDBjeHN6Wdf8
	ywjbWDia1mZjAYQOOI2Nk+P+rPWco+yM0cNecJlBLbw6e3CM0V0OJT/1UjkHKgylDjhKfps5C7k
	hxoz/dx/c+lGDNjZwVduBeqHe/sTYc7pvppCwdjnFRUNf3/lLmk/Ivl7N9CWHbCQpSUMQIOJGn1
	3wFa15hIcrDtwf4QOozQYRy8GhfOXeIJ6uCWCQcHhqFVu7PyDORBtr0KBQlg54PM0Bvf5NGPSui
	X1APwYaKRyvTuMU82DBQGDVn7vgjVoLxI0w1y1wtCPzzLg1wJfeIiAd+9AFx168/lfDghIvU+nO
	HQAq6akIHIiX9b3y8+p6zTUwo8fOmO/t6lX3eDqWuDgV13NRtAbcb7QGkRgfx/kqvtKBig9TbyK
	sd2JIif4OfazdX3bS7GQ03OYg==
X-Received: by 2002:a17:90b:4fd2:b0:35f:bca7:5d22 with SMTP id 98e67ed59e1d1-3650cd5a9c4mr11120425a91.10.1777925703657;
        Mon, 04 May 2026 13:15:03 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm20568593a91.4.2026.05.04.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:15:03 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH v3 0/4] i2c: designware: Improve device disable handling
Date: Mon, 04 May 2026 20:15:01 +0000
Message-Id: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEX++GkC/0XMQQ6CMBCF4auQWTtkWlqirryHcVHbASZCSwoRE
 8Ldbdy4/JL/vR0WzsILXKsdMr9lkRQLmlMFfnCxZ5RQDJp0S5YMhg1FewzWqadyRE3roMRz5k4
 +v6P7o7jLacJ1yOz+c6MbIquNqs8XsgYVbjKO4qbb9uIYJfZrirVPExzHF31YnwyZAAAA
X-Change-ID: 20260504-dw-i2c-d5a1b1a0036a
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

When the I2C master attempts a new transaction while the slave
controller is shutting down or restarting, it can lead to bus lockups
and system bootloops if the hardware enters an inconsistent state.

This patch series addresses this by ensuring that the internal state
machines are properly cleared when disabling the controller if slave
activity is detected.

Additionally, it adds a shutdown hook that gracefully sets the slave
disable bit before disabling the controller. This guarantees that any
incoming requests from the master are immediately NACKed during
shutdown, preventing the bus from hanging.

--- 
Changes in v3:
- Split the monolithic patch into 4 logical patches
- Reverted stray formatting change in the PCI driver's dw_i2c_driver struct.
Changes in v2:
- Fix description footers
- Fix emails

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
William A. Kennington III (4):
      i2c: designware: Introduce shutdown exported function
      i2c: designware: Convert PCI driver to use shutdown hook
      i2c: designware: Convert platform driver to use shutdown hook
      i2c: designware: Handle active slave cleanly

 drivers/i2c/busses/i2c-designware-common.c  | 32 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  5 +++--
 drivers/i2c/busses/i2c-designware-master.c  | 31 +++++++++++++++++-----------
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 15 +++++++++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 13 ++++++++++++
 5 files changed, 81 insertions(+), 15 deletions(-)
---
base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
change-id: 20260504-dw-i2c-d5a1b1a0036a

Best regards,
-- 
William A. Kennington III <william@wkennington.com>

