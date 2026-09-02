Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1733EA979
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384315; cv=none; b=oqB2aeHS6u66XT3UOTDzJqDv2oQjdzSefMZssHwC6d8MOXHoqDw4faHYSJ4of1a9a/5n/DEN2LtSEhXiK0ESSN73HaDKYLaeIeOrfnS+opFdgHlh345w3pNEXiT+0xQrBw/wqmg+D3vp69LbIIfyGcsgNTRFbbKaGvjs3hbCvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384315; c=relaxed/simple;
	bh=t7gejd7pyTIJ2I7S4voK9PUjbWOEyRbCiGgVq4K0UpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=de0Ken49hDuvEAJV4SsL+17CgpjlWumkkPHxG1mgCFWguVrDQ/gEEtk4EJ/D4ti0+rOJDfvPx9GRmKoRsdi4JyltLyi8WTtDYQ6eQ/Xn0xk3SUpTIPXXWRAfet/Qm/DHiynNnDAllDD8WfEISzHgcFdoQlBHWCjrKWWuDQdnAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWt99sef; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWt99sef"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1899038a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788384304; x=1788989104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v79KdHEjlvBLg7mwEWFWAGAPOJe9EFP/OK1uhnL10sw=;
        b=OWt99sefuErqJBN/8NdmxiZyZXwzf2B8MxeKNWLAk6q0LjFV7itcUKcS82kYsBNstq
         pbWk+PgWN3xMVh+5jz3g8vfL1nCxZoBBRL/1TX7KduFHVRKAidejWVVf/nFo7jq3KgKQ
         Zs6z/9HdFYIl6x4HOx6KNh5xR0l1ssmA/mSpKEMMbFr6TT8nCpDdZ6M8GuPa9nWnQaBd
         cqY8pPqK0WU4UUpXRrLKO96VzCSK1ofVcTiyQg77EmiuHVZ26nwMDieYCJfIIVGfEZ+1
         JypPGm/LvslT1GjNR5wThW7kH0jYzNJNT4CYfW41zef0u+7a2C90MSGNn6D1wBLhjowp
         lCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384304; x=1788989104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v79KdHEjlvBLg7mwEWFWAGAPOJe9EFP/OK1uhnL10sw=;
        b=GyN8i/XTFagWzAmWQUO+84Eemk3TOU1rzXg5iFLidWgBJO0g0BejvYcgE2HFye1v44
         uLdnfh/syhXcz89NqKEV9oGpmzw8wl8vXS5/N7w4y5R/iHvS4XS2GLFWltIlG4rjOYmR
         j0bDHz7xmDvdZMR8EYT3Zm3N9DycgYyD+Mmk+yjhNvTNeEHmfPR7eKKLNjlYflf3+4hp
         d1+IJnTgBuV4oLnzOtjagsJs1qPX1Tg4/NpA6BkwBDuMxzIKL537+5/lWzGM6Uz3vIit
         g8b27U0LPH6pAsrpDpYwZsiEaCEKZADNE92BZl97Ey+lo2ud6343CTMVhBolN8rCHBv7
         u1DQ==
X-Gm-Message-State: AFuF++nJcLU5xssmxl+NPmXNJkwhzo09mufuTuKjEKE6lqGFxKqgwn17
	A4ULey6zlxyTIPX3Gf18RjvUZ4ElttGM2rbOda8A9ffxipZvkD4DmptU0PDsVw==
X-Gm-Gg: AYBFou3UmE9Ujttd/Tlpck8l95HKEtUYiAC0p5gghtyQOkLqXEmYEz49pDzAJvq6e52
	IkDhkrMzWQusQe3fiiMcLCDFZo/eqXQOkI30kiB1/klmfqV8ZeDmFzT9iOyvbEkikqB7QIuYCWn
	ahS3L6x02xTrPxHelOtHtWe/A3jXJy6iRepQMTfkulT7qiJ7fLYzIt36daRZrJqqDNQemQxQIwV
	eISLAWgDIUBriVSyIQbv/k8zz7XRM7o1Ls2CHAaxpVzj4aBuogM+NgI9QM4CwKcRao2/p4HP6Pp
	vjyGCHthYthM45dgrAHsQZIt+qkrUPfx3cHo/WwrgLwMtFHKqaCwjVzI2sMIz0jZ/tJopBg9VmG
	Gn2kSr70as6Go8UxUrkK2Z0kCv18fQYsszM3c9nV4VDtqon16L6ZGGWNYORe9Z27K5WgoULAoFR
	wZAhsEOzdR/pe7nMJr07l3DCgQo+zzgNpDtd7/md+yERpLkROPYIu+WQvR65HLAkgB5UeV7H+5Y
	YjveMXieHbYU9HeuMdG5ObfjOawD4FcF5OPdjs1cWiBMFNZRbn3ZT5g/qd2WzfB2BYsxbleweiF
	UnZMgTqEyf/A1P1KGO+SqHfuN4fpuUc/CPGRww==
X-Received: by 2002:a05:6a21:70c5:b0:3cc:ec12:a788 with SMTP id adf61e73a8af0-3d9acb3e96emr13064690637.4.1788384303970;
        Wed, 02 Sep 2026 14:25:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d40c55fsm90890a12.19.2026.09.02.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:25:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 3/3] i2c: ibm_iic: use devm for main allocation
Date: Wed,  2 Sep 2026 14:24:56 -0700
Message-ID: <20260902212456.289608-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902212456.289608-1-rosenp@gmail.com>
References: <20260902212456.289608-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of kfree in failure and remove paths.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 8af666442952..d577bf47fa56 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -693,7 +693,7 @@ static int iic_probe(struct platform_device *ofdev)
 			dev_warn(&ofdev->dev, "using polling mode\n");
 	}
 
-	dev = kzalloc_obj(*dev);
+	dev = devm_kzalloc(&ofdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
@@ -755,7 +755,6 @@ static int iic_probe(struct platform_device *ofdev)
 		free_irq(dev->irq, dev);
 	}
 
-	kfree(dev);
 	return ret;
 }
 
@@ -772,8 +771,6 @@ static void iic_remove(struct platform_device *ofdev)
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
 	}
-
-	kfree(dev);
 }
 
 static const struct of_device_id ibm_iic_match[] = {
-- 
2.55.0

