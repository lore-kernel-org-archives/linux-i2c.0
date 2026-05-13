Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D533A63E8;
	Wed, 13 May 2026 05:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650434; cv=none; b=CQ/hLYBbMrEi+5hX5tW/+XJLMRXD1s/jemsCcNERQm0jG0ENmsu1J7cu1LweXJCFt1ePFl3oAAFMDv3y56mJL5U97c/3RA05WWN1PINQ5tWe4xrg4TjxX6qiGH96Y2sF5405FvYVaUjXMUqsoiOrP0nXoWT3ZB+Ryys/UPaHn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650434; c=relaxed/simple;
	bh=x5TkDdbONmZOgAdjv0ntaRUkxgGy5Aaa6erKOQdQyOY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZrPbDMqHxJKJeTA/X29x46w4Op1eHL324/TAIgqW9ce8YsXBiQB8fCi2/D7Zjdsx5M3fQU+Z/cSrN/jarI3gE8OcZGDffMxVjhfI6/M7h8E1EXzrXyQ3zMssEpLcxcs5t94VMa3Z07ZLNJf94RyfCRChc5XRxjKBXKF4Aj2Afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=atCl13yg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="atCl13yg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778650420; x=1779255220;
	i=markus.stockhausen@gmx.de;
	bh=x5TkDdbONmZOgAdjv0ntaRUkxgGy5Aaa6erKOQdQyOY=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=atCl13ygkqSifZE/CLSYS1fs2fiaif/wv70zcE3ozOELKiDU2AI0uKeOsbq5kll9
	 uBtfENjlD9+Tidm2Wy+It8hVl5WQdQFcHfmxeIumZygAom1V1WAQwhAqv/B2gU6/6
	 VSlz2tHaxE/X0VVqmmBlCrgOHqcflSzqmITHOR1X2JlB18DhokrsLG9slBiuFxp+9
	 YDzNcFuiM+XvcynpSDjRaueUF5gSs9vvygOfjzydtcPgV9Qj6Y83rFeM9ereJ/qXk
	 bmvq4PDSer5FeFTyv/Wp8rKf1rBLQx0ectt/ii0H9IoFejbV6iA/qCH8CTcMC+rPB
	 1b+4vbdMq6V2tcVARg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1wSoRt1KO5-009mWo; Wed, 13
 May 2026 07:33:40 +0200
From: <markus.stockhausen@gmx.de>
To: "'Bartosz Golaszewski'" <brgl@kernel.org>
Cc: <wsa+renesas@sang-engineering.com>,
	<andi.shyti@kernel.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	"'Marek Vasut'" <marek.vasut+renesas@gmail.com>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de> <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
In-Reply-To: <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
Subject: AW: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
Date: Wed, 13 May 2026 07:33:40 +0200
Message-ID: <004c01dce29a$0e44e7b0$2aceb710$@gmx.de>
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
Thread-Index: AQJOQ41lTjAEFfNc8nTp+ZatC5wHYAIpu+1FtRdc+zA=
Content-Language: de
X-Provags-ID: V03:K1:CacZtKZo6KCZxAVcRokzXQ3ySSR+MwPBMgmG+rXB6z3jg6fbHaH
 HfSQsHqg9tVqAh54Jt5qchZiRJKAwJnChXGym6JIGe/1+s4PbS7PTk23wv1iNrSrOtHZTnJ
 aWczeCDw6BoIQDVKldY2JhLNWEjEg72+DSdmHQtuepE8c9SEiuxcvHazt6MiPPOB1tv4b2d
 Wa9TdOZXseiDN6h84G7/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GdH69jWV4jU=;r1pHHCpl2lNgUyCEC0iqN0ADW9K
 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
 Vp

> Von: Bartosz Golaszewski <brgl@kernel.org>=20
> Gesendet: Dienstag, 12. Mai 2026 13:00
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
> ...
> Hi!
>
> A couple high-level issues. You'll soon hear from the DT maintainers
> and they'll ask if the i2c-shared-gpio compatible corresponds with an
> actual piece of hardware on the board. It does not, so the bindings
> will be rejected.
>
> A virtual device doing the mediation is fine but it probably needs to
> be an auxiliary device instantiated dynamically from C code.

This whole I2C coding is totally new to me. Can you please
elaborate what this means. Do I need to move over into some
other folder?=20

> It just so happens that at the same time as you submitting this, Marek
> Vasut wants to enable shared write-protect GPIOs for EEPROMs. This
> seems to be a similar situation where the default is to keep the line
> high and drive it low if there's at least one consumer that wants it.
> I will rework the gpio-shared-proxy driver with that logic in mind.
> Would that be enough to address the issue here?

I'm unsure if this helps. From my understanding SCL gets toggled=20
high/low for each transferred bit during an operation. This data block=20
may not be intercepted by other consumers

Markus

