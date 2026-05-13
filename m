Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A480399880
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692760; cv=none; b=tr/8ScIF0N8wkOT8oj1ed+PCBgdKZcQNP8HS8RMf+kr/oTWiUwMg5eFhmrHdvbA2ZXAIGP13zv3pw/VbM30JKvpXeSLurynHkqjOwfiVuzhJRlYxAMltxjbnrjjz/BBvamQ586Qv0+hrgODv48GKnsFTxUqdsrOElwV0E7BZHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692760; c=relaxed/simple;
	bh=PeP6ANlj0h1udmY2VaBAKpg3G6O/ZWu7D3Jwv3IH0JI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HuwCilB6cwayYp/coytH//uerxDY/xbgCPBy5mF0vySqaYVN+iJ1FXEORs2REWxuCU0SxEE5JtU0Sgtq/vGvoa8KFt2zcHQUSWlBCtgVoiInccVYVWMudkW8UNyt81TDmTk6+2b/nvrr1kl19z5OBGQDsEWx75Dwrs9cR0fVjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=nh2Pz+QQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="nh2Pz+QQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778692750; x=1779297550;
	i=markus.stockhausen@gmx.de;
	bh=PeP6ANlj0h1udmY2VaBAKpg3G6O/ZWu7D3Jwv3IH0JI=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nh2Pz+QQn9sNGVfBt9OCpVFbln1ZpEIRQLuWkDynOpXShurErcdHtOprwJ49E13c
	 UZkwjQwqwGksb7AjUCu2Dxi75J7zm9y6pu6IvEiU4WsjJ5tIM737FkZwDYok0UeVQ
	 /fed7v53476RoEC8bcz+YOLte/m1QV/AQ41qc3GmcoBDE5beh1sr/7tpO7kV+5+Zl
	 UsGH8VajrHSaI2y4axIhMmrRLFYw6P8flq4L33oKyy7CGXV33INNU3aQad8FRFrWv
	 r+X9cqKpXJKF0ggWqIYYX3SMg4/9V2x2h1qt4TyLUc9nn4a2I4Yyuuap+P0h+cSdd
	 obKP61CGVSfl7VLnCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1wWWdz45sQ-001STH; Wed, 13
 May 2026 19:19:10 +0200
From: <markus.stockhausen@gmx.de>
To: "'Rob Herring'" <robh@kernel.org>,
	"'Wolfram Sang'" <wsa+renesas@sang-engineering.com>
Cc: "'Bartosz Golaszewski'" <brgl@kernel.org>,
	<andi.shyti@kernel.org>,
	<linux-i2c@vger.kernel.org>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de> <20260507181711.2696783-2-markus.stockhausen@gmx.de> <20260508131830.GA1135235-robh@kernel.org> <007a01dcdef9$05ba7140$112f53c0$@gmx.de> <af9xGlIWG_OmREzX@shikoro> <CAL_Jsq+RyLno6kojsULC9M-Db+h1N+aoyJZgYs8nXtY4J+zEFw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+RyLno6kojsULC9M-Db+h1N+aoyJZgYs8nXtY4J+zEFw@mail.gmail.com>
Subject: AW: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Date: Wed, 13 May 2026 19:19:09 +0200
Message-ID: <05b601dce2fc$9c82dc50$d58894f0$@gmx.de>
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
Thread-Index: AQIKgUW0k0IN4HI9csbwIs8kp6Kp3wLKDayEAPY4WTACKFuNHgJo4OepAbGCAaO1YNc0gA==
Content-Language: de
X-Provags-ID: V03:K1:55X0b6glViIZIbODcQ4HVet/ZEtq32NVZFk02YcdGWp3FKOOvIE
 s4YYYNKbiL42rgf2y3pnOHz5uECqCc5KIE2dibCavgyMUgotFu0ueAU2RykhaqXk3ESFW7l
 nY/EptzIra0LCVhHh4tbZ8ja5IHwfyeiig2i2owvYwjTCGSzZk+bIX/OJqS4akYthK++rL6
 nIX18D4jDpL4MDy7JNIGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GXFCzoUNQVc=;l9ll0ZdLSQmZQ2lUxuOQDgfNSlJ
 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

> Von: Rob Herring <robh@kernel.org>=20
> Gesendet: Mittwoch, 13. Mai 2026 18:21
> An: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Betreff: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
> > ...
> > I am not sure i2c-mux is the right approach here. Because every SDA =
is=20
> > already wired, there is no need to select/deselect something. It is=20
> > only that SCL is shared, right?
>
> There's no physical select, but it's still only 1 active at any time =
just like a mux.

While working around this challenge my POV is as follows:

- See each SDA/SCL combination as an always hardwired bus=20
- There is no muxing of the bus as a whole.
- It is only a question at what time access is allowed
- Why not expose each bus as simple as possible?

Coming back to my offer about the new I2C bus that only=20
switches from compatible "i2c-gpio" to "i2c-gpio-shared".=20
This should be achievable in the driver as follows:

- add each SDA to the individual bus
- build up a shared SCL list for all buses
- link each bus to the required SCL

That will need no shared gpio features. Managing the list=20
should add ~100 lines and the rest of the driver can be=20
reused/adapted.

Ideas, hints, objections?

Markus


