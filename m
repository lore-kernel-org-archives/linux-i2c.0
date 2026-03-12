Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686F3CBE92
	for <linux-i2c@vger.kernel.org>; Thu, 12 Mar 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327972; cv=none; b=UHFjtAP1rSFhYz6KKMP7s52Mm7L8qfEGLNZIDNO1KoEB1ukF26A/4lKHeAPk9yp+rPIh4NmdBsv3dEVu30X40mDuxRGlWtQhFqlvuKU7WYd2UyOYVASVVkgAiEK+SFOql/lxlB72SUv7RtWaOVvkya9tAQox0NPUVQkGPiu/MqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327972; c=relaxed/simple;
	bh=125sLLSuTjGvTctK7MlteCpnWZ8dRR2FA4yiyluzt3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azub25jOco1htM8MPu1yl5NfBIc6luue2hkzHjIl8bXiIxUJ4qyZyoJrN0X7J5mtq/pfmqkT5905IYA4yCpqYDL/Ng7yOsmuncwvVlz9Amzo3BwYDixvR8WRiE808ipyZLslT6JpF3fsQG+46bbwpnQzqW9KaaDWh8WL0Tx376k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=qriZE8Ot; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="qriZE8Ot"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7447778b9so539269a34.2
        for <linux-i2c@vger.kernel.org>; Thu, 12 Mar 2026 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327970; x=1773932770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ivFPtRhxMTnjNuXFN8NVkjaiUTQi0M7fKGRjGo1VpY=;
        b=qriZE8Otp6ZKq7LmiNfXcf+J6N7VXqdY15d3zwo5BsyJpkuIwfepd1XrkNQ5S6YD8v
         M3swYhftrC359Gsm4ktK9GwGv2ZIaOYqGUVjeCcpAy4+9l8YHUqvCVpvJ0uLoaB1HLsh
         txTRfQ2Qc4QZ2xnKVAsCkVw26n04MSaz49H+hWgCfK3kDz1QD7WnMl1EgYfWDMfftcSN
         XdSbLUtB4IQsswl8AL3k0omaICmdq26pfn91gB1nYhY7KqKyooYkrv2jnaNl34v8ZxMS
         eBPcKUuU8xpNECnqyT5rYdO4v6amsgooWNmt65D6HXG+Sh8lMk7BxTzQlccEUNPxPaOh
         8lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327970; x=1773932770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ivFPtRhxMTnjNuXFN8NVkjaiUTQi0M7fKGRjGo1VpY=;
        b=EH63636W5QsUNHt5Kw9e7hXABr7X1J2VzLQQYO9lX2kSryh5NumHQwwIJBLS4jdtcU
         GqhglmhZeWbj7gJikBdM41WQiUG5554iDsVa2TTXopct6UKPuDNSO4g+LYuFTox7UOp0
         mfEgDdb+B6ps5vtMK3KX6RvV+FWgssqIMSYcCZCC0AradmJa7YwGHyv5wFKDlL7DMesS
         VjlLJaQW7VWKCK7zPV7i2HX15aqXuP4+K9kkWMFDknyphXSP3Nz+G0KuqBYexADMuRWZ
         llnRmKlL2UQKYDoYZa3d3oXZbC7JtsQZMBhWl+HgS+DaX20wlBjQaiG5IPVl77hCioOm
         QPhg==
X-Forwarded-Encrypted: i=1; AJvYcCVby/HdtZ02ruxcWXGJiZ0f6YPk877NN6EkkB0gmM+ICVf1upvofumxvanGMOjuapSMkIfbZ97AxSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0pRQzG+G5PRgp9nf7F9B7P2h05/QvxpIUtZUR9n6qMicM/sf
	UXKv1U1ro6KMs0seQuNdLCZJjMU6GU9YvUHHUv1LQk5N21zcho3aQxQ96laDeT6YlUI=
X-Gm-Gg: ATEYQzwsrUQt5Z+szZXSUzpyd8H4RG5pymKmBTiba4Bqc7Ai+UtSJop1zuHiAFBbb5L
	6uGAZLHtdyHaVeBGhmDRQy0YjRNosGEj0la9FCDe8PJ/2OLaASTG7GIbDoe/bLsQnsIaEi8Zyzj
	Uo0ut+pSqaR2ffBqvcYZDCrjwhr1n1dRr2sBvoxM741rhGxmIqaUApiUxH5l8E7ftYIdQ222cBs
	ej2zwYK26Pj6H2RimlLErzGU/q4xjU1/8qQyYs8YA1/VSjU6Z/u7R02fATSKu6h8l4J8AsCWjI1
	7iatBbq5rDh50zdTlcmv+JWBHqmBHC6G6HOWuR+9SQYDdI5HN5OFirussyCQbgsldYzztY/bBLK
	gg9Qp4nZObNdaxQYBsUTfRRmlx7dYj/naRwxjaUXD+4IMaHzcbNWtkuLZwHgeu4KrCU0wWcId+b
	j0sQK/cKlrstc+MWtu9rNdHz44IsvfKii4ZYyne573MNtSmkLj+KqxXrMMvRD5bAwKDQ==
X-Received: by 2002:a05:6808:4fcd:b0:467:11ab:cd6a with SMTP id 5614622812f47-46733422f3fmr3665303b6e.2.1773327970368;
        Thu, 12 Mar 2026 08:06:10 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:06:09 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 12/15] i2c: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:07 -0400
Message-ID: <20260312150523.2054552-13-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/i2c/i2c-core-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 02ca55c2246bc..04de8908de5fc 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -89,7 +89,7 @@ int i2c_slave_event(struct i2c_client *client,
 	int ret = client->slave_cb(client, event, val);
 
 	if (trace_i2c_slave_enabled())
-		trace_i2c_slave(client, event, val, ret);
+		trace_invoke_i2c_slave(client, event, val, ret);
 
 	return ret;
 }
-- 
2.53.0

