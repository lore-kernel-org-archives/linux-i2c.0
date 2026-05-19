Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EC4657EA;
	Tue, 19 May 2026 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183976; cv=none; b=NUy1xSWUw+GhnHb52rtMPBv/gc57/HwCdUpde2KPpyRA2bjLSyhGcbggZn9zh7HwNj3JVgPF5AKwAaI/lFhsES/SDDkvDde31ubcb79arWKLC5kUMQ5/yX5dN4qaQfcmobzA9chg17lfOubSKAlITP5WLhUbTetXlIRtUjwXzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183976; c=relaxed/simple;
	bh=alnlxJEWfcCNP6agE6eJCFXxzGbsOsuuHQuE44l8pq4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CeSC3gw4z4WM45dgsYegDuzUOWkgPHKH4wADslnlV/NsjMpUJOsSbp53Vy/jdQr1mClDOoPBByGcbKFI9aipzKAN/nEt/Rxq09Uk97DSrJUgMPP3xxFHgPZSP4kNW5k+YqXftZA/BNuVC9WRcwKeHwdFukvLXqeuvnWB7kqMGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YBWK14Zu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klEyFxNZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YBWK14Zu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klEyFxNZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC2817A0148;
	Tue, 19 May 2026 05:46:13 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 05:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779183973;
	 x=1779270373; bh=lwCz8Pd04rjc2RorchdOSNBHTq4t4Q6Yacpc/1GSmio=; b=
	YBWK14ZuTrXgcfu1/M/a99oyPZqNiJdt7ug4ooc6bSAXAdTMmUvSQFQ2FThQak6y
	KdhhY/wDBw40Gq2ddp0wvzqiAS+MEhCf23zEal7Jyb6U9TKNjTVPIk3ABwlijnHy
	60JtjdNrWEMzqpbIb68OC55vewyTtACkROIbkt1/ow50a53aaGNEElGtp/TH9hIi
	24kHxoHzsNKoz/wz6GnWltoJGHX8po28/zlKJ5bckLu4Nzzo9UF5Q4b1gOxtYAYR
	s7io1U8+u60iM8BWibilRHTPptHM2HcCShRlreFlWwFCnLePEcKzdNVoYHSn8tyO
	qoE4ao1r+/BnhjF+nRFxYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779183973; x=
	1779270373; bh=lwCz8Pd04rjc2RorchdOSNBHTq4t4Q6Yacpc/1GSmio=; b=k
	lEyFxNZJir6dWzbTxY183xpa3/0N3eURlkVWmCtWSG0EcoTAVItlJxuzA35gOTvE
	5asoiYGJaBB8Nv3H5ejE+ZtJHLPiJGd56mnyu2otNVUNyjtlpe5dxYN0vWMVpSxa
	7ANXE0Qwx2hq3lb9GeacFyH0BhzZChM4ijrhfz5pktva21cLb5XP/knAa865neH7
	qFWqlxeXt6BzApfUePSgtxNw3Z9hHZoJtxdzNXnZ/EgBodnw4T415BrXoZXC7HqX
	upIQ4eOD6FFrY/qFnxb8U7cjGsltbGjoHtzD0keEFNtOug4s6XBSnOnpUtBqeTq2
	/BOpnnlQEy1n5v0rvsMpw==
X-ME-Sender: <xms:ZDEMalrLUhYk4q7MN18oddGOMHec6bZRpBFGfaevSRxK24DY3BYEHg>
    <xme:ZDEMaidFekK9GkctEiAUtprCF3JlsyjQwmivAV-RjvtF6uYvw03miI8P81txTS1yj
    pj8cwVAY3uuhvvyOc6J4QI07TTVoD9kd7iNjBRfoSlWC6d6IcInMXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkshhhrgihrd
    hguhhpthgrsegrmhgurdgtohhmpdhrtghpthhtohepnhgrvhgvvghnkhhrihhshhhnrgdr
    tghhrghtrhgrughhihesrghmugdrtghomhdprhgtphhtthhopehurdhklhgvihhnvgdqkh
    hovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegrsggurdhmrghsrghl
    khhhihesghhmrghilhdrtghomhdprhgtphhtthhopehnihgthhgvnhesihhstggrshdrrg
    gtrdgtnhdprhgtphhtthhopegsrhhglheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugi
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhu
    shdrnhgvth
X-ME-Proxy: <xmx:ZDEMatZtCaAB-7L7uYoGq3wkI8qC20ecI7nhU0XWIAKg-freidHndA>
    <xmx:ZDEMaoH7vw_OHta7kd16Di2UtLJ6aobTMpj6QCe-YqXG7AFQRLIAQA>
    <xmx:ZDEMaolJF7GNOokMaB_yEg14-mvXLO98rA0jg1kSdC3w9zUwX5z5ZQ>
    <xmx:ZDEMatCsxxtyxjgVyN33Hv_A7pJYKYNybAZjXsiIHppohVZED2ghNA>
    <xmx:ZTEMahghc4FiuCpxig6shVzsc6C7HHlm-4FpZ9eX9yGniwpT_2Fnvvro>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A7CF3182007A; Tue, 19 May 2026 05:46:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACQzdJwokzWs
Date: Tue, 19 May 2026 11:45:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Eric Piel" <eric.piel@tremplin-utc.net>,
 "Naveen Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>,
 "Akshay Gupta" <Akshay.Gupta@amd.com>, "Guenter Roeck" <linux@roeck-us.net>,
 "Abd-Alrhman Masalkhi" <abd.masalkhi@gmail.com>,
 "Chen Ni" <nichen@iscas.ac.cn>, "Kees Cook" <kees@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Message-Id: <e1149cee-3b7c-421c-91ab-fd3fe94f3c0a@app.fastmail.com>
In-Reply-To: <agwvkt_iWF9UUR-t@monoceros>
References: <20260515162734.469327-2-u.kleine-koenig@baylibre.com>
 <CAMRc=MfxgY77TozGqUsWrjsTmBKnZLm0dziAn1JAiTok67RXnw@mail.gmail.com>
 <agwvkt_iWF9UUR-t@monoceros>
Subject: Re: [PATCH v1] misc: Use named initializers for arrays of i2c_device_data
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026, at 11:40, Uwe Kleine-K=C3=B6nig (The Capable Hub) =
wrote:
> On Mon, May 18, 2026 at 09:53:08AM +0200, Bartosz Golaszewski wrote:
>> On Fri, May 15, 2026 at 6:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub)
>> <u.kleine-koenig@baylibre.com> wrote:
>> >  drivers/misc/eeprom/at24.c             |  62 +++++++-------
>>=20
>> This drivers lives under drivers/misc/ but I maintain it separately
>> and send PRs to Wolfram so they go through the i2c tree (historical
>> reasons really and maybe we should move it under drivers/nvmem/?). Can
>> you send this separately?
>
> Done
> (https://lore.kernel.org/linux-i2c/20260519093806.1567914-2-u.kleine-k=
oenig@baylibre.com).
>
> @Arnd + @Greg: Should I split off still more or is a single patch for
> the remainder of drivers/misc fine?

I think a single patch for drivers/misc/ (minus the eeprom ones)
makes most sense here, since it's really the same change across
all drivers. My rule of thumb for my own patches is that if
multiple files have the same change and the same patch
description, they should be a combined patch.

       Arnd
