Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641B37FF60
	for <linux-i2c@vger.kernel.org>; Sat,  3 Oct 2026 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067027; cv=none; b=pxYjTS9cng35BdVR6A8VHH2p7z60+1jP3U22iRg2ApgrDvSatpMUnllqbvZwST0xQzV6ROupwwq3SHzcdyqn7JM7c8fdOs4CCr4t0TNdDcxAyliF4j+E+NYX/EYT9j5n7SLlz7tFkFJIKWv4co+ESKmEzRZU66aG8UDJkBPgXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067027; c=relaxed/simple;
	bh=gw+IpNQewdVI0rqRaqiRXyApfzC7YILLn9U3LasmatY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ4xwbviU2yao+mZuk2hGXHLAk/dXrWWGYCGgrOT6eJInT5znnUVlZVq7kPNOmMtM8ECjiIEY6p4cFQffZ6OrN5ZOUQAzu4HNfuYTauF5MUWj1rSvNLP5QdCxqHWZdk+yPbGbkX8HlsXAfkKtpI+/Frkae7FRfSzGG1zPQ/XAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnZDRAb/; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnZDRAb/"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148bc4a87eeso31501c88.2
        for <linux-i2c@vger.kernel.org>; Sat, 03 Oct 2026 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791067026; x=1791671826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gw+IpNQewdVI0rqRaqiRXyApfzC7YILLn9U3LasmatY=;
        b=mnZDRAb/grxX/XcfEiAhoSiaMxnzA8BU1Z6HwxHzxBQvm80Zjlp9fo2IeoJ0OXiyyo
         JsTCb5TgM1iksF1g/UD8q3DXFnAfDQiIS0DR8nyaDX4gPBC+utLubXtCUmK7gkk2C3g8
         7Qm0FyZwgHlo+wgnNbsFsOPa40+7S5CBIN+cCAaI+KjiNy1i+26iJyilQUvul9GeS0TG
         Z8fWuAlPmcdGjGA7FZFAZfAnqbVVwtMBwUw682KRezlpAToh9EqzbzGw+3vV3OmIL17U
         3Yoorcx18oXTos6AL0sBvYvPeb0eZmItr8RRVdt9FlaYi/7kYd+fXWGi9iTuZbjMQLKo
         pOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791067026; x=1791671826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gw+IpNQewdVI0rqRaqiRXyApfzC7YILLn9U3LasmatY=;
        b=lsZMM7tS0H5Mtgi1XA51/YQO1cv6eB2Txq4+FY9g5OxTbXdtz7p9PTkqzeL0+cRU7b
         KbVt3EpH4NTwltebZUETwV1iQ8DSenf8xgaL3gVi6gk9B8UD0ZTWDxEGeKeoErnkxhfc
         ZXBAhTRZlPipVSC7ZUgFJRF2TeUA4dFmUBanBOsR/29trJSTVM1ZKo9XSS4ASfaqzIYB
         yUk6rmvYx0Qv6kmdIE0w1LPYgr5uGJpDWsZOoHAPufXn1IVRbItiLvRoOe381ITcUo/J
         8M9WDSVKChiDjjKTV+4tLezZomN5IX8I6h8//qA+5bh3SMW8v6b1rfKHo1HZzx80oRw4
         OeuA==
X-Gm-Message-State: AFuF++lm2jrQC7lekCMe4nDy4NwfipRfa8MNKEUU70puKwViC4pR4AEs
	ZXlYkbuzHF3M38B65bRde+glDCrcpWKn8TRawsecCjzaLxf8tK9HZXkj1d05aytRyKQ=
X-Gm-Gg: AYBFou2rQ+Bu+7kdtk/2u8kM7ityNNqVgEGtfWmq277az3pYcftskvWjFMh1KmVRnmy
	K72uu4iTm5Icq7N6JFtLQbeeUNppnUarmEzhvzktOI6RSlb2L9t+nURsAtd6dOe5vsKscAkLeIC
	NTXO4rdWpc6b/Yv+oLI5UmV1uOZVHP3VUo3fH8G+zOUU85/VmtMBl1vPE27bXxVeONQXhaTYvg6
	LebPwS4vGQ9yzNLmpszjgfW+sdfKLwvK3ONNMOP8jZE0RgwwZI9ESt62bABFT1ZMw+3WS2TUBBx
	6NVybo1UejWVg4B8br0/a5MNytDOreEIpxY2MsfOyF/dGq9GuhKgBr8TRVDlo3g6/6O+ym0QQzr
	3ygXD4av7aUUBAG0XaSn1aEsDQG/aJ/w6vF1js6KPtgfGvByC24hUpeojziHOBD/0O3Y7fJuvEa
	Q+5UnJtayEMDdS22sojjxnuKaBif4ZwUCEX1JAf5XoWA7ntpu8MkBeNyGSMmpxjf/03jcRTXV82
	kaKYc2gevwihXYvY7voOCulE6aF7Pa6ExxFRKJWYpfDIVcn1P5ST8QrZszxaiB258oYEVx+gNrv
	ga2nL/yZDgwURfbtW2WdFnVhCL+a
X-Received: by 2002:a05:701b:2516:b0:144:ff51:2d73 with SMTP id a92af1059eb24-14f5b11e751mr11363335c88.2.1791067025496;
        Sat, 03 Oct 2026 15:37:05 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fca985c6sm12436321c88.10.2026.10.03.15.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 15:37:04 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the queued transfer
Date: Sun,  4 Oct 2026 04:06:59 +0530
Message-ID: <20261003223659.13974-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260919232647.448748-1-navonjohnlukose@gmail.com>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andi,

Patchwork has had this as Changes Requested since 2026-09-29, but I
don't see a request on the list. What should change?
