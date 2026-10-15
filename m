Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC804A7C8B
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051900; cv=none; b=hIp0kH74aOf0ytQPW5h1rp6TJiLPRPFEALHJyLyu2O+Zez+/pnJX8I1bq7P7WHiI8OlJccvwlZPui3PxVBsr6l8qSY+XVBJfqWBB6Mw4sljv8T0RZiyFYA0PK6mKUIe4Q7cwIChSo3denCHqArLkV08hIW9Uy0ZHNBo+ROUf2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051900; c=relaxed/simple;
	bh=2r3UVH+gyPAGLc1KXm+ystOLHCuv31r4fdl346qvDdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YI/668/KldvyMCjhyiDY4e3SYcxDGYw4BPiV47SKDAgOyiOjmM66ihs4dyU4OyCteFn+oFKXYQxqaTeWFeDA+7ERSE7wtTBSmjqF3Z6TGn0JsYuvnqb1QzDyaARLPWEqIMqZGucKaAHg953oRnDkgignWAT4hFzQ1SI6q2o+g78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hydLT4e3; arc=none smtp.client-ip=74.125.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hydLT4e3"
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c31d6a89460so111437966b.0
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792051897; x=1792656697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJuw0HG6b0/g50rFnImD3mqXWKPn47lEKfqXU/zgoNc=;
        b=hydLT4e3jIk9K5ebHmQFcBnmPtkptiadJmX5UPwOQ3/iar+5t6lhwuJVEtEeyoHCew
         tpK+a6WpQZSo3/hvxgpyFed1mAUxItUOa78+9ROM7XGxs6jTwq05HIqQNC/ryp1TnELE
         1OjyNMDWdmrgHLa3XkPoW40ZGt8AOdpxfHKFc5g2Qq1dDxziuy0L/sh/r1lTMuSntuVU
         n4Tl3A4br3ik8zGRRVuwJ9HfoPPeGdC8YVmXVsxng6agyGvfjCtXe6Is/aDdA2UtVbUu
         MaXgMdAC7+nemxUIv5jhG+FwdnHctVxSyHoyZOIiP1oH6Mtn1UMXvNUF0gSCAlSBgFrU
         29Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792051897; x=1792656697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJuw0HG6b0/g50rFnImD3mqXWKPn47lEKfqXU/zgoNc=;
        b=fD6tcaMdHQJ2WfoZ5IuHOPjbjOefB8zLmoK6s8hvkAMsHiT3UwiNWGZl3FZXnnZz6V
         KAqw/jrQnJYR4Ii028+DmIitwD49x5wXoiDG4GvwcmSEAIRCaeM6seBl5OuKNQQVT4m/
         k3P39KciRKIZOzz81omTu5D5nXljRjOLRbLcmdGT6ZH5n+hH8C3TlmXl3Z9IutjPB8y3
         kdYPbO5ShO/2f5nSBjntgH3WgKUo2PB/0Yr7KJASxP/uzQCjDdkGVmHDqlu/F+y+mBqA
         ar6RJls+4i+ETP1ozxQz6ylQJZrK6SwMgQPro6POJdUTaEjN8KnPI73j1gslEoE5Fy3+
         IGaw==
X-Forwarded-Encrypted: i=1; AKwUvBzpE1DIoBytFMI9NTuua1bOo+xfO+MROeyWRWTZWZ/Uvx9+wFr1of2ZscwlSTKmUZYHpNVKPBWPDRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcXyNzLsXrQC05groekrKQQHACe7LrXXTGFdW+jDzbagJZn/O4
	A+HJUx4w1B5am3DurZYj+PTXBNyaHNcUZ7I3qdoMR7TO9efADaj9o4hZ
X-Gm-Gg: AYBFou34h0TZI9vqPufZXQfkB9+1DwFulCCkgACQW8j0PSnP1hpuXGZaFthTqbtsPc7
	RHLGdpyFSgvkVLJm7cwow6JgaMWz3ZCMKYgWoVbxn0tuxu7L7/noXy3HCXXIzOEeKQMa8hF0D13
	1Vj5fYzAhRt2gteXZwFBCtOVgzQs7P27AAQAL3/dvyq5PGRJ9qOWqBG5sgnBBCKiRl3RF6fQwy5
	FlqUjXVx4qrq1IoQOMzEt9SwLb+E3V+0d2kTrwuXNDrFfI5lm08fcr6M5I68/4F6s+vqL1pf5QH
	lQW0AzDb+nvPde78c1WtVjkJoEm349jd3j65LFtO5Egh6SIzlSSrcgDovWGnF9ZatkeBqeyFuPs
	WMSH6hsDoTK3qDcNLCseuGpKMSUQ93SwLAagV/IAJDcfbjJZNzwh/gFCJfCznSoLKIndztFutOX
	p3WcfV84oHUANWX56GznVvnaHTxvy8JyVoEadYjWVBYJ5BYYMxTJUBBmfB5Ro3Gljkf1T1ICv1j
	VMOJ5aEhN6EDjig1aH9rJor6HWeXMuQ29ek7Nyxmey9NUB18GnjEeVoZnb7HUP0fkJOH6u8lVTT
	e1ZtLSGBcZUjdjAd2jmu6BL58g==
X-Received: by 2002:a17:907:3f87:b0:c2e:2e1b:30e3 with SMTP id a640c23a62f3a-c31aa00e12fmr1974043666b.21.1792051896835;
        Thu, 15 Oct 2026 01:11:36 -0700 (PDT)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda5297b0sm96080666b.63.2026.10.15.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:11:36 -0700 (PDT)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v2 0/1] i2c: i2c-xiic: fix clearing of bnb irq
Date: Thu, 15 Oct 2026 10:11:26 +0200
Message-ID: <20261015081127.1566244-1-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all,

This patch fixes the clearing routine for the bus not busy (bnb) irq.
The bnb is used to indicate that the current transfer is done.
A high level view of the software flow for tx:

* init i2c controller
* prepare all registers ( fill fifo, enable irqs, ... )
* start i2c txfer
* clear and enable bnb
* wait for completion
* ( serve interrupts )
* ( bnb interrupt ): complete completion

The datasheet ( pg090-axi-iic, Interrupt-Status-Register ISR)
states that the bnb bit can only be cleared if
the bus busy bit in the status register is set.
So the iic controller must have recognized that their is some activity
on the bus. ( Start condition )

Currently the bnb bit is cleared without checking or waiting for this
condition. This can lead to spurious bnb interrupts.

I am kind of unsure which branch to use for handing in my patch, 
this one is based i2c/i2c-fixes. 

Kind regards, 

Thilo Zirnstein
---

Changes in v2: 
- Unintentional changes removed .

Thilo Zirnstein (1):
  i2c: i2c-xiic: fix clearing of bnb irq

 drivers/i2c/busses/i2c-xiic.c | 42 +++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

-- 
2.43.0

