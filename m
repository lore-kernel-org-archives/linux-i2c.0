Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75278F2B
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451934; cv=none; b=M6X+gx8ajljIcBJ/ygyHjSG2GX1/ja22NqZb0APYAOJEgFh+BnIvEXmVN9gXgRg+Y2aHEXhokXMK6GqIZ7yI/ksCCDDSklxopDbtrhXf1k7+fwey7cDWZ/oHfOf8m9YlEO8+miHeT+YwAIBqdoNDK9iwWKyomSDa31kRrf5Uu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451934; c=relaxed/simple;
	bh=dNJvwOvtKkuRy5CJp7kfu5V0sbcA8LMVkK7KgeS0AaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g18Egx9GRLyvBl7HhVMp2tJTv5E/4Hks3oxj6Hu9j46aa+i5SEYTjmNGcANS9HxfpeM8ibbkO09vA6ST0lRNUs9t/r0gwA1oxSjYSElY7Ka6YmoxM69DNxayMlTHqLTsDlo7HmdX787LVHolutypXKY0Xf5yl0RQCHt4KIsJYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3y/RC0Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3y/RC0Q"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853aec185aso23123595e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 18:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773451931; x=1774056731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3d+vA9WOD1aIXWABPX3fea+gZYGZsE6ZaKFwHPcp3I=;
        b=T3y/RC0QSiLCNAODcJPUDco8nXt0Ps2Hv4BoFX9ZvOp8xtZvax0GV6+eYvmfoKFylr
         M294aq0xTu9devijqN5tNUkq05k3ZIZRZj4cMvxq7cMlAZ18qOeua47x6c+77CKaNHVr
         VyNF3QzD82MxmP+wkM43h3bXJgSyYC2jfCurzCLpmQZUTjSHH3/ZRpc9EO+KEV04Gkt3
         MY+07o/3QJmlJcesemijSQB9SUqzyOt51XV9EnCyW8xU135nL6cHJWi3qq13AXceoljz
         xWzcJqI6N7GMdM7VkNxkg8a3xSB2ySJmwJR+zPXnRjF3L4y4o6rXXu7FGo5YG8lotakD
         4CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773451931; x=1774056731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3d+vA9WOD1aIXWABPX3fea+gZYGZsE6ZaKFwHPcp3I=;
        b=FUtRGzAQ/pfDYJS+CnjNpcXtC6btreCTrJJeNiB2Ata0C2sfMQV6yZmc+ZjL+YtERe
         poSMiEWAxbt5jVEZoSJyt1hhiwvwIvSwJ25t/pPGzBmVuy4q1eCvmtWRN+dHHwL8dte2
         zgFUIel9BOsCnqQY6U7oxBFoGbHDEZTHGJ1XAf2fIvHHEaziYFkJCgJY2vKlhA/FohX1
         ckBnZuCGZoksfoGT60a7+6yLWzAa9+8FqMn9cS2hT4n8vFatkD6XZ67LmZR1r53pSWP2
         uHIOFrWlcCBts8p+xo3Wu39YtfoKHihGPOlp1W60R0Ty0DQJ/p/Qp9dtu0O9F9+NHr3X
         DNHg==
X-Gm-Message-State: AOJu0YypXPKe5J+1x8oTPg0amvaDVg3bYJYzlMvWjvEgyzVB8rXWaqv9
	z4BFIQHc24JVYhnJpH8PTUGf+ZfgvMgbEr5ivLrBu7V7t6fDALD2DKnBu01ERFn4AY4=
X-Gm-Gg: ATEYQzwfuBQ1ohqFwEVlIACaaeBQswip3QO+M85KXkMlJJomnATHT2gENd+EQKLGHeP
	BO89dYiOeCMhZJBgbcgCE8eeo1b/RnastH34vr/pHx8F2SWJyLB0kbepZrN8v3hQx1XHxX6OAz5
	/s3RbJcjRX2vRxwINVVI7ZZ6mPf4XQb8uFAiup+J8k8vi0Y1SNiMiCCWyrFgMQIiDMMtu+OrCLk
	wuyjteAw0zwuFeixJZo13WP2UEaDxPuqlrQloOKwhM16Wq6Q9PqCxjJeWmUjToLG3zJwFdwlhRL
	2nSsRcFCn57eg/XQGRYtOd/9llgHNAWgm/RVA0lTGfzHJXnZLjqMW/DQ8luRDrb+L2k+XXMAdip
	Tky5VIGXC42+3lRZhH9cP5SOPyabnUw4Gkd6U2mWcupQSaNwpEwz1WJcHnyyb32KCMCg0Ncrz6g
	9/5MpBb/W57gOuNlL+EMX/EDwraLF5kxQukKknWsrPz06fMxQYqSurPKi4Bb87BPCvUG0mUfmdt
	N0zzoKznnStw0RC/QG11jLmeM2UtU3FOceQkHdiOlxq2PYVtwrUCaGmpVL92hjfXXajIeFgmaBm
	I6t3YsoZotg=
X-Received: by 2002:a05:600c:3b14:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-485566d5178mr83204885e9.10.1773451930625;
        Fri, 13 Mar 2026 18:32:10 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm21876575f8f.31.2026.03.13.18.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:32:10 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: linux-i2c@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	wsa+renesas@sang-engineering.com,
	westeri@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edward Blair <edward.blair@gmail.com>
Subject: [PATCH 0/2] Add UCSI I2C transport driver for ITE885x USB-C controllers
Date: Sat, 14 Mar 2026 01:31:54 +0000
Message-ID: <20260314013157.7181-1-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASUS Z690/Z790/X670E motherboards use ITE8853 (and related ITE8800-ITE8805)
USB Type-C controllers that implement UCSI over I2C. These are currently
unsupported in Linux, causing a boot error:

  i2c i2c-1: Failed to register i2c client ITE8853:00 at 0x40 (-16)

The BIOS on these boards declares two ACPI devices for the same physical
hardware at the same I2C address: a generic UCSI device (MSFT8000) and a
vendor-specific device (ITE8853). The generic device registers first during
ACPI enumeration, blocking the vendor-specific one with -EBUSY. The ITE8853
ACPI device carries the GPIO interrupt resource needed for proper operation,
while MSFT8000 does not.

Patch 1 fixes the i2c ACPI enumeration to skip known generic devices when a
vendor-specific sibling exists at the same address. This is a general fix
that could benefit other platforms with the same BIOS pattern.

Patch 2 adds the ITE885x UCSI transport driver, modeled after ucsi_stm32g0.c.
The only device-specific quirk is that PPM_RESET is handled internally by the
ITE8853 and must not be sent over I2C.

Tested on ASUS ROG Strix Z790-E Gaming WiFi:
  - Boot error eliminated
  - /sys/class/typec/port0 registered successfully
  - UCSI commands complete within one polling cycle (~50ms)
  - USB-C device attach/detach detected with partner enumeration
  - USB Power Delivery negotiation functional
  - SuperSpeed Plus Gen 2x1 devices operational through UCSI-managed port

No MAINTAINERS entry is added as the driver falls under the existing
USB TYPEC UCSI section. Happy to add one if preferred.

Edward Blair (2):
  i2c: acpi: skip generic I2C device when vendor-specific sibling exists
  usb: typec: ucsi: add ITE885x I2C transport driver

 drivers/i2c/i2c-core-acpi.c       |  88 +++++++++
 drivers/usb/typec/ucsi/Kconfig    |  11 ++
 drivers/usb/typec/ucsi/Makefile   |   1 +
 drivers/usb/typec/ucsi/ucsi_ite.c | 285 ++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c

-- 
2.53.0

