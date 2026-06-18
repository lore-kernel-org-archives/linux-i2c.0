Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50154192FC
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808393; cv=none; b=RkKh+LRQM1VIJX421u5CWMVTMxbhsiVTJN8huTtYtYLzInsqPsMhx/XZ5Iii5pIczCkyeB5iOumsln+C6c/qHtw7an0U75DDu0kQCGQA9fIXHl267fVWz1EuDc4z7ZJfXXb3HwdibytFBKTBxS3cXX/n9a/ywRSya4DjyvQwt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808393; c=relaxed/simple;
	bh=1MFy0r1AaQOMVgMfm947ZtJZ28NGc8QsTfE7EFaYc70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPhRTqdLjoAICK5wLMbxGgus3fOum3MfoqH/W2/nrgJpzabzc+Z/OEBH8xQUpVt57rNai+BFzTowj/UYapRbbDhnGVdWOLiMe3lEe5cUn0V+Wf0rSKrDqH2ZMs0z0dAvGxQQugaBc+oiP+tJDK6OcxLZ3K/WSmQg7hB5QcxAN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD/miN3n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD/miN3n"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so702321a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781808386; x=1782413186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3aSww2RYBilvZ78lj//N2k5kgtCUlB2Nqs3hY7555E=;
        b=GD/miN3nZ7c09+hk9cgjYAeV7HzyDjphUO/Jtfnde2GnezjdM1svEQpBGFlBFlw70/
         VhbRm2cIcBxsQ+YQCpEvV91O3xCcIQ1WAaW5I0iRqNFuPWWjIib2sED4GEgThwzKiV33
         on9+Oe+y1pEsstahlHCXMCZ3ej0UMlm/AgLUVjgViLUepZUyLDBD3QvduS/k9a+x/WTi
         LaRrUqTWTz+7zxFU0RZa3EyygyC3+68FnrKKLeqCTx23nXw8vqaPFqzeVS7zqd8xRfk6
         pPkVOS+jPcjrmlVl2ieUF6nPaoGHfSH8DGbBK2iDX1t23y/8Sb4gjsQRWInQiGhBhZ8q
         +o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781808386; x=1782413186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3aSww2RYBilvZ78lj//N2k5kgtCUlB2Nqs3hY7555E=;
        b=i7Y9HItG9p6KPp6dRxV/4ehjnoMQMESqMIk5Di168mt0UdRejUPdgOsxEYxTQWhGCY
         0dW1+6Aed4Z5AmEoqN7y5A6Dfu6F+xAzX/FyXsY966NdtwBefXMSpaWGSAKcCaPcJo6M
         tMyRqc5oEAYHLq/6A07/1QRMbZyYKaNx9RZbkwqWurCtBEcGgNfWWfjwhzTf1Uj/BJSC
         F7qWIxnFzijr0Dt64SIyw3tDcjYP10SrKnFd4eKo5EbiggmpoJCeQu4HZpVXBF2kTgV4
         R2izXkDog53V7iJAw50RKQbdkSxNzKc5+mj7D+ny0RyIWl8+sxSD/3jf7ojB08KyyXtn
         PiTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vJAOAVwVLZOwzuUO1rSAKpJqdu6vqDWk6oRKCJd6sPOJZT/EA5vA2n3vTN6Ewg69ytROQ8zLJKoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4DZjUCZncgW0rnN1KRRlhqvjpBc+8q+odEX1NsKRq8t3pI6q
	aL/5FgvA+b/Khs2IY/iN8RidcMKSEqvJy9U5X5D+X96bXRcXY/EMRbHm
X-Gm-Gg: AfdE7cn5Qn9cSjQPEmJxphk++8WXMONebH0Ql4oyL37Yg4gUbYyBq0bSXs5ENEIAEF+
	JjDFNfAFPofM5ToH8MJBVzW5JG6U/Da/ZN2XQfEgZw/+pntFwcTiMWNzFtQ1oXWkgwI4qecCrgg
	C+5/UmHzJZgII+ov30JgZfaWfHcgq06ksntMAuSk3M24cG+tPHTVgi00MfwscnDuQl8y2tAF6sA
	jeDQHCOKOMkZNb3oJdx9ZU7BMXlwsuTLZXD/sA2q7d+mTEyc+gtgiOkd3JyIU8oDuVbPzTxZaRP
	SDVlZR4WmxZq0qiCFkjY3TadHMhAx6m8quw3ngltydVxiz0WMGOQmVI6EBKk3H9I+NzObLiz418
	Zurr6jZbaw0qotJI8JsEQ2S+yXpabS68fbLHtDtVLni4JMYieyIK3v9xrtKgp9w6LW9qBcOcIsv
	u7mik9ZB44KpVl7mj2kPkyw/4QQYE=
