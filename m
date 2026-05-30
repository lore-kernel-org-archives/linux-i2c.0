Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BE1C5F11
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171597; cv=none; b=KYFdU1+qbXePg4ojahlMt1EzBuTftHKf5sx/OtHjKdCpBwnqdyQyv55aP+QeJzMC0QkhmalCDNe6MP+C8TEKmsUHV0jslfW0pfo/fAXYrjRkAzdL4M39dleuUUXMwyWYfwTalObdPWtGCrt8BIOf7e6tFTb3smDQHDuWB13cBJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171597; c=relaxed/simple;
	bh=Dkf3gAZAq4XvP+PgcFLo58+/0+vf7HIbUq0GZzd+Yhg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uoJ6JNxhcJU7yEIU3eWXA880kLmCbjkaV9zIGyg26sgaIAS1lP1w/rdemB/uoaoA2bizd4bzoGhnmAeZgTNumNAuZuR8/vVN69g11YZinrAZAvKv15JZNXMqbEuQY4sD8J14AVInYBQrsVaCmTk3JyoZMmd+VFyi33EIrhS1J3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=HwooL6CR; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="HwooL6CR"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304e58292d3so4337235eec.0
        for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1780171595; x=1780776395; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iR5BKOFuuMA9SGOWYLy4bBf+ZgDv0FPHhDOTlvm7N6o=;
        b=HwooL6CRcZ8mPHZy0QpZgVzbxQtTSlGNNSukVv6CgnCD3dih0mskw9LWF6ApIRZup+
         USnGf2niPqgTz5b/emuw5A711JsYdTSVTkopCeujl6VSEGSbIvso72fPpZCNdbn6ORjk
         I5xXH2GXK6pwUfjV0GBaPvX5RqK3HDcft4RH2wfDhAzurCOogiOO0cwXh5uWBq+HZv5V
         SqdMQcLGxoJIeI6+3TyENBoefXdBlof3duEXz4sEhKWI3EP3jHEx3t0mui33QPmyQ9sQ
         skFq7xr+uypBdeh8JKh/lL0Zbg3jg5xwES0NFlSgXjQSxJt0qpiEUlT5WDQfDojXU1Q6
         z8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780171595; x=1780776395;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR5BKOFuuMA9SGOWYLy4bBf+ZgDv0FPHhDOTlvm7N6o=;
        b=CM1P9wZyw/QIzNubF2dloGPe21UjbgUUQpehkEnbVNVKmv3ukFAXxMele7gRwkynT+
         7Lnm3ERne1HDMbP2BJlIoi8gtsam9kwcuB5xBo8q8USS+ozOU5Vuk4ZlRA85syjbiV0N
         9sEabJ82RHNeS2u24bjtBAXWrHxLc15bFfyIKaubSu52VcLCOPozGiK42v+J5BtNVEqX
         14pvhh7OqgL7M/ASBMCPdPuNQMR4Gk/F3RYzpaJgLSZVPdrGnZt/w3848fpx4RPyFRHC
         b5ZGiXUixVnXY9u20GWVTG9InYDJdJMOTESR6dU0A+7CU4nqDm3T/OHFyXa9UAILIE0e
         UENg==
X-Forwarded-Encrypted: i=1; AFNElJ9w9ZVAbd2/lhYvazsUS0f1u6OwqagGaXrANy122xcSyBkUXqJC/xorPB0fX+ncQKUR+A13GKywA/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRENx+SEDLTiFpCaMwMixhIpX239k3/ppF38MGVLIBbRi0T084
	Z0g79UY6+CXA1nGx/qV4wSCS9R7b7acA3trw37umxg1Owjy2fmWyoZMJiO8ZLRTZpgrIxdjBU6B
	l9gTT
