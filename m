Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567920;
	b=S9FGRKria46OurG/jscOrgjODaYEOhHgisg0i1R48CETAtJf78LTbym75unwn0kQaUS5
	 0kIF5reCRXUvFsGuctq0hTtAJ9feARzmBKvlc6uDdD2LxIdilabxQLcn7rQAAk4aFxpyN
	 vEDwv2FWgK6fdupqru1WTWxWniZH5hXMTI6ie4AB2PLe+L0RiNjBGjk/aloGe2NuN+LqF
	 OwGyGgQ9WgJupFCx5dFiwIPsmM63E+3tzzljfo3rG100T001jcEe3gND1m6SozBysEvyc
	 WpOLyLqeUz5V+889WcJ2T4jJfUCCBVnnpOdA8ltce9fnu+tAYqmqNiCcySwQWNxMitg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QftI3K44ZZiobTwr/u+4ZTOlGFkxNtcO4iEVZ0vgnek=;
	b=KHYDHiFQL+74ghDaZ1LxysTyF1KNAh3GwjGS4+M+j2Rzl5WSEdEPhkQ8KIpMYtupx7vf
	 /Y/KywiMwXFEr6evcAcr0n5I7PwPj5wB/EuIuzH/b4xK5RzzsJ01HqMtUSGXe+s1NVL4C
	 dA3GBcb407QuRruT6iRh3EqMWyQz2oyu/zUdL1QkqPBTB969JUQUqMWSYSeg0J7mnfBNf
	 Qtt7W8r5wke25ToL0MViMwIRmObPEw+kprYL5rIYUaEIj0Cpzv7EPwU1ltWlMkuNpJiXT
	 SYk3/Ed6zTXsNn4Ws3ybMf/wJ7jRCUgO7Kpk2MKoP+op2w28v8cWRYgkM9kMTvEUeHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2OthWkM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F0606A327
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 11:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A5F0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A2OthWkM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so8068335e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 03:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567918; x=1795172718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QftI3K44ZZiobTwr/u+4ZTOlGFkxNtcO4iEVZ0vgnek=;
        b=A2OthWkMGm0zsNyY35xrHT76UqK6yWeQ07k30O5+g0WUzIeRFNJnwKJFwe35vdk6ys
         S90fiAwfr06xGkl5DyCyQNIe9Hc3nQGEUzV0L2VHa/BisCyvWruEdn+kR5fs4jxBE9nw
         diyiyKH3d/3y8vz14vzsOwxj61a2tpSo5kO1dcbcxOA19SalILeuktA6zzlC/srIsA92
         cd/vKip27+mkdz0CClhTTHy+w+opMEOcOvYTiaLB0/MPuKHKHhgToU4cUTeh+qccsO2/
         c9VWqsSt1twsHNCavS31smcL9BgN7YH4LBlJP79RBf23eXug6pfS7V6wMyJAkoVHfr5B
         A/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567918; x=1795172718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QftI3K44ZZiobTwr/u+4ZTOlGFkxNtcO4iEVZ0vgnek=;
        b=iTrLj3Gkse1Md0v0YzKe0boKE6NtJ6A9kgc2Z5TcNnN0LIbV+DGpIl4d46qbzUGobE
         nkveBjYXUuo8hJxYAEfGrYxx1RalSorfnXnwO3qhemn9sEtSi2GTX3hlgv98vF7U8rqG
         9aMJtSC39MReBiXN6L7EUqqpgg2vKo4LQkKU6wKpKx9PcgxNvkVE9vBWZDshdQZulmGU
         Nam5+sJcozzo9fBnQjWhJhehipIIYKxB34AaxAh4SlGxsjVwjiY7Usgf7t10PbhHitpN
         P9STlZuJ9Uc29c3ISUzlLNm9t9GOWbNp8AduD2oo9vxKyF8B3/IFo9qj1xln5XI7uure
         NR0Q==
X-Forwarded-Encrypted: i=1; AL+hErEtjirFtElSt8C61oUtAIk63iA3SxJYvijvM/VeoeZZIIeqTa76uvTXL9hkxaOJsTC4Nz8ajr3jYHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aslLMC9k4QpBdE1p6B8GaZgLajQcuJcqpVDrkNa39NFQ+QZ2w
	VAy9AQWHazR9ws+DAk1wbS6lAEfA2c3dKEBBLo2sTRJ5jZETI0XmdEyR
X-Gm-Gg: AYBFou00k91NWQy5y2ZIbdGS1js0zCWt5sOhBTLlncyhq4BRD2FVxzQ+5OROeazBXYm
	Trkvh4CfViaVKUYx2fGORCwu0571ToHYuJru9lRJOBB69L4rhiSgaYHBPrhutG4BO6BJDojs8NI
	n4DILfRcGdsLc6Q/KfrEBtzbyNvr3hcm1A0+CKYnw8hpW26Uu36h3GPyWwRjCenjT2dvwF2ciqV
	LTwmJtTQl7qNq2ZOUnSrCxzPEQ403qV7RkNMmqbyDvJeSQEjW4DoBIyUNwJv7Wkv5OopkUHlRtB
	lSFxBtnEVPc20n8YX0WKocpCIJ7JkEMIZMUwR8hWqKeyrXlWaK04dJ3kqzVieh/z3HB046d0uxY
	ewPxhBJH0SzG3W7NW+4pEvGFLSvoYFNQRNphr/XGtEbAQyWWywmLZml5bIv9UMZl8RyEvkLvvxA
	I9GfYs1u1sMebOo1s4h5QAyGx0k+Qu0f4tlxeFl/OBCrIguLKPwb9LEPq2MDThW2o0Q/2FCw3kQ
	p24sZNS96xbHTuUkGjLZQd+ux4s4C2er0Kuay+VklppIlUxQ+3THiyDfU9QewqQyCbGBsGLJwMT
	m8rlzLjp+v3uGeYWACV8UeBLi7F7azrim1A=
X-Received: by 2002:a05:600c:3b16:b0:4a2:1960:6fa with SMTP id 5b1f17b1804b1-4bb55a6116bmr46200125e9.4.1794567918385;
        Fri, 13 Nov 2026 03:05:18 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e4a2asm4788105f8f.39.2026.11.13.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:05:17 -0800 (PST)
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
Subject: Re: [PATCH 2/2] i2c: imx: return -ENXIO at once when a DMA write is not acknowledged
Date: Fri, 13 Nov 2026 12:05:16 +0100
Message-ID: <20261113110517.1142293-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-3-mehmet.fide@gmail.com>
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

Please do not apply this patch as it is. Sashiko is right on both
points: the new -ENXIO path leaves the DMA buffer mapped, as the timeout
path does today, and a NACK of the last byte the DMA writes can be
missed. v2 fixes both. Patch 1/2 is not affected.

The block_data remark on patch 1/2 is a separate bug; I have sent a
patch for it on its own.
