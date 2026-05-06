Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CBB3E92BB
	for <linux-i2c@vger.kernel.org>; Wed,  6 May 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057857; cv=none; b=DXEMTS9JPwPJO1dtFWumSiTGPDqy3StGR2j7rFs08GuJuN4Q2+V+k/zxSFlftIIxhplS+1CMuOAc3BmPH4QMCcDkgnW8qOYz6S+V7BbsJHvtGYD7jNPCWecZkbHus7NBx47MwO34MbvAlN27Ki62QKC2H8kMSZc7axueHLZ6O4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057857; c=relaxed/simple;
	bh=ghKgikf9+FI2uIKUB+DxE37613tP/i8t3PKEeTpoFk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjOVetKF5rH40B61A4xXHa1o/sLHm9JQ4S71k59mkpUfqOaU+l1LhJQCmc2kF+Loi1zvxTRFhGQ7ELPY1U/cTJO0FnC0CAJ0E/ZRsvi8xHj14yAMtbZWJwV6tDLsHlwZlQio90bGm2j9zE1KnYZsMz++sriiGK7egawdoYd/jag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LIz3zfKA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LIz3zfKA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4DF9E4E42C09;
	Wed,  6 May 2026 08:57:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C5FA6053C;
	Wed,  6 May 2026 08:57:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 009E1102F18EA;
	Wed,  6 May 2026 10:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778057844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5azX23DuBfnxlcEFATCyyUTMag7iBvCtncTNyxC9FS4=;
	b=LIz3zfKAiHFEx3s9r4HNm0+csIL4V4gRdb1esYK4Iy/K0aOKqV32F/UEfCXllr8oCFd3oD
	2VBpG2TMMl5qLakMBzb8VuG2uGcWOyJyLOENjLY8SAh219PPbHkiz32J0FRO08brlr/FRA
	+mtbMgoTMHwsoTwCPwuM6+FUAoGxUB0CgYxaS16XgVcooLcZdKDSjjwRuqKOsNauL8Y+QN
	X7XPrpNQxBBrALwzLtX/QsKxPCu2uz4MYjiT0tBAZzevT6+npw/VechDMMc1t2+fw2cMqx
	9BX3rXWkICcVk8CA3Lheh1S+XC2NF1/aX+UxuaV4XCPXIxYorlpTKgDlYZ781g==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: David LaPorte <dalaport@amazon.com>
Cc: andi.shyti@kernel.org, andriy.shevchenko@linux.intel.com,
 bala.senthil@intel.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 dmitry.guzman@mobileye.com, gregory.clement@bootlin.com,
 jarkko.nikula@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 mika.westerberg@linux.intel.com, rostedt@goodmis.org, tamal.saha@intel.com,
 tawfik.bayouk@mobileye.com, theo.lebrun@bootlin.com,
 thomas.petazzoni@bootlin.com, vladimir.kondratiev@mobileye.com,
 wsa@kernel.org, dgj@amazon.com, gunnarku@amazon.com
Subject:
 Re: [PATCH v6 3/3] i2c: designware: Support of controller with
 IC_EMPTYFIFO_HOLD_MASTER disabled
Date: Wed, 06 May 2026 10:57:19 +0200
Message-ID: <4KD0mYZGRSm8xhs1ywPcFA@bootlin.com>
In-Reply-To: <20260505232244.71807-1-dalaport@amazon.com>
References:
 <20260130-i2c-dw-v6-3-08ca1e9ece07@bootlin.com>
 <20260505232244.71807-1-dalaport@amazon.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi David,

On Wednesday, 6 May 2026 at 01:22:42 CEST, David LaPorte wrote:
> Hi all,
>=20
> I don't have Keem Bay hardware, but reviewing this against the existing d=
river I think this hunk may regress the multi-master support added by commi=
t f4e0ba52a89f ("i2c: designware: Do not complete i2c read without RX_FULL =
interrupt"):
>=20
> /* Abort if we detect a STOP in the middle of a read or a write */
> if ((stat & DW_IC_INTR_STOP_DET) &&
>     (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS)))=
 {
>     dev_err(dev->dev, "spurious STOP detected\n");
>     dev->rx_outstanding =3D 0;
>     dev->msg_err =3D -EIO;
> }
>=20
> That commit handles the case where STOP_DET is observed before the final =
RX_FULL. The new check aborts on that intermediate state.
>=20
> The sibling TX-side underrun check in i2c_dw_xfer_msg() is gated on !empt=
yfifo_hold_master; this one isn't. I couldn't find discussion of the intera=
ction in the v1=E2=80=93v6 review history so flagging in case it was an ove=
rsight.
>=20
> A minimal fix matching the TX-side gating:
>=20
> - /* Abort if we detect a STOP in the middle of a read or a write */
> - if ((stat & DW_IC_INTR_STOP_DET) &&
> + /*
> +  * Abort if we detect a STOP in the middle of a read or a write on
> +  * controllers that do not hold SCL on FIFO underrun.
> +  */
> + if (!dev->emptyfifo_hold_master &&
> +     (stat & DW_IC_INTR_STOP_DET) &&
>       (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS)=
)) {
>     dev_err(dev->dev, "spurious STOP detected\n");
>     dev->rx_outstanding =3D 0;
>=20
> Happy to send as a proper patch if that's the right direction, or to be c=
orrected.
>=20
So Keem Bay hardware can get a STOP_DET interrupt while a read is in
progress? If that's the case then yes it is not a spurious STOP and
limiting the check to controllers that don't hold SCL on Tx FIFO underrun
should fix that.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



