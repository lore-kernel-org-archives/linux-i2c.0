Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306313B47CB
	for <linux-i2c@vger.kernel.org>; Fri, 26 Jun 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496902; cv=none; b=UlVpIYK8e4cGvgZT/U6vO2rQE9+78C4ccdhT5b5N/Fm0O7LcvrNoORO2AlSyWXTaV3DmMhPL0uYTg9WjK4kKCtyw6nY4jyYMK0cmgObZcpoxa00ldHOnuV+a6eqDO11NhKeo6UOLDvg80CmRwsoizugdNumHJUugRJIrlkYkU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496902; c=relaxed/simple;
	bh=fcqV91QvDZP5CjJLTiEeVHsPtyILy94ZFyNlKnWY3mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwMtLnkT8G4wbl/mLxYkMP9KuvaTTNbfgeNHk2dL3BGXzkXmkJ7b25eEJ628kIgmXb0zl0SfUmMtaFZvcTSwSqxr37pvwoYfsRfnUoeKyOFi0oTslT7hN3hWKg+ee5bDnOUBcqBoIHCpi6sA1oSYNfAU1MNTmaa92cKu4V90P1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=J3lF1mCZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="J3lF1mCZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46ee68c3b7aso881008f8f.3
        for <linux-i2c@vger.kernel.org>; Fri, 26 Jun 2026 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782496900; x=1783101700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEQOLgwLqj2XrJQI6oRVczdNRdp9ywWpSoapDG67iR0=;
        b=J3lF1mCZ0CUqpToitr9QbGNiTB86oUoQQFHtZQmGzHjfFbjSd/ZvsMOQOmXUskMbCS
         6Z874qlvWdt/yR7UYHt5k2peCMqyb8hw9PeHclt84q/z1kjhHY+JdTaX73EfK4T6hCR1
         u4lJEZW3TZjsSYtCV9TqcA4lj4d8D+RzsjuOHWnsPljdxGTeKnfG3fUysntG0MCxKrr9
         RZ4GvyB4kK53j0MFBSMIZb0clVa4V5pLaapCV/K+T/PnjEXv2Z1BhoqFbuhCzcFuq6qx
         0GnfVO+xJqO1UOTW18ydDnQJjCzUhUsacGjjFpzJInbiPEM1m1jRNu4y4pkBpXmcoNIZ
         +N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782496900; x=1783101700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEQOLgwLqj2XrJQI6oRVczdNRdp9ywWpSoapDG67iR0=;
        b=TGoVsxN8KaTgda5Q9Pid/2OyR0wpivWSb8qv8GDaNdf++I6lI04jWow+fhrzs8JaPM
         bj18Qg+o8cjd6i7jkwoV6Hdhg1oJ6lbqESRtS95DdjN4K4GYpYpi54RD96HoI0+1hhN5
         Fnk++huuWpIPfQoRXaeKrfVOeTUiqBgIS01LW7VtkgH3wLJnreo9yGmQMukSLkbktFo+
         2MWeSKM2WfLcOr3cnA8fb3NUUu3P5+DQTKjuQ4/0/PlV3Syhh30Ck0Z55rIgEKbtbw0/
         7VSgWx0Tx0eeH64+OTflFKeUZkoWvbq3yShkZwHe2suRlkfN3QL59mPP6O09KmGPNVa6
         Sm3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVOQXcuGZQH3ZiMt/6Fn1zNXYETju5BjPUvqnekW5Mrycotbbc2M7y7ixKAjPZD6MT9g7kIpv5uU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRzbo3JDnwyHxQ+dyfyMkDBGIDRWpYidJPk8Oo2d2Hd2C2g4o
	oe5QPmpChR/6xsQa+32nKQMWCQn7BAQepvbIhFAye79JHowSvAGst0DpPFZizu6PIFo=
X-Gm-Gg: AfdE7cnoZFCIlYV2k4aA3HXGvxh/5NuZ6qNkYPB4k2AFKXHb/iKV0USz/fmkqNv+p/6
	ltpij1ijNJw3fa9LOqVVLSzHJ4QMd8e+ZtD//LZqaTvP5H3jUGskeLA0iNdopEwC9AHpWNCuLsd
	ZAqdwQvksMHGfYDr1GHphRmUjk/M8e+Qfu7s8ph81sAgZhexVb4NHGO0yL/+pVrPlmpxnUX3u2R
	tK/y3XiVG9thci4HtoJveJebYt+RjKBHMZfHACI4FKE88SjdyPgwruYUoqUL7QqdhurTS7iMOtd
	x6Q3pXuicJCOCfRV4XP4ldB2GtAU3PjYLywOCPQ0q9hEre5WRdUW38pB88z2/y0mJDfuOQyMQfX
	aoZbW63ijC0DoGWlBhpChPB5CxRQbVohIq6mkmxbR3Fx46O2KhXt/pldYP1aB1Tdl5yZMgSyjYy
	20yI3hv2ayPQ2UwozAdl/VKX1Do++T+2RSCoqmlIRo+o22JSqplVbx74QZdnyZ6NKpf9s9WRt42
	vdd
X-Received: by 2002:a05:6000:2c0f:b0:460:1f32:628d with SMTP id ffacd0b85a97d-46dbf5e5d4bmr13333711f8f.11.1782496899678;
        Fri, 26 Jun 2026 11:01:39 -0700 (PDT)
Received: from localhost (p200300f65f47db04b3606a871f5f1c38.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b360:6a87:1f5f:1c38])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46dd5f9da4fsm18228228f8f.23.2026.06.26.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:01:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] i2c: Let i2c-core.h include <linux/i2c.h>
Date: Fri, 26 Jun 2026 20:00:28 +0200
Message-ID:  <b33e36569227d35a747d61160f849cc49a783255.1782490566.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782490566.git.u.kleine-koenig@baylibre.com>
References: <cover.1782490566.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=fcqV91QvDZP5CjJLTiEeVHsPtyILy94ZFyNlKnWY3mo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiy7fT7MNjI8p7gvGT5XXeo5n1WjIvBgnEirw9Gj1UtUX yeYnE7rZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAip905GPo9G0Qm+CaxzdmU mLXxmoeeb0jGi38i03Ysadys6LJp4vGp8ZKnTjLWv9zfs+jEhsAdSxLafBbN7QyrT+UqvO2sO7e 4wVv3tZhBsd+bKK6ww643f/WeXsCiUHSnRH2SmJ9GYmBy+LKU2UL63VtNUv6fqgjWZ9Dwmci/zn W5QhbXRcad6x0efnyxQr744clyJ8MoHzZrD7a82QKSXvxLOC0u7XduNjhof8501XyhObsWxEa4T J++0tX9UI9/U8CT23zeASVG9xmrOF7b3uzSED/MuYt3ZYZCFXvrAm1fK+0utkOC3/N0bk8tmMar m+vp3FQx/5hEnfx38XTF42sF/y742tCn5MB2d3GyfwYA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The subsystem private header i2c-core.h uses several symbols defined in
<linux/i2c.h>, e.g. struct i2c_board_info and i2c_lock_bus()). This
doesn't pose a problem in practise because all files including
"i2c-core.h" also include <linux/i2c.h>.

To make this more robust add an include statement for <linux/i2c.h>
making the header self-contained.

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

