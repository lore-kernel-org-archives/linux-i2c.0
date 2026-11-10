Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337562;
	b=4eQfSaCDR4YKAES/98SjIJI+EPgeGpJ8jBWqGCw9flNhXbQ4DRn+1Bq9vkgRimkgvNZF
	 44P15Z0I1DXeXpdL3qep8n/zY/NZYgepqDsBGxrCzXSo+eSb5AkJukMW8kGTPmcNefGbr
	 Xgh5+YnkIIEYXnIRTGxHS4fdjqObp2OFaKEJyaMIv7x/RuUcZYirmx0V6znuzvtHdqdt4
	 QPnJhvNc3pQGWBeTyvE4kShUDDDx0zNM6SxxpLrsZOhq6k1S/kyt/kF3feLP7F4PyyD/m
	 dX9QTSjHhLditaOt+TbYwjbXkMHNZEf/N2xxIBCpe1dBPERhZbU/Ab1cLkphe7v2F2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WWnZldioVaIQvBqHhtWfm3ijxoimf6A6B8W6nEeMNyM=;
	b=Z2Y/dPeqvVl3Eii/3yTGUi7T2qzGJt79ijLyJo3/t7JG9m+3jpq0zuC6Nb1/1OgYnCDo
	 +JRO15JDcFsDnZxdkMyRLiJZ3uxunzSRMQwdbsf8Nm2rTlV1vXc6HBbQzx6OLC+jSJQp7
	 B2AplCPS3jQk6rQRcBn0CIeN5BYLIbK7zOxAaH6YBgchH3SoCM/yOVJKDvczenHbAMToI
	 5tqMKinWYz74Y+CYLqZVyRZPcErD2xjm/WajhV8SnCyrccFzR75JZS8jaiL8KQoLB9HTt
	 XSr2uVv2fXdLej4F+w92NDpqtj3GpI4NBvEE75FvfV2hdxqhhatkha1QT4wi65yHbDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eFtwUUhT;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DA606A321
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 19:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16DA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eFtwUUhT
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso3284730a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794337561; x=1794942361; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWnZldioVaIQvBqHhtWfm3ijxoimf6A6B8W6nEeMNyM=;
        b=eFtwUUhTY+0jkJqJtGdXrL5foXpP7zDOhBd6CDjTlQ0ophu8e90pUUoNjyYfZZ7wL+
         q8idMATXLqolvhlA5UvJ/oTrp9S8A9lVYFtIrGE64P1miOOC6EscjOCOrYg/GJ/lLyLR
         0fpuby24nRonI4lK+Q1ef8mfZ9eWABhd4xeXSEI3rjZWJ665uHUS/DMAcNMewJ14/xv+
         2LW5vlCMAyASHQUg7bS1znXs3C9zIc3QMVpPwr3HBx9XAP2iJ8rBQmm3YA0OS4SvhdQ4
         nsqST8gyN4jyHc5mmZ3mkctgu06rAdJbxHoDnQ4TmETaeIMgtZWDOREohyMR7RX7Vv56
         g0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337561; x=1794942361;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWnZldioVaIQvBqHhtWfm3ijxoimf6A6B8W6nEeMNyM=;
        b=q8yEMGw0uyO0miQ4LDigSKtnQQnAl3djLSF77tYKOsENqi/MgGZyyw6f6vFtHpJNNm
         tPvktTK6IuYuapujM/xU0TFOTSStzCmGMXXuc4JL78Rvd45Nab2B4LYX1oWmKy6A0EAK
         R2pSSTdJT8XGD15bIGH3WUFRULr9E6gaaLVp85qSUPrBwGGlBT4vnx42YbumCL/48QYX
         bvYcSpjIiQFam0MgNImqVnBdWZrtvzFyagzmcZFd8Gdv/PNIncnF1Q2xfR1DyXeELRKi
         5gn+VSr+8UJg52/OP3wGJXrTdEuXEu1GoPZoqN66jsVVRgr83vwUPw70crfsKKEgF/Xh
         RCFg==
X-Forwarded-Encrypted: i=1; AL+hErFY5KWDXY+ZRLvCpDUFsjRjG+aWWz4Lo2WsUpoAZAOI63gljJSHmR0i46lcKrcaatiTqXRYi9qVFCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AYXV0PNr8FTIMgiMKt3/YoujtjdhHiYTA2uUwj9r37C0F55as
	yIrVn4vgIAjCHyQYA1LSamm9mlCezdovA01ap9UWlVNYVlCU7gAiCfN3mLjhwHYyeZdYaz8Kq5o
	JwgZKAoVCIi/QeayqG2PILA==
X-Received: from pjok24.prod.google.com ([2002:a17:90a:9118:b0:3ae:c243:313b])
 (user=atifashhar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:524d:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b166c8500fmr3498740a91.20.1794337561037;
 Tue, 10 Nov 2026 11:06:01 -0800 (PST)
Date: Tue, 10 Nov 2026 19:05:59 +0000
In-Reply-To: <20261109102006.GJ176724@black.igk.intel.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104133745.1432212-1-atifashhar@google.com> <20261109102006.GJ176724@black.igk.intel.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110190559.819337-1-atifashhar@google.com>
Subject: Re: [PATCH] i2c: designware: Release slave SCL hold in __i2c_dw_disable()
From: Atif Ashhar <atifashhar@google.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Atif Ashhar <atifashhar@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mika,

On Mon, Nov 09, 2026 at 11:20:06AM +0100, Mika Westerberg wrote:
> > +	if (tx_hold) {
> > +		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
> > +		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
> > +		regmap_write(dev->map, DW_IC_DATA_CMD, 0xFF);
> 
> I'm not super familiar with the slave mode so adding Heikki just in case.
> Can this cause some unintended traffic on the bus towards the master?

No, it cannot initiate new traffic. DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY
is only asserted when an external master has already addressed this
controller and initiated a read transfer, and the slave hardware is
actively stretching SCL low waiting for TX data. When no slave read
hold is active, i2c_dw_release_slave_hold() returns early without
writing to DW_IC_DATA_CMD.

Writing 0xff simply satisfies the ongoing master-clocked read byte
while keeping SDA passively high (released via pull-ups), allowing the
external master to finish clocking the byte and terminate the transfer
with NACK/STOP instead of hanging the bus indefinitely.

> Also use 0xff instead.

Ack, I will update 0xFF to 0xff (and wait to see if Heikki has any
comments before sending v2).

Thanks,
Atif
