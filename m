Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424069;
	b=G7gt0R+I8dzgNm4IhQTrgZDJ7O7zBXaSx/luO+by77wuEN/eL2SwQLWo2VQtgemsRBP1
	 sJJD4j0tOrasOkp7606vbCNttBchNYoc5AsoIecYXnJ0eWg7wQsImFL+B0cOBXFaoNp2P
	 Fj2h9h6jdj419Ao2ypUTPlyQH/3mlEWenIAuA/Kr8cnTE+wLGb8uyEhD+sbEC/nptUkoC
	 pfAzdpcBCkVmLnLciku0aHUWe/NW6DnUs0QBHD5gbAIRjadWeH71UA/MGlE/HBjAuGxo7
	 tYzcXjq7oxktSgCF7Pzfy2CtQbzPbiwcaOG3oMtCY76Z6ovbTG3Bz6zp0jrL438qC0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vnRwo/ZsMPpWSsncariS2yc/xAKn3Nxe+Kux6J8DtAg=;
	b=rl6vRtS4RGU1ZGutNimQUvoUc4iUHpqtagy6aEkAWWXANcnNq2mdLcv3K8+HLQ8NlS6Y
	 URu5CPkIJP+lPv809txJcEi7FlhbbPbYfng0NDlkRqWzqhxt8rDkcnGq+MC3pZaa7bqcz
	 jws6rLavslFasbwy+0cmkBDjO0htgLSOJqa6YYpPuSgmFdMzPo+wxUZOEG262l+mOJQuV
	 wEAiocdGEsduUsicAeDVUhd7j4dPS3XLJL/HphuuupRsNhCjbE3vWI7id696rqOfR9Upx
	 fSkGmNDa/ze+QL0qRXPwHymUgtmXfYjokObjTmbVo6OlYxgelaqcXQcDND8Ac2CL76Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkd5DuMj;
	arc=none smtp.remote-ip=74.125.228.134
Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B8606A31E
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 08:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A5B8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkd5DuMj
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c410cdcab7dso90306566b.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795424068; x=1796028868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vnRwo/ZsMPpWSsncariS2yc/xAKn3Nxe+Kux6J8DtAg=;
        b=dkd5DuMjnT1Zg0XpG6+AvbHgqKji7n8v+2tMSLraDoy9z9u7GIDQ5GX+/LUkq1svfS
         zoVj4VWJRHLseKMmjRBn3rybbwpcEeBT62LGYFtJ8U/Q3dFbxSrt45GBzgPp/pWz92Da
         sSp6pvMANDwhvmi3V8aNC3UWrQbQMPUH1Yx6j5nnjZJAgbS9CT9Xi/d/wdNU9prxwanZ
         orwNq3KnNbdBV/7yJrETQbJub+HCBeLukgUMDuJET/B96xRQtwgB8RR9xSBWpPyL22I8
         KaFfuFcuNtXYsxTIwbGNtPgFF7rrqH5kJOWNyReKT1e7nr5trS6Y1ebcZB7IT4BHge/K
         UEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795424068; x=1796028868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnRwo/ZsMPpWSsncariS2yc/xAKn3Nxe+Kux6J8DtAg=;
        b=MJ79NxG9z0qbJl5K9XdyqMnzoPfzuT42kXo88wHvelXFO+7/Gd2BQaUk0N8LDTiNuh
         a7vQ5sYPc9WrJBqVYtOcJw1n4udBZ8yE+tRgmiimPdhbIxRoCbbIoY9hfNqLbjkR1p9O
         2DDo/2YggXj9w4956VJwZ76VEaGx6VpziFQ2o7UH8gXD/IUEGCZ7Tps53GnioyRfl59W
         eMhAPqicqZ4IzMMQlf+9nFBxJKPElSFTt0ddQlJ7YoumBO46CiTlyUP5a7os0xr2lU2H
         szzw09nuXhL1PJOwHj0bsPJqxynZicUFBNLDtyYCOoSe9FIqPS/aTDTg7nLn5iHR5QRh
         Kj+w==
X-Forwarded-Encrypted: i=1; AL+hErHoj0JZzNC/ycScfDKXsXcQCAIE0+v15Amkg/rso1SqvAksU6c6Kc4BidTb24dAcK/MPY6fRyJLsrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+9t/xnCLXIfwPEQCuv4nOyguQ1tf+FpZhKggPjHMlU3q+8rll
	Tu1lJdfJ2YGDAMYyY0qRZITqIrbADblu6WPdGHP+p4+oofhunXsqCGVe
X-Gm-Gg: AZFdTZf3TZn9Au6tTzSp8Iyg6GEzyP0h3rVLTAI82TXZo9XDqk486QgZJonxEveKm3X
	/O3GU0HFcUQb3nPZ+baqlhWCyl6avLpAMluzuAH8bYaHTIHckXs8IU94ULqHvuI+DQhWUDbNTtP
	QGN6njnt3y4d9lzARjlY3JiXQ1dav6tweV8e+QOG4C/EkpSXYDIvDDPawTujzYpeZkswDfWpYjl
	Wb4BsQ0LOtemrzl9v30fA9RRh4eGyarssfJo2qrC3wVHTQa8LbgfFvTOFLSS6xluYSgRKqZeUkb
	LOTcywWt8WedbQYy4spWipRxzpzmaAX4iAjRdO5Lwyo7RaOOgNKRjHjRkSKxo2KAzMvOroNDqFQ
	f7dwC+wVpdoOHBEsUHnu7HD2mc82uJZCOBwEB8WYXBLiUmbYVp6e3KEOUS2eDu5DQU92e7AnTCK
	iWPcjjx8gwkQfKbB3wonrJmzF/4eXt4d0t7zD2ojmmVmbcxlCu63jPHKDRJ5WdaiII6SsrINk76
	HDVVz3muM3G1pQkagVu8wHpIrzG0C38IgB1fBynRo427uF1g5gaIyW66t9huLczurf4Rq4w66hb
	5IGO7HbDMsvLxVD9d7mIBimPFdlxflVx/AQ2Yk3pMq/GvZKTUBJYfS3DOmeBEZaZ8FVgtrFCJJ9
	gAQMFnmk6YhziSvZkrCPkrp+kG6jTPzJTcIX/IPdDA97zINXqi3fpDiw=
X-Received: by 2002:a17:907:da0c:b0:c50:5545:b66f with SMTP id a640c23a62f3a-c513a803353mr781995666b.23.1795424067352;
        Mon, 23 Nov 2026 00:54:27 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-092-047.092.076.pools.vodafone-ip.de. [92.76.92.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdf022sm377880166b.67.2026.11.23.00.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:54:26 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v5 0/2] i2c: i2c-xiic: fix clearing of bnb irq and waiting/ clearing while atomic
Date: Mon, 23 Nov 2026 09:53:50 +0100
Message-ID: <20261123085351.3415122-2-thi.zirnstein@gmail.com>
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

Changes in v5
- Fix timeout for polling bnb bit, set to 4us
- Link to RESEND v4: https://lore.kernel.org/all/20261118101147.3350796-1-thi.zirnstein@gmail.com/

RESEND v4
- Add Reviewed-by Tag

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

