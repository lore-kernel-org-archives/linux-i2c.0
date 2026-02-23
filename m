Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEE257843
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807964; cv=none; b=CZkFzLI0NI9XLkr1cGmvz5Qj9qdtNtN8wnOJe5Kh6eycXTDfnYdrr2mc4n/VArU4mLFDwXckRTrdYjLu/8MmEUfx7uX590jaWdqk70nPp4JaDK2x8znREKzwUgPDnoiy9w8hooW5tPntC5/Ihp5XDu1DTqYW8HnSeu69FdVCsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807964; c=relaxed/simple;
	bh=NXWi2qspmLoMuK0oFM8TKtglzf9rvFsL8LsE8+ayg5s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=rqqY/lbqAVQTy2F6IQRdKn+aCB9VWD4HXFz8OHNSr8LZEGPLnUeZYaIibz4bCUMOAi1KyfNDrnm5NsKvfQsu11xb5Gumggk+XAtccSSzAVospGPV/GJMBNAp8VTYxUcgPkCRu/CnZl8ZE2I1NV/NseMCALGo5xoBcgYuBP4KXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=PGn4yR5o; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="PGn4yR5o"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso3472139eec.0
        for <linux-i2c@vger.kernel.org>; Sun, 22 Feb 2026 16:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1771807962; x=1772412762; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frs1IRziFlL5ohPBZrVbDbsa5wmnKDLt4hUZ8Mvfu5s=;
        b=PGn4yR5ol75N6GYBHQyo5c2PLCX3Vb68YMnUPUcjRP526nXVVYx9Sy9DkXM15VWeQK
         eUWvC24VHLJtpImsFg9lxrSw3fhakJ8O5Pr7THf0Wh2DpiIj/xCzIdts9r3/9L7wC5DW
         p+0ekvJYGNxPusrhElYWoZIhy4JX90HzZrL7Dw68RRV7SMmWxW4Zu1G0svgdux9nq8W4
         KhdeVwCncxKqtYY3Mu6QsHKRseNykQqVIrAtytXZs/L3LsQ7YMMMzaYc8+dY50JWJ1EK
         djM1kHqJ6tdHe/xzyCrbvJdieq3CQImoxFqtMHjwi7RUIXrcqEOK/Jt/LPeDZoq9IJqq
         puKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771807962; x=1772412762;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frs1IRziFlL5ohPBZrVbDbsa5wmnKDLt4hUZ8Mvfu5s=;
        b=kwFer1Jae3XJceRl3tMl+cg2lGwoo/00o4PZuf+uCTYmKZVue0lckrwzVie7kxV24g
         D/kYVwmSxISMJd3arS6cQSNPFQUOYvPXq3zx0cxpbuYunL2xPE4YiACOEEDVo7njhbvE
         Ww8CZ5RyJeTRLcb+RSyAPWb43e0r/T1skqCGSRA4O894wNKLlr8GLUHEP11UhdACLI+X
         FOB5DnKIGmVkoXcAHjfV262LszoKhGVLayYWUJrmoqeCr3yJGFJ+JBnoZbVZ3G8Y8IvO
         VjsrXG9ueJlfPwdarWUXb8i0pFVTYaassfFm7T08mx7eFHNAuIoAM3GWig2OgJFicmav
         deOg==
X-Forwarded-Encrypted: i=1; AJvYcCW+eddQ/La1I4ICj1umLneowy/qEohZEX601RTZzO7wiS3UyyQ237Afjy7SclXIPeS3C5Db0PNG6wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOGuNAHBJlRVRX6TVmEBvwgmm++Q0Fq7Ex1VmEGj0Wi3bA+IP
	RMeMYONzQ3FKxmhMy5CBlUiNXWjC8R/d9Y5HO0/PliNHqgtM5B6kACOntVlAn+VGIdI=
X-Gm-Gg: AZuq6aJ33SpQpHUnxHJoRw1xCXz0F8iEd+l+KgBqDEHMfPaUToKuOMsSJPmgfvmTpBy
	73KQTQ/A9ZHd/LeVH3krfYjrUzcyHw+2c2g/0JK0h+koEQf9CWW89mYCJ5adxgeAD+eGVTnkvzN
	3032Qy2z9Bcmd7Nt1yQdNbrjZS522q3mtRLGOTS4Kej9A2jhmsIwvcGunfZoiAhCESLqYHRmVKT
	EBxhK1I11waUu4FWEF0rJ9bvKqpLfGz4BR2OU7gP+rKfLm1sSd5TwhlBp3yOc2xnBFzZrTcae1S
	y20MRFXcaFmMnDpC3e+s8hhTWS1HQva6VhB40f0jQ0RolzmaKjoJ1s6lsIml25RqGl9S0ae9aF8
	53nomtlCPZTt3fL5JJ6s7H5LcB6Qkh/SbaTCP0eigSp69O+wl0Vcbn51tvOUjhOe1iyNwx5soXY
	kc5LwongTYY4x/8NivquQ/be4IfwLD4nkb7WRLj6Fekr+Mlvv01gyFpA9iW44rcrgMZw==
X-Received: by 2002:a05:693c:23c6:b0:2ba:6c38:c79e with SMTP id 5a478bee46e88-2bd7bd6fe06mr2634418eec.28.1771807961944;
        Sun, 22 Feb 2026 16:52:41 -0800 (PST)
Received: from localhost ([2605:fb40:0:c09:323a:5679:3782:80b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe78b9sm3895671eec.18.2026.02.22.16.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Feb 2026 17:52:39 -0700
Message-Id: <DGLXI3TWXQHM.12PGD5R3RH000@brighamcampbell.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH] Make userspace tools accept device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260219032849.668488-1-me@brighamcampbell.com>
In-Reply-To: <20260219032849.668488-1-me@brighamcampbell.com>

On Wed Feb 18, 2026 at 8:28 PM MST, Brigham Campbell wrote:
>            if it can be stat'ed as a path and is a character device file
> of major device type 89, return the character device's minor number.

After stewing on it while driving down Interstate 15, I think I've taken
the wrong approach with this patch. Specifically, the I2C device major
number is _not_ a part of the stable ABI (as suggested by I2C_MAJOR
being present in /include/linux/i2c-dev.h instead of /include/uapi/...).
Because it's not a part of the stable ABI, I shouldn't be relying on it
to identify I2C character devices.

If I simply remove the check against the magic value 89, then that opens
up some very unexpected edge cases. For example, a user could invoke
`i2cget /dev/video0 ...`, which would cause the code to recognize
/dev/video0 as a character device and use its device minor number to
construct a new file path of /dev/i2c-0. I fear that users would
(rightfully) curse my name if they stumbled upon this "clever" kind of
behavior.

So either I need to switch up this patch to make lookup_i2c_bus return a
file path instead of an integer or I2C_MAJOR needs to become a part of
the stable ABI (Are most major numbers intentionally excluded from the
ABI?).

Making lookup_i2c_bus return more than just the minor device number as
an integer requires some more invasive changes and more design thought
(particularly because the current code will try to open both
/dev/i2c-<N> and /dev/i2c/<N>, which suggests that lookup_i2c_bus should
either return a list of paths or some sort of new `i2c_path_hints`
struct).

I'll go ahead and whip up a new revision soon. After I've finished my
homework, that is...

Brigham
