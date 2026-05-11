Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0E371860
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499454; cv=none; b=egdpcoFYdWf2yB0N1Tl6pHU5V5ijyIKF1FYEbQpIgQsfwaloynmaK0V5IY7ejp46DlzV5hwDaXVk7NfJlMvQylGRlfz523pxZPf2e0QZSkzSVVUqG+f9BYI2QRkI0iw+AKwgIIpCbiy0gG3QXPSmW+8gSDlCexqX3zabONk8Qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499454; c=relaxed/simple;
	bh=Tym/BVOy9NE1Qeg8K8Acp0oOf3Og5IzMWvx+9ry5rNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgkNxS+GWFOU6g6O9jJM/2efgxajnPKaRl7lv46e/vF0HJXP8vkVlZfWwvNuTNrm2i+rgW+Hrj3dbJiQ4cgru8VKmeXu0QDTGzQPNcZ50ujaAHOwHr6tNfsg74BZf4/GarVjl+1v9e5r2yl9ncpRQJcjBWE0n0BpUN9KJtg8hxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1cUmrgP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1cUmrgP"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a40502e63bso3722392e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778499451; x=1779104251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhUH2tKMkut60kZmw5C1AVWBW1sMGkeiu0EpNEsXCho=;
        b=E1cUmrgPv8JTetP+QYDI4HvOH5SuGPwmaSvakbw4dxvGTN88Ei5B2ab+OKYl1FNbJ7
         KGRQiNzAniMQ3dvgrXSMobtXOajoWIude4ViiY92nie5bKzrlKENfSOmlXVbth7W91OT
         S9BBq+5wvTO2N9I27YEZsmOIF4arj7lN91g68EG8LF4fKacDspeF1p5OVGbmS9TBT8vP
         5U6RaBwX2nyOwkLpvu/Gx2MzI4qdz0WZ9vbyTyJv1jXcpfR7cZtkvbeDtdiOxXGmVLfR
         VA0qMaExmaIE3Kq130MOGhLmkBjtL18pLZqFPr0iNFDQcqFkdaHcDWyYO6Hw01wBSsyY
         4ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499451; x=1779104251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhUH2tKMkut60kZmw5C1AVWBW1sMGkeiu0EpNEsXCho=;
        b=BgJDtf95zj/VpXpHWmRB008TTPbRegCisaBTycJRxhrWGChFFZzHYZb0rQ2yb2b/5e
         zeabyBn5FubfM2U1yj0vRaXo1sqX12mV+BlF1sJsm1ttQ4rzerYBLo5Ym4um8xu9Hj3+
         PFEzWWODWkrO2/X5DWdPWtJI8lLcMLGI72tPTQ1NEr1fYAKb3sc3xa0Flom5KpBgTeAh
         4e6YY+ZlHcofmSnBMiPRgles4BacgsS/KEpmt8CiS67PIkbWQQzwWegGdGZ+2ZRCs1uM
         cXnGW2wB/E7kLkxLB4ST9gCV83uvPA6CgIuzI3d8oO8MgAW3/H0OXnKmVy8aj7V7sVS/
         19tw==
X-Forwarded-Encrypted: i=1; AFNElJ+WwDw9iqiYYNZYqOHmB6rs0YGe+eQECg8z1iuWk71HZTIXWx8TksL0bSChJ9zAVDFyKU4IgblS1p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kp10gicRihgx0iY7mGz1NvW8i8Bf2yVBiCzDwBRz+yJX0hQ1
	TN/2b7oiRxnBg26f421bdSa0aFvO6iFA9KgpPPSJiFzVXSOszz8TjzZq
