Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133021;
	b=RssOaL6ExMNfAcie4vh5/ZDjUlj+nselSB0gjwATV0RXohUoNw+LNglj7r1eSTAXBFF4
	 qoqufZORRTnRqD5ZvYJNth08gGalyPEPsNRYnq/kER1mdnJyq4wWJpUJAHgM5Ii9gf9Fe
	 v/P/m7nKImBsJKj/eKe7jIs5p9gdq7i48dOrqjKgB7TRDEJhJMzV4nMnBgi+EYH4x7qN3
	 xuTRIcIhKLyw+tsCV+cvsHwP9VoYSDhNK0Hf2a6ivoUwa0pcSX1o+OECGxBzG1nuTfvD2
	 lDttiCt1FzTd9alWJAiPlYJqeow/mzrsec90WdSe2lrDjQs52DJo7ss/zPqk3obdSRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133021;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UrgRuA4qIN8HYiSqMukKi9v17NzPiBhuFI6MYq6PyEA=;
	b=4kmrCkFfU+DCA0DFberj+aq2ZaXOC46yhqsAyXHvFlUNyDjuynJsR+SZ/0oIlmFrWmAu
	 huN0wYEsNBblE2n5jHVylVe5v76r+48a5WIFI04fBBS5MX3JM3GsFR+m89OI4E30wl5mi
	 jfNpms7OLUSBnk4tWaxTLjAtgDuZ7w/a09m4pbd5a7xzP4Idhh0I/OswqP3ogKXg9b1+L
	 nDvY0URIztlWrQ+XBoBirMzCIrHR2E5AN18Yg4rpvdjB627iiuxl8G0BastP24VgHQhpV
	 dbyC+QPgTV+GHXxBCm/6qmfRt5alObI2fbBnwBI2GYtFTamVySbUVD12/DZ2JKy7xPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=iSLg7Ze4;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41D606A320
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 10:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D41D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=iSLg7Ze4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=UrgR
	uA4qIN8HYiSqMukKi9v17NzPiBhuFI6MYq6PyEA=; b=iSLg7Ze4i8YhUgniD/xU
	PiEdi+qumx6BmJbCyrCDaKqmve1usIpJpojNOJaDxuj666kJmGdsM7OJgswSaNVM
	xEIedPFCRBHqysZZGQvl8wm7R/HRFCc1QqN+T61ICIOMNNbwTJqgvsBT6OvyKdPe
	7q5Zew4GGssjRwnOJK1R1khs4o91zACTkKRbWRhWXNr4Mom6MPVSeCr6VWxML2Xx
	/7iuehdxvj7P0MSX4ek5P/gU70Bmex8ZLAvaXFaz7uvq2VIH/+i0saMg/os80/aZ
	dH/+Af0dvEoEWKgfKAweA8ivsCPbzJr41ffK7mwQS2Hci1gbp9jL8IBdH2ZH8BBJ
	Zg==
Received: (qmail 2808041 invoked from network); 8 Nov 2026 11:16:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 11:16:54 +0100
X-UD-Smtp-Session: l3s3148p1@DHDJJMFfCLVe20rG
Date: Sun, 8 Nov 2026 11:16:48 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] i2c: nomadik: fix several issues in fault handling,
 optimize layout
Message-ID: <avBMEGxmWtANGbZH@shikoro>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>

Hi Dmitry,

> Patches #1..#5 were previously submitted as a part of a patchset that
> introduces detailed fault reporting feature in i2c-nomadik and
> i2c-designware drivers and i2c-core.

It was a good move to seperate these patches from the bigger series. I
trust Linus' review, fixed the minor issues, and applied it to my
for-andi breanch.

Happy hacking,

   Wolfram

