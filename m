Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362412EC54C
	for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922275; cv=none; b=LIem/GhPZfrP7TJ+yvFtwMuNh80pTMZmjAukNyzrIwr8G5/lW3nJp7S+7mHMXEG58GJ3xu8A+GHzR5UQ41onO7CIlMLV98TiSpPy3McjPJNTPTeMFIEAaOcv2+aT3Yd34rATl8+5zGitD5DQFWDSxAFGmZVJwhVD578RRFQZYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922275; c=relaxed/simple;
	bh=HETKb5Xmh5FavPrNWu/XlU3RmMqsoKuRtz/o63hcSaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQfeAl/v6z3tPjbOhDnH5Tvj7t0wle7isYOvjJ+cPmRMRxEbnm0nsvbftz+xHQ9oEhis+UNo2/yza/Igy2Ju/uceizy/wzgzwMPbHAsAlVCNdXDk4pzSq0flnYxuekuXeD8vK4+92/jW9YZ12Era4+g8HTtCOIGLDEBXvFk5G3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yxkVPbdE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yxkVPbdE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 85228C214F3;
	Tue, 20 Jan 2026 15:17:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99368606AB;
	Tue, 20 Jan 2026 15:17:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C93A210B6B39A;
	Tue, 20 Jan 2026 16:17:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768922270; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iHaM2GpQ7/0PRVLnbbYcRK10f08U28CfKqezLTrDiTA=;
	b=yxkVPbdE8eEoWwnD2ggu1LZgv8uzbvFLjAxaIjoYcY37lL19hbMYzmRcEQUwM7KT8LPZM2
	NWq/pf2nMwM0wQR3obLRMm2rCSGOYCfLjuanVDVpdBBKdvbKRyVyRn6yD+zJrMzFglAZYi
	MUhxI+xJEFI+wk9Lkj9JSox/E0wPlliabjpgFSPjsAPZ6ExGk1Yyl7L128LO5W9GxCC9yi
	1/5UtclVgl9aH+k5DzHqTym3EIT1fK20oU73QJZjWtt+yKSpnl+bPlOGk8tVKiN4S6ANcJ
	QdRF86kB9AJTEaWQPx/82stQAzgn+oIwKaDFx48gP51Hdu8Pny2sDVX6Yb+oFg==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject:
 Re: [PATCH v5 0/6] i2c: designware: Improve support of multi-messages
 transfer
Date: Tue, 20 Jan 2026 16:17:46 +0100
Message-ID: <27275605.1r3eYUQgxm@benoit.monin>
In-Reply-To: <20260120100129.GH2275908@black.igk.intel.com>
References:
 <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120100129.GH2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

On Tuesday, 20 January 2026 at 11:01:29 CET, Mika Westerberg wrote:
> On Tue, Jan 20, 2026 at 10:28:00AM +0100, Beno=C3=AEt Monin wrote:
[...]
> > Changes in v5:
> > - Rebased on v6.19-rc6 and fully retested on EyeQ6Lplus.
> > - Drop dt-binding patch: already merged upstream in v6.19-rc2.
> > - From Andi Shyti's review:
> >   - __i2c_dw_xfer_one_part() now returns 0 on success instead
> >     of the number of messages transferred.
> >   - Drop inline keyword from i2c_dw_msg_is_valid() declaration.
> > - Link to v4: https://lore.kernel.org/r/20251126-i2c-dw-v4-0-b0654598e7=
c5@bootlin.com
>=20
> Why you dropped my ack?
>=20
Sorry about that! I somehow forgot about it and b4 did not catch it either.
=20
@Andi: Should I resend the series with Mika's acked-by or you handle it on
your side?

Thanks,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



