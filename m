Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285337C92F
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240454; cv=none; b=OIINrl7WVRsTQN4edq/geANyH+QkqmwXio20NVcPmgVyQLzc9iVsgvzF63fSky45ooUNgmvAEGCT/iBDRUPMcZgttgqJx82YrW2RhVlTfAi7KpSPWGTAC13Bqo3Vw06Zl0hF4e25uJuZEzfcssvnoYItPHy2cMf4wfcuUzx0p/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240454; c=relaxed/simple;
	bh=+NaqvG8mCuO7+8P42j6RcaExU5XNxpxCIJ5vTgD37W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEoV5+XqqlcApUTOmYt1dgiX/u9Lj1Wk8BCcnY2SyO0mt3BxUSrkYD4qFTGRJdjp638dQXBnS/J1BWMKKo85bNXv+HdyHFQd5g+OZkQzIle4CpRl00GppuMq2LZ0aWHF6vaToG3hVD1BDlbicUqxrXw85k3add2zain8UDGPvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtoA5NKT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtoA5NKT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab973140bso29047715ad.3
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240450; x=1787845250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NaqvG8mCuO7+8P42j6RcaExU5XNxpxCIJ5vTgD37W8=;
        b=LtoA5NKTiRe3SrwRsXKCAwp0AjRA1YmxIdDaxcWHS2hJ2IdulQeJDpQdCYwkKsBhtE
         6+ntS9REeY26RgUKNQ6CzMoMbSUa6mPLJUiPWnP+DdZVq81KIZm5Ds/hMlprLVQixvmt
         9bdPqEILNh5vbxKrvE04Nsy5qu6AzOo15OjdBC7t5UBNE/s4raE7/vk738i9ms31VFmV
         xin05WmVveW5Qf8SHijOrDZckwa0wZflgYKI5Fsz9m6IBf0KtJDnzMJmRzqvwHLUmn7a
         W6shIiZ1ALd3C+sjDSFoKzkn0s0rr3Tz0KVeVNOjjRbgg19DLhiba9m7oOwxICgMb38H
         uLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240450; x=1787845250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NaqvG8mCuO7+8P42j6RcaExU5XNxpxCIJ5vTgD37W8=;
        b=lUD3Ii2fKW0LU4jnwg0hrJCJX5bJIe8SCMv4X1kp855gI2i9kWmjxh+AQOiyXmwtIm
         3PVUcEbFix7+7qSKXAkp73NCjfwW203obXvcDfoSuHQpYdmgUNPYSnxIDnW7Mc6g8aUU
         gzuzOvE9XpBTdv4dxmHkVR2A8gFeTxiX/FggZUPrV1dTnwy7WXfuO+XLC6OBnBhDU1Ts
         KOVOfnsn9XqqjU5mdg4225oH3lJWiz4TkWkNSuv4Z5Pk1sH494RSfXYBtSsXM5Z07OEg
         vHdJpoczIDzSn6NhLQKPuGFlz+lBWGX+iSF6RLBb1Ho5XlLHjIngwQ5fNYW1/tofLbKY
         2V0A==
X-Forwarded-Encrypted: i=1; AHgh+Rq7wXihnJbAVvJsI9oinU1RBZ9FetHBvCLnQGMmlEYGWgODcnyQ/jxuQNHIjeMISP96jO72MO8P5/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lMSiPKB0qQsM/5jc8SLfO0e6fKoOjFPpHUrybH/t/DsLVoWJWx
	M6LL0aM+RE2LZNRejzuo5xC13r7Rh49aatLnUnD12wRplOpTQISmlhU=
X-Gm-Gg: AR+sD11bG13BSXmcDjxfWsa9v9CidsF8XtHyjTyXsYL7TQsSlnqhWmYzKYKfFLYstoS
	b7PMwiOJrxwJvc3XEf94nr88tLCzFC2Wfhi8CwVFiPJQSRXzJtZ2xmB7yGuUP2mDlhzF4Ulv9qs
	u6OQLbyv/ye9i7U8XoDUIHen+rU8XclHOnj2Dprc5QA/YrtGLw6v/7YWxdAoRoTYArSQkpF5fl3
	NJzC25hZTVX4CFONrHbgKs6by6K+k5LM3TDrIR7gowwsqAPcMmie0kAwaSCqPriIoqSrAcOxhDw
	4V4LXmQv1fXecwDNkQPU4NbNbw9MODLdtnMH1vYhSCTg7VQFozT8GmT8Q3XgdJFS1b1UVjSoQCl
	iSMxe5cN8ve+vHkObbAspQBVH9JMG6l0lju2UHv1ak5eNo8vfNfTQipw1OgvjBOaa3JtPKZ8eQS
	WM7JRXQlL/2BQJjcVT3hTFYmiUg8HChtozJ3zoJTM59YJP7wAa9iQk9eMvaOoXS5dMMh1tvnRsP
	l1jae+kaTLoOKingaivuSbCr+sTLp1MZ6MCxbqzLC0+kD4VciQtZLo+DtOj+OIu3J7l
X-Received: by 2002:a17:903:3904:b0:2d6:3c22:993a with SMTP id d9443c01a7336-2d63c22a09fmr51971905ad.3.1787240449600;
        Thu, 20 Aug 2026 08:40:49 -0700 (PDT)
Received: from codespaces-2db70c.3gx5x4kts4veljes22u4ri2f3b.ix.internal.cloudapp.net ([23.97.62.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d5912f4sm9147335ad.29.2026.08.20.08.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:40:49 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: andi.shyti@kernel.org
Cc: bence98@sch.bme.hu,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	triet.hoang.dev@gmail.com
Subject: Re: [PATCH] i2c: cp2615: Validate read length before copying
Date: Thu, 20 Aug 2026 15:40:41 +0000
Message-ID: <20260820154041.5911-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aoYYzhB7Ia6cTTY0@zenone.zhora.eu>
References: <aoYYzhB7Ia6cTTY0@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Aug 2026 10:28:22 -0500, Andi wrote
> have you experienced any issue yourself or are you just
> speculating based on the code?

Hi Andi,

Thanks for replying. I just speculating based on the code.

BR,
Triet
