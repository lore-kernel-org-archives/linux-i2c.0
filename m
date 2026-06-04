Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80376400E05
	for <linux-i2c@vger.kernel.org>; Thu,  4 Jun 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588825; cv=none; b=p6Wh6+iXQ+T/F7ZO9ia7kgrpPY4KjpmZtusQdvLbBsojbBO2BtWbUC0XAuh+LVfXvtB9vH4or2D8W4ZVxhHK0Sxax72nt93i1IMhUP/X0I9Uef5ygi3GMZs+GsB045L4VqVeMFyEDaCf2VGUgoaHKSt9rrNb9osUg8goQMzXCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588825; c=relaxed/simple;
	bh=qpqvcRSZpCpa6DteDmRzbStmpGjQx4m9TH8aKoyhe9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EO/YDcLkmwjiUAY0AX1t/VjLzcV0KiCSFx7KEZZTm9IliXn1D9OVVrkJXDn+XkrW9Gr7iVTJMyPlI9oJMxuvuG93LQRX/HQguUnCPfCSqQIdG1RqH7l8m3A3bJO4OhXknG7IiMX+Vn+1ptPpiqYbVmQ/6VcBL82Oq9Xehe+C+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=drTjoELP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="drTjoELP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CFB2A4E405FA;
	Thu,  4 Jun 2026 16:00:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4B2F5FED1;
	Thu,  4 Jun 2026 16:00:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51A82106A1C43;
	Thu,  4 Jun 2026 18:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780588819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rYUbEscHk6vv5pXKMfbMSWrq+Phe7Yq5oGedJQiiU4Q=;
	b=drTjoELPONBaIUUmHSczhkx+oZYiq7kHcR5pkLZI8SiS6Gl4sENpP26uGo+AdtuP9Y9W9N
	kn2j2WM4e3akDvYMPvrEhyXb70y86183GRX7uAdd95VOkB27u6R7oS9mW1s8V/YdbFnHsX
	OHNYOwRtQEvXpaRqka1d/v5p0Fkcu8hRy/R4MwvC12qPWg7EfHUtPHDizZacgfDPsdnz3B
	lIuvZxLhDlv/U1wDF+djNoYj51mQcaPjipD19tt48MHYXu8f92/RpkX/s2fZ7UIhX+QYpf
	WRTvZ5ctSPu8IBRnE5G90MW72mwvHoGIfr/9iXImHguY7j9MeNdwfLzD3j30GQ==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject:
 Re: [PATCH i2c-tools v3 2/2] i2ctransfer: Add optional message modifier flags
Date: Thu, 04 Jun 2026 18:00:17 +0200
Message-ID: <oyWrZgMUT2iRI0tfI5ARxw@bootlin.com>
In-Reply-To: <ah_Y0bOyXRajpp8O@ninjato>
References:
 <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
 <20260127-msg-flags-v3-2-e7539945db2b@bootlin.com> <ah_Y0bOyXRajpp8O@ninjato>
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

On Wednesday, 3 June 2026 at 09:33:37 CEST, Wolfram Sang wrote:
[...]
> This error message now only shows up if the 'rw'-flag is missing at the
> end of the commandline:
>=20
> # ./i2ctransfer -y 0 p
> Error: Missing direction flag 'r' or 'w'
> Error: faulty argument is 'p'
>=20
> Otherwise it complains about '@' not being a flag:
>=20
> # ./i2ctransfer -y 0 p@0x1a
> Error: Unsupported flag '@'
> Error: faulty argument is 'p@0x1a'
>=20
> It would be nice if '@' would be recognized as a terminator for the
> flags and would then complain about the missing direction flag, or?

It's true that the error message is imprecise but I wanted to avoid
duplicating the parsing that is done after parsing the flags. I can add
something like the following in the switch case in add_flag_if_supported():


@@ -202,6 +202,20 @@ static int add_flag_if_supported(__u16 *flags, unsigne=
d long funcs, char arg)
                        break;
 #endif
=20
+               case '0':
+               case '1':
+               case '2':
+               case '3':
+               case '4':
+               case '5':
+               case '6':
+               case '7':
+               case '8':
+               case '9':
+               case '?':
+               case '@':
+                       return 0;
+
                default:


With this we get out of the flags parsing and the "Missing direction flag"
error message is shown. What's your opinion on this?

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



