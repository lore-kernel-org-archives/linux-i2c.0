Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1C49363B
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787379986; cv=none; b=ghBWpTmy8sgtpstPGrTM/Ys9wsWKIuliZmEeHChbjcEe8Mo7iv5kESvqaLaKdFjccE1F5dsFHMblLEjUGrlq+BbCwQ7mVwHr9OJ3IkyPDYj2I9Qi3/dp2ZDqM5iATwfdK60SXEGbyzPuG6BKaOCcWu65v8ihLchFYMXJuzLMIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787379986; c=relaxed/simple;
	bh=3UH6koQd9KG25t7aGSyzZVrMYxuZIKrlXBMiJaivrbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OuPbIT9Z1LglMPoE3zeIwOGrTCtrDy1UvDpyDiZ6w09wH9YvMoWlOVxq4s61oQToyXmyIbCNEvIxHZkIT4nKx6JsP07VXT0QiwzWrfkoaMW4PYBkIVqYbTrnAGXdSXmRmxKlemSrVfIf9xJ6KgradTACG5odpmpLcKdUX+X2pvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNZKQqdp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNZKQqdp"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1581272a91.2
        for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787379984; x=1787984784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i18tLyi/eYdEX2WIGQQO7R0XqZwH8K2eK73aSPl6aJs=;
        b=XNZKQqdpxV7iRKpBHfqmK180aGFgQNzZzF/et1UJ7fSXTbw1/5HseMNlU0EA5wGA+x
         9zPDSKKbLer41lRRU6WJNCJ6hRAvn5TCAggzhIe2v63St6gyLfHjnZkJbzsnGFHP1F7W
         HikPPDU41reuYvGXDGT2uB8bEmhWeuDx1QdqE8STIOlqUgxlBi02FvLVbULZmDwbZHDw
         8kTi6iplq2hHikb6QiukWmldMonjobfTMEn3rds3HWmxtS1pl9BvmWk2GQBl0RBA9YMJ
         4HoQmpRQ1beHls5HjDcXe033O4ShNLvb/58vNiwxGsp1uBFS/OPZs3OvlPv/exn9Jb0O
         Wesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787379984; x=1787984784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i18tLyi/eYdEX2WIGQQO7R0XqZwH8K2eK73aSPl6aJs=;
        b=cr0Lp8rtwYJFEdRhr13N8fqww8V+YjmevgfPxZgKAhwr457nUtRxZlShnrbX29MAg+
         3VQrwcimqfLESUl22k4bQSpr5j9L/bWK4lf12q+b41Wm9DVt76orJtIFoIEF4FUFHjQd
         RadNw10Y38xxllCe51BNTcDVILn/hezInthiXLDqf2HzIOfov4KmB4YhaFsvKo8pmkW1
         ttd42t31fkMUoylvo62/QKRxjke+QBLYMbHXwPCjKRR0VxiNVYyxz0BJEDSYBlHQ1jEf
         Xk8e/q8WhZshg5kYj3O51GglIy+C+Th+AMiufogQE6Sf8klTBTi/O/u+4ZK2XJHw7Xri
         PoEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyNrABVTW9IUAe71GUjQ8JgdQLG/nqijE9Kx04TFhOTn3oQzRHUzuWgRTKOpJx6C4b88QkHzMUX+8=@vger.kernel.org
X-Gm-Message-State: AFuF++nowu/3iEieBY+7CD95GLxMIqWWvqLi53GBQywxAlqeT/cqJLJ/
	y/jtmo1Y2I4u/SJlji5/U2ogIy6+7WZFutG4YFfZmSzlep33+abreiNI
