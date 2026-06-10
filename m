Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276793FBB69
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091752; cv=none; b=oX3e8p9o42YMUp2b1zZOAeONt54yxQp8sifyACtrj2BpWHgIwFUk9xlMumBb7AC/PJywAAAKFOCEx9ABTANDBzzel1+6Ya+0L0pSOadLyCDIMRcm6FRrg6Q0GSTRLBav0a5kqhS9R5a4zgjeXLwXFIUz6HPcy0Us/16Rxc2Fh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091752; c=relaxed/simple;
	bh=5Qc7Il712MhxrkYi0Tl+MzQTuW6unt1kU8P1mDmdWlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DcZzCVTnfIRRpIZozXsRB8N0717HNYtoF9/6VzZDX3+H1d5h/bdR88/2LMbILCwJcoiq4ksH6/CWHcXHouzUfvB5mm46Rhkrex8yujjgra68jYc5zX1XMCAhTMmp11Iphr4g3lFl8DF4ZhB1uRvqea9uhD4WE0Rbnw3vtgtKDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=WECyEttB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="WECyEttB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842848fd613so5579511b3a.3
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 04:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1781091747; x=1781696547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UAnctOXPEBU/LTDpVali6QmzFmGx9yLLNsl/67rlxMk=;
        b=WECyEttBzuE1Y4sIMw2iKqiykPRRuiN4iJRCWlhjlhx8x7mA3tQeoG/akIHxg7+OWM
         Vv4hBm3MF9pmxhQFc96Y9M2IIdC8pPqqS0Dv/CN4ePTC/tFRb7/EGaea9tEfJ5vyNqBI
         D2dXXYdcXeDXWqpu8/u7iGNOIaX6pUBs1ozRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091747; x=1781696547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAnctOXPEBU/LTDpVali6QmzFmGx9yLLNsl/67rlxMk=;
        b=QDvv/O9HTldv7YiB6hEwp8ryvhZjxJsQyj/EEARzFDThavoOQxGnqZkcvDnxv9kcgw
         B+smb4gvzFs09TmTKcVuxoYnnHZsFowvdVHKL7aJxDPEsm4ZSNbn+yl85H6tR/dq9A78
         pwB0nruEdPgsTvycK7t8YoEvObkmUHMYwOWGIDj0itcuscNyPRRk/mpjz7scLA1BnYE6
         Fu3YxFMniZjPG8EJ0d8YB9WwX+r+FdKFPZvKS/R2rJnr5DB/diYwR4W5t7TGlrgaJzM4
         3EqXMfEuWVQR4xITwZP1Qwv6nvoC1HCiXeSEI7Pdt6qOZo7RZhYMbLpFgaxdk/5knODz
         DKmw==
X-Forwarded-Encrypted: i=1; AFNElJ9mZtu6i3MDyV3QLi+pR1h78h4AVwY414UdAaXzbkCipfaDKnUXTyVzWmS3gQP9cTD3a58XhY4eFr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3wiJdxbd0QGa80IPKJpQDDEZxHlw8WMuM1sHQrh7gil79glz
	djz2oiE0ECi8rm/u3/QU7m/FpxDHwdbMos7kmd5bIHo3y4zKfFp13YSOvIc84+GGWiCKAh80fme
	vltr+Zys=
X-Gm-Gg: Acq92OGAYHeRnffNGRzOuG0aEp1ATVeDqCPhsi8kI845tnsdxEgLFqwWRHbWmG2zn/g
	HXMN3dhJik8NmWwt8ioPDBA2EeBGr+SZTNCGI1ugOdEfM+Mwrl9FmT6Ovp3h/2qDV2RHRjPutSX
	iyFg6mrby80JOtGGDY/6dM3KhdU2dFGEat0iV0WzZ3Gy07xw/P6zNA8XTytVYYUeA8PysDzJOBF
	tiQ7sw66o2jWqQBQ8DIldejV0wJ2niXaFGqVWuPbA28BGs51tPUG1OUkR28xvzM+YexMPU7JAMk
	HiyAUF0ul3Hai7qd47OQWeSiWvzouEx9g31wahqAnJLpKcjy/VLvPZIRJGBeGDM3CZram6dYNAm
	ADf0i15RBBcYXxEeGJ2BlNmEAosC8xSmPdv5A36m4fwhQHof3Vo5qgTncRvMCdUX+oJ4lVzu+hI
	SmyhFfKpxKXHZGAqDuspbRb/OXZiwDJnlM3x39YZB3rddCdgHbrRzsykn8tZDiKddAO70=
X-Received: by 2002:a05:6a00:9a3:b0:842:4f20:5402 with SMTP id d2e1a72fcca58-8430a70bb0amr8218165b3a.21.1781091747363;
        Wed, 10 Jun 2026 04:42:27 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm25637789b3a.15.2026.06.10.04.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:42:26 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: i2c: img-scb: BUG: spinlock bad magic in img_i2c_isr() on early IRQ
Date: Wed, 10 Jun 2026 20:42:21 +0900
Message-Id: <20260610114221.724966-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

img_i2c_probe() in drivers/i2c/busses/i2c-img-scb.c registers the
interrupt handler with devm_request_irq() before it initializes
i2c->lock with spin_lock_init(). If an interrupt arrives before
spin_lock_init() runs, the handler acquires an uninitialized spinlock,
which triggers a kernel warning.

The probe path, in img_i2c_probe():

    i2c = devm_kzalloc(&pdev->dev, ...); /* i2c->lock zeroed */
    ...
    ret = devm_request_irq(&pdev->dev, irq, img_i2c_isr, 0,
                           pdev->name, i2c);                  /* register handler */
    ...
    spin_lock_init(&i2c->lock);                               /* initialize lock */

The interrupt handler, img_i2c_isr(), takes the spinlock.

If the device raises an interrupt before spin_lock_init() runs, the
handler acquires i2c->lock while it is still uninitialized, which
triggers "BUG: spinlock bad magic" when CONFIG_DEBUG_SPINLOCK is
enabled.

Suggested fix: move spin_lock_init(&i2c->lock) above devm_request_irq(),
so the lock is valid before the handler can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Thanks,
Jaeyoung Chung
