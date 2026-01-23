Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D42C15BA
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162750; cv=none; b=Nta7vkgdnOvoy7lZmjMyBBC3ED3xTJOyBcL/hyf+z/f3AxZddkUq4mYZJ8/jXjuPl6if8jeB0SqL5cFPaO9FPG8ghWzEqg2QMD6/m8jZSDHNIOHIuOh6y4KaOpYs8wotc4Yfm/csESBijmyFNhyCzNIg5/blO+NVhRhaq8vbI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162750; c=relaxed/simple;
	bh=ZixxmyDJK1TZsGAkuoNjkGaPnXKebF+tiR5kAJ33kxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rE695T83HIC4Qj3YzYX+jj8kKS/A2yatqcANaiyiKehlUKWI2sV9sl2rdlSeSH/dLOZTijwB0Ag8PPfkvx3VsGFx2YCKf91XsrC5WKv0pso9uPhnyOCwoAhVRbV7FduyYLGqEeEG5Xqsz5HARc2Obj7JhSOz1Y1tOLLCXettdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igLVGsme; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igLVGsme"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so2596844a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 02:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769162742; x=1769767542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OPAhEHcnzFb1q5rx6RdDHI02f+ORuOWyrLORsemtx8=;
        b=igLVGsmebSjYnnV4fLKGgiFpRf696iQgjuYDpOoHpWxKgte0+9r4c7FRxNN0Nb8vQy
         9U5vs3vr6rqxkLlPV0uJgmCipNtmJIYH5t0FKHrV5zdsDR6RiV+hEu2araclE3gETsMx
         /HvODuyV0bkp7S0Q4wELKohjvKJafyG79zNRYmerCmctgBMlH/6lKzilsiJbtKGCICRz
         ZskFEpDGjIlWIk18a9dCqQ8wRBreRhTqSoncTy5IYaJI1tKqvRYT5KAMa2jWbe5sCbAd
         S5U1wRhzyMO8khk7LA7CaKoUFwmux6HfrF+0lDsfn/NYRmixnPMoRhaj2TjCEZqySRND
         Nozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769162742; x=1769767542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OPAhEHcnzFb1q5rx6RdDHI02f+ORuOWyrLORsemtx8=;
        b=FK1ubbTKP1YaU6cZoYzoF9J+EjB3sHL5kZMd4zyNcepeuLS2/IhYpY7ty/8r712WpA
         dhNm8pMYzC8aLGLywG9FKWP5yHy0jLJ12UfgAfDIT+cZojutag83NM0gSwR0QPjJMbwW
         JSRKEJNAEBMpFmlcHwHbQV6kZojh6DcFZ3DBTloSa2uvjXWaGw3uAYQ7Xwje0qaIlzQY
         xGn4zeuDBWIDsJv5lHQ2T8SqSngPyWqwI2QNyoUD/jAXjp0XKCBu8QZU7tKTBT5Y49Q2
         H1WmDM4p4powWqTLc/YbNjOUlP5RenaDn3jcDOdF7f/ZsiMM21hpf7++IPOz1dHBkBSl
         rhBw==
X-Forwarded-Encrypted: i=1; AJvYcCU2GFSedOqFu7t0Z5fM2S4BmsBCV7h6xU0xppLUu7ZzmGYvzl124wOxr1zrfzKI4nh0eaRBsrl5YYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPMOoRY3QjkksIf42TQm1tFGMBRxToa9kAoKpGZOIUCrnJPfC
	B5A0ghIoNKwGO4DFFs7ZGGbKdzmYuWwLDrfXxJVvn4/331LusLgFLq6m
X-Gm-Gg: AZuq6aKZsyr0d/db/YuJk9D9VevNovHh+SLLZJEwS/RNMl9puKYg2qYQXOHwaMALrYY
	h1Woz20KlE6z3A+Ag/C1Rr5uMGTH+7I5CDuBK8nGKE22Fy2pNhHTvOqGGFo2Hbk4pL8uUFTBh0h
	AUHQLe1xAXrXE7A+ha7NkMu8Az0djyY+OrJXamjwtwXBOEEMvv24d1jQt9y4wYixLnQTMek8COS
	/bpb1pYxaZHZMwNierbVAbZE+LTrH8yiMsLNZQN8L98PYLTz7Rptq6MWBUBkmiVSsbht5mpYC4q
	k6PUERtPFr5VHYVuCm9NUeQd0WOUq7isIRtsg0B5XWZlUu5zy+9Aj8YjdwAuDJscfb5t+Qt+2VX
	hiaGcwxORtAG4SWcC37ba82rjrRaZuTFwMcFNSXTVZn/FAXQnYkj17w5mJqTQpyJWoXO2jefWSS
	oI/okaig36cYjR
X-Received: by 2002:a17:906:ee8d:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b885accd55bmr187411866b.28.1769162741297;
        Fri, 23 Jan 2026 02:05:41 -0800 (PST)
Received: from NB-6746.. ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d669sm83079366b.51.2026.01.23.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 02:05:40 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andi.shyti@kernel.org,
	p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] i2c: designware-platdrv: simplify reset control and error handling
Date: Fri, 23 Jan 2026 13:05:34 +0300
Message-ID: <20260123100537.1429497-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers and reviewers,

This series refactors the DesignWare platform I2C driver to simplify
reset control management and improve error handling:

Patch 1 replaces the manual reset control acquisition and deassertion
with devm_reset_control_get_optional_exclusive_deasserted(), which
combines both operations in a single call and leverages automatic
resource management.

Patch 2 follows up by refactoring the probe error handling to eliminate
goto statements in favor of direct returns with dev_err_probe(), resulting
in cleaner and more linear control flow.

Both patches maintain functional equivalence while improving code
readability and maintainability.

Regards,
artem

Artem Shimko (2):
  i2c: designware-platdrv: simplify reset control
  i2c: designware-platdrv: refactor error handling and simplify cleanup

 drivers/i2c/busses/i2c-designware-platdrv.c | 41 +++++++--------------
 1 file changed, 13 insertions(+), 28 deletions(-)

-- 
2.43.0