X-Gm-Gg: AR+sD12k64VeMUWeEaaH8y9JDvSl27VcPfu1+Tanaf2jc+I30O8nCnZ5uhW3wguWyx1
	y7fnIFXK/CoPb2P5KP1C3oAdNnOxA8rj/Y/nOUN+ZCd6lbRZInPa6W88KEEjTiox+LoZqfXNtVE
	pkkDefkStMp8yhjoibAYhAgiVUtpqwO337QzHZrhn1sk9YvtbA4RnY6wbp1zxaHvL+MMuVc+BlE
	G/SyLNcblop9aRy45F2a793obOvQOXzF0Ty6aU1cUp0Dd7aiSOtJuYggYsK0Ef5mKxj67NuP/rj
	ALvBy3Wdm16MAWUbgvPr0uRGwhP5c/VFP3XnwmTzYER/tqWDyFwcuZxRpFVtx/CoB2zshq4v1fy
	dzhwNnnexZyFYt5JPbKwZY1zNX5mRNL7Pflcm0Awwz8y7vBfzSnX+Jdryjep1h8xGOLW3bjpKe7
	oIUiQdWkygDF7degRUs+9+l/d1yn1YhVgvxnqER6gRtf4Z8mo1iI254FkyUPlM
X-Received: by 2002:a17:90b:164e:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-395c3733afdmr18995899a91.13.1787379984190;
        Fri, 21 Aug 2026 23:26:24 -0700 (PDT)
Received: from tradnomic.. ([2601:646:8300:7570:bbc0:7d7c:f404:1bb3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6ecsm3997899c88.14.2026.08.21.23.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 23:26:23 -0700 (PDT)
From: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>,
	syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com
Subject: [PATCH i2c-fixes v1] i2c: core: Fix use-after-free during i2c device removal
Date: Fri, 21 Aug 2026 23:26:20 -0700
Message-ID: <20260822062621.769921-1-rafad900@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A race condition between a process calling i2c_device_probe()
and removal of a USB device by another process leading to both
processes calling debugfs_remove() opens up the possibility of
UAF.

Fix it by adding atomic xchg() and replacing &client->debugfs
with null before calling debugfs_remove() such that the
following statement: "if (IS_ERR_OR_NULL(dentry)) return;"
inside of debugfs_remove() executes properly.

Fixes: d06905d68610 ("i2c: add core-managed per-client directory in debugfs")
Reported-by: syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
Signed-off-by: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fb25704219c7..6fe11232f5ee 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -586,8 +586,14 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 	}
 
-	client->debugfs = debugfs_create_dir(dev_name(&client->dev),
-					     client->adapter->debugfs);
+	struct dentry *parent = READ_ONCE(client->adapter->debugfs);
+
+	if (!parent) {
+		status = -ENODEV;
+		goto err_clear_wakeup_irq;
+	}
+
+	client->debugfs = debugfs_create_dir(dev_name(&client->dev), parent);
 
 	if (driver->probe)
 		status = driver->probe(client);
@@ -608,7 +614,10 @@ static int i2c_device_probe(struct device *dev)
 	return 0;
 
 err_release_driver_resources:
-	debugfs_remove_recursive(client->debugfs);
+	// debugfs_remove_recursive(client->debugfs);
+	struct dentry *dir = xchg(&client->debugfs, NULL);
+
+	debugfs_remove_recursive(dir);
 	devres_release_group(&client->dev, client->devres_group_id);
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
@@ -632,7 +641,9 @@ static void i2c_device_remove(struct device *dev)
 		driver->remove(client);
 	}
 
-	debugfs_remove_recursive(client->debugfs);
+	struct dentry *dir = xchg(&client->debugfs, NULL);
+
+	debugfs_remove_recursive(dir);
 
 	devres_release_group(&client->dev, client->devres_group_id);
 
@@ -1818,6 +1829,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	i2c_acpi_remove_space_handler(adap);
 
+	struct dentry *dir = xchg(&adap->debugfs, NULL);
+
 	i2c_deregister_clients(adap);
 
 	/* device name is gone after device_unregister */
@@ -1827,7 +1840,7 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	i2c_host_notify_irq_teardown(adap);
 
-	debugfs_remove_recursive(adap->debugfs);
+	debugfs_remove_recursive(dir);
 
 	/* wait until all references to the device are gone
 	 *
-- 
2.43.0

