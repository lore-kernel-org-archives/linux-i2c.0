Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664C382379
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018921; cv=none; b=bCHpSkKjhs05tU4dHDJ/dASH8cvfoBP1wKtnI4cd5oWqkTfVJt8YjzwMnG93x2S1CtCr7Z2+VfIS71QfBb85HhW+CQQUkj3m+fh/fIKcH8t0L+jKT7cpKsgMSsEnTNBt/Rbi+qz03r4fuuC7NdUEVZHcBuFpmGM0SUwSx/BMJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018921; c=relaxed/simple;
	bh=M3LaB/n2bRWU2FBZC6RO8rehNEGvKfQDDHq3Q0zanrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0RANwCcMCM2jPs7kg/Yu2PLn+Pfn8NnZhbET2thj6gI3+VBe5DenlTb4HUIw/GtoMCO8HgH5kjdElkDcxy9ODivFUhA5yvERDBNnkcliYqVZKL2/dkQfWE/AJbYl3XIM/sb5V6IBjeQQ3fGerJSZE+vtWxAk40TTZdv3sdkFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywrg7mjH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywrg7mjH"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfd44fa075so12012185a.0
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018919; x=1774623719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlG6o3IymovaUMvTR7MBl3xO/ZinUQDi/0H4OCVq+j4=;
        b=Ywrg7mjHsfosy5iXRkDwnfsbT5IcMiN1+uTi716N0zxPAU2VBiXlQmS7P00frBfMvT
         iyMN+sYN9cc+mIuqN8qAPnvZgY1WjGaIcxGn683M3R+IgeFKUN4jqB7tWdS735n60haA
         K9fri0RUvyNlk4nLk7DRk81Hef39siMNC2vidDsbHGyKCnFZx1nrxSp581weyw1exr21
         YzCPjGm5jIN6DxtzyUMY5t+FG/APNPy78ucvOrpyapYnIymnfJT7SznK0fZvLCtqjKtO
         W/PttNwiOZlLfuPbQikS238y7UIdlH0S2RMhsqFucHUSTmXvmgol0lgX8WrrJ5j10ynl
         AmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018919; x=1774623719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlG6o3IymovaUMvTR7MBl3xO/ZinUQDi/0H4OCVq+j4=;
        b=hQOp5gYfeCWdZ4SvKX5ls18BJRLxPVezDlVA2gKX6jBScfioLV0kmvnT53gHqil5C6
         EW7ENsAQZ/u6EU7X+I+ozz8arcMhOCQj5g5eGDHvBAycl3mVyLmNNL7KkKqttkh1TeFc
         DelmZaVC3hErM0ERPrrUc6rokG0JbYuRfe0KZf65HTHrI7sTN660Zq+/tPSqc/mnNVmX
         jIaAlaPrfLoY7PFhNxwyCv6rDD/GjDtqTnAlvFjb9B0hnjVKNIE55t9gbaPB4AR2cK21
         LGMcQu+6TguesDLb5W34kh6+Dea38piDoeAZiMCRQjM16xYpy4JeE5B7ur58cMwJSBo8
         8yrA==
X-Forwarded-Encrypted: i=1; AJvYcCWiQYT2/JxsKpKvb682yCNPupBydLCQ6IU67wy+VfUpSuJ1hQ747s6VWF+ozieAMRK061JN1mwcryA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2G4BUByW3co+TdED/uYLBx8LdC3i9//JaqHljvF4Fn2U/Ak3
	27HHJ1adc1zE6kpFOy7Yj93OU4IxG8g7NCkP+XwM5foqoIBG1UrBAL//f6/ae2KF9UE=
X-Gm-Gg: ATEYQzzdl/pXeWXIUcVMKeYVfPLexllFaL70FU58IRIkr2ypzUjVQfnI9puQg61niqc
	XnwLFJotTZddbRqjQ/7CvDlckvAFUP4xUkTrvk+i0RZNvL7OayO7eaDUlMnWrAKkyIdYOHBqNiA
	mECaVzw1B9eonbP1KT4fh2N9l1XZGJB21XwkGAHeeL/1ALA1TFzHjpxkVlwa3SADQGZy49PfOLV
	shXb9i5wicl2QlJFKKIe25y6c0B2O578ag+KmHUl7NTckzKgliK6mvqOPO5p+Ur3g0GgT8thlzH
	NyIRYNxUN244KIb++ko6RM47eT9a/c4j1UoYkj2MbqOh7zaHt6P4rjxG0BRgLkXhfLPZjjaXvC4
	UwCAxXrCc1GiHlWeMLLxnwFATny35R3rHxbPpZvGN+DgLfsh6PPIw83UwRRhuJI3moaSqC1QxJ6
	RJkd++/FmeSA==
X-Received: by 2002:a05:620a:c45:b0:8cf:c75d:29fa with SMTP id af79cd13be357-8cfc7e6785dmr510633085a.11.1774018918605;
        Fri, 20 Mar 2026 08:01:58 -0700 (PDT)
Received: from jovin ([184.145.97.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9089ca9sm178047085a.24.2026.03.20.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:01:57 -0700 (PDT)
From: Jovin Basil <jovin555@gmail.com>
To: 
Cc: jovin555@gmail.com,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: gpio: replace printk with dev_err in probe
Date: Fri, 20 Mar 2026 11:01:37 -0400
Message-ID: <20260320150144.432345-1-jovin555@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320122656.430939-1-jovin555@gmail.com>
References: <20260320122656.430939-1-jovin555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
    - Restore original log message prefix ("i2c-gpio:")
    - Restore original spacing and colon placement

Signed-off-by: Jovin Basil <jovin555@gmail.com>
---
 drivers/i2c/busses/i2c-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index f4355b17bfbf..724f13cef9fe 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -490,7 +490,7 @@ static int __init i2c_gpio_init(void)
 
 	ret = platform_driver_register(&i2c_gpio_driver);
 	if (ret)
-		printk(KERN_ERR "i2c-gpio: probe failed: %d\n", ret);
+		dev_err(&pdev->dev, "i2c-gpio: probe failed: %d\n",ret);
 
 	return ret;
 }
-- 
2.47.3

