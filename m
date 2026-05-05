Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE336EA8A
	for <linux-i2c@vger.kernel.org>; Tue,  5 May 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003761; cv=none; b=UnUbx4HxCyY01YsiwBna/czdsvvXxNnrlb8K3WKgJ+9vBGx4fNDfly5CcTBj9fgEs+RvTdefSND9geJRfY4iVXh57alo7WRl9uem6FFm0kJTxsqELpSHQv2ZAt2NBarzbx+oZ2JnTRmMPsBC4pEYH2QK19IzlZ0DUAByXRQMc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003761; c=relaxed/simple;
	bh=NxW9I3BhNiO+2+AGW6hS9Oeq4rZDxWVX3/T3h0T7XBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2v2KJt5D61uBv8+eHmWjRfM6qCAaFohXY/5ETESmm7/XZqlky4/XgrmYHNdVGeQXcPJ4Cpx7SS28Le+xPUKojSrpS7h4CqgEVc8I/nN9U+NHon1MdoQxCtULmQnLQdk0YeFlUc+lxgb0vxiUWIvZs31pnrp/7frXcRVlf68Acs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO2CdVYH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO2CdVYH"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70c112cb61so3414101a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 05 May 2026 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003760; x=1778608560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx4i6Txgy6DoPF46xtQdVqhEuZCvacl8wPfj2s4kHQ8=;
        b=PO2CdVYH2nIRGDWkMlw6mQ3NSfdsbJZ/Ly075xIzugYzJIhaEkzbYGFsqsdzn8ztJb
         a269uFz3AUEDUP2HZ41rMJN/rqxDUk+pe5GZwbptPdGil8eHDn/sZEtlhAUkiUyS5NvS
         coL3yvFMGrsZnltuEx6UucsgNjnRt4AOwUtcuFHAUT17OQj3l0WSkfqIp58QcO82TRTu
         0qKmjrmZWikPdsMeX1dK9a2Nra6JvRxjcc8m7Z3NW/PKiKU/RI4MRNS700AyxwBGWO8k
         fna2lcjjC8aaLHZwJxUKaNuyX+rui2aIdAuBpJsIgV3961tWLkiXk1t1pTJGHZ6cTFMn
         GMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003760; x=1778608560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx4i6Txgy6DoPF46xtQdVqhEuZCvacl8wPfj2s4kHQ8=;
        b=nYZadSqqqNp9kR9/JrE0vGhY/0C7mU6yqtmoL8xetpmVWXrsf/wRskDsKbzWICl3JN
         TLIn7/Y6LqBxQp7sxbzhS6g1SnGLehZsT5cZbceHMCIxr57ddMkQXXnczn2BNhnkgTWq
         8a/Y5PrqZZBW2PUEHnNZfSSSbfOoj1MPqqNXegUf9RoZnSMIN7gNayUuodDM5PTOgzdd
         Z92WtJ8msobWq9942kk3DxjuUVkjfnyxsZtszDnz32aizcJ+JVDEbzflAeeBo3C84J40
         UNyeD3cwaFHsAlmQ6zE7ne9YtQi70BSycOD1memyLgyzavrVZ+gpm0NzcJ0niAdPcOsm
         QvGQ==
X-Gm-Message-State: AOJu0Yw6HyJb2awyflerLKRHPX5BEZmliJwJchuWxVHkgTNrwHwfQ7ds
	NZvAigTfC0JEkuSRRi7iNGWWEowwkPTAeAaNII1iWQynNArQgfCYhqdRzpocgLsFphQ=
X-Gm-Gg: AeBDiesa0/ADEVGhwm7lk9mszCpxxgkpBAfVynuIzOwBgdweLLxF9btkS7ayT7CQGsG
	C9MV4Iu3MO0SURXlPn+iMbrEsvOwfJ44UHdmOqcYEyXY/XSmF+1z42EZDSeRa78YAR+fqsj9/+u
	hiPfjaCxc70Sbq7xAiuo1N5EDtB1/MCuq/3MCg0FDoor714aZIC2sfWjxo1xCkqmMoLAguVdYGV
	f0UGEhBWUuu16BYrD/iS+N50y+efW1Z/3AQnu+LEZgoHXLXEmtzxwdM+ct+RwQpuqxIm3fqsaxc
	HasZ5f+/7cIncGPUnwLmFz4bJ8L4LpwalzF4c3u4ZVCijOKej63XATOAPJ+zo9QvwWsIuG0hEk3
	+f7wX2vRh6SG+Zmdz8LcqUE6lFTN5+tOGwusOmm1cOBz7WHy4Nl1yMCCIx328Jxbp22F9kQukuR
	azcwXLqaA8mIZbbL9Om1AMwL1GbWk6gyFD7s/VYKB3EN8xu/EXQksgHYjsTVBgNocyxitYGcWNM
	++jq8ii8zda4IZ/3o9Wx44=
