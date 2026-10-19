Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440774;
	b=ES4APwUG+4ECL88446pQD+EAXAssS0rRdz1jquFOw+8ptexbvJUhTB1I3XHcDIVprdfe
	 AHCBFlcg4hK4QYyWuVv5CbGWMUw3rTacSIDUBhNUCDVFb0SvkeW1+bUkvvqRA8rWoetkG
	 +seMwmmR/S6ES7g1Gz9EGj2QFqJeUYQl74gSkxPVXaLNAOM78Ti0SnPl29an8CWIq3qn9
	 qpJGbxkbfrmaACU8iJcEN1SHDsiojqQjehRneHbZ4IiiPSYOk/Ba3scP6VdsjJ5dRgr8O
	 keJXH0apnYIoY8Jhk9rOeU/ASHA5prmRaEkIfBLWpNPkzZ/1YSgkN+pMwkyvbivvBSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440774;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=bhtdHmlzv0DKoEw+Zc7TOwdDACTcoyGMeQ8adip2B7w=;
	b=SE8Pq+vRK6WrGOeggw6dGjfAUvThQ1K3D+xDvUkYZT9CVcXg2nWUcXrVgvVaAgDGq3q9
	 6XNhDz0aurg3UaiDJjcSW7bcoI1QRy9pGYCMIssmHCdNyiSQ0cviq4xx2ZC1AQWy+rMnu
	 y1tV3dmm0wZuF5//DVC1n3MjWhk+kICKCG2Yfav7iP6WsjTQ8g4Qi47hR3IgRDVa65gOH
	 ltY171557ECsBdwgVCWbgNR4mTijHVf8s+MCEUWn59GKgrdyDKlKdop+TofZJUQsIk/7I
	 UkiNzRZRgYzh6IIZMXQzqQqXYQ+Tc5wRzvlOyH7MCMukUseTBdlh/EkDCNLSrt5CgVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="Pa3/iQqA";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE8606A31B;
	Mon, 19 Oct 2026 20:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62DE8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Pa3/iQqA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E5C9C4E4127B;
	Mon, 19 Oct 2026 20:12:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B800F60582;
	Mon, 19 Oct 2026 20:12:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A795910328C52;
	Mon, 19 Oct 2026 22:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792440766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bhtdHmlzv0DKoEw+Zc7TOwdDACTcoyGMeQ8adip2B7w=;
	b=Pa3/iQqA6vAUfEWx2TIhJVrvDVY1bNti3mgE+dD437CyxrCLMqTJ1ErML4wYetDTmcOhYK
	PGq7h9FpP9dgS6Ncnd/AkqwJYFSPAxzZpb4yCCAjWY741cXlg2eGwlHYPABmg57+gc+sf9
	MbVZ5UeAITIRMWz1Eh3/oQAh6vsciD1LpJEyq2XrUfqG5VY2iX+lZm5FyMaQrAOn06ueNZ
	gi26YmOton3sKCyOeJXz0LOqt71W7hYVDciazQm48/qe7tvcsRlzC/6olMpGP/ez9o+f2V
	tcsQpXF00uQ0CStVQxb/29i3zXwo+y347qLAYTuhPpZg18W8E8lWlZjzlv/mqw==
Date: Mon, 19 Oct 2026 22:12:44 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Pablo Mazzini <pmazzini@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/11] ARM: sunxi: add Allwinner B288 and the
 PocketBook Verse
Message-ID: <179244056617.104236.5769731153552958433.b4-ty@b4>
References: <20261012100816.331033-1-pmazzini@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012100816.331033-1-pmazzini@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 12 Oct 2026 11:08:05 +0100, Pablo Mazzini wrote:
> The Allwinner B288 (sun8iw10p1) is a dual Cortex-A7 SoC used in e-book
> readers. This series adds the CCU and pin controller drivers, the RTC,
> I2C, NMI and watchdog compatibles, the SoC .dtsi, and one board: the
> PocketBook Verse (PB629), a 6" reader.
> 
> The B288 is closest to the A64: most of its PLLs are bit-identical.
> The clock and pin descriptions come from Allwinner's BSP, cross-checked
> against ccu-sun50i-a64.c. Tested on a PB629, boots to userspace.
> 
> [...]

Applied, thanks!

[05/11] dt-bindings: rtc: sun6i-a31: add Allwinner B288
        https://git.kernel.org/abelloni/c/51f30cb855f0
[06/11] rtc: sun6i: add Allwinner B288 compatible
        https://git.kernel.org/abelloni/c/3784706c87c2

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
