Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBB246784
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155161; cv=none; b=cNjOcsC4TATHDQ9un4QI2Wh5TPSTpcgOZo1VWRj/mEXwECsgJHJHpa6O2JmwmwHio+qSthkjFo6acBjHDCapNVLL1Tv6dCJcOZrNcVsjUNDJvx4OB6Ji9hr2JwbeJLHM747jgCi4zQGwUKcBL53WAS0YQOHPKPgfi4uq1BQ94qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155161; c=relaxed/simple;
	bh=liozZw3edUG90dfqSRetHlnAXnjby7qz60x6l6yH+zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBvB8fi9/C6fC2VUyCkDEHktuS9DbomV556SbBq/QWwSJYUmh1Q78pu2THVvtBVGdxkLxxqlUDaMQcnarX7ClgOtHDUsc0CsRVMnqMsJzldbINmAWJ06UxVMajf/Rq3lfCUFzzurDMJRG0BhRf1yydav8I/9s0D4aoiIGJhkijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFcURtjh; arc=none smtp.client-ip=74.125.228.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFcURtjh"
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c410cdcab7dso22956866b.0
        for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792155159; x=1792759959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bLZq1EO3Hw3snWP7J++9hibpM77l9B4DBDoATQxFi0=;
        b=GFcURtjhm6qPAJYlWeAx2+t186sObC9+6M6TIo4AUtWND5aXbAimxv3/Pt4ZSV2y6i
         Qg51/ZYpt4k12Ce8rs4rYnFL+bQPz/DHZWJ4Tu9sp8lQ4wl8aWqs+UOHUVSPLccwKRU+
         9kH2wFUcHH3s9uRQUAQG56dbk7BW4t9wDIXL+jsJ2c0ZuTO8oxZNzOlbero7XXYxEgNd
         EeW9t0N5JrE0ptvb5fStBJbcilJyx7NpIxS06J2O6/7hN52gb8WZVH3jp9GLLfOOPF7K
         p0ZD1cQ3rrvkJjwMNnhLRzAhabyYporGw1ywhim6mzbc9K30l+8krU0cGbrr3dqF4yCe
         A8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155159; x=1792759959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bLZq1EO3Hw3snWP7J++9hibpM77l9B4DBDoATQxFi0=;
        b=wg5IqQ332+asy7dLVfg2ZeTBdNhaYijgIELHY+pjXhCNH6NfCrD/dZtl6BWdP5qcV/
         3GNKrK5kBP2QWNUU4w22pkUQ95oNmt8Vg2Uh/qdm1nA8+nq2wE4Rp3JmWYo0gDGm8V8J
         q5VJmQ1AvgTdTbwUiQNTcgFQDSEBmi2fqXin8XkCWk7rGhLeT1Z6cSnc3d8R7ewY9QL3
         xa0iUNib8EST9ywwjy2ghbZAuQnDxvh8n2JxxEnh4Gog7QwF2hBrwQdrSusB1W7zzsSO
         wCHe7DLltI6/CgAlNCh6MHZuzfSzKno/uTI5RRwGKrN/oion6FB70XyWCsHFpcbO+Y10
         W3EA==
X-Forwarded-Encrypted: i=1; AKwUvBzRQpuj64JLX0Dvgcv8XWeG2yyEcfljQ/BFqBP1oyM8axv/Owdb6uQ05PrGqGwhKkANEBM+6rOLeE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYDFEY3KA9kEtza5tHOZpN+VxnDIdlmTL9OSODQ9jkMfhH5rCf
	nd3XTIRB6WNkpq9A2+sfadsnjD/w2qtNhSz5ybpYrmcVqrT0mxQ8OEKR
X-Gm-Gg: AYBFou0AX6YdAiiZ5Z3H98yVKSlJrxvJDfLdvf4fPU7IN0aWMYeUxv0YZY2YYeVf9m2
	G4wmu6ZnO0/e0oPon0KCMfrD1LPuIwCmW+NaNX1sR7EVBKYLNIbEJ8O54EuVZXE7REsZ15tIk7V
	Z7ew0IXqjCUGdlI1hOv841V7mrmIGlwNZRGfcvHvutzXcWDhfUSeO8t5Roclr4uYjRQHXpznhY9
	r1bEvZty8pT3vsMCu3RCeq+og+dQbfA5zZuSahFa4mWHbJXszrWXQUNRAPwStEcvdkojga7pQ3N
	oQX/SnN5fH8NSnuH6tjVVsm4Cjh4DWG81x2XZT4JJsqw0YjUUjxm8HO7jZoLq0xq1mtARSVpz1U
	VTmyqYyGE6ZWFyH6o716k+8L0mdoSPLmCudxIFKf2bgq2qOx7hqucPX8pVakwd+85U2+gb9xWcx
	1qicK5qTOOXn1Yh8t2vGgbV+6bxRHDR9p70NGFG1KFJGexE1UyHB95GGDt2q5tLr5cAzgQg7IDt
	/mtKFE9bwCuE2qil66NyXJNfLfuIdcMYEFSw97+gj5lBsuZnwesUY69DnjvZPtOKSM3ZouhsF+a
	7ooSXe1vY700ntbsRaGQweJLAQ==
X-Received: by 2002:a17:906:4fce:b0:c3f:ce1b:9971 with SMTP id a640c23a62f3a-c3fce1ba820mr366288966b.25.1792155158395;
        Fri, 16 Oct 2026 05:52:38 -0700 (PDT)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32876asm69433966b.10.2026.10.16.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:52:37 -0700 (PDT)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v3 0/2] i2c: i2c-xiic: fix clearing of bnb irq and waiting/ clearing while atomic
Date: Fri, 16 Oct 2026 14:52:27 +0200
Message-ID: <20261016125229.1798791-1-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all,

This patch-series fixes the clearing routine for the bus not busy (bnb) irq
plus the waiting and clearing routines while in atomic context.

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

Andi suggested to use an atomic-save function to wait for bnb.
This was applied for other waiting/ clearing functions, too.

One question left:

Are the timeouts fine, while in an atomic context ?
One second seems to be rather high.

Kind regards,

Thilo Zirnstein
---

Changes in v3
- Use atomic-save functions for waiting and clearing.
- Fix intendation
- Unintentional changes removed

Changes in v2:
- Unintentional changes removed.

Thilo Zirnstein (2):
  i2c: i2c-xiic: fix clearing of bnb irq
  i2c: i2c-xiic: fix waiting/clearing while atomic

 drivers/i2c/busses/i2c-xiic.c | 68 ++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 13 deletions(-)

--
2.43.0

