Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716A3BBFDA
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684002; cv=none; b=qrpPXnVsdz1EjXCMhXLZn08siexegyz4wZeyOUbXmwndn/TCL18q7bXyqakuJJcYdipyFgWsi6gD4TmcWZTv7tNvpmBu5n4i3uSH8EiD+GeCn+P6bp/7u7KMwbqB3bF32q6xfEfKxJoobSc4AvI7Oe+EBmdMDdoqbH5glm1rb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684002; c=relaxed/simple;
	bh=WFw/atU41ypvBVQUx+DdFa11OwawP3xK9J7ljYajoO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8ASwDNCs1Y9ysBCnayCzXZLJlO+9g4XXj36UXIzoDGHF/8I+UPd/+Oeti84P1v5yF2TAvDSndUL4i2InYC/Mc/Rf7xjb2zXTfxrwjc20+KBMYUKyyU0I8VAH+LskNMe2+7YPsaXK6hmlEt1ViagYN59JNlE6O1B5tpAXG3XjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MhiDThu8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MhiDThu8"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472055b0efaso885216f8f.2
        for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782683999; x=1783288799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OQ1jlAtb+iKCJdusM8HO2BZBQieF+FywGo4oJOXOC8=;
        b=MhiDThu85Qq/JJPULjGlxRbn1BBx8HSXxTuGb4U/kXhffwB0Eti8txT8B2jgskdhpJ
         iquZi53yNNKp2F/Ea36IV5lizwhltv1N2LxmXEpeubu/rsZM2Tprwhwh4PhHrMCTyDJj
         bBuaKtqKoYmPtP+sN8/oKp1K3g5X7wJ+U25zsztJMqUPY7WqJCZh+zeHzEFeGnu7+LAM
         4ZgrYGpCIUTmnBYzlsXJeQzsUEfi3QB0u4TJFQJwVJfEBGj8WW/WhoRh6Cgn5/VCCbdM
         UmBlKSshfXDg7xCxGCOJ+Diwlkm4i8lXvF+j5NVppN+ZJvdy6Bzy1noxHrJoCpABZI1Q
         Dezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683999; x=1783288799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OQ1jlAtb+iKCJdusM8HO2BZBQieF+FywGo4oJOXOC8=;
        b=d5cLDJFGdcwGp1hUjSDyLQuKJH9qMweXpUNVfsYu+hDb45OYYWIeyjlW/m2pgdQTeQ
         x5LntQ6XgCpwc66qltUNVIUhRVrKAX2E/p66jm8dgeto0imlSLZYoHpmha7HY3WoVACC
         Be1FD+MFKMATxAZAaC7S+9oPxufajV75KxRqHWMpwkfN6oeL+XTwVX1dlcYE5FsflFVj
         YxWEaU5lJLQ1JP32PuvrrvNavTWG4qd1kwAQNl3pMIIdMHqtOOFdzQx3U+oqrqko32w/
         AUwiEswEd1D7uJBzeL7O33odpcBM57k/POBiFLxhxVVOBzBD6YooJ3gViqeYZacCE9u4
         80pA==
X-Forwarded-Encrypted: i=1; AHgh+Rrz5s2QxbxxpY3tgTc1Lo9hjAtnuMETPmhCd9EhF8SVoJDcCod43cjYPsx0V7OJHQjySMDkbFZA2aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmizlWsa6H0S8UIdV06F0rYIqHtwkjg6dPUUM/tzrfDGUCoV0Q
	8wcsrUqpVLpA3evgKxHBj1Xo7wN4apLBi+7zMYppXuNnDUNRL692j1dGTOhlKWNSeGz5KHAioFc
	E+r/p
X-Gm-Gg: AfdE7cmKFhVd0Po9ZSBPsCG3OcORh/gDTw86alFgbZIqUY5fwcbRzc+2qz2ROZizjm5
	w8Q6GbyC3hWQEi0Ar8KSLnXvgCeX33Qh6FfkyripBb3Kz0F07qunVlFzDoMyJFahkbO9zns/LMg
	e/AQsysIJh+cG38VzwU2W/DfbMxfaZxMYTa279LQ7lHunskxOWAaoW8Vz2WNAvV9SLIZqXcP8pT
	L5UlGx3wT1IHOPyYCX6mOKourBqQlENsSa/qCTbuhln0zt5O4gJlaMxnXIWZiImifDLekdjz0J9
	rXt/+A7DsGIfJ3Y3gUn1KKRbNWHUPu6QOf/BY1S+x4gXI8uAT+0jFb5LGJ1eCiGod7+25G9ZftV
	LVxLjK+SxqqN0Fy6rBtzf/xAReFuCHIB0omj1k6PflXivDGc4mTtYIWPR3abiPu7lJDRbXPjfkd
	hRqJDZQT2QA0hucEebkg==
X-Received: by 2002:a05:6000:25ec:b0:473:937:db6c with SMTP id ffacd0b85a97d-4730937dc46mr5167284f8f.19.1782683999198;
        Sun, 28 Jun 2026 14:59:59 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47290ed4377sm10304456f8f.37.2026.06.28.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:59:58 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 08/16] i2c: Let i2c-core.h include <linux/i2c.h>
Date: Sun, 28 Jun 2026 23:58:43 +0200
Message-ID:  <c176fb7e8503d61e08f055a5bb1ba4989aba6ffc.1782682124.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782682124.git.ukleinek@kernel.org>
References: <cover.1782682124.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WFw/atU41ypvBVQUx+DdFa11OwawP3xK9J7ljYajoO8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqQZkg+aoy2OutZqy/K2xo5BBBdfi5/K/kglRjC J+dIqc34LuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakGZIAAKCRCPgPtYfRL+ ThPLB/wI7bEAE5OrgW8CxRwFvjIV/16G/OxgITyJRILvqL5SnLLVeGiWPZ6PvUEYnCuAma/rFFV B8RHC8w+zXlMQGvkOmpwcuRDJ4LPUnjxLKZdbYIvnndZWM5yY5cFujJoXhqVE20jqFf4blYleew UHe6F6QR8A1Qx4cHBKOxKmyIZQztk70uLFNmAg41VkubPuPu6JxKsdxHWJ+cPxgEN/ZcYbjQ+cT gwni1iJjHBOZJbkcotfm7AvH7zP+9vvF27Q9SjKL6YGNlRgI80Kptxykv6QBaOS/U5djcPxah8c 8WKrlNkHBEU4dfF6CCNTv2zyTYf2zBc2snQdMv25sD6BRp7q
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The subsystem private header i2c-core.h uses several symbols defined in
<linux/i2c.h>, e.g. struct i2c_board_info and i2c_lock_bus()). This
doesn't pose a problem in practise because all files including
"i2c-core.h" also include <linux/i2c.h>.

To make this more robust add an include statement for <linux/i2c.h>
making the header self-contained.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/i2c/i2c-core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 4797ba88331c..c519da536647 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -3,6 +3,7 @@
  * i2c-core.h - interfaces internal to the I2C framework
  */
 
+#include <linux/i2c.h>
 #include <linux/kconfig.h>
 #include <linux/rwsem.h>
 
-- 
2.47.3

