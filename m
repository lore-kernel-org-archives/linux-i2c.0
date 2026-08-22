Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7D390998
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434848; cv=none; b=OJtXZ4gJ1MD1Oxr6LaO+xKbvD0s1WFk4iPpJureeOt9Wd+kdWFUUhGj7HCpS6BYKyFpf2w9EBBAauNwnyemHmaPX2WduZ9LDhCdMQbPx51538F5mwAwSVFKA9lCVFV6Cs2+IMjZhnGiWeHhut0EyE39Mt8l6cLDbpJxlUU8CzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434848; c=relaxed/simple;
	bh=tSaYsW5ZA87m0Wg9YJ+wfmB/gHIRTOyA3syuwyg8qeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH0HLvejDrCTT5TD3ON9E7ApXwKOatgP0gQKe34wSMDavvzwuzlrfWgS3zO0TLyngTQBI1JHP9z1PoGGpkn3oIp1vzl24dXRMiAfj2ip8aYRvB0zi35FJGt8VYFwHILWW1809Tz5xtU1/Y1I3m/MdW70g2ewTIrLWm6Y8aTGPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTQtPDkb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTQtPDkb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1712a04ddaso364468866b.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434837; x=1788039637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4eLlaKD/QchVb0r7zAM59fvM/PJvb2qK03bPG46mJc=;
        b=oTQtPDkblPAwvUkJILdH3vavLZI6Uk5u13K9Ty3z0sAfJwsMNIn5HHspUOj/MbClK9
         i/gC5WT6TRpLrB/v+f4+FSlpMYBxviJFaHQBbWx5OZe/3PxaCQfXjb8ODwmWqN0syodk
         PLGE5SeHFYlu1aei1esnpmpkwSibc2rwC6ldYusk8RW4WdhxJvRfAmp1/LRo6rbdBiAQ
         U7J3Cq5XVpdfa9sC1fGgaRtqjhxRUWHLMFolk6SUDVl1QLN14Dyi/obQGb+72Ajt7+Mo
         uIY4ZI1I6AGcHImG499TdlfkMy6BnBy8w09JaqLNU2wB+P0wn7t2KRWHAnl2WG75vGbN
         b24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434837; x=1788039637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a4eLlaKD/QchVb0r7zAM59fvM/PJvb2qK03bPG46mJc=;
        b=o2zx4IjntS2TW8ApNCYf8OZSMaLASz31A+UijrjSZRXmeY5p/JunMUrvUdiVrMSBzK
         o3xh/bc9j9PYK0d1UqCA/NUQb4LEKUtRk7XqZ+p305xEdoOtEnm1PLN6TjV7QZfOUL4a
         XkNx1nxOaJ0jsbKn9F1n/yCW+opj3LAHQdKwPU8TVhkyUPKL8QS3v+ZDx7hXdOGmFVcC
         OtgIzLDfn7ZvbIq7sw03P52H5BttL5ulelMGg7g4lRftYdk6kWOKoTm5Nl5Y3uiCYW65
         rcL6EK7X31v/2Cpp+Xri3tdQIQBR54beWLjhrUPWUXQaJTJwpjqv+V/zxSqMathWImsE
         sAkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1ZflX0Bh17C11OmKVAjLPEvHyHqdyds/ZPpdlYQhTaVXEQGB+B89Wru7YjdyI42mDXIkceX/S3hI=@vger.kernel.org
X-Gm-Message-State: AFuF++nhzCQDm5ZM9ks8W0tfk/WEb1fTNnyxVgbYwpw0LYkBMrvvg2Z2
	NK7AKH/B+pM7GITZ+dXuDSiBnuFMzrIkWzW3Pgsv0qZB+To+KN65htJh
X-Gm-Gg: AR+sD10MHzSsMY7G2EU3TVLh09aeRegCxD5fXDNOKCkmzD/Z4Ut4MVOOrO/ZJdwLkWV
	Kx6a/xDc+oXblYMSFc/GT7IAFPqTOQgyEfnEg2lejvKqaAx29OVSoyOBGIxqa7n8tXlCdFJbTLI
	XCuf9lV5rOcbGewHfjidhqD1fU0T8yAtoIqEBRcZ/Q6iCjwpNBjwf4F27eZF8jNdecQfK78HBdY
	Klqes4BpPMGp3xJLVqjOjibJgCbJfzMC2iaSrTud30hbe1m9ScmDCEyBoi3a82svRN8YHqzMDRF
	6GwcevlWASzOxVUxnLSB+7j/d5XW1W8fIeP2Pf7CX7XwcwgmRvWtX2TAKEw9Mv1eI3gknNfGkE/
	TvFiOkwhn92w0c+erv2O9pH+7BSwB8dJerJ41MvBhkhIea4E+33vf7KTxc1e+XXnnkh1DY7pvKd
	bhl3zBYhp2mPSMhlGqzGJDmYSZ/gIdscRbb5PipZBsCiiNNGZUNpIyZpf1hv74hBB/gJOSdA==
X-Received: by 2002:a17:907:1c27:b0:c21:382e:9a38 with SMTP id a640c23a62f3a-c2491c2a110mr884931266b.2.1787434836795;
        Sat, 22 Aug 2026 14:40:36 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:36 -0700 (PDT)
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
Subject: [PATCH 05/13] HID: ft260: i2c: silence sysfs store big-numbers
Date: Sun, 23 Aug 2026 00:39:33 +0300
Message-ID: <20260822213941.98882-6-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FT260_ATTR_STORE returned the feature-report transfer length from
ft260_hid_feature_report_set() instead of the sysfs write size. For
values like 1000, userspace writes more bytes than the HID report
length, so the VFS retries the remainder and reports "Invalid argument"
even though the attribute was applied correctly:

  $ echo 1000 > .../clock
  bash: line 1: echo: write error: Invalid argument
  $ cat .../clock
  1000

Return count after a successful parse so the full write is consumed.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 4435a39fce23..8db896f164cd 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1479,6 +1479,7 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 				hid_err(hdev, "%s: failed!\n", __func__);      \
 			else						       \
 				func(hdev, req, name);			       \
+			ret = count;					       \
 			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
-- 
2.43.0

