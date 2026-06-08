Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284C37B007
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925180; cv=none; b=PUZMzkXK/6ms6YTi+8JpkPnYkdq6Ye5W+ymUZHaxpc4oQAr2xWsJG19ioa2LZxvCKr/lTXi682pwc/qSB3R6mV9AFiw9h+UpB22lKzqDl5f/SxRbWlzImx7nKitHpsjACVkQ7m8tM7klWTbtb315XWD7Vt8i55IOgMKYSYWuNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925180; c=relaxed/simple;
	bh=CyLRRk1uMJIrr/N1v/tfb8NZKpwKikxvmNKhd7bjz9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cafAlAXjRH1ODEoK9qptqTt+KVndulb6CqdtqoM6RrGroZog6ejTSSS92NcjVq4EDin4+sdurZCvtCNpdJYlaVTytCmEqUTyARBxDyqVWH7cEKR/UMkYznJ5byGYTb502H79XOs4V1AQ/PUWMDg7Ye0wJ/TrPygqJnVam7fyjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nOf9qdWN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nOf9qdWN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C0F851A36E3
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 13:26:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 951015FFB7;
	Mon,  8 Jun 2026 13:26:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 688AA106A28E3;
	Mon,  8 Jun 2026 15:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780925176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rXp8JdOrJGVi96179yVQ/7L06x+mE2O3OB7utEHnm1Y=;
	b=nOf9qdWNN+AKAPVyCOgTJ1awZPQ2uwXrM1HXrXGOaSNi/JGIgPkeKaRVZBv0b8p/XumSG4
	5R0M/xqgNM6rJu+Cg8nPD4E4q1OlriMyXjbg22PuRLr0g2CUamFxO9jaESCzN3MCVnKiZo
	g+p3WXPeil1zQBz+zfVTw2CCjOrXVXc6XqFklx6tESWp5vBrsyJG81QcOROzmm4S5NN0rR
	kC2P0hjdVJBm7PUKbuqLk8fVsxyayJKLEuiph0AIY2MK0I0aLW3upL62c6Ja1JkcGYANIB
	TUraiHK0MS0Txe+RznUAzdqhlIuk5xdgIT21IXhvQDBlABc0ncPY18AkGWfcBA==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject:
 Re: [PATCH i2c-tools v3 2/2] i2ctransfer: Add optional message modifier flags
Date: Mon, 08 Jun 2026 15:26:13 +0200
Message-ID: <m8YevGrnTd62S0MZYhSJYw@bootlin.com>
In-Reply-To: <aiaJmtl-n-mNtsDt@shikoro>
References:
 <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
 <oyWrZgMUT2iRI0tfI5ARxw@bootlin.com> <aiaJmtl-n-mNtsDt@shikoro>
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

On Monday, 8 June 2026 at 11:21:30 CEST, Wolfram Sang wrote:
> > @@ -202,6 +202,20 @@ static int add_flag_if_supported(__u16 *flags, uns=
igned long funcs, char arg)
> >                         break;
> >  #endif
> > =20
> > +               case '0':
> > +               case '1':
> > +               case '2':
> > +               case '3':
> > +               case '4':
> > +               case '5':
> > +               case '6':
> > +               case '7':
> > +               case '8':
> > +               case '9':
> > +               case '?':
> > +               case '@':
> > +                       return 0;
> > +
> >                 default:
> >=20
> >=20
> > With this we get out of the flags parsing and the "Missing direction fl=
ag"
> > error message is shown. What's your opinion on this?
>=20
> Basically fine with me, but we need another adaption then because this
> documentation is not precise anymore:
>=20
> + * 0 if the argument is a valid and supported optional flag
>=20
> Doesn't fit anymore because for the above cases, the argument is not
> valid.
>=20
> I think we should return a dedicated value for this 'unexpected' case.
>=20
> Which brings something again to the table I was close to suggesting last
> time already but back then refrained from doing so. Now, it might be
> good after all:
>=20
> It is about not using magic numbers for the return values of that
> function but an enum with descriptive entries. Example:
>=20
> enum supported_flags_retval {
> 	FLAGS_GOT_RW,
> 	FLAGS_GOT_OPTIONAL,
> 	FLAGS_UNEXPECTED,
> 	FLAGS_UNKNOWN,
> };
>=20
> I think this will make life for future hackers quite easier. What do you
> think?
>=20
Good idea! I'll update to patch and resend.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



