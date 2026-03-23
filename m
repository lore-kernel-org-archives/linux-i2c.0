Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345A386446
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257133; cv=none; b=jm4hYlZjAG9Bn9gqFjGfO9vO6h625mgk4Yihcun+bU8ruCFYMiasLTZAtdzT1QD87v0cBhc3F3A2hGuxJGd0I6Qa79XiDBgUWjyqFa6k4iAFlk2zwZsyJvlQzOYysgNHQ6s4lGx2mvREhVMajYLMYAczGpTdmTurCQ8l85RImN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257133; c=relaxed/simple;
	bh=kAQO86RpjVOm3K24aQ/Yi1xYhb/6UGmkPz1fVqTvCzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW+rdi4a6PjJtrsULm6dx/ist9OCiw3sMqNB1eigO0w9jrjfY+PI8AoyKEyBbGQ9u/h/viatvFpMsqS5bj1RF4pRUEfki67erGRpS2E/dKeU9h8PORDuk4EQml8DDlC40Iuhyq6CY6CPUPo2fU3+Zsa2P0XYYthmQ2ydwjz5aXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tiZggNI5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tiZggNI5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F4070C55061
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 09:12:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B7D05FEF6;
	Mon, 23 Mar 2026 09:12:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90A4710371305;
	Mon, 23 Mar 2026 10:12:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774257122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sRAjKwvTk6VGCHDSePOPRSrQbusZAjISvAefHVBk3/0=;
	b=tiZggNI5/mwYuU67FFP4ABsWDMzB8ewwq6opuLTT1QphrusvASHjhL6vmBKr739ujEoFpp
	sqSralIroHyrgUCTl92uDWfXS8qhTidzbMpXomnYyIPGMr81yWpu8zyZK24k8cHR0AMzK3
	klJS0TLRn0Eu5DMi08o8RW5Czrr3Req22cSEa1nI7Nr/T504NT3gQVox7fS5aemab6kb1q
	vcWxwsdt5qNXS0XJ7LzecwqY7JCcFKRzInJjmkO0zLludGvQuKzoBSLRQtkxDCY3LzifQF
	PV+Ehx1ZIdbpGn22FlT6Re3y/UCOprLbKscfadpYnFLIsa3AklPj8TPHB4L+ag==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v3 0/2] Add support for message modifier flags
Date: Mon, 23 Mar 2026 10:12:00 +0100
Message-ID: <5031224.OV4Wx5bFTl@benoit.monin>
In-Reply-To: <20260217131348.007dde93@endymion>
References:
 <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
 <20260217131348.007dde93@endymion>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hello Wolfram,

On Tuesday, 17 February 2026 at 13:13:48 CET, Jean Delvare wrote:
> Hi Beno=C3=AEt,
>=20
> On Tue, 27 Jan 2026 10:25:56 +0100, Beno=C3=AEt Monin wrote:
> > I2C messages can be modified with a set of flags covered by the protocol
> > mangling and the skip repeated start functionalities. This series add
> > support for such flags to i2cdetect and i2ctransfer.
> >=20
> > The first patch shows the support of protocol mangling and repeated
> > start skipping in the output of 'i2cdetect -F'.
> >=20
> > The second patch adds the parsing of optional flags to i2ctransfer
> > message description. Those command-line flags then set the i2c message
> > flags alongside the read/write flag.
> >=20
> > I wrote these changes to test the insertion of I2C_M_STOP flag in
> > multi-message transactions with i2ctransfer, but the other flags may be
> > useful for various test scenarios.=20
> >=20
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> > ---
> > Changes in v3:
> > - Use ifdefs to check that the flags and functionalities are known
> >   at compile-time.
> > - Check that the adapter supports the requested flags before using them
> >   in i2ctransfer.
> > - Add a warning in i2ctransfer man page about the risk of using these
> >   flags.
> > - Link to v2: https://lore.kernel.org/r/20251223-msg-flags-v2-0-8d934a4=
366e2@bootlin.com
> >=20
> > Changes in v2:
> > - Document the flags in i2ctransfer.8 man page.
> > - Link to v1: https://lore.kernel.org/r/20251128-msg-flags-v1-0-6353f26=
fa6bc@bootlin.com
> >=20
> > ---
> > Beno=C3=AEt Monin (2):
> >       i2cdetect: Display mangling and nostart support
> >       i2ctransfer: Add optional message modifier flags
> >=20
> >  tools/i2cdetect.c   |   8 ++++
> >  tools/i2ctransfer.8 |  28 ++++++++++++-
> >  tools/i2ctransfer.c | 119 ++++++++++++++++++++++++++++++++++++++++++++=
++------
> >  3 files changed, 141 insertions(+), 14 deletions(-)
>=20
> Both patches look very good to me. I was able to test the i2cdetect
> patch and did not find any issue. I can't easily test the i2ctransfer
> patch though.
>=20
> Wolfram, can you please give some basic testing to the i2ctransfer
> patch? Not necessarily with the mangling flags, but at least test that
> the changes do not introduce any regression for your own use cases?
>=20
> Thanks,
>=20
Did you have a chance to test the patches?

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



