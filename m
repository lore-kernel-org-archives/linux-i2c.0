Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D83B9D8D
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805081; cv=none; b=l0+r5tI5YWlY4lfwqOHj+utTF/fLBN3AOXkeZBsSZaIP0GtY0uVx3/7jqHEyCgVbi6Pqa2KNhAeLhfYRcQuEChQaW9NwFCc2JeCcklQek8eo27IHM/NPK8BJcV83z+/ofoKTXeUp2CodOnoUZoQWAgEJoKV+6FKhQ0ujhhrlhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805081; c=relaxed/simple;
	bh=Kybdz7vMHfQVHVOh6L5fYiSlCH/4zeDGpuUchAH7Tmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6Sae8VZYZGDzZmftFRba2fm1qhj8ruP3BBuGbNZwxVE+sfN0U63TW8QEne0EYP5Uv408XUXB8h9BKA3lENKBKx3j16mnDJQmU2rGiWTBuvDXj1eQ5TrP0iYNoM6cLYcOHhiMFLoHwQNkg4dswJ2GaJUcoDyGldOKOhEvAPOq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jUCdy8Gi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jUCdy8Gi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso42538725e9.2
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805077; x=1780409877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7+ZEzN34eEHBV2XeA10qliUnFt9aIEOrlvbEy+ooC0=;
        b=jUCdy8Gipkt5y1MdcWslWRDMUj8JgIufk+P9hRE/YWr9GaQcjwOmoEt5qBgAPYQJGm
         fhMyOvwnNEu2gT8q+Lvv/ezwTrgG/MzOvWku/AH/ansOg9CipsEdrlnMwU34y8l1KOBS
         yGCk8FHKq99skBMwZv+iY8FPTRruC2IxSIZkuxVmDp5uxYMpN4MARnAqHIs+sktvOObc
         1pxwsRdd+M+ZTolUYkhoBNwfPxVjPj78KRVjKsOlwraDzdYlRmft0W6ufYl0lF/ZAH12
         Csw9U/m2LL0Qt0h8RSMnL6ZGFWkI2K+NcSD0GZMMl1stByq7jSkFkJqHVHn5f1SOp/o/
         VBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805077; x=1780409877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7+ZEzN34eEHBV2XeA10qliUnFt9aIEOrlvbEy+ooC0=;
        b=ctrnL8I9XlN09uvv2UQkQepGYdZlRUFp9ru7EqHQYdusk0FIM1sH1acr20urTDyxpg
         rid7dKzZvZ54QLeD11uQsL6H8fpGDHDO9fy535SDfukSxar698PCeN7/39CZZnkPHlNa
         k3cjBNhrqVpHXKNZWhN+E9RSImx3incvxSfmcawIKMV8RD7BA4VTIsdfLnTkx2sGAkwb
         GhuJ/OHYZglECp+bUpzPmxajPuEGN7HrUsuPYoxSZR+u6CG/TqtDjZDZ7ymKg0fcM8B3
         HSGJaOOu6DPHW6UisrL/QUEf3pyNlieSp6u0UxmUkYoGT1inkkUdpA+SABJKI2BAsSli
         AI7g==
X-Forwarded-Encrypted: i=1; AFNElJ98tmyqaxH+XYNCmrnqa4Epcfb5W/n9TGwp4E1lIiJOzTl/jHHSne4hDCP3xGB+NNOzCbeqC+BBgMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD7gOduzFqSsrdccMPJtEOQ14UaNPIaiym6sAq0CFOjak4UQnt
	KCsqWKOzCqiykDwjflgKBK/Q1wNdk7D4ak8JAjFX4J7dhbF98SzRds+eFUf8ThhPT18=
X-Gm-Gg: Acq92OG+9RrWgv1NgQVotoIsY89TOZnZAZM59zXX1XJICSAInt6zlFAALHH71KPvk2R
	2fCMIU5havQSvjDHTIPrdWRjvcd3BYy1vQYQvfH9zipk93C6ON6ppVwCbd/UKstfiadzIglsVW1
	T8Ei+ebsMDOzofBppq3Y8TI7sq0FxlozZl/k9FfuTREJB8fDXEniXUIvwzL79h05YC12p2chtT/
	uhCi5lW5k1fNURp0B00a87cbClX80QdZe3wUe8ROwNJtx3dYVxZwdXpSnf+qtDK0ZTR8i95PXiM
	3TBhCGklcSgAC4B9ODZqhMQAK+3UWUmYiPczsFeXXsw9WbwDk2QbOU1Y/ydDa6u1OhzXGfQb+z3
	Aq6qooQ9Pmc6G9T0y762s+BUyTGomRTz3DYIapZMOOR/RjYIq8ShDCGC7grnl6WMJswmhsbiTkT
	Cw/L+/GfOyGbM49Lob0rw5hKsquNaC4Vzfh7Y20/xGQNhWF6ETc/lhe+5IJbmFErxmsmaDoZ7b6
	6lusv2Z5Cs7QC3AQ7edB3iySA==
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490426cd8c4mr332344195e9.20.1779805076904;
        Tue, 26 May 2026 07:17:56 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904526ca21sm323690885e9.3.2026.05.26.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:17:56 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Max Staudt <max@enpas.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 0/8] zorro: Improve handling of pointers in zorro_device_id::driver_data
