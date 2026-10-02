Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691E469852
	for <linux-i2c@vger.kernel.org>; Fri,  2 Oct 2026 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929951; cv=none; b=faqXDT1aeEyha5NJMS3DsmT1wYxJstgLTw2INZC3xqYyDi5zIUvKt+AEfYjrrXOs7DWKBZPD/9m02A9SqB1giJ7sY0+ezU/5LlIYNA9w/8rleC1vFQI6USa7CkD75Dd9b8sxdaQrBf6KksqmKrd5snTqYOyxZG/0hmMUjpIiepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929951; c=relaxed/simple;
	bh=zF76oz4WZP/X06K0KuuyliwnKkh6eH6J1UrreBkUc1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YV/Z7Y3sg1/NSjbob1jJ7to9kSS3r8SJ6bTcdErqjdT5uV0b6ZWwRrpVwnbOZLyf+Rkm1JfEXJTn6ZNDMOhbn9C4bSR49zpFvWsUReFMkZqKL1btz2FY2cAdyonrJMtK51921PySrsJXAV89tv/T2f6R+je5Lii56tbFdB32GV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VhAXFi8a; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VhAXFi8a"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so56005335e9.2
        for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790929946; x=1791534746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
        b=VhAXFi8ambzYBv9n69bMkNca7/NJ7sPb3NrTSVe8FVSpIht92qKmRTWr3tjSBTgiAa
         WEsXt8TnPQBCeLDTFhaciL/1AhWWGFe6ayK+7SOSdDRNa/PzqYvvcXpbwZ2l4Rg7sYLW
         ub83ANUrqJxByICIMfe9EvytuOhHA7VsAHZ970gA82BMzNqXu09AOys9CXWQMAA5dZt4
         D+MMNz9D23iBMBb7o9+YtCcjJOuH28IpKRGX/lgKEHdnz/oe0G4+7ETkTNoBGkf2yw72
         I4+J8aQXuY5lvnMaFAvK11UlQoSh8GupOYg1ItqU4LvGv+OdWKtV7Qo5NOt7M7nrF7Xj
         EzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929946; x=1791534746;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
        b=ahFsDJzDUWB+ptHbLuyyZEfZv0hIlmEnod58HtzaNdiiHLeeylrp0KGJrB5kjeS2mX
         oDOm9KtMOyF/z6/EAf+MtQm0c6O/eqMXeFKsp51AAAyf71u+grx/qgxfXFU6luXvGVGq
         uAuofToWljTTJgZ0XcCaua/RLMlMKgL8bUGFnh4nvil+yy4BiHbQto9IhzO6waPO35Br
         Jghcx1RuY9wUuN/x7oewR+MUB3/EwmrykUKHz5BHfdIl+UVoMcp2LrH/ILB/quIQKPF7
         GfMtZQQyNUdX4h4AWZTDIK4uPaf44OljEdkoPoUJW96hX8jhWFEiD3feQiRp/DqhdBUL
         hPcg==
X-Forwarded-Encrypted: i=1; AKwUvBwlFa2GLOaeZPh9M0BxDc7VXTNYeIWMQTQ7KFME/vKqH7ZEgRQjQqClqNRvN5oPpTWemD5s+m43hC4=@vger.kernel.org
X-Gm-Message-State: AFuF++lUMc+9Np8+6QzatH6/Sf00Jh6otwyc0Ms+AsC2x7j3+EIQ9fnZ
	mAk13Ydu68Uaw8YsThJz2m10NvqsKLeXcfqCdIM4KcaTobNkFpJ9kFNorzAunsA0p0M=
X-Gm-Gg: AYBFou1XZn898U64baHrS8f7Kt2tc9VfUi2dy4QsDEN650ObEiN5cH/8CYFU05gWEoq
	iL0Mt5zZTJFEOw+b9XDNDT8tAFcA6G99jp+bGHgWBj5Tpz1ptSXln/PSEjPilNhz3OCo9dQZMp7
	7fjfkr6MxF8SXzLhYrRAjQXy9iUOGJOyZkEB4EkWePUvuUFgwJsmPAC9qsTsYm3oOE4E2QzrTUC
	SS+qMvpp638Qj5FGSAqnbhG4tIaIuGD1ubN4MJF7p249aqbHOmDasXoEfJEblC0IjV95f4+V1s+
	nSlZ5KCy7d9lJgerNXXF6ykA86OVaA8Df977YhTH6jdtx7Vac/BvHF+unbIjrG4yLBWmsITlR+R
	yYFBcbxXlEPtn0AZz7rxoi1nzzxZCGjsTqpS7dJWnx9LbEzh/R5EMJYoKmoGE9b54BBBeaj/QTS
	B+Nze9m9Jzx66251KsyT+IuTl5Xvxx0JN5i3t0fCWgnaW7es+1UD2bZJQ0307Hka195Ao=
X-Received: by 2002:a05:600c:4307:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a0274569f9mr25694905e9.0.1790929945843;
        Fri, 02 Oct 2026 01:32:25 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:32:25 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] module: Remove obsolete __MODULE_STRING()
Date: Fri,  2 Oct 2026 10:31:03 +0200
Message-ID: <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Remove __MODULE_STRING() now that all remaining uses have been replaced
directly with __stringify().

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f6f90cd88f15..37de77340032 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -896,10 +896,6 @@ extern const struct kobj_type module_ktype;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
-/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-
-#define __MODULE_STRING(x) __stringify(x)
-
 #ifdef CONFIG_GENERIC_BUG
 void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);

-- 
2.55.0
