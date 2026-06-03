Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAA43C077
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479547; cv=pass; b=ZC8ZEeEuuFKdFxaqHRD3b0ZTIyCs3V+7AMvTzEnRGPgKTE+c0+nEjsYP6FRubF5SNqR+Dcp1LsDvUsB4EMYhyaYdnIsHeVeP4VSqfQqkeZO3bsRc0yTLoL77ysE2saldUZUAuddyPMoSzEblokejit+AcZI2CcOxIdHO6CRT7sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479547; c=relaxed/simple;
	bh=///HpxAlcYgLG2wMEcJcVtUxqHyzJ8JV1WqIbjNbQAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQkIVMYdS/lUeh8RM7vGmKEslAhoRQJlJJ9UEADFtfXroRZxdtL0AVBtqpsyDah+IEhLTey3nJcALU458jiP+q3/vpDHIqItNHUGvWlkfbdSvV1gxxtnDLwwUF006xt8SaOzy1MG/UiEIaoFlGcChprJIuDWijkMdV8VY1ICXO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDq+qfe1; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDq+qfe1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68bd167797dso60923a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 03 Jun 2026 02:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780479542; cv=none;
        d=google.com; s=arc-20240605;
        b=BoNgW0yVriwYnnzUrSAF3xKgZ/bUZ1xAYnA5US2lspdLOYQWyk8TId04WXjrlBmaA5
         5q52GsrEFZtiXFpRyR/znm2ekCqY3yyXueZlsLP3eicl625S91Q8tkcHK5EM4Us/UNgK
         tsIAPzqk1wqNBaT9lUZWdUhitncNqV2WycFDMMKUvtEvLd65MrmWOxXpKc+D8kTsqDus
         QBXGf2E6DKqMICfuGjxBw0IP2a3ZHJqZHR8jHKY3juIM5QqhpMwXZ3998Vm7wQc0AFQz
         wQ+Uh5gEn37wYGKQ9JoRP5NK8zu4yWf0JQtI8xQdzdOqULtQwskI7rwLMIZWHQTHtjnx
         5lQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SwXKhIJjZGWqX6uBB2vnznJQiVYEOuhYWUEkVzvu58Y=;
        fh=48L2CceQk4sa0stRIrPDASA0DExQStb6vpMJ5n2NXH8=;
        b=l2o1pgCCm8Fctah0Iuh23gopJKMCJu4kaBC9/ABgmwWc8lUXz7WSgWzbI8JOQPY3Lz
         SSHlBgo8Ewx7yiFtPTauKRoeJfZYgejQavWdN5er0bPohDZl9jgEfuuORkgKkAmIOB3S
         ZJ38tua7DcJxtsKq7CavViaV6EtNM8qX3zTKXj9vzgk5W6J/D8Tce+Cdhlig8GQLVBd8
         0tcVwC+Yk8bsGj9jdAX3hx6y+QIjtUfylOJozh72EkUtYJvMCPABbKqOYxQTFsOzyV/t
         iwJFOTT6CnCFiruLt4JLC0nG2NHhCGBLjJra1IOJue9np4lYnfVu65ebweHNTNNRMDpd
         uv6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780479542; x=1781084342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwXKhIJjZGWqX6uBB2vnznJQiVYEOuhYWUEkVzvu58Y=;
        b=XDq+qfe1NrAPV/3jydH9r/RQyqmiqe4EZNTPzotlDRo8bS+YUYgPpyNU6BVsSxBWHI
         IPqZ5QXjYVWnSm5AfNNxQsmpZI3TVdXIweovZEBgmqvqmM4p+kGBi/rzk/kohxxj2D42
         fIZ6RKBccoXhXmMw/0SBUW6YRH4GqUyqgMpFY83jtNMxZKpQa++D7naO+NnCyMSOYjQZ
         urRu5iTnYr5FiKu4jhk0XJl2yklxuK//FAKbBNE19ctyvF321HQzxvga8ajvcs8tGFQW
         tsl+w1WOoLVhQVPpPYXTNSPA0HgN7rk7Ks9GRVe3IYIfNezSpkC6onwb6pWg91bpEamA
         bBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780479542; x=1781084342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SwXKhIJjZGWqX6uBB2vnznJQiVYEOuhYWUEkVzvu58Y=;
        b=qp8uvdeASVMhSJGTJwmckGIrFSzbbF+gvugzusJCVgsbS+Dwvu6S2XXHO2KuTHwhF+
         84ugK8FqsLkAePb+UUfyB0aNYK/uBfYjNO3btEWxd6wUi45PZSt6XkuQrL5tE9jNaCfV
         4wsOSh+bcTJLsDHVbg8m2rFSUAmOgPxvKW1aJ/LlOKB3nMNd+d4zUpzwM0bKuCVKpWTr
         Qe5o9ZA28gGfEkiDxrfqgQrzCSNLFvCsG6MAVy7gGIbeJfna6+JIEDyNN8XCVSloyq9p
         MguUnkPNksIY4AnxbrbBMB4LpNSFQSfQM8ydMF8U0MReW1VwWnDxuLllkrV1pWBEIE/Q
         sIPg==
