Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7864370D55
	for <linux-i2c@vger.kernel.org>; Fri,  8 May 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251411; cv=none; b=T6xNXlNyJ5n0ALyyKnV1PQVUs3GIBD4Q92OLUGMoBjZVoRI9k2/mU667GL5cRBaBmfBZKto3N2PiGRitKTQ3dv4IkwOJL3RujMmRrNeaQllaJD6jxKJuCGHkJhjWe7jbl+9KrxUyNf9TT3iPUHnEMho72YvEkyUIyhO7bO13KPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251411; c=relaxed/simple;
	bh=m2zqdXFwa79tNcTqvYt0qnHlikPK3s6SImyr9JY+OUE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lxu0a9SwjAbLswrrGAq4vGL8d0QDxlRA8iBgGjrpdgFHWQDcJ8JH2ColmCCvfgt6Ak9MIsm279bMHxHeWF3geudEe5/Xu/vpwIDs2pXtt35q6RAm9T+8uzWPjcCKSP+7qRj3djQl8gaa/VeSy6T9/Tkoyh6n3+Kh1KmmIHEbzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=fEkkuwgj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="fEkkuwgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778251404; x=1778856204;
	i=markus.stockhausen@gmx.de;
	bh=m2zqdXFwa79tNcTqvYt0qnHlikPK3s6SImyr9JY+OUE=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fEkkuwgjK0hDLkvoI9RakR3Sx8oknod/E5coYHQlXbaLUG/Dx9AXhZNhp9CMmd3r
	 XJeGNM3rjq7ekI4Mb8X+WN0GG8fP1+lT81Ar0wwszCBkO+tAQ1FSU6kOr5Vrj11mH
	 iVIZo+3p69CpouGwdjeXNVGFIC3LcT7Y+FtzoljIPe6z5pCF/ijsbn0q5rVIOYj1t
	 hqqjOHRbHAmEXe1bDXO+8qrt3sFHuWEnzQ7scqMhK2vx7zDLRSbTdfC7cZhbAJnf+
	 eyjPS2saam9BO6YVmDfAAC7r/41G5O44aVLGfvc9KaD5fxMbjUoMH4l3R47W+4MpU
	 yW1fHWKfN6s32rc7AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1wKWwV0CSF-00AtD8; Fri, 08
 May 2026 16:43:24 +0200
From: <markus.stockhausen@gmx.de>
To: "'Rob Herring'" <robh@kernel.org>
Cc: <andi.shyti@kernel.org>,
	<linux-i2c@vger.kernel.org>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de> <20260507181711.2696783-2-markus.stockhausen@gmx.de> <20260508131830.GA1135235-robh@kernel.org>
In-Reply-To: <20260508131830.GA1135235-robh@kernel.org>
Subject: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Date: Fri, 8 May 2026 16:43:23 +0200
Message-ID: <007a01dcdef9$05ba7140$112f53c0$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIKgUW0k0IN4HI9csbwIs8kp6Kp3wLKDayEAPY4WTC1iuGxAA==
Content-Language: de
X-Provags-ID: V03:K1:dhX3nhhdGItA4N6VjA6i7+LsjZuNlIPwiNaDcn4UPgsf61h92Z3
 s88laJgQ4pUBhmT4tkqEBtS1jsGGVKVXl4MmOkKw5QyqYZ3peuYh5GZMoj8nYkNZBTkFJoW
 da/YrsOu5PNXuy/ut4szq3AnBHHMaSz5z5vQ93exuuQUjIBM1sxgm069LlhLEMCFZWP8QT+
 4tsSHJtyJhmVcK8GhBa1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y6UWDyh+0f8=;8ZCYROJYKrBPi1mZiRkDU0mFSlN
 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

> Von: Rob Herring <robh@kernel.org>=20
> Gesendet: Freitag, 8. Mai 2026 15:19
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
> ...
> This is basically a mux, so you should leverage i2c-mux.yaml. Maybe=20
> there is driver infrastructure you can leverage too.

Thats what I broke my head about the most. From testing and
my little knowledge I came to the conclusion=20

- two native i2c-gpio based busses can not share the same SCL
- so mux infrastructure cannot build on top of that

But maybe some I2C expert can advise.

Will address other feedbacks when direction is clear.

Markus

