Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BF38B157
	for <linux-i2c@vger.kernel.org>; Thu, 30 Jul 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428747; cv=none; b=X6I+Qk+zgodfav85GHKVduyjOE6DK5xTQy1QzZetAwtBnORpA0Hd1y7AtDVRBcl4V772z6GyWRCH8VT9VGs8nojU64bFeDHSw6Scx9Ulk4HGnYx/RqTyQ2eHVD3mPD17N67LO5in7IS7DwbWNl5eHAOb2DG8jKpaYJNe4QFeThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428747; c=relaxed/simple;
	bh=jqhhbrTzEmjbw14S2sNiVG23v2x/6ksmQqVEZ06B9N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+p2y/3ObMu12Slvry8kfIUjskIpPTRifo2jYe+aTF/h3uHluiTCoIqUKFV+Dl6z7+FLi6H+AXlUxTZGFMASYdwZWHJOvplxaWhiZ5H/gLeqZo7m1A0PcEQIqpFwJ8hSzC9oB2IOV5YQlGBNXSlrtrdevuYmoEwKDlosiQMEfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovy6xz2D; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovy6xz2D"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f6609c657so1201624f8f.2
        for <linux-i2c@vger.kernel.org>; Thu, 30 Jul 2026 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785428744; x=1786033544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMW8WK0cFA9sXIrDsgT2C69Qk1jn1nPY5AZbMumzfUk=;
        b=Ovy6xz2Dt2mkQn62pnm0SmI3P9hVZw/g24Momw94KryV40ZpxKaeWLgV9omUxkIWRR
         9jsPWN8OX+N31uvGLRTVmy1EuikJRt1Djgnk10wMqqJGIK+YGZxQ8xKAB5YDnBAwDZPD
         7xU6n44SNTQVe+qmi7lb4dIteuG/Udo3S+eIdbhKAMCJayFSR+ccVmNGbMSxNEAysyot
         ZdBRytGtsbxDZun8Dk1OMtWZXGI11drfRKB/gSPUyi1AAbvELMY/dt+fUXkSeiYgvoGq
         aW9EXERWB6Uw/xGfnM8yLhWV2UZC+J6O31OH5nA7hL8yQIMEFpmV33pB8i64128uUFRI
         mJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428744; x=1786033544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMW8WK0cFA9sXIrDsgT2C69Qk1jn1nPY5AZbMumzfUk=;
        b=ZaT/KKTZ+eSka8jzGApvsRFaJRJVeezlQgsc5rU8qIs14WKgtF9hi4SLx4P+bLKVeo
         TDGUTaOm/Toc+ZCOnvafHT63+wDopJE6JVyxAcagrHLH/AMPJ1cKb2jH0klwn3jxxlfG
         p8WbPgDH8YCqkjE779ey8doFkraHqFtrumUlMq8aKv5SEZ7pVIdpnM/5pUpNqgHFRz6X
         L5Zl1aw5UMLHkOS2I6Y/q7VQE/ZeqrutWnkUgny2tMoZF4lEfoDkfpvaqzh3RuRD+r1N
         NnS6FMJ69ZJmXOUkRFPfHmb73G+SsW4HeyO0wU52NQolPgmCTO9PvRdFwCWEMVH5TwFg
         wc7w==
X-Forwarded-Encrypted: i=1; AHgh+RoTkbZM5SHYXYyaFVIN/3FKCajZbjwBuG0chnm7bKH+byl0UlEUd8dQL1wRkyvBPmMt3djEpUqBm4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAAnTSKMuJRQxB+OppL39flQM3G3qek5NFQmOaiDZVzddNdoez
	/ntXRcGNGYrfblm7YkK3968iIm8GQ+07IKq5QziR72jkl/naCqVObkuG
X-Gm-Gg: AR+sD13rHakMNx8X8XcbWC0aeXDeq3hLovC5+0QYJpQWRqgBQ6GGNK2R5o549TyAc/K
	ZcrFoU4Bz+VqapNGSn8S0q7nK8K+kF4AwH//1NHjU0HICjd3+JN57YsgC3P4FAgjIni0e7kRrMI
	oxPSC1KapGD+A6kK+FwxD83+WQdKcrqqk4G510eDA82egUD+i2nEQGpGfBigLgYguksQW70l0FU
	CkYpNG7kd6cG81qvEudvYpVgNOsLQUWw3gMnTaUmmkru7YLXY+7NYNfG10mR4lQ2yf/XobwIXS/
	XVr+7WaZaJfqZNAWcpQSW8o6IZWddxcFVVjlbhDFVyEqEh8Lz+zyBZxjMXVNDvliDlbhElZ9nc0
	cPNCZihsVL8LWePWkh4Q2+XrqE3ga7JG6CSXugyfR6N7gxRq03dMsWIFfZzapVGzVKEr3EEOT+j
	PA8cWTFYxxgpqR+3+ckXceuwgbUo9feyGLKiWBU97bcUJ1+suhA68lCszgg7HGthrCn+4oa/C/C
	YsqOaHx0+oJFMnPkENa+1fZ+kG4+UGnaOMMWF6wqwh32yS7e5RW6NHdww==
X-Received: by 2002:a05:6000:2507:b0:45e:73eb:5119 with SMTP id ffacd0b85a97d-47fc832b63amr4540154f8f.22.1785428743602;
        Thu, 30 Jul 2026 09:25:43 -0700 (PDT)
Received: from valmpani.fritz.box (cgn-195-14-216-95.nc.de. [195.14.216.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc892cc54sm7439586f8f.21.2026.07.30.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:25:43 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: johan@kernel.org,
	hdanton@sina.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
Subject: [PATCH] i2c: core: fix debugfs UAF on adapter removal
Date: Thu, 30 Jul 2026 18:23:44 +0200
Message-ID: <20260730162540.291570-1-vasilisalmpanis@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_del_adapter() frees the adapter's debugfs directory before it
unregisters the adapter device, but the new_device sysfs attribute stays
writable until device_del(). A write racing with removal still reaches
i2c_device_probe(), which passes the freed adap->debugfs to
debugfs_create_dir() as the new client's parent:

  BUG: KASAN: slab-use-after-free in lookup_noperm_common+0x407/0x430
  Read of size 4 at addr ffff88803ef87810 by task syz.0.61/6090
   lookup_noperm_common+0x407/0x430
   simple_start_creating+0x9c/0x110
   debugfs_start_creating+0xdb/0x1a0
   debugfs_create_dir+0x24/0x350
   i2c_device_probe+0x814/0xbf0

Remove the directory only once the adapter device has been released.
Its refcount reaching zero means no client is left to reference it.

Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Reported-by: syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=23ad911c819b923238b7
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ec04787a737..b894563f5a75 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1826,8 +1826,6 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	i2c_host_notify_irq_teardown(adap);
 
-	debugfs_remove_recursive(adap->debugfs);
-
 	/* wait until all references to the device are gone
 	 *
 	 * FIXME: This is old code and should ideally be replaced by an
@@ -1839,6 +1837,9 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
 
+	/* clients use this directory as their debugfs parent */
+	debugfs_remove_recursive(adap->debugfs);
+
 	/* free bus id */
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.47.3

