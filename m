Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3CD378D80
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771445; cv=none; b=l0Wy2vWR9to+q9HdchixsGA/MKccUe/ldhLfYtXUo79fDFhQjxm0Q0lba3lx6J58zM8piFokPsM+WaPdcp+TSANOddcOWhAe0HldvCwqMJov5dJR8J17DF5kBKbIfJ6Efyxb+gy2PNQo89wx3ju6DtiZcgXmIxHEEuDcfsq2yI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771445; c=relaxed/simple;
	bh=grxsWiSQIWYptfHyeCAe36YzyB1aNPsrBaAkZWRkASA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVyijzYCyYJtBRFYATXlCLZscZg8qdtXjGu+sTtFC1mXGzQlHwYhjYcIxyRBHc3VyTVRV2TKtzoQnk/YaLNt8kbnovZtJICrQFrb4VvW1Z37sjLjFHC4usxbvdbAKGjXsjHksFP/Kfm6DSkKOfQkKbE3xv0aRZjiZPzNoHmhy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyGj0mcO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyGj0mcO"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso3096863a12.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 03:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771442; x=1770376242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Oe6WMhUi1fD7716YH3wMzfV07CChalwfEI7z463Rs=;
        b=XyGj0mcOnN6lk70zRZzqlBBeo6gsr1B9ooypuJxVJb/5k3zOUpCy6Qn2Nl0xppiSb4
         DAAbX3uYSO2A/yD5wam5Spy5ETOA9rY4JJiuHft47uNiHKDeLbtaBdgjdYwT0gzMvG+t
         qnqcV8P28GiBmvRcwFnkrpbOwvpweEN3nUXgByxy6P4GFViam7PuQKYHPKzAw62YlUp9
         5xGjVWAP7s7Wraiwps44uagLmjpkXQViYRkX5tqvMbp0V3tI4q/PP/kByHjdm6YaaqqL
         LVeLtFs1yY+lba1q/zQWkwTSncMAY0j2trlUd4QMoLfrK+LTmRiEUOR/EXfQz4u+jMk6
         uFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771442; x=1770376242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+Oe6WMhUi1fD7716YH3wMzfV07CChalwfEI7z463Rs=;
        b=VIF7pkH5weAkXOOp1C44o2a+0tlkUtiAvesgtUKv7srJXuoWTUNnab+OlsvtYN4cCE
         WqyimvglS2QVVAMQMt14j1ige3obmo3VPSm80q/ydKgHG/1zbD13jDOY7tfpknUgPcdd
         6s6R7GlM5bLfJdnfYvEe0WZDtOLVIQtwpIA40W/nyKAJw8eEjsVbVoGs1ao/pSE2oanr
         5MRNC126MLBQ5P4xhvai1po7djaHjdg2drg88Rhc5UoYWW2YeXcDod58ZgVQju7lcRms
         AHM42v4Ysnc+I6kVQBdCGLJ396EXKq/0fzMJQkOHPPRBYwxmR03DIQJvMzpr0W2G66R4
         0GnA==
X-Forwarded-Encrypted: i=1; AJvYcCVjf54Zt0BwAPCm0le0BPZFrf3TPZR5XxNZO1ptAWPfEjU/+l9MKgYCZJFEn/VA45/WX/vzvDhMgC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59IVAyafOtM/IahygT3CE+/rQ3jYJo/5bVy5/5XEH7+dEOG5e
	zs+aIxLPRu4EsdPCFO/DfCOMOO3FmTytElSPwkmGTMvtvTAlaAPqftkuSH2EKZpA278=
X-Gm-Gg: AZuq6aI3mFLQN81mlUSB/njt8ZZKTPmaBbjsdW03OuuE8NBj2CwVm/RvsX9emvU+1j6
	afTUhRUHUz8i/2K79lr35Mvcot+nj9CkL95UUh0bNZTcpqVTzVzqXkPV1lemejEizgd0Al6/nFk
	tZlEtz0BBczVkXwViMg72Cggm6wgESilYWTGgWmD/rLc92h1Zp6SlGgb9OLzseZAQpe3NieIzUu
	ZbGVzmI2kMIq9PjHz1wqWyF5u9FQKz4c6GFt2RhH5ljhRe0NXnWK+hQXOC8fskPqQ4IPtTR2ZOO
	9lxDQ117PCgix/7C2e5EJVkz1peyKlsPcW+0j4wJ+I61l+nGG67yUf6WIZQC61+Rwvl4u/aWagW
	qvDTXro3t97Nx5kEHtLNXveQGK/iO6d2ou4hA3Zsh9n1DG2wx4pq+XDAfv8gJH5yOzAXnrj8k4o
	zi4JU+yQ+wdBt8d3UxZMjR4d6gWyWo2w==
X-Received: by 2002:a17:907:3d0c:b0:b87:d09c:1824 with SMTP id a640c23a62f3a-b8dff5150ddmr126853866b.3.1769771441743;
        Fri, 30 Jan 2026 03:10:41 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeffedd3sm396035666b.29.2026.01.30.03.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:10:41 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andi.shyti@kernel.org,
	p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] i2c: designware-platdrv: simplify reset control and fix cleanup on probe failure
Date: Fri, 30 Jan 2026 14:10:35 +0300
Message-ID: <20260130111039.874548-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series simplifies error handling and reset control management in
the DesignWare I2C platform driver.

Patch 1 replaces the manual reset control acquisition and deassertion
with the devm_reset_control_get_optional_exclusive_deasserted()
function. This simplifies the code by eliminating explicit deassertion
calls and associated error handling while maintaining the same
functionality through automatic resource management.

Patch 2 removes the unnecessary goto label for cleanup on probe failure.
The cleanup operations are straightforward and can be handled directly
in the error path, making the control flow more readable without
changing the error handling semantics.

Thank you!
--
Regards,
Artem

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251009074443.2010699-1-a.shimko.dev@gmail.com/
  v2:
    * https://lore.kernel.org/all/20251009083703.2038187-1-a.shimko.dev@gmail.com/
  v3:
    * https://lore.kernel.org/all/20251111140935.3220840-1-a.shimko.dev@gmail.com/T/#u
  v4:
    * https://lore.kernel.org/all/20251111145536.3232456-1-a.shimko.dev@gmail.com/
  v5:
    * 
    * [0/2] https://lore.kernel.org/all/20260123100537.1429497-1-a.shimko.dev@gmail.com/T/#u
    * [1/2] https://lore.kernel.org/all/20260123100537.1429497-2-a.shimko.dev@gmail.com/T/#u
    * [2/2] https://lore.kernel.org/all/20260123100537.1429497-3-a.shimko.dev@gmail.com/T/#u
  v6:
    * All reset related changes have been carried over to Patch 1

Artem Shimko (2):
  i2c: designware-platdrv: simplify reset control
  i2c: designware-platdrv: fix cleanup on probe failure

 drivers/i2c/busses/i2c-designware-platdrv.c | 41 +++++++--------------
 1 file changed, 13 insertions(+), 28 deletions(-)

-- 
2.43.0

