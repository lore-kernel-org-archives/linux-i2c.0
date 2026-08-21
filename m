Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888741DEEB
	for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353340; cv=none; b=uYpYhNCF361i1FsW1PPzwDq1W/BU53vGYsM4U7ZGFpjXp+uypp6Q1qvWt7yi2l8Hjz6w0orkBGItwdnHT4IJToS0+Hg2taGmOcyLD91DO9hnAwkgzeOsyjkap0ti4OhEjF6SpM73gFwDIkbnBQKxmiajkRtRI28rwXzoYsvml9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353340; c=relaxed/simple;
	bh=fp3TlCp1FabIkUZtwArAO2IdqLKJamWvVF/B7Mw0CMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EL285qbikeQs/QkZG2ctJQx2HOpydhwLx7Kj8GWfyWkP8dbP5ouNkd8robE0SIPplE+sI9uA8fkN476yLTfLUQCJ9hp4r9SnNqwAVaDnARse2dxBgmgbONYdBy8a6RHX+TkyTTLxCKIa+uPGuFarqx1cVybr3OvSITfj5O9s5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+goMBXx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+goMBXx"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1115690a91.3
        for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787353339; x=1787958139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wex0vi23s42CwpDf+V/HgCg8jkqgcL69PBjyJ8XQK7c=;
        b=i+goMBXxhAuBDIGlhc4ZznJJjtgXLJ5bX/QIbiLfbylkxMfXgXGKfUfLRXvatudCgB
         e/P5T4Vu5jv8/t3eudjz8ev895yUHzhyI/rB3NG3k//zmkDeWtzjZHP49YWSLAFy6Ng8
         hn9KQYO23Kk/UzG7GSANguv75zQ/pmCA7MLDUTg6l+rxTwVRwoJhgZClgzzYqyjVr2B4
         m+ojb0JgvWJuCrwGmvGtKskVpq5vUkVeAPXHCVi3wB8G4bHKJuNPHX5ZzR3IlbtGE23L
         yD7v60k2A8qkqps/YoquGCeUrkpFvsRxow47SSFOX9uDRzLT+jVH2vYh+ROlwhdZQ6+6
         4U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787353339; x=1787958139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wex0vi23s42CwpDf+V/HgCg8jkqgcL69PBjyJ8XQK7c=;
        b=p5noD45hgp9caFOh07SYhbw7ZMjskq05HOzHmjrSyiBFPyAacqF0PAOjTnw5oFyroO
         NCsE3guvH+cA5N75QWAzJJ2Tsxpp4bFMMVba5zEIEuJEVCjrX4f03m8P/YDOS8wYPmMD
         zQDCL0SwgQDJs6iiEGGelj2NqTZ7vXZLf1zUY+UYhNocXBIojprtQWiNdYzEyWyxGIgF
         3iKOYhXXgutuiegtPYQ/82aMK7Uc1n8vEA4uJvzoTUya6n39lhQiKF+Xp4J2J+XFyceJ
         GajHfqYz83n9oFxQ8fcF1NCMwihZeRtIMuzWVex4YW/PFOr/izU/VTvGV+GWPJviNdp6
         y32g==
X-Gm-Message-State: AFuF++k9Dvj79rj1DVcfgvO6X7G/HO5Q8INupywobj/DhSF9hGAxM59f
	F5BnX6iAq/wFEnCULa9CTNxJI+yI+EHk1sI2b9CiUnupDkPKSyg9AlHPUXTHyQ==
X-Gm-Gg: AR+sD12vkobTGz3wsDzYJ3bj2+RVsvcQhdXAx7U3cgBeqHnZH26XwaEMC5BzkmXIgp9
	WO7tjZoTAzMkNZp33NE+OR9Pw3tjk249Z9z/1vtpGDZ81lFUVGP8ikQ+0yKPEEaJncltj7DznOC
	z8nPEyLB7PdZXrUKLtyTpl0WvGsFPEoyroItD2FNo5PJSeJ90nMUHuOjdWE21mNOXm1pR+F34WI
	VL/Lh9PhKwxbJW3M9umWJRKa165e2bLmMAiEoEMq1ZLNEnjAwtzHucL+MNHHqhaz50MhMVcmJSE
	lt1Sz2DeQPkL9lQ5EWy1lY6jRQt0C00RIVccXnyBadRwKGF5BI/UgmHSLyN1KRMUFvScxGttk9M
	TBGls+deih1J9ZuUiWkDr5OodO9VusVw0ZmGPNIyVx6xEgHFQU5Y4GPmE0xl3i9lKro7cQQf5XL
	1hO3cYcN5yN9ut+bEhE5FnGo4/1pZQCu1O4rnVd1a1ee8sgLaG3wjKW0KapIu+GUIvZ58D/UkHo
	2VNWFkohX7Aqmc/KRH9/UeP1+q3EQbYr3R0Pk2Diu5GrF7ZUxuYSszVJZQ3fxwgXnMBs5VbxZc5
	vioFlN1eYiFCw94sbcVJN1ozJQhMaJdPJ/GRPw==
X-Received: by 2002:a17:90b:54d0:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-395c353ee4amr19171855a91.6.1787353339103;
        Fri, 21 Aug 2026 16:02:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49d8b1csm552044a91.11.2026.08.21.16.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:02:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] i2c: ibm_iic: use devm and get irq in probe
Date: Fri, 21 Aug 2026 16:02:13 -0700
Message-ID: <20260821230217.319418-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies probe slightly and handles potential -EPROBE_DEFER a bit better.

Rosen Penev (3):
  i2c: ibm_iic: ioremap with platform pointer
  i2c: ibm_iic: get the irq early in probe
  i2c: ibm_iic: use devm for main allocation

 drivers/i2c/busses/i2c-ibm_iic.c | 44 ++++++++++++--------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

-- 
2.55.0

