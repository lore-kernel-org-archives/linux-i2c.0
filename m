Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D14439F83
	for <linux-i2c@vger.kernel.org>; Wed,  7 Oct 2026 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791411899; cv=none; b=pLnN06QlzWQ6qG7d/MWMXB1mWOHHNeHRvA7Pf8X63yv/3L9CLRxYVPRxAyaDjTMpSlEhJArZpA77sQMRtUB3sy4itElxmQDIA3HL9Hoxz2PMIbuIsMDNZ6t6amQd+jRMBOAdU6lUMTyCKjN6TRA+OcReekqcoKf1C+dMcYWvKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791411899; c=relaxed/simple;
	bh=pel+0U0Ma2DTW7rjaB0n/gDtEEX/h0DbfZcUI8yEGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibjTx+6iYe0EC1p9FsFB7gMSB9wizKjul9TaCsOIiPk0HIh+H4WDU9YpZrWAkK8R7H3RiHxmWT/83aggY39M3mhzmSYv+RrqGGcwxXdKMFIiA7sdGKovp+avwWM7PTFimm40utqwrRDDBv2JDZ/+kwIYfPMQJkIuB7/JiXJkj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EunBzzyv; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EunBzzyv"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1438dbb05c1so14896c88.2
        for <linux-i2c@vger.kernel.org>; Wed, 07 Oct 2026 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791411897; x=1792016697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pel+0U0Ma2DTW7rjaB0n/gDtEEX/h0DbfZcUI8yEGQE=;
        b=EunBzzyv/WF0gJqfYDdFHutPrJuW5+frDQLC2gLbArD+KObFBf70aDDBGqUt1iJSqC
         KDkqK0Q14FvuRiLPNJ89IR+91PjXaTcPGjFWIr+2Nj3Ty/2sKFvGCf0ihnzwWcBQTzum
         EOxCIP3MyDCUYJZoi3LFUeGwzjkSfRhtf1v3egeKaF7Q30S49XHj9Mh/NNK8ORCXdfJP
         jh7KRMQxqMhJ+M1ZFwy4ZUF6kHE5PvIA0YBqoX0r/SjH25brdGU9EMrlm+QlAEGyR7fk
         xfwQswZsEoiUIEb55eGu1xy4X0VI8GrVU1mrzE7ynbs1LRhlZz5ceYhfiVmAtV68m7VU
         k6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791411897; x=1792016697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pel+0U0Ma2DTW7rjaB0n/gDtEEX/h0DbfZcUI8yEGQE=;
        b=xHa0Voy7z1y9DjM/Mb976HyiR57+WKyV9FrPxy5Bb1ilCCkF+s2BmyIvp0t68LiBxr
         EM90ibGPDIbvHmDGb553PAhxA++K78U3Sng0eMCfO3hhysEbv7Z05k5CowCV63CM5/C0
         N0T9WeCsehmXDPhHVJ/xKnBzVbm6s97AEPl9l3YCAXx5Lni73AsLqzLiQTD+vY8hDq/m
         EREbRP8ToudQN+AwMDvhEGx3aTzXyWZLo/TPjM2Yx2TapofAABHF8Ao2JxzFKCwFIs0m
         7fTbiJ72SGDWuWS2tSm/BkUmKKZ0lwhbLMh8SVgCNXAucsLvCXLPYP7dRt2ogihFeu1H
         GInw==
X-Forwarded-Encrypted: i=1; AKwUvBzJapbKMLMEkaPgHjsLRsCnNLpPO9PEXrud4g/o24mZnSIeXbEcVaX2a17428LpCo74BOI/7LVWKHY=@vger.kernel.org
X-Gm-Message-State: AFuF++mPBobVAvh9g4qQ2AzuRcmX67ivZtje+JMrHH/A/C+z57wtKfnO
	ORjcUBH6gL2DIkKu6/gJOGqTLyQsp5BMRwzVcdQ4yGpAKT6ToeY+OXo/
X-Gm-Gg: AYBFou1XeWtPi8I6RpMZFPqCpzTiMLXKz/Fmv61Q84DCp/TeyQJcEQJ+LOC0Cs6Ouee
	eLuzyrH/cKvkzwMBymWDZfCs0cKslr+8GaBLtOHyyBXWspgdL3fO6RlUt/VjcYd+f4BBZbTKX38
	RF77h1oo2g70h6q4Fg+Yl5sUJeu7gUkK8QdJopGKbrqvbCIbDyd9ln7sxx6RYoXTMNPW3K5VDjk
	3pXDi2t3nm8tyypXZbows7iQeZHGzE3mlUkz3Bagy0hXPNQJF5UbpxJfL+RncDKwcfzzpNJ+rXo
	GOewVeOPceQ1qSGzo/e6Shy0AHaPh+UvKI6WSp44pZ5j1MPzp1JpLNZNir+XWIFvrky3jk1s9ad
	DgSKR7AZ1OUFnQaU+gvh27exbROe4WKhq5faQ/vMMaHgwwwxkgpcBW+HKHIONBZ6hO8fNVV+KVk
	WMW5WR8J187xG40iksoYUEcK2OqVRDHwMisWTXo37SA4UzdB7BNsCXncIJqunzq+7juuGjTTb5T
	ImYn4P6ptFaU9tITdeD1st4YHl3gF70eRo+yQGyYXKUngcZNAseiUMhr759345rFYCbrnnknKFM
	sEpO4TOrHaQpn18FrmA=
X-Received: by 2002:a05:701b:4511:20b0:165:be2f:c56e with SMTP id a92af1059eb24-165be2fc7f5mr856966c88.2.1791411897121;
        Wed, 07 Oct 2026 15:24:57 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm9201838c88.12.2026.10.07.15.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:24:55 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the queued transfer
Date: Thu,  8 Oct 2026 03:54:50 +0530
Message-ID: <20261007222450.616022-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <asIKZluOk2ocK_mw@ashevche-desk.local>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com> <20261003223659.13974-1-navonjohnlukose@gmail.com> <asIKZluOk2ocK_mw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 04, 2026 at 11:12:22AM +0300, Andy Shevchenko wrote:
> I think you might need to adjust the commit message (and pick Mika's tag).
> My concern was the oddity behind /dev/cpu_dma_latency: Does the commit
> message suggest to set it like this (then it's no go)? Or does it state
> the fact that CPU power states affect the latency (then it should be
> clarified)? Or something else behind that?

The second. Fewer interrupts per transfer let the CPU idle between them,
which is where the power saving comes from, and the added latency is the
exit latency from those idle states. Holding cpu_dma_latency at 0 was only
how I measured that. v2 drops it from the commit message, gives the
latency figure and its cause below the cut, and picks up Mika's tag:

https://lore.kernel.org/all/20261007191911.502428-1-navonjohnlukose@gmail.com/
