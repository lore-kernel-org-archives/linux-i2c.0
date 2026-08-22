Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C746439060A
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434809; cv=none; b=Jad3TcFmfQJVBaa3cFDWGaM2NIbvm4oPKNQdPkvl8OcjU257yMitNeOEBROoJomWT2zmty70bogod+ArDtaAKQY/kiHevsqC7E6D75JWuGTgvYb1T70MESQWHkPOSTy8tqzSf3NzSqmDuYta4H3NdqAdMAHqMZn94raIod7Z5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434809; c=relaxed/simple;
	bh=KVdVCQFws2YHcTf23OIbqpRHGvWtL05gPa/MIQhexKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMUlD2IDwolDYynT2VDhFoWguDDmUG3Q/TAnOUuEd+fNH/FuYoF0jezmG9PvFJMvmzq+DPUc3DL6ouylOMHFNPHUapYkJKln/OTva3NuM6cwyULFl9yfH2EWJb1I9PXovVOAyCnEaBsr8NdOVCxBU4rrFPgaZ29RSXMOtu2WdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCZ626GC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCZ626GC"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1712a04ddaso364422066b.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434804; x=1788039604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgMbZ8S6nkK5E2O40RbnDFU7z8jdbPLfNie0mYT0a4w=;
        b=fCZ626GCLhBsDRzFUNLU/YDlvTHSp3ZLtaj/x8sIhfDruvwrr/H0AKWZkCSolUukZF
         WQojYuU4cwqBEAfa5fBXHJrNUhUUbex28qO4zNaEMXlJW3pmjzlJiBX5Ixit2mVMWiBW
         qGBfuaowEhbb1BAAU3huh+a/+GkL0PzLP3tNMrr41/lVgXKqV+PdIGAjv5vIdkKd2YV9
         vM3sA4siiq1uxAEkNYnFBJRN2w1uxc0isKVRnuX6Gfgxenw4WVYrR9iK3EJfXrKt91ZV
         MSD4HSHdPs3yfPSPHEWcv97lEEFe5IgCo8NW2c0c2xZ7v2vBSE0Z+bOzokZV4OxOIR1b
         jN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434804; x=1788039604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgMbZ8S6nkK5E2O40RbnDFU7z8jdbPLfNie0mYT0a4w=;
        b=BReQ5vBrvaj5u+lftmltUSom5XPdz25rtenIazfm2VGY/HRKcSOUA3MwTOvB8T8wR1
         koI/mt6OGIuqYxTnia1KL1OH7h0ZRRHfe3/lnhJ13QSijoVVkN8PA5eP7OTLfyUonsna
         ciH/ysdok+iDCalNk7qkPz+u3+JA0ZzYPywq1wGjA/Wkybof+WYHwleLfam5FntvfQxg
         5qY2gixgZPwcmMb491SPpssG3aKvSLs/MuLzBDUyd1Rr9zCyw8Y0OrOaPmIyI4UPxLoL
         6z7EbHqs8aLaZfnvNxdYyyB61aoQ0OitoilMo5sVODl4UalXZW6oS7Z4JxVcPftW5dgx
         PvjA==
X-Forwarded-Encrypted: i=1; AHgh+RqzaguQk6K/K8SzgK54gHl3eLB/FKf6+ucjsxYYDLhWpdhWoAq4cdISJAD3a15a3YOKTfR0SZId9/g=@vger.kernel.org
X-Gm-Message-State: AFuF++mBKlc9GHcFGuGzHWLJab5QDRXT54F9C9FQrh1Y+l5LFiNdWCqg
	SswmcV2pSA9QVd3cqflovg5uYG1XpoGjJboiJlYFVWDMngDRJIUri1iC
X-Gm-Gg: AR+sD1363Nupo9QKv1SiXoNYtz8MaggPA6KFXvMuOEocnVROwUXNFpso/z49gu32nRu
	QCYbi33MY9La41Gi/WRoxpuLA2Bsvc3k8icCiAXRSyrn/x9JQcs0zQ2hr/2yXQfOiOsSVFdzgYN
	fp0+DWhi8pX+Cc0/RA0y8i8KuFzijC1I55IFnN58GNa7JPGgjmizIL294WRessXPWxr6sBTQTTd
	/2gbXBgav6ghHOPhItVqwBoxhzUQTY5Gf1J88+6+Pk32IW04GuyBUfbSirbsVC95TgpaUIZxxHU
	OVkBywVi/N+pN3XZCd/EJH7TD0jWc8HlNaqoCibirQuT4trf8Fsj2KYSDGrixpdubNKolQy5IEX
	4PQs3GzsFFj0INn2/6AsQ9DwJYUULCHohDSfKKrP0V79CJtntdZ7AYdqYP27Z3b89WO4Cre8+Dz
	ASUL5JoRr2qAglYoJi3M0MXoU+aZbU+UMHhCHt8a7Sb4gDtYO0tjUojyjwXmWZExfQxHsNvA==
X-Received: by 2002:a17:906:7316:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c2491cbca79mr901591266b.9.1787434804173;
        Sat, 22 Aug 2026 14:40:04 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:03 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Sun, 23 Aug 2026 00:39:28 +0300
Message-ID: <20260822213941.98882-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mainline supports only the FT260's I2C bridge. This series adds the
UART/TTY interface and GPIO on top of it, and carries the I2C fixes made
alongside them - two years of out-of-tree work [1], now replayed upstream.

It picks up work that stalled twice: Christina Quast's serial driver,
posted as v4 and v5 and never applied, and my own pre-UART GPIO series
from 2023. Patches 1 and 3 link both threads. This is a new series rather
than a v6, being much more than the serial driver now.

The patches keep the order and the granularity in which the work was
developed, so that authorship stays visible: squashing would fold several
people's changes under one name. The UART and I2C changes also interleave
in the code, so regrouping them by interface would mean a rewrite and a
full retest. Only adjacent commits were squashed. Patch 1 is Christina's,
patch 10 is Rio Liu's.

Tested on a UMFT260EV1A with a 24LC512 EEPROM. I2C - reads and writes
that cross the 60-byte write chunk and the 60/180-byte read chunk caps,
SMBus byte-data and block reads, and the shortened read timeout with the
abort path of patch 13. UART - a 2.8 MB pattern in both directions at
115200 and 1.5 Mbaud against an FT2232 peer, without flow control and
with XON/XOFF and RTS/CTS, plus DTR/RTS toggling over TIOCM*. GPIO -
through libgpiod and legacy sysfs. Every commit builds with W=1, and
checkpatch --strict reports no errors and no warnings across the series.

[1] https://github.com/MichaelZaidman/hid-ft260

Christina Quast (1):
  HID: ft260: add serial driver

Michael Zaidman (11):
  HID: ft260: uart: bring-up fixes
  HID: ft260: add GPIO support on top of UART
  HID: ft260: i2c: reduce driver module loading time
  HID: ft260: i2c: silence sysfs store big-numbers
  HID: ft260: i2c: reduce bus-error message severity
  HID: ft260: uart: enable flow control
  HID: ft260: uart: add modem pins control via ioctl
  HID: ft260: gpio: group sysfs attrs per HID interface
  HID: ft260: i2c: fix large write transaction failure
  HID: ft260: workaround for TN_189 errata endpoint STALL after
    enumeration
  HID: ft260: i2c: abort in-flight transfers with STOP before reset

Rio Liu (1):
  HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR polarity

 drivers/hid/Kconfig     |   10 +-
 drivers/hid/hid-ft260.c | 1967 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 1830 insertions(+), 147 deletions(-)

-- 
2.43.0

