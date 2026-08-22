Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232038E8D3
	for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388742; cv=none; b=UtLxUd/k29xjw1ABcWmfzWWRYpuyeMosy/xBqjodNzYyX8Jqy8HRRshu1RjnOFJVhXXD63Dn5MD22Mek3hzm/chRO8iN/qqL1jX+BEjGpINxeg4MJ0EROuG+UHgxdY1Kip/PTDo4AjqeZzXPICPSCaH4v1DTC1rhtW3JeM9KtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388742; c=relaxed/simple;
	bh=187gUevoUjeC7SQQCDf4TozN7QjpI1/iaNef5IjHHYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9+oy0F97NZZoeYsh2MRB57FPqUeyu6/dzadHRQyoaCSq9/s9X6yVA1QpyohK0Jk0uFHAgu82nGmnaWfNhoxim3eT8RXBJ8j/PedswTUiqzJMzP4iKLCtMkCfnb1xbORAGC3tcOD65tSUGKzKTovj4k5Mn/Z6Q5PDYFNPBdZXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=dJbwwQUH; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="dJbwwQUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1787388736;
	bh=VF0Ke9qNqILhJ6oYATYP3zDa0WSDrT78Y0w/usS4xYU=;
	h=From:Subject:Date:Message-ID;
	b=dJbwwQUHDWebapAwAwueUgp3HwsWWXZHkm0qOMsaQU9C3ejTZ5n5f+C02k0MJnAqh
	 zCpjBxH++aebyhfersTqTbW6RvyenVEiSpPe2x7w+VDZkWpDBONzsxIeIPEQWI38yB
	 7KA0Xk8lEWAXVqNrmtZUa+4Ci3fGkXZ/mT/u+Mz0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.34) with ESMTP
	id 6A8963320000575F; Sat, 22 Aug 2026 16:52:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8380546291892
X-SMAIL-UIID: 60965883633C4933B51F437140E56EA1-20260822-165205-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com
Cc: Rafael Alejandro Diaz Cruz <rafad900@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	syzkaller-bugs@googlegroups.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH i2c-fixes v1] i2c: core: Fix use-after-free during i2c device removal
Date: Sat, 22 Aug 2026 16:51:53 +0800
Message-ID: <20260822085155.1409-1-hdanton@sina.com>
In-Reply-To: <20260822062621.769921-1-rafad900@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

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
