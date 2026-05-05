Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B304346E46
	for <linux-i2c@vger.kernel.org>; Tue,  5 May 2026 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955523; cv=none; b=fkyAhAuDuvJVB23dBS0XOZlOOFY0R9uFcFN+ZfqRQyI0Gnk5uPQgR1cgdbkqUGXCgMRnUty3gz/WFYPiwkHsm3IUOgaOR/+y7UbX3O4/f92cjWLn2MOr1PsdLzStq1ePmag2+pWFYGzm+xAReciKiqjesA3wYJXwPuNaYXDC4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955523; c=relaxed/simple;
	bh=Vd+UmJAJmUt4NDw+SGQsSaSmOgFFI1R1bOsuuDv/ML4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiQoyG3Vj9mavkWBO+TJVVvVlRx0LdqjurU9Br5FbE3B0E/b2GC56OhJqnyfgBkeJfLKwOZKWdC7GiqIirzvk0Om8y6kyKzDx0gwZAH7G6RNcVQ2/i+MQpFsTADEbxhZsLYriY5mtuzhEqTbTNAc0sFm1AJ18XLvUIcQpopX2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOuLlcUA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOuLlcUA"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3650453fb28so1944154a91.2
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777955521; x=1778560321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYApqTlxYKzBrVSawdUtYeR0lCLKGPypg3kECv7jaXg=;
        b=BOuLlcUAnvZ0VQdrI9qkM9u8+i9ZRBoa+RC3/sDjuKTi/50BOD0AD4CNqypbF/Y1HC
         +huGVOD7USI1Gjc/UYTFejuYRt+azA6OC5qUONDJky/A/uQI+F87AFHmyE5TU8EiXWRy
         CaTbEIQSzLUGoLuD132ILUI/uurkve6oxhGjtHULrNf9JloLMyZPokKT+YQqZpeaXZao
         Tr9TSr3Sg0sziVcibw2/TJvyK6nCHluE0uGXfKJszcxF+L8KXrFeqWvBBIpqwZQL8hxK
         L0rTteW3wRKxyPpOwUx4AgvDTUkXaUPbcDMLXJehdR4KSvZGJpRwh1xlhN7GpxOvUSW/
         8HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777955521; x=1778560321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYApqTlxYKzBrVSawdUtYeR0lCLKGPypg3kECv7jaXg=;
        b=Gnx5xvvPu1LAiU97lEf6p+qhIvo7AEi/A8HbbrWdpUquovuQVdml5Op9ksLtCkiCvQ
         JItg6bYmUuZlggMI2Xa6UR8xKPxkMi03y0Yw8LMiPYRzsWvuN6TjWbBU5O6DQ7u5dcSR
         lekeqSOHtTAmQeWF6bKqNtrdsJ9sp7XtE3meAQy8Iyq/cOyFtiTPuLXj7oKGzdTCcYnF
         o1PlE3SEmVz4o+EQuJvSlGoS7qoh1IpoLjQKj3A1dn5m35bdxl26qBsRvTaXRP+Yhw2I
         YDR6xT9RuLSICrzYM8w2ufDuPdwn67HL3V3egZ7maBawBmps7t0qqD5idRcEqVgDYsd2
         f1gQ==
X-Gm-Message-State: AOJu0YwGRE1ZHrtUpulmvqqauMKVEzZblandglddGfka9S8Wbna1VVko
	qa4+hFv75NmFvUO6IzFWGMchc8poGWQMidvk+vHcY+++QzWxIXxHveAe
X-Gm-Gg: AeBDiett8EoBSsv2Esb+M5uDENFoKGiu/Xg1IavIicNYZa9DLgI3ZzJAzg0lu0aZMYu
	5Rd7xHLWXkyW72TdxlIpg2lHdMjFnCYFvRExbL/ksRCDJDCN3p8Ak0EJU+cBw15CzNIXHRr1NXh
	CSBDpMElhe0yfb3+Kfy0ETe5Pj/JnSB2+SHS7XT4HiG9e3BR9WwgBCmD/Uwd0k1X1mQgO7RMexX
	k+U3RkeP1hY1oIj2txoWepBdTjzLI3iUL7HzvBiNdS30327wKuYwH0C/Cz4f5gEp6a4f8K+c6NQ
	oArLiyw45qqnpOIYZ3xoclvSDnyzbPQqw10i1f34CSx2LfQwXG0wqI/lqC5EeG7pKqJ8RuFXko6
	vIlzQqzHSaS/ryQNqWYFRvlM6yXXKQFSYhmqiLA81jCfQUs79pPdlhNLbP7K3dqjhV7Mgp7+uvv
	HJciIW+mkYHMzBgROS8LKE2I1OE6kr0q5GoodYJdmin/S7LvGGPEbWba3eSf8gRGh+6LDE
X-Received: by 2002:a17:90b:3a91:b0:364:534b:a898 with SMTP id 98e67ed59e1d1-365773ba4f7mr1571320a91.8.1777955521275;
        Mon, 04 May 2026 21:32:01 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2ac19sm20343585a91.3.2026.05.04.21.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:32:01 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] i2c: core: Use of_property_present() for wakeup-source
Date: Tue,  5 May 2026 11:31:45 +0700
Message-ID: <20260505043145.33284-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The code currently uses of_property_read_bool() to check for the presence
of the 'wakeup-source' property.

However, of_property_read_bool() is intended for boolean properties, and
its usage on non-boolean types is deprecated. The 'wakeup-source' property
may be defined either as a boolean or as a phandle-array, depending on the
binding.

Switch to of_property_present() to check only for the presence of the
property, avoiding any type assumptions about its type.

Also apply the same change to 'host-notify' for consistency.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Verified with st1232 touchscreen on Armadillo-800EVA (R8A7740).

 drivers/i2c/i2c-core-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 354a88d0599e..b45d39da9208 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -51,10 +51,10 @@ int of_i2c_get_board_info(struct device *dev, struct device_node *node,
 	info->addr = addr;
 	info->fwnode = of_fwnode_handle(node);
 
-	if (of_property_read_bool(node, "host-notify"))
+	if (of_property_present(node, "host-notify"))
 		info->flags |= I2C_CLIENT_HOST_NOTIFY;
 
-	if (of_property_read_bool(node, "wakeup-source"))
+	if (of_property_present(node, "wakeup-source"))
 		info->flags |= I2C_CLIENT_WAKE;
 
 	return 0;
-- 
2.43.0

