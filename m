Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C2137923
	for <linux-i2c@vger.kernel.org>; Mon,  5 Oct 2026 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791168461; cv=none; b=pRsgm6qiET+lS/ra5fLvDqu/1aXBA6UGJjP01+3wz9nz9XMdrUaWt98zjzD4BpK8l42t34k2CAf9itHXbmPMPC5jfGzBWhMtQ+gjrvJrxiQwYX7pMSJNUaC7R/1mriLxLCn0F29Qko1AHcbXE3E9b8Y/8jG93yF76kwd0+eUWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791168461; c=relaxed/simple;
	bh=ZgvtJM/DUHMnHszNUGeuhEtSEbOa/wydpZaLbhEugRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNP1A2bpsxGOezL/G5aO8bMb3xpUURCeHAyYBblQniDzd9fqme0IqVR+kjrbsy2z/AXC/QF82jbL2xc6ZYPiyf/O48jZj/i2LBQ9SKUbkv9AvgflRF6ILJtcu/o+iO2Kx8vAPJwCdjwsVILJCYKOs5E/KnVuV8JZ54u98n4kdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwCEx8N2; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwCEx8N2"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2e58733c31fso1223095ad.0
        for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791168459; x=1791773259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fPN+9NWOFucdGixkLZfdt14fhztpKr2pAx7CYx5nGY=;
        b=qwCEx8N24if+xWkPq68GJKkKtl9s60/nbKvwaUX2wbOwRBayypmyc1KZdpnNltelEI
         z3jLKgRVzal74WKXy3R679RxS8cVQI5XCYe6tsSZu47ukr2GhBmJ38uPsVD+3ns+hqoY
         j4y5444l5+sJNRYec2IhVNBrRTSxgd/6zwtBL2qp1Yzsr916lfnIRx88vx6MGrJIZGHq
         Pcgv9o2gbXAQzFbOn2cx2jwNNvnycjML6GI77DBDJqrUnrUXjLXSWu05VEvmxUSz/y2A
         9gCprrmvAsoBgeRbscyjmVpeVdpEznSEhrL7GOxUnJY8TwwSmIz2nqRoYC9Ix7mW91/L
         U/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791168459; x=1791773259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fPN+9NWOFucdGixkLZfdt14fhztpKr2pAx7CYx5nGY=;
        b=uXYYPm8hmHlIpcfy1bDXB2IRHlNkvk8vx30Oxc4T89B5/dXH949/oDQv7LGVzyVNdz
         hYnLQGlEl1UXtd1+nicIJSyCQiUE5dtpatGRTB3qJGbl3oRBTeHtUs28gbXjRiyjLKSu
         fhOfkWsYqpnLxmPty8xnIe/dOXLjFlgiI3avLH9PWV1AQ1yi+Eecyeqw2AZ0mbowe41z
         wqWVF/9Z1V9JHviTCgqkbF5Vxx5cEz/T/XxVmpgsI0K7PhtOGn4GYSU/awyqYYaRl/m3
         5sqeSCIx8QtfUrazPVFuI/BzaMmCazvClhNNV9/yiPMCxA7Rdu9hl13CrtGm34iqv9Gk
         7q+g==
X-Forwarded-Encrypted: i=1; AKwUvBxWN3yY8NXuc837zZ1+k32WoLKlAOeJNf5jZBg6x3KsZqX8TWlIL5sMj5GWSfYIRwmdS3MQA3fSdC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDpTpwy4L+Wv/oxFpAg/Ed2EtElwBhSzZaxS2a0sI4zlyuv973
	oOcoSZ9Hhy4ChWiy+XFM1N7qpop7OyxHwqu0i9Kle/BOnVjFUv1JvY32
X-Gm-Gg: AYBFou3rHuRlKnmRgcyCithOzQflPnwKl8SNh2RxuxUjBGNGHm3rNrdueYFRFyKDamT
	eJUc96hwgzB4cOEqjmaIoDxGYdb5cygu6Nvl0V2ZONpOHzqO8M0glIBPReoflWfk5jVMWCT4hzD
	s+NSjv03yYPJvokdS6Bci8aqYiQoB6Vjfj4znC2ZioJTJQwyzssXx0r+9v+U4kP1ctPvbxohh+c
	WYUCMXXsYrC4tqhG7JGTL1bxfQ18roL0likuN7JSmyDuapfwWVb5SLbJSdGDoDBmqz3YN/Ap7nT
	tLoEmdbUKpqoajZp6gTWJN9FRbBpb3ckrsAZY4jmDMNdwcK+GN1neTxchrzRHwfyjSVSiwWECNi
	7qOPWRnIVuZSV11FnrXljhee3cqCiFCQY3fHTTcNpfHMp0ci9hHtjeTMaxiBBToRDvBfcqdH0mu
	r9+Mt6mnI4TGUejKzOF/J9doDPAKkl5NOgkY/3K4jRAwMJD/XUA5HpMKJh7yl7T+Zb5R1GDqw6o
	cnrkUSew/aVDDxgXQxIGEagEHR6O5huBJtizoLcXmG6nBXQTA==
X-Received: by 2002:a17:902:d511:b0:2dd:c100:4b85 with SMTP id d9443c01a7336-2e49b6ea3b8mr89037265ad.60.1791168459101;
        Sun, 04 Oct 2026 19:47:39 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([112.2.158.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ef5576sm744665ad.72.2026.10.04.19.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 19:47:38 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: westeri@kernel.org,
	andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0662 to i2c_acpi_force_100khz_device_ids
Date: Mon,  5 Oct 2026 10:46:54 +0800
Message-ID: <20261005024654.26888-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918055653.GD106095@black.igk.intel.com>
References: <20260918054109.23550-1-xuyuqiabc@gmail.com> <20260918055653.GD106095@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andi,

I just wanted to gently ping on this patch. It has been a little over
two weeks, and Mika acked it on Sep 18.

Please let me know if there is anything else you would like changed.
Otherwise, I would appreciate it if you could take a look when you
have a moment.

Thanks for your time,
Yuqi

On Fri, Sep 18, 2026 at 07:56:53 +0200, Mika Westerberg wrote:
> On Fri, Sep 18, 2026 at 01:41:09PM +0800, Yuqi Xu wrote:
> > The ELAN0662 touchpad (04F3:317C) in the Lenovo ThinkBook 14 G4+ ARA
> > (21D0) intermittently stutters and drops touches. libinput discards
> > invalid touch coordinates and logs (rate limited to five messages per
> > 24 hours):
> >
> >   libinput error: event6 - ELAN0662:00 04F3:317C Touchpad: kernel
> >   bug: Touch jump detected and discarded.
> >
> > The ACPI DSDT describes the touchpad's I2cSerialBus resource on an
> > AMDI0010 controller with a connection speed of 0x00061A80 (400 kHz),
> > and the kernel does not lower it for this device, so the touchpad runs
> > at 400 kHz. This is the same issue previously fixed for ELAN06FA and
> > ELAN0678.
> >
> > Forcing the bus to 100 kHz was tested with a DSDT override on the
> > affected machine, and the kernel confirmed the override:
> >
> >   ACPI: Table Upgrade: override [DSDT-LENOVO-CB-01]
> >
> > Before the change libinput discarded three touch jumps within about a
> > minute of touchpad use; after the change no touch jumps were logged
> > during more than an hour of normal use. The patch itself was not build
> > tested; the behaviour was validated through the ACPI table override
> > above.
> >
> > Assisted-by: DeepSeek:deepseek-v4.1-flash
> > Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
>
> Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
