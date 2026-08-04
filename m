Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4043E5A09
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877662; cv=none; b=cR8E5PYEfHq5LOdeAToSJAJ4qS/OaDhfBgWtXQDydjiQRT4cbJtu2tLGBtQmkdauYXeSF+aOB1Y6VGVy8rBo3PNELd/aPBuLTBAtXlWfW56HQVPwt9uWwdGQM6mbrD7GtvCpKnON8yY086Rl3KfRokijFcEXUwv+7SYykh4bxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877662; c=relaxed/simple;
	bh=M94F1PqXP2R4azTv5VsBrw3fcVY3YhyrZvCDUpvojig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McVppQqnG1A2ghzFSpL/oxWLelnZhzbAZ4Jri5QuMSZnfJU84f10WPhVL0EBLVm9tWKSl7oSs0acOi40IPyzFmQgr6e2aM1vC7+iXWU2RT2v0lCF8io/Rohkf3PPRK38kC+H5f6tzMQ5uBV8PayPQ1vuic2jkF4ZKiH5m7QIAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/JyTPzm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/JyTPzm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1607977b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 04 Aug 2026 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785877660; x=1786482460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5VUaS6lIR89fzUXE8jE1kCkmVqVFSCHPmmwJhW/Xieo=;
        b=s/JyTPzmzEy4CYMFx0MDLuGE+Hz9l9t0GpvdDSsuX6ku14z12aoaDR2OJu60H7O8VP
         1fl5KymTjLMPLGt4YuDWeSSUZdNkRrIWHhaB2fwnW6LxD33/8HSOxRMuxD36+cIAeSFs
         oAWrzA2+GfzsqWbs2n5swGClIIwf+vZo48iZgoxXV6+Um2UP1QeHj69XQ68xUcm6E7Zr
         Dz+nSSlWrsUXfnFYtukGJgoQ4RDl/bNZNIt2MbviTqPz/56gAHTX4OaF62Ipi1qUlPkN
         rJc//7Le8rHgmUaIxWbz3FO9JAeIRxzpT5Nj4qO5sD//y0RXvFTgzxLJyNXJAhhpoYG+
         PRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877660; x=1786482460;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5VUaS6lIR89fzUXE8jE1kCkmVqVFSCHPmmwJhW/Xieo=;
        b=YsKjT+DN/WNfjPaaRLZGuAmEufBbRwAaxRkBfVGV6VeptoF93WUK/Jpy2/C6Bmqjkm
         39e/g2KKnqYaexl3bL4+RXCmTiw87+IozXH1z+b00L7rV7d5qjtrS8ICtRSZLEMALci0
         bgURjYR2ng2ldw3EdO6Xn2TPTIvZO1uxQC1WlRYCR/xnFezv76KfD27xSq/HH5+0Cr3+
         k6S1EqFGA3SgTocb0MT2zrNkAbsqia2lQzFCA6s1bMTFKCX5pRg4RukJ/iarh8d7w1DD
         Z1X+55Cq0I0QWvvDGbo3248a8Meb0alAinYW98SU8Z7zLCPhZP/IbaIVs6/ksr8jU/I0
         dMnQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro90mFaubrj5tIiBRic3i0LbYjE2XCOicgcJRyz57uS26ViDsutcuTK9xRpoUcDfs108rnL4ln65cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7SWn7hHYW4Aj6R7Jkrutl2V7r/XutfNj6mcF5X48UbyRNDAe
	tnWykwRRIRJwKeBn70gF7SwicQWtzjnL9rz5yU93TEK2Y9fIFPZri7y/
X-Gm-Gg: AR+sD13t4nQeqAvgz6bmLFTc5BSGIxyLPy2qtCZTVuRle3rZ9dSkY9RtQivkOV9UfY4
	IoeKZA7rKBmQjOKtdgHibAl7fpsuDge71COoHiqdeANu8vOQ+X9l5tRysj01B1XtLSsTt/TDIxp
	mXOt/A9PT+ueXBO/GKyD2REPB20JEReLKvwR9xU1dOgl42Au8phw2IJmqQlkvBU/7wqCCCHlNbT
	4y2ycN9GBSvJu4DdRwQAazGGW9SRHjby7OUTECnTo357sfioBBbQ0Nc9LWnOLmQd5D9UMYaZd5P
	tm1L6bFkqnBblrnMsmJL8oxyPof6TOCrrmgEH+KCq3ZcZruQZ4MGUnDAj0Trl139DSiyqM3qcMu
	NJ0ClVkm3r6IgarirHxYwlLMz8d5v1tCORPMRiYFYmPvkn0X9cHIxoKIMdJJnHKvJimAw01UjAS
	AL/SqMd8aUvOXgMlPY7G3cgMJGJfFSYx/ApxocZ/bifApzXZwphrhwrFdcTuPSZAGbi6kffpLdS
	EjZ4dRa3dkXSQ==
X-Received: by 2002:a05:6a20:4320:b0:3c4:3750:2c03 with SMTP id adf61e73a8af0-3cb6c7b71b0mr5878476637.9.1785877660120;
        Tue, 04 Aug 2026 14:07:40 -0700 (PDT)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca6576b7sm6062339c88.7.2026.08.04.14.07.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 14:07:39 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RFC net-next v2 4/6] ptp: ocp: Validate EEPROM board IDs
Date: Tue,  4 Aug 2026 14:07:35 -0700
Message-ID: <20260804210735.48116-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <4ef01fa0-969f-4ec0-997b-5f5f3f67e11a@linux.dev>
References: <20260803205011.1249-1-ahmadexp@gmail.com> <20260803205011.1249-5-ahmadexp@gmail.com> <4ef01fa0-969f-4ec0-997b-5f5f3f67e11a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review.

Agreed, I will use the 12-character Fixes hash and split this safety fix
from the feature series so it can target net.

One detail about the suggested snprintf(): the size argument limits writes
to buf, but a plain %s still scans bp->board_id for a NUL beyond its fixed
13-byte storage. I reused buf with a precision-bounded conversion instead:

snprintf(buf, sizeof(buf), "%.*s", OCP_BOARD_ID_LEN,
	 (const char *)bp->board_id);

I have reduced this to a standalone net patch containing only the over-read
fix. I will rebase the remaining R4006 and V9 feature series onto net-next
after the fix reaches it.

Thanks,
Ahmad