Date: Tue, 26 May 2026 16:17:26 +0200
Message-ID: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Kybdz7vMHfQVHVOh6L5fYiSlCH/4zeDGpuUchAH7Tmw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFat2pwUr5NuB2EXH5DJBMYu0MFsCRZClzwm2T O9dYlR4RvKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrdgAKCRCPgPtYfRL+ TkGXB/437E8f30EKdaE8q56oaJt5WlihQ7/3LiGG3zpapj74Iu08O8/GcyZKo9eVo8NUFaoQUo0 0hif3fK8HhAxSruKgus+1EQhLy4QeBS7zZsfKLyQOA2B83qRv2SA46ZptWCnVfQXneJtq5rnt/p z+XAhB5HNmZ0vPCrnsT8fL9BH8Yuh3zYqxT9eUnhr+pmthPLdEZiphMZPNHOU/10eCiEJb0TQUX jspmFLtmTRiWApFBZdcAJAZ22LyP1Ls51jKz1i9KFNk3U1cVVN3KNX/HmgRm8an2jPEYqs0Aq03 oaSi8UN/pRU/wOeZjcBFx1K5Dq0XXmkIHLJB0BQbJ8js9PWI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series is about improving the handling of pointers in struct
zorro_device_id's driver_data.

While it's ok on all current Linux platforms to store a pointer in an
unsigned long variable, it involves casting that loses type information.
This can be nicely seen in patch #7 where after profiting from patch #6
the compiler notices a missing const.

Preparing for that change, all zorro_device_ids are converted to use
named initializers, which is also a nice cleanup that could stand for
itself, as it improves readability for humans. (That is necessary
because an anonymous union can be initialized by name, but not using a
list initializer.)

My motivation for this series is the CHERI hardware extension. With that
pointers are bigger than longs and thus you cannot store pointers in
zorro_device_id::driver_data. So this series is also about getting
support for CHERI into the mainline, but I hope the clean up effects
mentioned above are justification enough to accept this series.

The dependencies in this series are as follows:

 - Patch #5 depends on #1, #2
 - Patches #7 and #8 depend on patch #6.

So if the ata maintainers agreed to merge their patch #1 via scsi, and
Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
#2, #6 and #7 can go in without further coordination.

Patches #3, #4 and #5 are only about using the same initialization style
for all zorro_device_id and can go in without coordination.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (8):
  ata: pata_budda: Use named initializer for zorro_device_id
  scsi: Use named initializer for zorro_device_id
  net: Use named initializer for zorro_device_id arrays
  i2c: icy: Use named initializer for zorro_device_id arrays
  video: fm2fb: Use named initializer for zorro_device_id array
  zorro: Simplify storing pointers in device id struct
  scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
  video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

 drivers/ata/pata_buddha.c             |  8 ++++----
 drivers/i2c/busses/i2c-icy.c          |  4 ++--
 drivers/net/ethernet/8390/hydra.c     |  4 ++--
 drivers/net/ethernet/8390/xsurf100.c  |  4 ++--
 drivers/net/ethernet/8390/zorro8390.c |  6 +++---
 drivers/net/ethernet/amd/a2065.c      |  8 ++++----
 drivers/net/ethernet/amd/ariadne.c    |  4 ++--
 drivers/scsi/a2091.c                  |  6 +++---
 drivers/scsi/gvp11.c                  | 17 ++++++++--------
 drivers/scsi/zorro7xx.c               | 16 +++++++--------
 drivers/scsi/zorro_esp.c              |  2 +-
 drivers/video/fbdev/cirrusfb.c        | 28 +++++++++++++--------------
 drivers/video/fbdev/fm2fb.c           |  6 +++---
 include/linux/mod_devicetable.h       |  6 +++++-
 14 files changed, 62 insertions(+), 57 deletions(-)


base-commit: d387b06f7c15b4639244ad66b4b0900c6a02b430
-- 
2.47.3