X-Gm-Gg: Acq92OFaI63owqiwJgbk30Th/IXpDYIbV7coW+bGWuzDopU4tgDNxfrqr/lB2R2NPX1
	f1VJ/1APnrAq0EVrsqzdg4WlA+CeDVE3ZzC3OAptixS/MvxGqQX/P2hrqsQjcH3LBxIcFddVqy5
	n4lsZxob3Nzr9RqgjOEFAy/71/cXVaiM8/fXD1vZnd46Y1w8dTfJPwfmAEyyks68cTDhrBzBiqn
	iRt5mUYcr3YTDvTz88l5JlWtclFaka8Mr+P+pDyrnm4lzvEfjbwfPEU0GR9CEI845A+syxA8GA2
	/Gb+CeiB1dzX3It5WeW5xBqxfkYVl6n1VVV4v08YOA0doj2H9TyinKxrU91ZlaNES/Swuj6JzJc
	v27iaMAhYD//Klw1tFhU73VGHekP1WPzXazE0l/4Lm+wmBDZSKpzIOeRX+qb2YJxE5jFIfHlJxk
	g38lBp2pgWgcmCwwFB9KLHW+yCU/5xdiFcmY/jmp+ib/VedBz+ftqjtJcOrXuVFy62quLFX74rm
	oyAm2w=
X-Received: by 2002:a05:7301:fa06:b0:304:705f:e4e8 with SMTP id 5a478bee46e88-304fa746836mr2485910eec.32.1780171595242;
        Sat, 30 May 2026 13:06:35 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm4791484eec.24.2026.05.30.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:06:34 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v3 0/2] i2c-tools: Make tools accept bus path
Date: Sat, 30 May 2026 14:06:39 -0600
Message-Id: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5FMBCF4VeRWZukFAmvIhY1HYwFTdt7IxHvr
 lh+yTn/CYG9cIAuO8HzX4LsW4LOM6DFbDOj2GQoVdmoWis0ROwi2rQlRmfigrVui6ailgo7QTo
 6z5Mcb7QfPoffuDLFpwTXdQM0fVMAdgAAAA==
X-Change-ID: 20260530-accept-device-path-539164c9c1df
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: b4 0.15.2

The purpose of this series is to make i2c-tools userspace utilities
accept an i2c bus character device file path as an argument. This is
useful, for example, if a sysadmin creates udev rules to create a
persistent symlink to an i2c bus and wishes to use that symlink with
i2c-tools.

I've tested these changes by running i2cdetect, i2cget, and i2cset.
Please be aware that my current test setup has an i801 bus controller
with what seems to be no slave devices connected, so my testing has been
superficial, involving mostly failed read/writes. This patch series only
touches code that actually opens the character device file, so I'm
satisfied with this testing. If maintainers prefer, I'm happy to test
more rigorously.

Since v1:
 * Scrapped brittle checking against device major number 89 in favor of
   an i2c_bus_hint variant struct.
Since v2:
 * Scrapped i2c_bus_hint variant in favor of combining the lookup and
   open steps into one function. No more awkward variant.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
Brigham Campbell (2):
      i2c-tools: Allow passing device file paths
      i2c-tools: Document device paths as I2CBUS arg

 tools/i2cbusses.c   | 40 ++++++++++++++++++++++++++++++++++------
 tools/i2cbusses.h   |  4 +++-
 tools/i2cdetect.8   |  8 ++++----
 tools/i2cdetect.c   | 14 +++++---------
 tools/i2cdump.8     |  7 ++++---
 tools/i2cdump.c     | 14 +++++---------
 tools/i2cget.8      |  9 +++++----
 tools/i2cget.c      | 13 +++++--------
 tools/i2cset.8      | 12 ++++++------
 tools/i2cset.c      | 13 +++++--------
 tools/i2ctransfer.8 |  2 +-
 tools/i2ctransfer.c | 13 +++++--------
 12 files changed, 82 insertions(+), 67 deletions(-)
---
base-commit: c1b0305972e89aae048068a3b228f35ef0206243
change-id: 20260530-accept-device-path-539164c9c1df

Best regards,
--  
Brigham Campbell <me@brighamcampbell.com>

