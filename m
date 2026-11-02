Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611965;
	b=ZYUABf5lClYF0nspTSoKpNKnRjMmLbKm6hdYyWX05Ym0/EgETdF8qqbgr9240uPf84Hd
	 86DzDhHURsyACv/DL9zSpvZDO1yaFZFwdlAirg8NKnk+Q9xOya96XyqiPv85FIxl6ZOQj
	 j2MhGLiTO9khDz53Lk2TO121qNE48xZk2DW2CzprsDLdVx/BXeucIvjyhOEW1qzh+x5jq
	 PQ5h/GN+305BdfemmCOTIXWDyKwvCmagtn6huQ1z8p1SHrRk8dYhZrx8aVGFhSUJKj60e
	 CozPBYDL2WeVaTgVY9XOsL4pEzpZtRBti5BHc3r3nJQJanCNJIMzcra9d529m3MFJFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xFCr7dXRwZlmmMVL8y3jBXLGA8axSy+kDHY18LbXjXQ=;
	b=IToMoIM1RkRskKe1pn1bb4yEQ+CGa4u18n7IDiO1ZI5jQCQNmNBsebPAHO0vZ7KagA3t
	 AfhzfgRdgWD46H2SPKw6nKdQivqW5HU6fzG6S9zTD0Xh6uih3KifnVG4HNQ58aED+IkoB
	 gqhwddBOrdwFfHvTyvPgZXoEkZYUU3kxyNdrKEbs1DnDfsb92bW7yirHqemAXjRt1+x8e
	 RorjaIn1HM1XpzUpky/sQ+/1iog3cjGTVjVgE7bznCE7TWWwS2kxlLhsR/2lNwDK+HQI+
	 xpXS/v4T0QJrx31mkjwrga9isSbP8C7FQUGuQhNZIDSOi+uH6o4h/f3WPwjMGoDRhmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpY7iYcj;
	arc=none smtp.remote-ip=209.85.208.68
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347FB606A324
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 09:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347FB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VpY7iYcj
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso6794829a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793611964; x=1794216764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFCr7dXRwZlmmMVL8y3jBXLGA8axSy+kDHY18LbXjXQ=;
        b=VpY7iYcjUrBWCdENfOZeW2hM2MEUHu8ClikKdaH8ZbCV8gzKdAZO+YzEiuEtJXq9hR
         MUVFi53u4QOBEmQtWukqMS/LIWPko6fXl1Wlu3JWUgOwkkcbmyj9rtrIS4BnogPVursl
         44acph208sl2K9/UdsfI6VDo4Aq83AzQhJzKBNOtRnJP+Y5ghw8WmrXV3JTtZ29WDJk6
         2U/Mxa9xLC516jgZ9nAzKpr/pVDXHsj4owBPtL1cIpK7GqPGe0HWKHZKBCqR6m5GRf6M
         0gJW1fo97SBSIgWW0/e3CNRsMODLWABmy63MxVIiJ1UHE4iTQbKitwuN7J3JXIZtjg1s
         hbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793611964; x=1794216764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFCr7dXRwZlmmMVL8y3jBXLGA8axSy+kDHY18LbXjXQ=;
        b=FjJahTmoBoXw2EKLL5tsSTmV0SVZfdzEm/Mt6yrmIlelZZvZ531wIVhYbyhSCRB6nJ
         GIglbpWyC8DHlcGNJY6zTk9LVxbJcTeLcYP15jGH9HGkylLIZP31yH7E2b733j3oXMYY
         Cq4B7Q8EahlsJ2buY0rv9+rJH0DJ1AoVJs9ab0L1p1yWFdaJKnLsFFPmjW7t9Gc0ZRy1
         Vshy0TLTdqo813rRGPQJjGds1eqKMlWg1bQPyGzQuFTNWXWOpxPhZ0L8y/O6ShEBUPig
         bvJNtm6CJUHdhmN2bdaz9vOTorPGSqwGf2hqlkUJ5KCuuq8RwpmIyVhNlq9/gASnl+r/
         pujA==
X-Forwarded-Encrypted: i=1; AKwUvBwOVIgPgOj/eDYtrp0Z1d7Dd0PwUEPu0NLSTMrODL0BXr097rxcnp96KCSv7IQFgBFNSC3U7P/ReCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z933IZItpmFJj6SDPJ0GigTPiJyvKHSGWpqkn6dPn8limFoMedC
	mGIvEB/F+UeLx3MSAUrU/JDBe6e4fDDI2hdnSaZjDaRkZ/DiGor9+ikZyAoBdGNp
X-Gm-Gg: AYBFou0Hur98GNDYqvq6Ky6lSB7LhIHtdGHU6jNbYtTA6cr6Zjz/u7gW6aUvy6T3eD3
	MTpzDC0jx3NtWJ7ISF6WrzAj9ZbeeE3LuCtO1LFkEhByhQDkkjCpwM/44MEcWpikJtNuYk2eV+O
	fBg/Jsr4rGtAeTIPgw/Qxj8aLzlXS1J1uWWQLaI55U0Blh6xuY4vTn2eEy4DSw+Dg9y9U14WmV9
	e4lagTHMnV3pFEVG7i0tmW7ZWRABPodOXIdQbfn/8xnMmtw6A5ifK4Y6j8speqWJo3ImSwUGsml
	bAuF/ItWt12e7rWzWUyRfaBtHwIJiYBOlHaDzytCRBc6XIZaYdOFq+IWceDUvilE7kYJ7NFrY80
	AFANiaxidZx6oi1tswbgYYXyyooJeTL0I9NkGMQ6WJmLzU/ZS8Vra2vpX/IKbwO6F8+1IMjIlU+
	CvYfjwgo4oLzpEjLqdwqybPRfOvykXXogZXYGZU4cxvwMjA9AFxQxmzAIa33JKfaCIl/CcZhLDX
	te4Eqv/cXIRyxc3xp/MUaat6MWGTuND3qf//U52q+HsMasRx530gS5sr6edf+dBfoedtWX1GrS6
	qaMwZyIxtblwPH/KbhZ1sH2apty8Cvcjj8lK9nNQ0smQu5m634g8a9NSKAETwODnFBtErPAytuf
	RD3FgU5bG9WCKy0wo67FAkvcb7bq3+p61Ijn3YOyq6ydNkfSC6ZcPz7zq
X-Received: by 2002:a05:6402:15d2:b0:6a9:8863:ada4 with SMTP id 4fb4d7f45d1cf-6b4b0b8288dmr6687683a12.3.1793611963451;
        Mon, 02 Nov 2026 01:32:43 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca0f2a0sm3214273a12.25.2026.11.02.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:32:40 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v4 0/2] i2c: i2c-xiic: fix clearing of bnb irq and waiting/ clearing while atomic
Date: Mon,  2 Nov 2026 10:32:26 +0100
Message-ID: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
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

Kind regards,

Thilo Zirnstein
---
Changes in v4
- Fix timeout argument of polling in atomic context

Changes in v3
- Use atomic-save functions for waiting and clearing.
- Fix intendation
- Unintentional changes removed

Changes in v2:
- Unintentional changes removed.
---

Thilo Zirnstein (2):
  i2c: i2c-xiic: fix clearing of bnb irq
  i2c: i2c-xiic: fix waiting/clearing while atomic

 drivers/i2c/busses/i2c-xiic.c | 70 ++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 13 deletions(-)

--
2.43.0

