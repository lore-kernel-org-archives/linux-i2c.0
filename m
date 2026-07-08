Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D691372EEA
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481982; cv=none; b=sPaLIk4KBzQa91N2gg8uW/LFapMDElRbWsiwjYZP1QudY9eWeTYajfzwBSWJsM+/mJa9QxBfW1fN7064aGX0hkJMkDjxLohpr/9i/JXtRpEHL2gJF0kCToue3Rnly3CF/6BItYZDtqGBkIE0OHf2P74eApRh9uxZoSUvk7BNtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481982; c=relaxed/simple;
	bh=qNpbVkjWV3LmZ/c0VFRVdl63+pvjWxxebPoKoAK14Bs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lSQyWBq0R4qGu7yStPRiIgIo9hQ/GWfYjDeI7HC2z4jBApU3Ilvy8uHZ0XHld2nG78k+qP65Xb0wLwSTfPIbym8eyYUvrWswcEmYd2hKC4ROF2tJcHlrDLQuxDmemqfdb0/9stR7y64CEC9HN4332RnIhBvE+BXWpAm1fAasnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=nwrDEkqt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="nwrDEkqt"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca12086c06eso136063a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783481981; x=1784086781; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SPpEjM5tk4AvncOaWPWpqTvH0stBMLwyecUahY52qzs=;
        b=nwrDEkqtnR9LmyIINuS+f05sOzQGwJd4nLOW15vkql/YHrfaNNNbKBUVo+r9Cx/cTU
         6m2mdwaUz1pvI2e5veEoMlMTVBfr/PyXP0rjsYWczPn3B7SoV7oY1JC93ui2oQX99PKZ
         b60YV5RuqQrNhKHK1gx0+ecrEqTrp/njGQh4+MG77ihmay49gOjF8kIHz8Olcjbqu3cI
         qJu1RTFNvrRx4mSOBaeDm6b3+AJOVabCodxwUzyRorDSw7bd8ReOLAd3qwFIFvoV6Lha
         NdsZ9Cfg+H5+EaXCkQBbRLCqkYVd1Vr+aqWUzS5D/1zH6cA0kLOhTwzTzwBaTJIwU5HS
         sksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481981; x=1784086781;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPpEjM5tk4AvncOaWPWpqTvH0stBMLwyecUahY52qzs=;
        b=mjmvTU7lEocyviQCFuTZ1A9neGjbkLBSos+MFSCMzZa1Uho6PBy5pJcD0nRn39ZXo0
         wiMLgw6OFhT+k7ndDF2t6lRCzqatl86Bm4xcajAKfHh/MBTpX9VCf91DywDAxNRi/w5p
         fH7sWKDja9o1DG2JGUtobqYiev4IFgHDMEOlXw3PKoQw37ycwgujMl7oFZl7dJBrPnbY
         YQ5HblADGKhbfnxPHDQaUxXsKuk+YG0Yi3qfNSsLgmwf9aYQvjBKA0aHRujWffS98PXH
         FXBIJ2KiIJAP6eiqLrD+VQUK9CRU9G5GpqvuVC5uURXjyDYS0aFfVdl7YCjYKAOz3auL
         yOaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrla9RG5armdQkYIuzGnGkmGchpigh0ntzc6W5qUkBIyjyuHZVX1u46V314n7/T6+4OMBA20RSrEHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdewvM3bjPRxpXiMMvQFMLHBGUNNrL6NLSrf25Cx1OARSB6mR
	+btdz2/ku0MLVNqkEQELvLXP7MceO270y4zAvoUk2f5YOx4EnOzgEuXfiw5JQOG2Sho=
X-Gm-Gg: AfdE7clL/Rj+jD/j8OxFIINnFlVr0gpGpSfgbi+mjs83ahhNKWR3oecjalGOp8olDh3
	swTcXytd71l2eJyZDuphogOmmp8OZ/d0ngDufRi7ULq5xs6CXr2+wyuFdJa1urByRMhKZqF51H0
	LWM2dbHYIY6RE9Xd/XZjBE3mnuDPdjXOEEKr7EeYWChD5/iIy6t2NpjQ/Vc37W8Sv4MdFKW8V7S
	hqrQ1yqoCMUa5Pm+79MYQR844AEA865DPQXKAOCRuvPtSpWcd2k0Nh392JR/tjFUZ1uZeDTcFxD
	y+2GnsUP64OVD53cgvGxrimeJ75KmEinrSIU8RZ1K8vLzswVbGj8ADL+37bTiDPhpBgzGu62myf
	EMRIKrkFunkUP70z436ilt4VhocUWfmEYwS3pwVKEmiO4siBz1nGCWGfx90UNAS+X3I7sWITZty
	paYvW342b84cN6coEPOdYQU3e0YX/QzlhT6XqYV7K9BbE/ADlwz+irMOMBtQ==
X-Received: by 2002:a05:6a21:1bc3:b0:3bf:5ff5:2b15 with SMTP id adf61e73a8af0-3c0bc96019dmr636965637.16.1783481980634;
        Tue, 07 Jul 2026 20:39:40 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm13767928c88.15.2026.07.07.20.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 21:41:46 -0600
Message-Id: <DJSVN4OMOMB7.EBB9SV2PLWTR@brighamcampbell.com>
Cc: "Stephen Horvath" <s.horvath@outlook.com.au>,
 <linux-i2c@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Brigham Campbell"
 <me@brighamcampbell.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
 <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
 <SYBPR01MB4586AD69D431CAD2D26ADD68C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com> <DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com> <akzuG3VpcoUWRhUr@shikoro>
In-Reply-To: <akzuG3VpcoUWRhUr@shikoro>

On Tue Jul 7, 2026 at 6:16 AM MDT, Wolfram Sang wrote:
> You might try busses 0 and 1, too. Some laptops use the Synopsis
> controller.

No such luck, apparently. Busses 0 and 1 each report no devices
attached.

$ sudo i2cdetect -y 0
Warning: Can't use SMBus Quick Write command, will skip some addresses
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:
10:
20:
30: -- -- -- -- -- -- -- --
40:
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60:
70:

Instructing i2cdetect to instead probe using SMBus receive byte shows
the full range, with no devices on synopsis bus 1, but one device bound
to a driver on synopsis 0:

$ sudo i2cdetect -yr 0
[sudo] password for brigham:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- UU -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

It looks like it's bound to i2c_hid_acpi. No ddr5 temperature sensors in
sight...

> How many? If it is in the 120 range, then every access from i2cdetect
> fails with it.

When I run i2cdetect on the i801 controller, on one invocation I count
111 repetitions of the "SMBus is busy, can't use it!" error once, then
on another invocation I count 112 repetitions. The error condition
appears to be encountered very frequently, but not quite every time.
When the kernel's i2c bus arbitration retry logic kicks in, it appears
to be able to eventually complete the operation successfully before the
i2c core driver code gives up because otherwise I would expect i2cdetect
to exit prematurely and report an error.

Wolfram, if you or any other kernel developers think this may be
indicative of some underlying issue, I'm happy to investigate further
and report back. I'm using a Dell XPS 14 DA14260 laptop.

Cheers!
--=20
Brigham Campbell
https://brighamcampbell.com

