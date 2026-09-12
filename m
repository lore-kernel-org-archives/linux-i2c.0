Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE5331A6E;
	Sat, 12 Sep 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789229547; cv=none; b=S7621508Ijl0fZtth61NWrxS+1FKfZrnG+mjsfHv569e9oPFAsHM4yJdMxLmlWA7W98xFk0luhSwOH+KjmDzlT3EyAc5CmEY6dtEidovB/tSp5YOOkZSQZGol0SKcWpeTeC5ay+8xASm1FnF4yaEiSlIRfmBz7l2yaIZ4LLi+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789229547; c=relaxed/simple;
	bh=Jq+lXFt/DvHTKBTccAzLvvlFYvfksp6s1tq8Ht1Df9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZAOvgvVSAzgiqs9nxI1kgg8p6XVQh9cERHEE8OxTPV3TllCcphpkWJBnbXjJ43AlTkURdFnYfg/cVurECrOMfvqjhK5qvKp45mvwrNPFxwEywp/LxE8oc8HzVsanEU/JyoZRKKEh787bExlYoO8lIqqSWueC4OextKjgFivqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=j+YGDr1E; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="j+YGDr1E"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d867e24b;
	Sun, 13 Sep 2026 00:12:19 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] i2c: slave-testunit: prevent work requeueing during remove
Date: Sun, 13 Sep 2026 00:12:17 +0800
Message-Id: <20260912161217.1683453-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09664200c03a1kunm66cc688621d6cd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUpKVkgZHU9OTEMfGUxOQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=j+YGDr1EIAAFWRFYmD9uVQi5zJBOV15z6YhJymaftbZ3EGnJzhiUJIIlzW+UD1o/TFb1ndE5ZPJN+MCOpKd8FZ0nie/NSJHPJKBLILnNrrTFx5umECKLZa/lLK5DHfjF4n/3oyrJegoiKYhd+Oqa2T0BTMVzu9fdj4A0ykQ+FFM=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=3ku/Zq7VV2rN6a4VIH8vuqaooA+I4kAa4rNpnlVWlMI=;
	h=date:mime-version:subject:message-id:from;

i2c_slave_testunit_remove() cancels the delayed worker while the slave
callback is still registered. An adapter callback which is already in
flight can subsequently handle I2C_SLAVE_STOP and queue the worker after
the cancellation has completed.

Remove then unregisters the slave callback and returns. Device-managed
cleanup frees the containing struct testunit_data, leaving the delayed
worker to dereference freed memory.

Use disable_delayed_work_sync() to drain the worker and reject queue
attempts which race with removal.

The issue was reproduced with the real slave-testunit module and its
normal sysfs create/delete path on a four-CPU KASAN kernel. A virtual
slave-capable adapter supplied standard I2C slave events without calling
driver-private functions. The unmodified driver completed 1000 removal
cycles and produced 111 slab-use-after-free reports in
i2c_slave_testunit_work(). The fixed driver completed the same 1000
cycles, including 993 transactions which reached STOP after target
unregistration began, without a KASAN report, warning, Oops or panic.

The reproducer uses administrator-only backend creation and removal. An
external I2C master can supply the command and STOP timing but cannot
independently remove the Linux test backend. No unprivileged or remote
security boundary is claimed.

Fixes: a8335c64c5f0 ("i2c: add slave testunit driver")
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/i2c/i2c-slave-testunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-slave-testunit.c b/drivers/i2c/i2c-slave-testunit.c
index 4a1bf1aa504b..97a7542fa8b0 100644
--- a/drivers/i2c/i2c-slave-testunit.c
+++ b/drivers/i2c/i2c-slave-testunit.c
@@ -265,7 +265,7 @@ static void i2c_slave_testunit_remove(struct i2c_client *client)
 {
 	struct testunit_data *tu = i2c_get_clientdata(client);
 
-	cancel_delayed_work_sync(&tu->worker);
+	disable_delayed_work_sync(&tu->worker);
 	i2c_slave_unregister(client);
 }
 
-- 
2.39.5

