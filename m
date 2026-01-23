Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53283325715;
	Fri, 23 Jan 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178340; cv=none; b=JJpdssE/Ak3jZB3h1QsqvPwvcm3MED5MKbKnLQcOxuR2cyn5F2I16/vAK4VEeALSjGdwdJVvQvQXM1TAuLvyZFBVq7WVnf42tQ5O8uZ5xLy5qjumTBEojdgoqisio8jShDstV/ctdbLnUZ9CM6BiwfNN2YY1VhA39MkF6lJDlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178340; c=relaxed/simple;
	bh=Irvjef9/AWYaUeiQB1Npfq9HleYHezZV4pOTWj9W1HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SY6IXjNl/LJZJgbKgK2TRfUR8Js9F8Am2QTH733X4xJVOYUVwWEztXarCB6+fYd64C7leGamynvn4yEkP7GZ6KvDpE/T/Yt/Rhgc3Jv2FB/NVy3phLowggMb67uW1EoCg2Y/EjKUPFTA/Bgu5Dw6Cw5cMp0mRCVQhh+JrfdLCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bMz1rXDW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bMz1rXDW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A6BD8C21ABF;
	Fri, 23 Jan 2026 14:25:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 607256070A;
	Fri, 23 Jan 2026 14:25:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E56F119A8547;
	Fri, 23 Jan 2026 15:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769178329; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Irvjef9/AWYaUeiQB1Npfq9HleYHezZV4pOTWj9W1HQ=;
	b=bMz1rXDWB0EDZwAIlBCY4gwkOUfUTQo1UuUvgq5q+5IlHGxlXsDxXiPaeQ9bC/9tjg+52C
	XcXNSzsE9TiVT/nSfy1MGqi3pPI6GuITQDBjWtbPpjOLiO7zsDFj2X4YCA+aAKEsqWG9ou
	SzZSq0EEuvhWMhpIpodoj+zwpyO7Vd85ihQM22HQKzENh/zc5BjvT6XYyumNrvXEMK9wt9
	KPS3G9UTTDb6/kRhdz0I4K/KdcPotcgwrnwuBVa7OVfOO76nEF7yk+Y28s8CoB4xTZVK/H
	em6aewCHy/dJ1dN7kkOjymwPyI87eBeKi2nWHyXAJBR33s3fM1d+65ls2xdB6Q==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 4/6] i2c: designware: Implement I2C_M_STOP support
Date: Fri, 23 Jan 2026 15:25:24 +0100
Message-ID: <7226044.9J7NaK4W3v@benoit.monin>
In-Reply-To: <aXJPljHeRxBXH_Jo@black.igk.intel.com>
References:
 <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120-i2c-dw-v5-4-0e34d6d9455c@bootlin.com>
 <aXJPljHeRxBXH_Jo@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

On Thursday, 22 January 2026 at 17:25:58 CET, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 10:28:04AM +0100, Beno=C3=AEt Monin wrote:
> > Add the support of the I2C_M_STOP flag in i2c_msg by splitting
> > i2c_dw_xfer() in two: __i2c_dw_xfer_one_part() for the core transfer lo=
gic
> > and i2c_dw_xfer() for handling the high-level transaction management.
> >=20
> > In detail __i2c_dw_xfer_one_part() starts a transaction and wait for its
> > completion, either with a STOP on the bus or an error. i2c_dw_xfer()
> > loops over the messages to search for the I2C_M_STOP flag and calls
> > __i2c_dw_xfer_one_part() for each part of the messages up to a STOP or
> > the end of the messages array.
> >=20
> > i2c_dw_xfer() takes care of runtime PM and holds the hardware lock on
> > the bus while calling __i2c_dw_xfer_one_part(), this allows grouping
> > multiple accesses to device that support a STOP in a transaction when
> > done via i2c_dev I2C_RDWR ioctl.
>=20
> Does i2c-tools support this. I.o.w. can you put an example of user space =
call
> to achieve the above?
>=20
I posted a patch series for i2c-tools, adding support for message modifier
flags including I2C_M_STOP to i2ctransfer:
https://lore.kernel.org/all/20251223-msg-flags-v2-0-8d934a4366e2@bootlin.co=
m/

I am working on version 3, following Jean and Wolfram's reviews.

[...]

Thanks for the review!
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