X-Gm-Message-State: AOJu0Yw0gN5H0PJdv9WicSOgtyEMuMzgU56Jjm+ev5jBBCyvluD1D/Fc
	9siL20G7Svn5fCaj5pr2etHCSqRFUpBgdVkH4ud9HQ1G+DdTm5BnLbeU+Drh+ZLf3zI8OV58Z7L
	uhEv+0x/UxluoHNtdF1z3gkjsD0TA6kA=
X-Gm-Gg: Acq92OHgciIHBBm7pKp9MQobTyYx/iJBd1whX2pCGWJCX0zayiM+hKtID95gjLVOSmF
	BZeoqhNr1ndva8Yrb2wITJwa8j0n6Pn8ksS6LlO3Wo8fpnoCv5WqyITujGxLGIj231ALackk/H6
	ubGT8aOwWoIR69hbLvPmMGZ/xac1WOBFFgWkoE/lI4zXuzPArwLPCzidCke4VBKVyHVAUsJarRy
	QTqfqyp8+f0xIZlSZt7VvlJxpsIxKD7TKtWqWpqp+Bh+mPbyFh3YZeZPSIBnPQApIAp9PFTsemO
	bCJp82Z+ODYGyG91/9HfKAO/Q7QTl6BexRetsBgawi9zp8kEN+MOtzGB2DAMW3pvKEID4ncJ2Gk
	Y1bpvJyPFizl4UdLQatt1w8AamcPrwyyYskWDNWFOEuRJGjHf9kZkL3H4etdiKJmbR9gx
X-Received: by 2002:a05:6402:1589:b0:68c:3424:af6c with SMTP id
 4fb4d7f45d1cf-68e710f7416mr1164077a12.20.1780479542040; Wed, 03 Jun 2026
 02:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603005455.226882-1-rosenp@gmail.com> <63476872-b3be-4564-a748-74757130c50a@kernel.org>
In-Reply-To: <63476872-b3be-4564-a748-74757130c50a@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 3 Jun 2026 02:38:50 -0700
X-Gm-Features: AVHnY4JOPde6EcbhbVP7kQ6u8j7UMFPXiaRnZA5NqzesPep85f7PtCeO2ye9Qog
Message-ID: <CAKxU2N8UBXMqeOoKOTy20ZL4sK8JNQfuamWP-_nMyxS3EH5oSg@mail.gmail.com>
Subject: Re: [PATCH] i2c: cpm: Use platform_get_irq() to retrieve interrupt
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, 
	Andi Shyti <andi.shyti@kernel.org>, 
	"open list:FREESCALE I2C CPM DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:15=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 03/06/2026 =C3=A0 02:54, Rosen Penev a =C3=A9crit :
> > Replace irq_of_parse_and_map() with platform_get_irq() as recommended
> > for device-managed IRQ lookup. Properly propagate any errors returned
> > from platform_get_irq(). irq_of_parse_and_map() requires
> > ire_dispose_mapping(), which is missing.
>
> irq_of_parse_and_map() and platform_get_irq() look pretty different, can
> you give more details on how one can replace the other ? (I don't mean
> this is wrong, just I don't have enough details).
My understanding is the latter is higher level and doesn't require
mapping. Just a request from the platform_device machinery for an irq
that it already mapped.

It also supports -EPROBE_DEFER. Probably not relevant here but could
be some day.
>
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/i2c/busses/i2c-cpm.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.=
c
> > index 2cb6a233d313..23679c192edc 100644
> > --- a/drivers/i2c/busses/i2c-cpm.c
> > +++ b/drivers/i2c/busses/i2c-cpm.c
> > @@ -434,9 +434,9 @@ static int cpm_i2c_setup(struct cpm_i2c *cpm)
> >
> >       init_waitqueue_head(&cpm->i2c_wait);
> >
> > -     cpm->irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 0);
> > -     if (!cpm->irq)
> > -             return -EINVAL;
> > +     cpm->irq =3D platform_get_irq(ofdev, 0);
> > +     if (cpm->irq < 0)
> > +             return cpm->irq;
> >
> >       /* Install interrupt handler. */
> >       ret =3D request_irq(cpm->irq, cpm_i2c_interrupt, 0, "cpm_i2c",
>