X-Received: by 2002:a05:6a20:1592:b0:3a2:f2b1:1ac with SMTP id adf61e73a8af0-3a7f1fb6640mr16655349637.44.1778003759641;
        Tue, 05 May 2026 10:55:59 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbba635dsm13531169a12.3.2026.05.05.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:55:58 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v3] i2c: smbus: reject oversized block transfers in the common path
Date: Wed,  6 May 2026 01:55:11 +0800
Message-ID: <20260505175510.1403736-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMBus block transfer length data->block[0] is validated in
i2c_smbus_xfer_emulated() but that check runs too late for tracepoints
and is skipped entirely when the adapter provides a native smbus_xfer
implementation. This allows user-controlled oversized block lengths to
reach tracepoint memcpy calls and driver callbacks unchecked.

Add an early validation in __i2c_smbus_xfer() that rejects block
transfers whose caller-supplied length is zero or exceeds
I2C_SMBUS_BLOCK_MAX before any tracepoint fires or driver callback
runs. data->block[0] is filled in by the device on SMBus block reads,
so the check is scoped to operations where the length is actually
supplied by the caller. This is consistent with the existing -EINVAL
convention in the emulated path and protects all downstream consumers
at once: the smbus_write tracepoint, all native smbus_xfer driver
implementations, and the emulated path.

Two distinct bugs are fixed by this change:

Bug 1: smbus_write tracepoint OOB (include/trace/events/smbus.h)
  trace_smbus_write() fires before any validation and copies
  data->block[0]+1 bytes into a 34-byte event buffer. With
  block[0]=0xfe the tracepoint copies 255 bytes, overflowing by 221.

 BUG: KASAN: stack-out-of-bounds in trace_event_raw_event_smbus_write+0x27c/0x530
 Read of size 255 at addr ffff88800d98fcf8 by task poc_smbus/91
 Call Trace:
  <TASK>
  __asan_memcpy+0x23/0x80
  trace_event_raw_event_smbus_write+0x27c/0x530
  __i2c_smbus_xfer+0x43a/0xa40
  i2c_smbus_xfer+0x19e/0x340
  i2cdev_ioctl_smbus+0x38f/0x7f0
  i2cdev_ioctl+0x35e/0x680
  __x64_sys_ioctl+0x147/0x1e0
  do_syscall_64+0xcf/0x15a0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

Bug 2: i2c-stub I2C_SMBUS_I2C_BLOCK_DATA OOB (drivers/i2c/i2c-stub.c)
  stub_xfer() implements .smbus_xfer directly and only clamps
  block[0] against 256-command, not I2C_SMBUS_BLOCK_MAX. With
  block[0]=0xff and command=0 the loop accesses block[1+i] for
  i up to 254, far past the 34-byte union.

 UBSAN: array-index-out-of-bounds in drivers/i2c/i2c-stub.c:223:44
 index 34 is out of range for type '__u8 [34]'
 Call Trace:
  <TASK>
  __ubsan_handle_out_of_bounds+0xd7/0x120
  stub_xfer+0x1971/0x198f [i2c_stub]
  __i2c_smbus_xfer+0x306/0xa40
  i2c_smbus_xfer+0x19e/0x340
  i2cdev_ioctl_smbus+0x38f/0x7f0
  i2cdev_ioctl+0x35e/0x680
  __x64_sys_ioctl+0x147/0x1e0
  do_syscall_64+0xcf/0x15a0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

Both traces reproduced on v7.0-rc6+i2c/for-current with KASAN+UBSAN.

Fixes: 8a325997d95d ("i2c: Add message transfer tracepoints for SMBUS [ver #2]")
Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3:
- Also reject data->block[0] == 0 (Wolfram Sang); scoped so that
  SMBus BLOCK_DATA reads still work, since block[0] there is
  filled in by the device, not the caller.
v2:
- Moved the check from stub_xfer() into __i2c_smbus_xfer() so it
  covers all callers, not just i2c-stub. This also fixes a separate
  OOB in the smbus_write tracepoint that hits the same missing
  validation from a different angle.

 drivers/i2c/i2c-core-smbus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 71eb1ef56f0c3..ad6acb5ebadc3 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -566,6 +566,18 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	if (res)
 		return res;
 
+	/* Reject invalid caller-supplied block lengths before any
+	 * tracepoint or native smbus_xfer callback runs.
+	 */
+	if (data &&
+	    (protocol == I2C_SMBUS_I2C_BLOCK_DATA ||
+	     protocol == I2C_SMBUS_BLOCK_PROC_CALL ||
+	     (protocol == I2C_SMBUS_BLOCK_DATA &&
+	      read_write == I2C_SMBUS_WRITE)) &&
+	    (data->block[0] == 0 ||
+	     data->block[0] > I2C_SMBUS_BLOCK_MAX))
+		return -EINVAL;
+
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.
 	 */
-- 
2.43.0

