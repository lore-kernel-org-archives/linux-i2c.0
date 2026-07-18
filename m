Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DA25B0A8
	for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343840; cv=none; b=U3d1q71ogujghrXLysa/JWTVmafKscQ2gfvplTucP+DwnLtqmal40kYk1C5CG4h5Yc2qJk/knyHhQRAqDTzrgMhrYbsxn3fOd/XKbz1PWs0V1FNWomOxVPGgrAErjN4Xjryqao002Ar1DfIX5/ve2O0j4oNJ+IFIw9keyVK31Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343840; c=relaxed/simple;
	bh=pPCpxr9XgsyMz1xhP7Hg7iTwImnOiQD93GKWC8ZNcxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzeTUZKknCP5RIZgl7eQlEKfHaIkXF3yXACIjVpDGBla+mhQIX3ATwiD+QksmSOGAgLS8viTjZlx9PK5siwea6sDLn8woMCQbr8TcsH1e70JMVWvzwiX8S+MPBckJ3cAcRtVDKtsU7YEV6rEkIxh24s0zjoaL5gEpctq7uQz1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTwgm+Wg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTwgm+Wg"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so3201216a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784343839; x=1784948639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPCpxr9XgsyMz1xhP7Hg7iTwImnOiQD93GKWC8ZNcxo=;
        b=iTwgm+Wg2sS+mIV0DMNR6fLahIQmiUCyx4MCpU4VHB2tOSMZZJEnajl7+z+JMectZC
         Xb9ETdLRW295iKotIi0gKsgIq6Ammqyq7ZcNhqWE3gvozAbBRLAf2CxBVaoklYWTwTER
         SEp0pNdVmmrZgWTVDj4VldMMNmeXoFzScibBXI0LrDOWeU9dKFVeOpgVyZHv3Hhw/hoX
         uPYWH7pYsu1au0atDZtQRWD8ofsWKpGQRKijQmqvIIiE8yPdzuRWOdF66Zf+tXpOBmF6
         4/9Rn6hUrr/ehSvZ2RuiaBgcDh2+4s4khJNv33FuondztEgNSFyzZqcVMy2fDd42gKBs
         YPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784343839; x=1784948639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPCpxr9XgsyMz1xhP7Hg7iTwImnOiQD93GKWC8ZNcxo=;
        b=hcn3gnRFovfwBZJrdTR8p5j3V0wjjnPuh1/9uFa39CpLyKybKyzhRrf6cCULhuIFdV
         OnXC6je9nSK5SFTjvFb7lHi9qR2QyaBdz0IXJwgQ/7+62MdIjbvI9vGjGiqMsb5+ZdsG
         7T13pb4xjRLjInFUlKRUvIbVQ6zOfLW24b2Zyu2xCEBOxaS/ajn7zTtK3BbHEQb0so4o
         Arq99281Uwo5//vFg/mEOmiD5/7Hk3zkMaxL3mXwDLgFCeM7Tr/x9wXX1+8RlOoMVYgL
         y6SaPLxRY2rBZUq4ETtDwOZXOFVhw4E/pcYAXAIaElS8SRpr/fm/Xm7mrBomFFgavtVR
         QQgw==
X-Forwarded-Encrypted: i=1; AHgh+RqsMTJeq1muwZQ212Pg2puVvM0ZAm8s+qldVUbwvMSaRMhOvx4Z74sUJohBS94tAVPSJPrIM/nrk9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFIWqbqMX4mDWpG2YY1kSUbH9G0zFrriz5jCdAdbapGwSqhYzG
	fI4qlHpU0ujYrWobGXEx5zpGTmIoa3JROBWMC27NTzv/Hqi5I92edsUT
X-Gm-Gg: AfdE7cmlVjGOk+2TPLKwlYht+TutJbPhoknJgV8Ijs4OPSPoOaM+CQ/kjddl8RMtcfG
	SYkSiqXHMu8s1AqL0EbVkRUtyVTe3m+mAPyrF0C0xw0Yx2O/vxf/yRf8+7eAQ52NvN/La+oUPpV
	xulo4N2k5Ba+4mJ2aLpBHxTFU0/vbi4TPVJBZURPtx7l4fFQw4PsZHkJkbfG6x2mT26/X/eEYlk
	X+7G9qJfBb+a8zlQUzLAj+/1ucMYGycOQSybs4KWYzGGjfVmMFfBb7rALEqrCmVBknAg58HnObX
	x0hQrcEA3i2/8SJWeCO5rf3t3KfRGxjq/QQ7nTE2+eKRw73E4vUkdDXmZG8/w6cvR6taVlH0Tu7
	lKD9KnNsUFuXHnyevwECzhYW0I/V/5Rlhkbm9tEdQTq8WsBM2OVX8ZvkiRiziw2xaZcfx8Clk3v
	SOA3/YZ01uz8hmgHI7cp/nxYpdfwuqzA4JkW7a6sc4QVZCDpzQwfuKvr8b9A3lTzDYhbxTAJVGG
	nNbSviYxeQI3rsOajbH28a9IwmLqAfOoBMzou/she5W8VRaK/kWDBZXCcrrYrf496JSjZJLKVFn
	g9YPF5BoaleQ4/18kcxG1iLpdTIU1yPISP0Hj1ryz0tBWGaWMW0YyJGYMclw5CAfars=
X-Received: by 2002:a05:6a00:451b:b0:848:7459:5f62 with SMTP id d2e1a72fcca58-84c2945a902mr5377409b3a.44.1784343839028;
        Fri, 17 Jul 2026 20:03:59 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-54-213-160-35.us-west-2.compute.amazonaws.com. [54.213.160.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e48csm2015355b3a.45.2026.07.17.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 20:03:58 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	tamird@kernel.org,
	aliceryhl@google.com,
	boqun@kernel.org,
	dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] rust: i2c: add SMBus byte transfer helpers
Date: Sat, 18 Jul 2026 03:03:46 +0000
Message-ID: <20260718030346.1698-1-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178376605131.22511.1602274538745913609@linux.dev>
References: <178376605131.22511.1602274538745913609@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Jul 11, 2026 at 11:34:11 +0100, Igor Korotin wrote:
> I2cClient should implement the `Io` trait rather than adding standalone
> SMBus methods like these -- this was already agreed on previously [1][2].
>
> There's also an in-flight series doing exactly this rework right now:
> Muchamad's "[RFC PATCH v4 1/3] i2c: rust: implement SMBus read
> abstraction via kernel::io::Io for I2cClient".

Thanks -- I hadn't seen the prior agreement or Muchamad's series (it
ran on linux-iio, which I don't follow). The Io direction makes sense
to me, especially given Danilo's point that it's what gets I2C the
register!() framework.

I'll drop this patch. No point in two competing implementations, and
Muchamad's series is further along the agreed path. When the
FallibleIoCapable discussion settles I'll rebase the SMB347 driver
(patch 3/3) onto the Io-based accessors it provides.

> Your smbus_update_bits() is exactly the kind of read-modify-write
> that's affected

Right -- and it may be useful as a test case. Unlike the AS5600, the
SMB347 driver is write-capable: it does a config-unlock write and
read-modify-write updates of charge-control fields, so it exercises
exactly the try_write/try_update paths you identified as unsound if
left routed through the infallible backend. I've offered it as an
early consumer on that thread.

The power_supply abstraction and the driver (patches 2/3 and 3/3)
don't depend on the shape of the I2C accessors, so I'll continue
revising those in the meantime.

Bruce

[1] https://lore.kernel.org/all/20260708214738.25008-1-brucer42@gmail.com/
