Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556926;
	b=UFhwC7SEOxMFljRhGdlQeYigHdzupkxwpE1G0/018BrWgwt7p2PQ1W7bbUGcAyxGZKEg
	 WT4/2sy5vlKp2EnMbx7kKb38ZBr43ZcP3EicxQXk8wIf57z7gNPoHDP2jqjsKWl007klf
	 E9a3fD7ZOeKxkCwIUB+MPG01x9h2RRl7ZHfCa0Ahc51JtRzlh9hyk5q7MTlmC31d2WjPn
	 ajT/VxSQVMMJZob+pS+NibXd8q1hjDXkjA+U9XT9K2hJ/lSCg42FsHtZF31APKYq1dQCX
	 eTbGw9mPC0LW3BMiDrzKulLQMbCNJVAZCtEsQLuyz1TFO1/dnc6w9qqScPHJAjOTfLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QJxalrHssAZhNnjpSDoFedeDiy/biVpvzIuN3reWEpI=;
	b=joc1RVhtwP11o5vRGxUz4vG41D/vHI7/JLqHWHjTr8OgBxp5hxcq+8/6TSAyBS7YKrGJ
	 bxqpdvRENmT7QximvdqIVcFxX2jCJy5kd6dXZAEGVcAntR649j8xD55MMJyJs0Pe4yM7Q
	 R3dXVIfwAH7atjTA+QYxlEl8lNuLaAXKOASYXODLqbygMThQ/UWhv4YQLcj8EbXpzt2Do
	 Vzm4FR85PQHZWEQt10bZb0Iab7zMee42b0/vdP8E2JvCvqFJNYROGzaBa9OXx0lispNwq
	 VNUbcaE/AQFvsOCJfkfIbm5dC+GeAENYlhHQsqHFArvU/3q/p0V731OZg+PFwhJP/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTIYH4qx;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86923606A331
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 08:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86923606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTIYH4qx
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso3814415e9.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 00:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794556925; x=1795161725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJxalrHssAZhNnjpSDoFedeDiy/biVpvzIuN3reWEpI=;
        b=zTIYH4qxkd/UVxtwx/nA4llgh7bESZeGQaTm2prdn7irBT+NII+HvK+AbhWvy4rdyy
         bYKhIfRmJ9GflhYQE4Nmct3m+qHljveeJJbUuliL3S8spo8t1HrXd2rQRIETLr2SDHu5
         rlCHeYrkuksr7oUerEBI2GJebaIgDOaZUv7fYxsplA+DCFzWW7kM7wNsKY59ehJuaO9y
         EwOcgpCz+aeujkXZGcwcKp3jPDVtnAEwCbkinfXL+hAYv6au+gBt75XxGINglZuKzWnY
         RhucEJ7oA+h58Nlk5miFoKMfz8TFoOQ4Mn4cuxAqU8clBxCjhc65T1WK6xbgzu72gsFK
         Wd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794556925; x=1795161725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QJxalrHssAZhNnjpSDoFedeDiy/biVpvzIuN3reWEpI=;
        b=dd3P6g9Tb8TM4MyHXlaXHtVM+st/xO9bxvQgx+zQiF9ShO0QCuuXEwl9iMk9JHiKJX
         RJ//qrqK8XWc3xemu/7q6gPVykgPDhPxNqRFhDkKqZ9I9N6E2L1CXxFdgs+rTkfif3F6
         KbGIKR4P5VENDQ7s0AAcSYaCQrmwzlIByHUH87BcoSiWk8ypH5JhNSd15Py4KXt5M8kL
         Z0xUqvPqLpBvOlQrG65KXM60sh34p2dQaBT/U8EaBd6XXM6BagxKaccslc43pkDR6vAJ
         5ztyWCsUm5W65oCinekyUTxZu7pecbKMPqNmEsv2DKTkBZ6WP8SBLcX6a+5dYHFC1AxT
         LxUw==
X-Forwarded-Encrypted: i=1; AL+hErF56oEDalmjva1GhRXYIUXBKXAUDIqFNtbK4qSpl3qy4kbBJkK/RZ3TqJbPa5EvwZqOK98jJuKIzC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tT0iUXq3F3UKx9qSZRUWkJx5fO7QeobsfsXCjmQ/SCArArczO
	t1gP7YKL2ZVBKO9gPz/FMTYxqypaA4HOaeIEpGUMxL3aPDsNPNwZx7Dl
X-Gm-Gg: AYBFou0GV6/KWA7nRkWQpHGu1lXa2IXDjSsngiwJGlUKQcOBKv/JTNtUEf+wcPBJgyU
	7DQYlW65T/NOL1AGnmBQhdI1nORB3E+iGkESdZqsM23PwfRmB8rG1hXLBJa7v5NrFboqs5qwgnM
	tbZHIyZnBgk09yC0SImdrfgqnskBWWe6jwcqhDU0lqv51yqenCVxj26bMf9PVT7m9zD8C9IhPIc
	BUc9A5Fq+voOY0T+bfx49T0A9s5Vjj1FCfZ4fpkj49RLUTAJCmEaJeH6zhAHFWw05hm0SguFr7V
	i4ep+74sfw4YBDl/3g1oako5lvoz4ScP5kcXZCX9qovw64qVmehCnGrNAMDWJO5h8MYrh1bIPI0
	0K6LFe9pF6r5gAUAOf0g6UycUgSBUXLlFd0WbgYL4Vw+jZBtV4oeXZhMhXCpSPJNXlWTSxtaF9x
	Zdama39B0CXGuAWqHZt/wy6zVZVBDYDM/Q1yS36g335aTW2Gddgr70Cp0xXOZ9vVjJefDqqFmd6
	2BpcvabGyziLoamnu+3r5m5LfvtkhVFAcJYHztY1VcqmqrsOEt87UdWLo+hGI3ZeTJXX8VrRnkq
	zGi9mqn++oTMB9OjaREJ+J00Kk446b2XxB3C
X-Received: by 2002:a05:600c:c4a3:b0:4a1:9663:7639 with SMTP id 5b1f17b1804b1-4bb55ab5526mr35140005e9.34.1794556924633;
        Fri, 13 Nov 2026 00:02:04 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2acf81sm121590835e9.14.2026.11.13.00.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:02:04 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] i2c: imx: two fixes for a DMA write that is not acknowledged
Date: Fri, 13 Nov 2026 09:02:03 +0100
Message-ID: <20261113080203.1046422-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-1-mehmet.fide@gmail.com>
References: 
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

A correction to the test note in this cover letter.

The v6.12.117 kernel I tested with is not plain stable. It carries a
backport of commit 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non
dma mode"), so its i2c-imx.c has the interrupt state machine of
mainline. "The touched code is the same" is true for that tree only.

For stable: both patches apply to 6.18.y and 7.3.y. On 6.12.y and older
patch 1 applies with fuzz and patch 2 does not apply, as the interrupt
handler is different there. I can send backports for those trees once
the patches are in mainline.