X-Received: by 2002:a05:6a20:12d6:b0:39f:9eb3:1d09 with SMTP id adf61e73a8af0-3bb34d6c0dcmr273348637.37.1781808385943;
        Thu, 18 Jun 2026 11:46:25 -0700 (PDT)
Received: from vbox ([117.251.163.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8a8544e2afsm137087a12.12.2026.06.18.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:46:25 -0700 (PDT)
From: Tejas Mutalikdesai <tejasmutalikdesai@gmail.com>
To: andi.shyti@kernel.org
Cc: wsa@kernel.org,
	vladimir_zapolskiy@mentor.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejas Mutalikdesai <tejasmutalikdesai@gmail.com>,
	syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
Subject: [PATCH] i2c: core: move idr_remove() in i2c_del_adapter() before device_unregister()
Date: Fri, 19 Jun 2026 00:16:10 +0530
Message-ID: <20260618184610.6536-1-tejasmutalikdesai@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race between i2c_del_adapter() and i2c_get_adapter() that
can trigger a "refcount_t: addition on 0; use-after-free" warning.

The sequence is:

  1. i2c_del_adapter() calls device_unregister(), which drops the
     device refcount to zero (the adapter's release callback fires
     and signals dev_released).

  2. The adapter is still in i2c_adapter_idr because idr_remove()
     hasn't been called yet.

  3. A concurrent i2c_get_adapter() calls idr_find() under core_lock
     and finds the adapter.  try_module_get() succeeds because the
     owning module is still MODULE_STATE_LIVE (this is a hot-remove
     path, not a module unload).

  4. get_device() is called on a kobject whose refcount is already
     zero, triggering refcount_warn_saturate() with REFCOUNT_ADD_UAF.

Fixing this by moving the idr_remove() call to before device_unregister().
Once the adapter is removed from the IDR, any concurrent
i2c_get_adapter() will get NULL from idr_find() and return -ENODEV.
Callers that already hold a device reference are unaffected:
wait_for_completion() correctly waits for them to release it via
i2c_put_adapter().

REPRODUCTION AND VALIDATION: Tested by inserting a msleep(500) after wait_for_completion() to widen
the race window, and using a kernel module that spawns two kthreads: one
calling i2c_del_adapter() and another calling i2c_get_adapter()
concurrently while the module remains MODULE_STATE_LIVE.  Without the
fix, the WARNING fires reliably.  With the fix, i2c_get_adapter()
returns NULL and no WARNING is observed.

Reported-by: syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0291c8c9aaa473c7721
Fixes: 611e12ea0f12 ("i2c: core: manage i2c bus device refcount in i2c_[get|put]_adapter")
Signed-off-by: Tejas Mutalikdesai <tejasmutalikdesai@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index a2132d70fb36..780ce42fa950 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1801,6 +1801,16 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	debugfs_remove_recursive(adap->debugfs);
 
+	/* Remove from IDR first so that a concurrent i2c_get_adapter() can
+	 * no longer find this adapter.  Without this ordering,
+	 * i2c_get_adapter() can find the adapter via idr_find() and call
+	 * get_device() after device_unregister() has already dropped the
+	 * refcount to zero, triggering a use-after-free warning.
+	 */
+	mutex_lock(&core_lock);
+	idr_remove(&i2c_adapter_idr, adap->nr);
+	mutex_unlock(&core_lock);
+
 	/* wait until all references to the device are gone
 	 *
 	 * FIXME: This is old code and should ideally be replaced by an
@@ -1812,11 +1822,6 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
 
-	/* free bus id */
-	mutex_lock(&core_lock);
-	idr_remove(&i2c_adapter_idr, adap->nr);
-	mutex_unlock(&core_lock);
-
 	/* Clear the device structure in case this adapter is ever going to be
 	   added again */
 	memset(&adap->dev, 0, sizeof(adap->dev));
-- 
2.54.0

