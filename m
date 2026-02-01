Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA83284895
	for <linux-i2c@vger.kernel.org>; Sun,  1 Feb 2026 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769944700; cv=none; b=E/sTpDB3vkxtNye6m+iB8GRfLshapZPmEGtpRx5fVWgmUP0WFpaJjOX9AhTQLxA8FzDVOyhjMfAtTYi90TT7v+WnvftZ6d5VhQ62w7Ht+dGk0670484FfekYHpWLJ3vOwBpDQoOFdDpAQWCAXycHZl22ngzvHbR6MROXPKTsWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769944700; c=relaxed/simple;
	bh=PnFCt7U5faHEoRgRm4/E1Qi8Fg0C73L8gOhM1SYo3fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqjUTCKNIdWbUiGWsFjGpJsev1qNl3B2JgmNE1Pa2NJV6ayvMhoG1aH2kXmavGX5CqGD7lZT2+iVqArCWbfMBMKnvATm9xBsUVGxWcT2n8UQsZbPLaaL/kL0jpu7r15iafhGZzt4EPRDa6j47wkpSlGShR17gEyQQRgtB5JrFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgJ1UAxZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgJ1UAxZ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8845cb5862so555224466b.3
        for <linux-i2c@vger.kernel.org>; Sun, 01 Feb 2026 03:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769944698; x=1770549498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Apd4Pw04WM7E8SQOUu4pdhPSYadrEuDMSe+FLY9m1bA=;
        b=jgJ1UAxZY3fX4xPWDcv60FOa/hKhGHJqqv3hGiKlVKbN7ntx9LRG3NSEqLBvPo+ppn
         oQICEJdPXRVAKuf/NLXxKK42N9NgB8h+pQq9GKBEMYBL7KZ3VKdzP1lWpUHdDjO4iztS
         gr+RVEeBG6yop7tebAg3ndsg0zOAXkV7o37TK8U7reyLaLPaaayL+1ZsG1NQVAA7lA2O
         FnK+VBjw4YjZwYVrPOAGG7Ttxme45KXM6RVHfQC05dg2aMT6ZpCELcKR2BedlAPjDcV7
         HRfHK3Kg45hOtuPEAJyWBChx/GL5s8ZWpwN/8B83b36NMH4Crha04ZFBuYYeoS4ElhjK
         lB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769944698; x=1770549498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Apd4Pw04WM7E8SQOUu4pdhPSYadrEuDMSe+FLY9m1bA=;
        b=Sqov5r43zdB7E44wfcNdfv6L49a7jXz3TGc7bHl/a7SSA9e1eIQnWg27TLTp5lckpy
         QHCGqeqvQjD8qzjjNwfOZvsp3GmL3SJQmQIlFcZcLLLyN6ISY0xdlJ3Wkvp2gnkpyRWx
         tjeHMKmc2MMiPIBKjOVm0K1t4+jEygwc+TCZLLSxoDnXCJUh4EYzhiUkaCP5VW9SKpgW
         Y2e/hsnxfsuD/qfmFt+GY5oU70IiVzuJFq7mNt9Yh5lKAM8EuQARiFqKh8GD2kNIvd9K
         76ToFQxi2FjHUQSKl31mVm6L3xQuSG7hYhXBIf2IdraZlKLjd5c+u7fzreXgQDlkMH0g
         R3vQ==
X-Gm-Message-State: AOJu0YxkCAsijyarrxziNp10auffnYw2y/H36dszv7z2XKcxxYbHRocu
	58CuuUMyKQ5gGtpcq+1Arjbnfnol+/m2mTty0/v1z8oFhAIa/f+EvgwL
X-Gm-Gg: AZuq6aJ0KhNQ0U9t9/gSXCrtA1xLYE80zuOSc1wM8QauvfM9vsQmyTw1DuLR1JEk8YP
	N8OzeBsmCupR+J4OfDXDd2kTRqAtWHGxZtQ2kGGoqJvuOu6Ct4tHP9prVE5xdE3PXy1enHoloO8
	LCM/oAFabSiHC5g5WG/uwhlc7F10eZcZYwcH4TwTy4Xuzk+SRmdEd3mPfsitZZqNWvRSmy7Ks1A
	HHH0pDqvqLmGUS1ofm6+AzHfoIuOAV+Ju52H0eqlMwjwrEYPQFonGbmZpKAXwxDYgk+EStW+58e
	vcADhB1mSrxUfcLpJ5myeBNh3YC136Exif7ekY5+zkliqZvP7YVa5Pk4U8wHYvRuyKifTaHPXir
	tbPfF1pXEL1X4IONI3pHFu0wBbymb1CH6DHJ/rkv/JNzMBXq375Ad4h+HFQKkNh4Z9cfii4Bb6y
	NBtKe3neX/UXxmcYQGZVxKMyI=
X-Received: by 2002:a17:907:97d1:b0:b87:1f21:f09d with SMTP id a640c23a62f3a-b8dff58a0ebmr540036466b.19.1769944697422;
        Sun, 01 Feb 2026 03:18:17 -0800 (PST)
Received: from C-PF5D4647.localdomain ([147.161.249.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed6besm714713066b.60.2026.02.01.03.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 03:18:16 -0800 (PST)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linusw@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v3 0/2] i2c: improve bus recovery for single-ended GPIOs
Date: Sun,  1 Feb 2026 12:18:10 +0100
Message-ID: <20260201111812.18945-1-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLnk_5KG_q1aCtpOrTCbhtK-FxXH6BhPFSwukyt2F4uxmQ@mail.gmail.com>
References: <CAD++jLnk_5KG_q1aCtpOrTCbhtK-FxXH6BhPFSwukyt2F4uxmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

Apologies for the delay in responding.

Thank you very much for your review and the specific guidance regarding 
the return types. I really appreciate your patience and time spent 
guiding me through my first contribution to the kernel.

This series (v3) updates the helper function to use the 'bool' type as 
suggested and includes the Reviewed-by tags.

This series addresses a limitation in the I2C bus recovery mechanism where 
certain open-drain GPIOs are incorrectly identified as input-only, 
preventing the recovery logic from functioning.

Following the suggestion from Linus Walleij, this version drops the 
previously proposed "force-set-sda" DT property. Instead, it 
introduces a generic helper in the GPIO subsystem to identify 
single-ended configurations. This allows the I2C core to reliably 
enable recovery for open-drain lines regardless of the 
instantaneous hardware direction reporting.

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
 drivers/i2c/i2c-core-base.c   |  3 ++-
 include/linux/gpio/consumer.h |  5 +++++
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0

