Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270E37418D
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216610; cv=none; b=X3Pid7Yt5Jl7MIvupPx+lZB8G+4u5m+paxmY43osy17B4J4n9s00B6wMPZqx8rHKAXYcyTHgK1rHbuTQkQt4muLET1mTrlrSTJ8TmwxHEQWkZioWmy2p5Zt8+DOGlp6cP9TSzgBiLNX3maiZVSngfQlwaMcs7yRoekQXFUpU25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216610; c=relaxed/simple;
	bh=PYAhNtqtnszYu5l+tbTZL3tiM35a60fQLKNvKel4cUY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jbm4Qq/T54/zoD4n1AjXpXjHueywnqqqH2Pn1n8Ux0e/GN0I8plnW5DBqjvuGmkEh7j7K26mtqM6klnm/ttKla4LDFjoN1gnzWTkUidkTVWl3lF34olR0mwY5eG5nnq6otLyFHR2p6z6FCkJBAzgVtZdcKUBZCqyrRcX5p3JuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUl7Bbh1; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUl7Bbh1"
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-5ff2bc282baso2357347137.3
        for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 10:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772216606; x=1772821406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lo+eJagIXatFxiZOuXjyzp4yV+2ptGEyj5f4SK9fDa0=;
        b=vUl7Bbh1GXFsTsEp+3e+gZJR4RMxSyeY/8Qv9nV01Q7aL+ojXcXsHtNY8jJMFLO6rf
         6vh8VVPLjZV5gF0hPLo+ccF3eNmHfzMSNHfqg8B8HKogNKWb0vezbclJ+wIKvsY6gt3y
         P/fFJDbEscFwr0Avh/fLOpPh+aBAG6pwC9jZNOU9Bzff0O9CMIK41eNlw7G85KNmuXE2
         FQZnV0N/2mioVdN8gJ4P1Cv5U1AlVXJnH7I1ckOGCmcVfkgyfue1SaB6ccfadDs/BfLT
         f5VHqbsG4oV/fv6KVTd2JmsJxLHOolVX0n7uzjzoJJTzBngoJ8joLOIhVfzgjX/Q950M
         7BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216606; x=1772821406;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lo+eJagIXatFxiZOuXjyzp4yV+2ptGEyj5f4SK9fDa0=;
        b=oB/uC9vljD+kMcXPUmqHf6e94eqIKNuhlcWFkyZChUqXuLXmGHRAP0V2Ywckc2pQAC
         aogohW2X1//QgKJvMDpTuWcMHIR7DAw+anYehQtEfdGgNzGlzlOMwRqgZOgkiPLHzJmf
         GNYAciV9+jf5ZxkzkZcOLh8VNWzKuI1lGEmctyOoAAfvsZTi4SpUm/8v3BvitIvKIdaT
         VNc4IDENroCNUMjTcxbJddphYtj2A3Aco+9qe+l2lTrMJPjCBanNT4o5gS8+OSYHAsX7
         11orf9VAvT4PP5WAs99O/LuBWTHuIus5qxl44vYNgSNKAD5xKff+wK0RNGMHNJBbD0Vf
         /6hg==
X-Gm-Message-State: AOJu0Yx0iuur5Y8muE3Pw/LwIlLHI/9Y4FqrUyiYtOANag2qyr1t2i0b
	ifE7XO8hjszNxk8EpyjUqpPLKVdZ9s9hl+35JaTF3+lpCtSZZVuKT8DCFi1WvuZnW4Il16AHTyt
	KGqwEbKLGXUcMYCmlkL3tcKl6aHElo+uyF5a+lEPBnNC/4dFp6qj2vhBC4dtgqgPYJwy07XicLL
	8QszvqOakSFllQvWMBkFOFweeGjp4/63ZW8diikhZNTuw7dg==
X-Received: from vsig23.prod.google.com ([2002:a05:6102:9d7:b0:5ff:1300:8955])
 (user=moritzf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:3e8a:b0:5dd:89af:459b
 with SMTP id ada2fe7eead31-5ff322c4256mr1650178137.7.1772216606273; Fri, 27
 Feb 2026 10:23:26 -0800 (PST)
Date: Fri, 27 Feb 2026 18:23:07 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227182308.776922-1-moritzf@google.com>
Subject: [PATCH] i2c: designware: Add a new ACPI HID for GOOG5000 I2C controller
From: Moritz Fischer <moritzf@google.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mdf@kernel.org, ovt@google.com, 
	Moritz Fischer <moritzf@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>
Content-Type: text/plain; charset="UTF-8"

Define a new ACPI HID for GOOG5000 as used on Google Axion.

This has been validated on Silicon.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jan Dabros <jsd@semihalf.com>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 426ffec06e22..3351c4a9ef11 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -268,6 +268,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "AMDI0510", 0 },
 	{ "APMC0D0F", 0 },
 	{ "FUJI200B", 0 },
+	{ "GOOG5000", 0 },
 	{ "HISI02A1", 0 },
 	{ "HISI02A2", 0 },
 	{ "HISI02A3", 0 },
-- 
2.53.0.473.g4a7958ca14-goog

