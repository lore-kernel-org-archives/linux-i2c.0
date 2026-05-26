Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA04401494
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805091; cv=none; b=E5r8rjp/vNcP7n+/EzbMsMb/bpEcU+jAWpjCWJdXDEHKkk0qyZ6QiMAR71zByhId0sVAvbGk8HQH/484xAX5qbOixaNhTrnIhsOZ3I9quOYuC8JpP3hYs+Lk3ipvi1rS0OM1aaIlyxOpdyrFLSFqRFFgKtWplzl5U0xaIIVae3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805091; c=relaxed/simple;
	bh=A14j4ivDNBl2yGcg6n5ndH+ByZLqjyYb/4BbZyB+vg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5WPJ0aX9neCpnrU7Sw96VtZOh/EwZSYBPnsu7OabrYI3D4v0bg4t84zDmCL0BdXlQ96v1VNCfOmlhzg8IZZAbaxFkRR5xuE5sDBtQgk8ApCuzqS+vfLhiUg08r559o7h6D2TGVIgw0wZKDTlaPQaMjb6CLtYBlCXjvjqe1i0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Kr5CR1pu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Kr5CR1pu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso30332645e9.2
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805085; x=1780409885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
        b=Kr5CR1puBNaF4clfOgdrSY811kH0XkJYaXu+tVuev20pRHeBFa6PmkgFfS7uPTR2Mj
         fccEIsQWEhUkWS/CT8WCi3/1a7oZuBvZ0BapIIz3Tp+MeoOcr1VGd0OfwtIMkjbrk1bb
         S51PVUaLe7Z2+cP8ML/eZy1CDRItho9DvS6wXJJhHCYPnaQRkpWofV8xMl3D+fAmy3L+
         e8z7ETF1JDJ+fKIfD9mFwX7Xn3lnn0nDGBAeeV/ZNq4TxDc3KDbcEEeWE8PRq1sgwGN/
         5b2esYUBdADisNNp39HkOaTwLPlCZEXJANrO0FuFsYBD8fAgQRjXET1mdfBqRTJMj+3X
         x24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805085; x=1780409885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWA1rx79U563LTGj65VSgfxyjti8CkpfF8kpzyqUrdk=;
        b=ragZy9ok7lSz/EzSLCbO9CbqJocFnME4MlziqKM0ciZqlVbSLOY80VL/yvfeHqYUWw
         zvoIAfanndpSZQVa6PtjoNk6cR81drlAMznnx5GnjF2Z+ZYnv6OfMV2tJCuSLndFFx3N
         T+Mr+EylCcb+qSOD0Wsy0//f1e+b/tzJG6UhTvdP8eAfavN8mOSyK0TYQq+B2MNaSgqB
         D2/3/fqupRQM84tJKG6orQmcZnzZQib8g5x9qvfikZBVwiwN7gYLoQM3AcekA8gS2eJe
         ZzE6PbAodXzc0JeMeTlsL0dso9iqVt4Vz/qLKmnX6Uo7SgG/7uL3gJrFXZseRxPuWuy0
         Rw7Q==
X-Forwarded-Encrypted: i=1; AFNElJ852UKCjVK+JBFbiNiIElTDiH9PBh7wrJvK7OskPcLzmmIvPTNVxr4IkRpiLuG0SoOPrz6JMGRvx2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1OxwJFyv9ZFn7is+z5y6ftOmnh9JopaLv1WuC58ZPK00WKgg
	x7EDRriYrEThGdrJb9XVDeltl4gKbd3I1CIolvSI7nOafI7ydK5AGdwEHGACBy6FxFs=
X-Gm-Gg: Acq92OEs9vk++mcMINenZtC/8k4iv0dVbsDDQvdiZAXYNldzESjvMQh/R6jjnfKwx3h
	39Amzckf7o0PVLbEJkcO/wd3IxG9kcZRU3u8ivmFTwrfMYuMP3bIeyVXLRzcJRYE36FHO9JdRv5
	xlMQYcq5Cp6kfPd/W1tUwt7BrVt9m4KtAX93UVU8c/dF9fxN5uGjg2Hg/i+FQ6sjrffhL1JujAL
	kSqBdWCzxCaHs24vgMPwAmrqYAhnsD+A0pqh8IIUt2QCny3YGeupYngznlXoxa9nqJVXPZgt1VF
	ID4ouyi1PNWICBr43H41qh+zRYBfsZ/9v85KQ+dBv76AcyDRd16PGxd7vnDegrrXoCpAxbZWS3q
	w7b2y/mYZ4OxHi20Fj3OIi014M+V92JpKCPV1/dr5QGHynLctyG9sV+VsVscp2euMUv45lJonDi
	1m6Rb9fR5tldJJcbOVUH4eTxG1usjG5PV2d7tAwL8CPxtknbev9qsLQqqGoFZ/mKfsqJVFnoM4Q
	nLPqCL15sGzkMFG+IMnOfWAqQ==
X-Received: by 2002:a05:600c:4592:b0:490:6237:5213 with SMTP id 5b1f17b1804b1-4906237537cmr145220735e9.23.1779805085104;
        Tue, 26 May 2026 07:18:05 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904561a160sm379625175e9.9.2026.05.26.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:18:04 -0700 (PDT)
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
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1 6/8] zorro: Simplify storing pointers in device id struct
Date: Tue, 26 May 2026 16:17:32 +0200
Message-ID:  <49576a7501128c93ef318566ed7faefce163f1fd.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=A14j4ivDNBl2yGcg6n5ndH+ByZLqjyYb/4BbZyB+vg8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFauEMCO+XO5wBiq0WLDW9CPIg9uJbXOSVo41d x54C4q2mLiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrhAAKCRCPgPtYfRL+ TjnnB/9l+SDbdriw4+P0R0QawXzQR6RNcTSEDOsG0Za0QxbkFa85XMb5sLwAO0owuw/Rowx6ky+ QMdsAXUgR3vwvQLdxYJlkEl/VA/XHq/xJJAuw+YZlvI7KLvHFN3YqbmJgo+fHO56QX05JkYBvJ2 Jk9WKvtvJ58lFHkr+5etBSYF3AixiJ+YBuoVcvjao9lM8EjUJ8SyDU/sXtdjUltWSXQmsKSN5Wa cffVeDubVIqpPQNOIDt4M8130VMFMoHEz1nySiOBmpolGD4C9tykhh7r5xGVttivy5+fc/p6kFl 64ZyNUXuXtZrf+NrGcA7ZEOvBZuObVE5B7q9XxMf4MX80c3s
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Technically it is fine (on all current Linux architectures) to store a
pointer in an unsigned long variable. However this needs explicit
casting which is an easy source for type mismatches.

By replacing the plain unsigned long .driver_data in struct
zorro_device_id by an anonymous union, most of the casting can be
dropped. There is still some implicit casting involved (between a void *
and a driver specific pointer type), but that's better than the approach
to store a pointer in an unsigned long variable as this doesn't lose the
information that the data being pointed to is const.

All users of struct zorro_device_id are initialized in a way that is
compatible with the new definition, so no adaptions are needed there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/mod_devicetable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 3b0c9a251a2e..2673a1bd82c4 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -640,7 +640,11 @@ struct mdio_device_id {
 
 struct zorro_device_id {
 	__u32 id;			/* Device ID or ZORRO_WILDCARD */
-	kernel_ulong_t driver_data;	/* Data private to the driver */
+	union {
+		/* Data private to the driver */
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 #define ZORRO_WILDCARD			(0xffffffff)	/* not official */
-- 
2.47.3

