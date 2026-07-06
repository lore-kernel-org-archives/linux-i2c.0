Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1C3B1EC7
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325093; cv=none; b=cCBVC/Xhd+0pCCf57vTa4saRI+rU+V4fxULu7rH8OXXtz8k6DQHLP323UXCwWhg0dwtFaIoBa7BV+l90p8sAMs4ntX2eqxqCdusYTM3MkdrDdWQkSxS+Xa/Xm3wt4PvmIoBAHUllR8cvRSWz9ZoBI9T0tVSfGHWI1Zfs5AZPoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325093; c=relaxed/simple;
	bh=HGqAR7HvfDl63QM6OaBCre4TBwfZYA94Sl3aI4NjFuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmYkQxrhHx0X0UiWLoeC8LaSSEWjVdyIE5PFL2/fQyfLR8o5fanvbvtDK5gODp0K14E67pQPBvxmAE8fG5QZLA/602VeJ8/yJ1di4L5We2N/EaUyeIhN6CQIgIKc3RolZRxiISgLRGMhE5LUtL9TxMMm6sygOi9ClEn12VkePr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P7Gh+7jw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P7Gh+7jw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E33BDC8EC60;
	Mon,  6 Jul 2026 08:04:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D3BE5601A2;
	Mon,  6 Jul 2026 08:04:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBF0711BB9890;
	Mon,  6 Jul 2026 10:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783325074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g9ttxJNYsFOcVksW/hoFLW229x+2pGIBE5GaWTLQVPA=;
	b=P7Gh+7jwdrMXzvFCNNAFBgZ/eYR84ESE89GefqicwV0JSD89yIlLSJKsBNcv+5lvw3BWSz
	bcNiT7xssSzhxU1rPtZyqFOkRCFU1qNv/6FXd4aksDHhtj1ET7XCYYdXoMBLDq4ONSY2R/
	55Gi1a+0lji1fF605X0QJvqeHcktxlO632aVRHB/MKnP49DEqgx+fENn3V3/9eLC2RQQ7i
	60jwDZBxmDQmlJD76k0qDXHwSaddNlR+SvZSnO1PVdlON8plEFnQezChnvy8KxpaEVnsd3
	OzVVoa7gTT4e5Pgu71ckLgD0NQHHnzTsj1jB4tJvaLI40bFrB9i7e42ZoIXIRQ==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jean Delvare <jdelvare@suse.com>,
 Stephen Horvath <s.horvath@outlook.com.au>,
 Brigham Campbell <me@brighamcampbell.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject:
 Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5 release
Date: Mon, 06 Jul 2026 10:04:31 +0200
Message-ID: <_pseq_zFRVG0Y1vmF1rbUA@bootlin.com>
In-Reply-To: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Wolfram,

On Sunday, 5 July 2026 at 20:10:42 CEST, Wolfram Sang wrote:
> We need help, especially with tests, for the next release. To make this
> visible, document the planned items and explain where and how people can
> participate.
>=20
[...]
> +[ ] print I2C_M flags in PRINT_HEADER (maybe Beno=C3=AEt Monin)
> +	Beno=C3=AEt agreed but did not know when he has time. So, if someone el=
se
> +	wants to do it, happy hacking!
> +
I'll try to send a patch for that today.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



