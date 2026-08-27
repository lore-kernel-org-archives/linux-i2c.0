Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BC364927
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869569; cv=none; b=UE9KSxUgnDKgr3ZU+fX3tqgkzJMIkfnYzCbzOdvh7EYDySw5ffBQAMu5woV3taHCR2gdDrIMk69JDpJetXAbZeEgYskqHQB/AgR1W94+Jb/C4yGdhjsWDnZCMiu+yET0vp7J4MwthJJGxHtLmoVDfySyxDVqYmNz1BN4GPluQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869569; c=relaxed/simple;
	bh=TxvaZ4zayK7a2B63L4t8D8MbZm8/BwjOSwYLxeyM8RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB+SKvkRHXxpsJgRGwaYqGfbDA3F7i0IL7PrKGlQjhOj+cTBSaaH4uZIYpMwuFEE0GsQfNlN/jIrrIlo5DwLRAdSra1itAct1TZtMn49v8RyXfP8IcZyhICLYSSfC6jANAQCv6UiTc/mqcM8mM4C0jyQL7ik4E3KlfuxPRoF/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF5KNcA6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF5KNcA6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so2579835e9.1
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787869559; x=1788474359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KrToZPBnqDhx/hwRhT5E5yIhfEGUpGAvOCdqzL7a7pQ=;
        b=IF5KNcA61mCdmQAodnOMCbggzzV5GrSxVQCEGQJCGP+SqnY/CbBiUNQpPohcXta6/K
         NJe2uIl9cAqkhldVJeP/RHrhRUn7yJKKMjLsSzx6+PUyVtYqxVPTOjVnksM7d+0IGS5N
         IOyTXSpEAjSHBLhgHkzxOKK4VpjTVLgm5rFiOo6d3Q/2pR5ckLDRn7RPbDRdf0QnPl40
         qUueiIgrMI2dGZREPRUnf/e0U85r4aBQ+P5obu1ijGNY2ipD6EV8sK0/Ag/aXn4IuANN
         3u7T3fs+tvg9It+W2/9VvHMwu1q3C4af4S5GFVgrQ/LQ2j4Npi+T1zwbe2IKpmj58hOY
         JfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869559; x=1788474359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KrToZPBnqDhx/hwRhT5E5yIhfEGUpGAvOCdqzL7a7pQ=;
        b=khmUthI2SGB7+Wl7HjjqhtWC0mOZtD/J2o3dZR5ljMnzPpZXcvb+32ThufiFk/J42u
         vOkuEFKIdnDNyegdhpKggLsvI/+hjxYtKOiOJSbyqBOjWN19tfiFIDdKvMhIRV5RtPeG
         Vm4n4Skqb4sPNtIaDjRNQ6AltpzyTMdxDU4DmLx/ocZNv91JnTYaw8jcMaEylmVJy0ik
         yhoRSpIR+lXqns18ap5NjuBj9/E4YEc9ANB87b8OwVR7g4zjs5zM6XiaPBJ+0Q5xtiYp
         UohiIiuWnxMdXC16PhK4xp6phzrStkmDxK0lhUj7omHpCE8zNbycxQL2WiCGSdXxd7y1
         1cNA==
X-Forwarded-Encrypted: i=1; AHgh+RobwCU86+T6Uw6OwovGDDbdJJlrVvE4+hlmFhzoYSNO/ZyLNJf0Ao29uBQoYOqHHuPSbBIVNqky93I=@vger.kernel.org
X-Gm-Message-State: AFuF++kOHpyAKJVHTmtMCXPrQsssKVwSgYWaqVxqs7+g4Aox9PDJq+NY
	aUJcZGlA78E/c7Rd2d+qeRWnv6vy4I/qqANN0amWA8aKKBtNx4huhv1R
X-Gm-Gg: AR+sD12mLOV2M+rMTcr9S0hPS1RzwNrY5v2YI2kk21RKzEMF460y+DYHstsl3412MDR
	77XoNXT/kj5FdoEYjtTfT1ufJqq+l0KTBAUI9/MEpaMj1jOrO1fWtvrA3toQAeuJ2/ni/L9YCku
	xPVYjnAIVMGk7c8ce4cpW77Dnw0AJ+mUV9CSiTd+Vh0+udRZ9n6sKBa0l/NGrC+lD2B6aUrpfIZ
	1Nss+KfUTiiKUneDz9ZKZDHhh203HjNXwoFaWBUjHYcpdu6QOHEEgYMqspfs8/V3r7UONha/JRR
	sEks+S/y8DEIZYepaTuRVd4RVkmmtOAvP2phQwGoY0PgIpCm9iyObcgY0r0NiO8xTMNCIstwFYh
	il0oou51HM2jQ+7/SVBpfcRezOx56robNyK9I8pORd2OFP2o+GqYXCGqAhYP2XqaSz7eYnvZVh2
	gwMSsZng4mbl3Lwdjpp3gjKPnxcM9WQhIZzGvHtvkYBdxpObTytsWVLPv9JTM=
X-Received: by 2002:a05:600c:698c:b0:499:adb5:e7b2 with SMTP id 5b1f17b1804b1-49b91c3ddc7mr38429415e9.11.1787869558933;
        Thu, 27 Aug 2026 15:25:58 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49b494228bfsm79722395e9.2.2026.08.27.15.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:25:58 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: lee@kernel.org
Cc: linusw@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	brgl@kernel.org,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Fri, 28 Aug 2026 01:25:50 +0300
Message-ID: <20260827222550.24634-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827205116.GJ2943942@google.com>
References: <20260827205116.GJ2943942@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 at 21:51 +0100, Lee Jones wrote:
> That's precisely what MFD is.  It's one chip, usually with a shared and
> overlapping register spaces, that conducts multiple functions.  This is
> no different to any other single-chip device or SoC.
>
> Shoving everything into a single driver isn't how things are done in
> Linux.  This should be divided up into the associated sub-systems where
> each part can be reviewed and looked after by the appropriate SMEs.

Understood, and I am not going to argue MFD scope with you. But this
is not specific to my series, so I would rather not decide it here on
my own.

drivers/hid already registers other subsystems' devices from a
hid_driver: hid-cp2112 adds an i2c_adapter and a gpiochip, hid-mcp2221
adds an i2c_adapter, a gpiochip and an IIO device, and hid-ft260 has
hosted the I2C adapter since v5.13, commit 6a82582d9fa4 ("HID: ft260:
add usb hid to i2c host bridge driver").

So the split you are asking for is not a change to this series. It
means moving code that has been in drivers/hid since v5.13 into an MFD
parent with cells, and the same reasoning would apply to cp2112 and
mcp2221. I am willing to discuss that as its own conversion, but it
needs the HID maintainers to agree on the direction first, and I do
not think the UART and GPIO support should wait behind it.

It would also spread the driver over four trees, so a fix touching the
shared chip state becomes a cross-tree series with coordinated merges
between four maintainers - a cost the single driver does not have.

Jiri, Benjamin - this is your call. Do you want FT260 functionality to
keep growing inside hid-ft260, as cp2112 and mcp2221 do today, or do
you want a drivers/hid to MFD conversion for this class of USB HID
bridge chips?

Thanks,
Michael
