Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32C481249
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989784; cv=none; b=X8iyvS30BXDlZO3HoyLvFVZAeCKal4ZHkW2b+qkqlTaLvHWUtYF4cJvQlWCYmIK5q4/ZcKiP5wCJ3Hf5ahJEh6Su2GbDg2qsTUfO1cafGIoqc7IXKSkGteTGKJLqIK1ZGp2bBeHchoK5V0v7qS1dhf2yhdJjOqUOQRg0u0oZ11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989784; c=relaxed/simple;
	bh=GLlqd/29zDcuE7sEBvl20tFQBYrgDkzQ9B4Yuu/RXSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPdt1DmL3Kegs6LC05BhnrdkEF5MztFrKjT8Kt+sJZO6FnNdhTvhXWJkB/iHqKYCLyHTPxpbZmE+m5PsS0yNWm/OWcJ4WcgIWbL/6zzcry89K0Vgjmbskc6gLOT/1kjrdpzOF5jBfGWtgGp3Sp/2QZqtw4yWpHVnR3Ls3dl+nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WwJZICBD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WwJZICBD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 72FC54E421CB
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:02:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49B706070A;
	Wed, 21 Jan 2026 10:02:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FA4E119B10FB;
	Wed, 21 Jan 2026 11:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768989771; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GLlqd/29zDcuE7sEBvl20tFQBYrgDkzQ9B4Yuu/RXSo=;
	b=WwJZICBD87/5xMgJd4/kBuE7UIigHU9q72GOYoz4U/jgHd/SiyVPbl9TlMOR2chqcIgFut
	04fVUAUHMiZOKHZwP+mSIYk7RFPyv/gDYmv3Le01VC7Im/0aS2T4O0CGKH+FahSK+QOLr9
	uDfLdTPsALWJhJ0/k7y7OPc8I6F99kEP1hoZPwksyLUQczkMvnQecVjRpejreyXjTVnWps
	F3sQNhwzatlPnJvcFd91qsxrENJQ7LakqFjSeiDygFmD6LJJgn8piCQKXfEs/8DlceIc1W
	iNzBhKgZJVSLzgOg6IZl8hkpbO0/XxypzZ6/HZNCZN4YIiCyUt3wTTaaXE/EnQ==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH i2c-tools v2 0/2] Add support for message modifier flags
Date: Wed, 21 Jan 2026 11:00:56 +0100
Message-ID: <3571298.LZWGnKmheA@benoit.monin>
In-Reply-To: <20260120151536.7de21098@endymion>
References:
 <20251223-msg-flags-v2-0-8d934a4366e2@bootlin.com>
 <20260120151536.7de21098@endymion>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Jean,

On Tuesday, 20 January 2026 at 15:15:36 CET, Jean Delvare wrote:
> Hi Beno=C3=AFt, hi Wolfram,
>=20
> On Tue, 23 Dec 2025 14:22:41 +0100, Beno=C3=AEt Monin wrote:
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
> > multi-message transactions with i2ctransfer, but the other flags can be
> > useful for various test scenarios.
>=20
> Out of curiosity, did you have an actual scenario where you needed to
> do this? Protocol mangling is supposed to be rarely needed and avoided
> as much as possible.
>=20
My only need was to have a way to set the I2C_M_STOP flag, but since I
started modifying i2ctransfer, adding the other flags was not much
additional work.

If you think that some of the flags should not be exposed by i2ctransfer, I
can remove them.

> > The patches use defines that have been present in the kernel since
> > v3.6 released in 2012. If compatibility with older kernel is required,
> > we will need to wrap some of them with #ifndef ... #endif.
> >=20
> > Maybe a minimum kernel version can be documented in the README?
>=20
> Be careful if you do. Kernel versions are a very broad indicator,
> distribution kernel maintainers keep backporting features so an older
> kernel can actually support something when its version suggests it
> wouldn't. A kernel version should always be complemented with the actual
> feature or flag so that users can look it up if needed.
>=20
True. I will go with #ifdef instead, as you and Wolfram proposed. And I will
add a check against the adapter functionalities.

[...]

Thanks for the review!
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



