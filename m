Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3C359FAB
	for <linux-i2c@vger.kernel.org>; Sun,  8 Feb 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770562392; cv=none; b=C0vWhDcDF4pKLPJXgUkT2UQAuypSQKu4DfEqgxAqXt8t0DEx2nT2Q0waw+rfaSz1F0ztqE9QxiBEHdg7Hgoa5uDKlKdHyfu9okzEVmz28ZRe/Qn+SivOdnZAMh4y3/vyg4i+z3KE7wfZ9bxtdG6Xo9OC8I7lnPX++drZn4PJFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770562392; c=relaxed/simple;
	bh=6mVp2KrFl8YgrrhyTg79rNJi9T/xw6DGin2neGIdhE0=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:
	 References:In-Reply-To; b=FoqU6FhHhc6brK4wqPI22GVSoCzcvelEFZ+P4rpbtf6Leo1rplg9ifaEdrYQ+gikRFrgUa2EpqqKI3O1TMmXAaxCkVUWKjf2DUUvHctQoaSZcqdeMNgBKHdr4OOfmwt/CV7Ng0yn4+MnyYUzOAnRCFr/evfKx2mf7pHkCh3b0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqva3aoC; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqva3aoC"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-126ea4e9694so120691c88.1
        for <linux-i2c@vger.kernel.org>; Sun, 08 Feb 2026 06:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770562391; x=1771167191; darn=vger.kernel.org;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h+xkqNhYlCxgIu3rSmKZo7/K9DidHR1ZXFR3pIVmKY=;
        b=Rqva3aoCqE8fTFdqCUkeUjkzUkDbSqHqIvKdToM+yFwXhYA0pgfOrUaW1OpoUcwPyD
         HJmsA/dn8mFNvCqcdUi/A/QRWqcbz5FqXzqWB3gxXL0V09E1SxWXYA3ASpSJSRPsp+dy
         QUyJE7hOJxzO5KwCevfX0eiVwjzJoDN6XVf+fmWCFtsQbEcwJ0nB2D/CSgPp00CQUb91
         F2T0HACQfg9kMMzLTptX+Oabs9h1nxy5kAT7DL3RV4qXaXpARgJHe69HSHF6o2QcLf6b
         jl7NsuJTdczTpZblmnOz07pLBTX/1uVOEwOvEz0NTXsSsQzilHmyYizaeCdAxNfZcRLv
         CoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770562391; x=1771167191;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8h+xkqNhYlCxgIu3rSmKZo7/K9DidHR1ZXFR3pIVmKY=;
        b=vSeQNf8L3gE5p02iYbD70fbTZ+pLwyy3b0PbRCvHuY6cDqhad6jFM1+H0lY7YLzxoV
         unZAAWPnsCJlSKdjyRA2QgE43fVBswBRcuhof1zV8LglbD40SHvBxso9eGA8JTh+BczZ
         p+p+h1E9JGAxSTZf+2keMyEQqjW75E/jKBnqv+og7NVsOYK2QPKgUSonmfkdYIRhQe4C
         LgHZ/MDecgB5AQPvKsP/P23hXP8Krohxc4EZYGYR/vI9wsi2iV9knsd0/fLhWnDAfv2Z
         C+ES26uQ1AJKh7dda94OuhYGy7t9sNk4WYHQIED3dVMDmq1efflrS0jhI33gieuB8LhT
         HOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfik8JUzBr2kjy875/XrXSD10RSws+xI7Z/2niKMLINAjl1lkc6FG7R4uyPV0MWzPw62fNFhGc2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hilFI4Ooqwb9xeK1GUAo8OSa+WB/8amocU31sVTtiDC1R3dr
	CtFanEdssc7YNg/KEOBdx3+gSaco09Nttg3QVhPgv7gPRvhVq42YlTv7
X-Gm-Gg: AZuq6aJ2TQ5GzugIIHtfSUWJMoFIz+nRAFclUVmkvF9Yi1ZH0fP1NobpCwZDpYtk+ln
	M0giR+bQn+cEuZBE6Cs2gr8d/X5dlTrLDP6vwrmRnqYAnCSNLX2bf3GZr27jOyy1w8UmTNRjAm+
	Y75fX8XT973gBqO3QIhyxzHTEtxpAlHuDdi+M5eghhTej+LKSnhdzqkuFS8p4dxYVgkHP1hZ1+K
	KoUNSEAyt24G+loJZ+hif03l8DO74SWYcl2Z9LPwfgOpO76U5NimwqESko6fHK72lfxJ99STXAa
	nsaDErxQCGItg/C989Dv4gfS/wb57w0J2R2SAqnEDSldwn3QUUiKqroCXEa2hCvxaMwy8XcLA/f
	Ahfs54h23bjs4sg1oOJuY6H2CdeznCv5AjuakHyaYqNbEOTyNL0J61JTH89Bm2lEF3h5oib5pPI
	cNG137iH5R99sS2g==
X-Received: by 2002:a05:7022:ff43:b0:127:874:af0a with SMTP id a92af1059eb24-1270874af69mr3714033c88.5.1770562390862;
        Sun, 08 Feb 2026 06:53:10 -0800 (PST)
Received: from localhost ([72.11.140.113])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm8128977c88.8.2026.02.08.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 06:53:10 -0800 (PST)
From: Troy Mitchell <troymitchell988@gmail.com>
X-Google-Original-From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Feb 2026 22:53:07 +0800
Message-Id: <DG9NZG0N2T3V.3DZ7YPCZAMD36@linux.spacemit.com>
Cc: "Andi Shyti" <andi.shyti@kernel.org>, "Yixun Lan" <dlan@gentoo.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>, "Alex Elder"
 <elder@riscstar.com>
Subject: Re: [PATCH v7 0/2] i2c: spacemit: introduce pio for k1
To: "Aurelien Jarno" <aurelien@aurel32.net>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
 <aYiR0VQXvBJDSQPh@aurel32.net>
In-Reply-To: <aYiR0VQXvBJDSQPh@aurel32.net>

On Sun Feb 8, 2026 at 9:38 PM CST, Aurelien Jarno wrote:
> Hi Troy,
>
> On 2026-02-07 23:08, Troy Mitchell wrote:
>> This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
>> enabling the use of I2C in atomic context.
>>=20
>> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> ---
>> Troy Mitchell (2):
>>       i2c: spacemit: move i2c_xfer_msg()
>>       i2c: spacemit: introduce pio for k1
>>=20
>>  drivers/i2c/busses/i2c-k1.c | 316 +++++++++++++++++++++++++++++++++----=
-------
>>  1 file changed, 236 insertions(+), 80 deletions(-)
>> ---
>> base-commit: 2fe0719258a48c204270366ef574066122e81924
>> change-id: 20260207-b4-k3-i2c-pio-318088c1b3b7
>>=20
>
> Thanks for this new version. This is:
>
> Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Thanks for your tag. I have collected all of your tags in this version.
Apologies for the delay in sending this version.
I hope it hasn't held up your patch queue (p1-reboot)

                                  - Troy
>
> Regards
> Aurelien