X-Gm-Gg: Acq92OEGm2bALhi8ia63Q7LRoIJ/YlCHqCrDGzmGE0GgQCDlVjrb5b6lQZ68SzpNaZM
	IP+oGHKuArSibaNAORGedVcpKcUuF8lkrcM1R7jyZb0lg9MW9kiW38rVKZ9uyeGlKSt7wed5GSI
	0jmPIzaspooqVeob3PKMpIV4benrp2QItO1Xh5oBIaFEQnGvYTr7GuzAp7ZQfoMHeFTENo8D1Hy
	BRBYox27OJ3wfMP8cyFuUDfsTbARXSfUlr++SfAtlCSB1JrtAi0XSh+PG9C4ewv8vCez9xPzShy
	iDhlc9X+Sl7TVJh1PiF5FmTQJ5NEFhsV8AqDxx6LAjIX3P/gLI66RYecrw0IF3EOB0Av67N3sxs
	f5NEOYUlfhZ99N11kWEJGSaiQqaC9xsMB8VIdko+QoXNIdq0bHv6T6a07N0CRz4OF+zYJBjtxQh
	FIUU2iPu5z1CFp5TdhyR2gExRpv7epTZPSMv8MKM5O5eLw8A==
X-Received: by 2002:a05:6512:1543:10b0:5a8:886a:1164 with SMTP id 2adb3069b0e04-5a8886a11ccmr6107757e87.28.1778499451179;
        Mon, 11 May 2026 04:37:31 -0700 (PDT)
Received: from C-PF5D4647.localdomain ([147.161.186.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956b1cfsm2593967e87.73.2026.05.11.04.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:37:30 -0700 (PDT)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v5 0/2] i2c: improve bus recovery for single-ended GPIOs
Date: Mon, 11 May 2026 13:37:24 +0200
Message-ID: <20260511113726.49041-1-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
References: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bartosz, Wolfram,

This is a respin of the series rebased on v7.1-rc1, as requested by
Linus Walleij. No code changes versus v4; only the base has moved.

The series addresses a limitation in the I2C bus recovery mechanism
where certain open-drain GPIOs are incorrectly identified as
input-only, preventing the recovery logic from functioning.

Following the earlier suggestion from Linus Walleij, the previously
proposed "force-set-sda" DT property has been dropped in favor of a
generic helper in the GPIO subsystem to identify single-ended
configurations. This allows the I2C core to reliably enable recovery
for open-drain lines regardless of the instantaneous hardware
direction reporting.

Merging strategy (suggested by Linus Walleij)
=============================================

Patch 2/2 depends on the new gpiolib helper gpiod_is_single_ended()
introduced in patch 1/2. To keep this bisectable and avoid build
breakage, the recommended flow is:

  1. Bartosz applies patch 1/2 to the GPIO tree and exposes it as an
     immutable branch.
  2. Wolfram pulls that immutable branch into the I2C tree and queues
     patch 2/2 on top.

Bartosz: per Linus's note, please could you pick up patch 1/2 and
offer an immutable branch to Wolfram? Patch 2/2 does not touch any
GPIO file, but it is the sole user of the new helper, so it cannot
land via the I2C tree until 1/2 is available there.

Changes in v5:
- Rebased onto v7.1-rc1 (no code changes vs v4).

Changes in v4:
- Patch 2:
  - Use GPIO_LINE_DIRECTION_OUT instead of the literal '0' when
    checking the return value of gpiod_get_direction(), and drop
    the now-obsolete FIXME comment (suggested by Wolfram Sang).
  - Added Acked-by: Wolfram Sang.

Changes in v3:
- Patch 1:
  - Changed return type of gpiod_is_single_ended() from int to bool.
  - Updated return values from 0/1 to false/true.
  - Added Reviewed-by: Linus Walleij.
- Patch 2:
  - Added Reviewed-by: Linus Walleij.

Changes in v2:
- Replaced DT-based "force-set-sda" with a gpiolib helper.
- Added gpiod_is_single_ended() to drivers/gpio/gpiolib.c.
- Updated i2c-core-base.c to use the new helper.

Jie Li (2):
  gpiolib: add gpiod_is_single_ended() helper
  i2c: core: support recovery for single-ended GPIOs

 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c   |  4 ++--
 include/linux/gpio/consumer.h |  5 +++++
 3 files changed, 29 insertions(+), 2 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.43.0

