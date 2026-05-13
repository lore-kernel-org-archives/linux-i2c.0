Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2A407592;
	Wed, 13 May 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675117; cv=none; b=kPHbRxRmpT/PLWbTQWDiTUVFC/39xVHqLxdOFa3IokgSKPIPzJstUjWNiYmnOIlZuDaGX7jBA3xOmQi8OleowmAMhTOvkNn/xbTNZ80OkIxke/O9cFOeOA+fNS88Ei/+Y1KMmfIM/nbpyiShrJ0IitzpWvrEfGZaOSqjBE2381Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675117; c=relaxed/simple;
	bh=8FiaGt8v/47mhEfbyvopFGVJOK9oYI/PuMxj4b9NQ0c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OX+XtCh2RG5BHG+cYiELNylAXT1CcMhKIEKvyPNFdK8jOqulO19I/4rZLapWWlUHcSLDBVMwtfHwBwICRKIVdWNEkfLOakTf3HesMBh+WKG6XW2o/ABWDQl7RWe0QLQRZXnp2kC1oBU0MMjkJlL57gnzGAW7ZbgAlzhHPFiIiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=bUcHMdDl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="bUcHMdDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778675112; x=1779279912;
	i=markus.stockhausen@gmx.de;
	bh=8FiaGt8v/47mhEfbyvopFGVJOK9oYI/PuMxj4b9NQ0c=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bUcHMdDlYLMi+reOqnFkeqgT8P6OjkA6B5pfQ/ym+zgqPYShS3S0IhunUNSYcBNe
	 ZhLmyMx2mi5Y8BBNQOHuOhZLNrs7dJpefBcpCSgkzeqpgIa3qI8yytAdjBsr20F4e
	 UTjOVX46Ctrw4/7NhNQUV/pqPi1JcfNjyNA7lEjf+05T1u51iR7wMzz8U7U8y2a/Q
	 343tLAdcy5WY7eQPZP+INmElrST505bVdKVUoZTh+4Ott+shZu6XU23DnmG3uqwDh
	 LN+TKCCfaZ+9rPmOC5SAdOAfjO68Kq5PIOPSlk72U3d0Q6is/H8PN9to9bY64TzQ+
	 X9pCKftl6hJJ7GCXdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1xFMfC4AeL-014tCU; Wed, 13
 May 2026 14:25:12 +0200
From: <markus.stockhausen@gmx.de>
To: "'Rob Herring'" <robh@kernel.org>,
	"'Bartosz Golaszewski'" <brgl@kernel.org>
Cc: <wsa+renesas@sang-engineering.com>,
	<andi.shyti@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	"'Marek Vasut'" <marek.vasut+renesas@gmail.com>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de> <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com> <20260513121135.GA432696-robh@kernel.org>
In-Reply-To: <20260513121135.GA432696-robh@kernel.org>
Subject: AW: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
Date: Wed, 13 May 2026 14:25:11 +0200
Message-ID: <036001dce2d3$8b65be70$a2313b50$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJOQ41lTjAEFfNc8nTp+ZatC5wHYAIpu+1FArbUHLC1AhmSgA==
Content-Language: de
X-Provags-ID: V03:K1:KykuL++uW186c75fTJGp8MkH1+SuBuqhkTc3eWdbnQC1BvsBGQm
 2jgwBX9Gy/Dto3A94hVjvotBbOOtB6oUYLYHmotkFvXIINbQarf9wu+ZACWEjMVj1zij9T+
 ++ApeZLZPX/Ys6G9CxBif4I/AebAWmc90kAPJL5jcrnByMa5ZoStB/0gd04b/8SQ7/QJqwg
 8MTVD6BlPKFV7BnRbym0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gOoRAy82N8A=;V9uKpwDdhUMvvdEWHiVMbYIordJ
 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
 VP1Wr51eVR8EpnlVf6r2NYlw==

> Von: Rob Herring <robh@kernel.org>=20
> Gesendet: Mittwoch, 13. Mai 2026 14:12
> Betreff: Re: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
> ...
> > > So the implementation manages several classic bitbang buses with
> > > locking/unlocking in the pre_xfer/post_xfer handlers.
> > >
> > > Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> > >
> >=20
> > Hi!
> >=20
> > A couple high-level issues. You'll soon hear from the DT maintainers
> > and they'll ask if the i2c-shared-gpio compatible corresponds with an
> > actual piece of hardware on the board. It does not, so the bindings
> > will be rejected.
>
> Perhaps you missed I've already commented on this. I'm actually fine=20
> with the binding at a high level.
>
> But if we want to model it as N i2c-gpio nodes I'm fine with that as=20
> well.

Thanks for all your feedback on this. If it helps the dts and the end=20
user I can offer to convert the driver into a simple drop-in replacement=
=20
for i2c-gpio. Enhancing the existing i2c-gpio driver is beyond my
current knowledge.

Markus

