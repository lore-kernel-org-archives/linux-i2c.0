Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57912E6CC7;
	Wed, 17 Jun 2026 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666246; cv=none; b=VEVQVxb/KA96A9gx6cB2StS/rXT92oOI7KB9BmwOK1SJTzng4pu0r6OgTgO5KvVeZiderUvBheCrCt3bcZZjFQ8Who4+SSb3smEatd2ttSj3e91AAw/eq5DeAaco5JZSKeSeTtdXZQiOCTKzKn+5n3NQsG9ia5Lsn7f97QNGmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666246; c=relaxed/simple;
	bh=IDnvYn5Ez+gwXCTGgPLRG7i9cbI6CEEUE1E2bs1ZbA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZaWcJu36vpmykXarZpTef5lu9in1OvxqBgxr0uEojWhotuY5crzqeeByo++8rVdR4dMjigh1IXqgxv3Tb15tTeiRkv5DV5W4Iw5jweNuq4xw8JBlp6bweRbjS25X/Jw3oHhoShp1kvbEFSvKuf2R+J2mdak4Sl2OvYNDfYls44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YLiHY8yY; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YLiHY8yY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fW
	CYvr53asNyyP12AIc2sNruqQEi4dBSYbddVckFnYU=; b=YLiHY8yYTtZgOyNnBY
	qx6McE8E2jxdj2c/zEFsg9gq6FssNe7xpm7uaZ0mBrgKyQk3VI4wf50JABluHtm0
	SLn1np8H0LPC8oCtgtXq10HBlVsWwsGcWrGaMD+bu5VteM84Lkt50GzK2IBSbg7F
	ODInqsANjhJcMgdO4XaKPfIIg=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAX_h2hETJqS2V_Cg--.58501S2;
	Wed, 17 Jun 2026 11:16:56 +0800 (CST)
From: w15303746062@163.com
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	25181214217@stu.xidian.edu.cn
Subject: [BUG] i2c: i801: interrupt storm and hung task with invalid block read size
Date: Wed, 17 Jun 2026 11:16:46 +0800
Message-Id: <20260617031646.13295-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAX_h2hETJqS2V_Cg--.58501S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr15WF1fGw4kAF4Utr1xuFg_yoW8tr47pa
	43CwnxJr1UK3WvvF1DJr4UWa4UCw4xGFW5Gr98Jr10yanxCr18AryxJry8tayUC3sYg3W3
	Xr1UtF9rGrykAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7rcfUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAAiVeWoyEailhwAA3n

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Hi all,

During concurrent fuzzing of the i2c-i801 driver, a severe interrupt
storm and hung task were observed. 

Note: The crash log below is from our fuzzing environment, but I have 
audited the latest upstream master branch and the defective error 
recovery logic remains untouched.

The issue occurs when the hardware returns an invalid block read size 
(e.g., len = 0 or len > 32) during a byte-by-byte block transaction. 
While triggered in QEMU, a faulty physical SMBus slave or bus noise 
returning a 0-length could similarly cause a kernel-level DoS.

Code path analysis:
In IRQ mode, i801_isr_byte_done() reads the block size. If invalid, 
i801_get_block_len() returns -EPROTO. However, the ISR catches this 
negative value and forces the length to 32 instead of aborting:

	if (priv->len < 0)
		/* FIXME: Recover */
		priv->len = I2C_SMBUS_BLOCK_MAX;

Because the transaction is not cleanly aborted:
1. priv->status is not set to an error state, and complete() is never 
   called. The caller hangs in wait_for_completion_timeout(), holding 
   the i2c adapter lock.
2. The hardware remains in HOST_BUSY, continually asserting the IRQ 
   line and trapping the CPU in i801_isr() (interrupt storm).

Crash logs snippet:
------------------------------------------------------------------
i801_smbus 0000:00:1f.3: Illegal SMBus block read size 0
clocksource: Long readout interval, skipping watchdog check
INFO: task syz.3.373:3148 blocked for more than 143 seconds.
      Not tainted 6.18.0 #10
...
1 lock held by syz.0.370/3150:
 #0: ffff888101d110a8 (i2c_register_adapter){+.+.}-{4:4}, at: i2c_smbus_xfer
...
NMI backtrace for cpu 2
CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 6.18.0 #10 PREEMPT
Call Trace:
 <IRQ>
 i801_isr+0x167/0x990 [i2c_i801]
 __handle_irq_event_percpu+0x222/0x870
 handle_irq_event+0xb0/0x1f0
...
------------------------------------------------------------------

Could you please advise on the preferred way to properly abort the 
transaction here without corrupting the hardware state machine?

Best regards,

Mingyu Wang
25181214217@stu.xidian.edu.cn

