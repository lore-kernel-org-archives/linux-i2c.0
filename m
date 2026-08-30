Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98017DFFA
	for <linux-i2c@vger.kernel.org>; Sun, 30 Aug 2026 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788066656; cv=pass; b=ZTHkcKVM3ZRhec5fkK2LE7bPoM7c2ik9mSTDcI82dXi5sRo0ApVa9l+NI6NdOSTGaW6jLxxinfIcrTXFEuEgGaYkEAn+mXGNqRYQZ0vjSg5+UUEjgLlhQY3WOHFKK7Mujy8jSom/cJxv6jjpHfx1HL6NSocepzXDsbxa+oQsEJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788066656; c=relaxed/simple;
	bh=EcokqOrpwwkJDa3/TmKd74l8l32zk/+gqO5e0HKb86M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpOZYcR++jihVjKakBcfHD1eb202Z0yCadZ+v/HehJzQq0M5CCfoNLHJwGhgYrhuMerhigXHTpk7ognsgdP/Op05AKhdDXWpxQQtMXHkAonaAlzUqD978bqHtIM8w7DRBLeVGRufK1/KPoj+avFq67jhwHRAExr5KkeVDgilKcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaSpdUI/; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaSpdUI/"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so1825190e87.0
        for <linux-i2c@vger.kernel.org>; Sat, 29 Aug 2026 22:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788066653; cv=none;
        d=google.com; s=arc-20260327;
        b=hGV4b7oI18lnfoO/fW+wB4RWUOwBmlF1H5PC4UBEXcMegkaEmyY6HmtJeRg0vYvhqX
         ayCmzfZLaEkdzZ0Z70Z8NJ3RI+12Irj4FvkzTzOaJ53MApKvprIhXbzMJofgBGsOZsdi
         5yRgWMZS+zThwfXt6IDxTilAI2PpsXF8QQXWBmUlq77H0DkouqjCAd8ToKB9sA63gLq+
         1Malt7awgdNlO+S6TYK4YWd9S9iuh4lsZFdl+qrpxTjYLrYWl7tUtNQ1tznqaNCTjgpx
         CB5y+LpPEQXBhKu98wyp8kXZDnkMmV0hJBhPHlbMYMTFwpCKUIxULJCFLaf2+SbMe1hr
         jrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=84JT6cOw8u9kFp+0ao4yoSlNBQ7xKs7udQojtC77JVY=;
        fh=qpcEeWPtsshhLCf4s1yD1AeHJDofJfMnpIxfBzC4q4k=;
        b=G4wLdQKE6IfhY/Jp5ZQiEGYjhv92nfO/OFBgORGIiXFthMQq3P2InikzMokWw1h5MG
         SdQRWfDmL1SF6I2ldqa7Hsxsy8sHYGElHCqmEeEtsUHkxCY2Zw9Xs8D/14UrxRetdWp8
         c8+2RTRBtHlh3N9KPblrZh9i5pBTPi0VkSbtnB660IMUh8sctL4FpDeMHGEH+Ixlwn+V
         X2qlXOy/dbHbdpUyCdjLgbwUuiYVisvZlez9LJtZM/qbxR42aQhrixaK1l8qG/33jzIp
         aE08G++JhVQ/kbj3SXDWFnG6PaA++DDNDE8MzEg5al9ft0HQ3tQQedgKJmGp3KsSAA0r
         KsVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788066653; x=1788671453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=84JT6cOw8u9kFp+0ao4yoSlNBQ7xKs7udQojtC77JVY=;
        b=BaSpdUI/612IHIbRlGnouu4bGj//T5UgGxkrLyxm4e7ACWaPYpruYPO0n5FiLcYzvR
         RFIlbKEOgsj2QtMyGbVOdn3MRaasFYybE6D7h+6T6/9F2Roh5FGv1raXHUYGj5OBype8
         U+vz0ZH0xSW0uB5gtQETamZYhp6O25MWAMHHu9S3g9xS50VmbIhMQH7PeWtfD58jWVcE
         T+WXt7S9uPwUJ3PWnqly7kqbLdrWqB9ohsFwFnbaDcIjHjxMqo6OVT2TV9oPZsKPIVgs
         cFhLsmxSGxnwlEntF3sYXIoD65aDNcHLOqoSOU9fRWzvh2zx9x0GH0FD8bNnHDnKLNpT
         dKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788066653; x=1788671453;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84JT6cOw8u9kFp+0ao4yoSlNBQ7xKs7udQojtC77JVY=;
        b=FyvnlPIUh6tRQxYC/uDQxHrcOixPSIqi/JkES9Ty8alEF47k6hppXIzqMOv8gasXKw
         jywyIXOAB5Pqmhd3pmiHuIjbjEokr5pbYLXH2yMyBHcajam/A7SAQaY8D9K6kc1oNPxs
         /d8P+HLuNFZfncyur1dtmNWTmKXVT0RuCqhF2f0tzvrrUC9l4PNWaYAsNtsTQ/UdfOgV
         3JfFuEF05t+wISuuGJ3jIjEfXkK7V5FKH8a9q7s6AEDkprKWaJ4ac0kf0jWlORuokMx3
         Dk30rBQy2jqbOHewo7X8EIM4ruxICOL38784TElxVrF1QRP/QQ8ZAaKfnLxstIKF6+yY
         bq0Q==
X-Forwarded-Encrypted: i=1; AKwUvBydZoB37o7Km3Fw4HSqjhpVhNZlSVaiT3kF9NdD2+T2BOWZ44FMOqWN9RveG70s81PGA1VcuTWgzH8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6tCvf704LG0ketKuezE507r4AROabnBTXErIlGOPPeYOBQ7sC
	tZ8xKrE+EQA2PGtatPaVqUNQzl3F+q1I3wRtQkMShMIaQhvnrsdtSRr7P1jEt5R5CCfWY2YaDJy
	w1jH8iDsX00r8ilSERR14u5O0YnhaNBg=
X-Gm-Gg: AYBFou3DComjCLVU8rZJyAG5iPKqDlDzun+SFMuzSHrvlPJ6BPiRPo2JfYNQ7hdoEdq
	CouqmpPo3H9evu6anT4kKr3xLiYm/u3Ri1U9BQgjW415Yz9xQxKRSJACMfx9UqGpCQ7CMmIVXYo
	L5Wgxyt+dDpPvmG4hbEqkdl8gCP4oY/xyTTgS6kI0yntkqp6VBoTkSjV8MkWA0carGao3DBdA2K
	j/3qHEvaxRM1du0FhjVi9RyymlKkCquTjw1BWWBHIx0H8ntWhK77j334RxqdKTyYA7wv5LuHr2d
	FGuPK2g8bd0tNrjaMrsyTBXPMPPbsOsgQ4NC3S9td5j9vxo5kIKhxEg2uvGimQFLGJR4fvjo858
	Asx1FEyra9dQ+6Eciagt4uogN3Z4=
X-Received: by 2002:a05:6512:3501:b0:5b4:ef51:8cfa with SMTP id
 2adb3069b0e04-5b5e68b61acmr4943182e87.8.1788066652494; Sat, 29 Aug 2026
 22:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787502619.git.ahmadexp@gmail.com> <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
 <ao0tPhBvK1Er_Vs0@gryt> <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
 <ao_VE0W-FohWqPPt@ashevche-desk.local> <apO31ydKoiqWCEKo@gryt>
In-Reply-To: <apO31ydKoiqWCEKo@gryt>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Sat, 29 Aug 2026 22:10:40 -0700
X-Gm-Features: AcwNN1WMfys-Lv2qkNkQwS1zYM8cqlHImchaOtKCuY4HCELC8S0B3995OEX6SgM
Message-ID: <CAOQiBWN5DgOcJ9Gg7s2GZmpQguJUh121Jn9yUzxxm=D530c8dA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel adapters
To: Peter Rosin <peda@lysator.liu.se>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter, thanks for clarifying.

The check is intentional. Without it, the generic traversal would also
inspect ACPI firmware nodes and could match _DSD child nodes carrying
a "reg" property, while the existing ACPI path below uses
acpi_preset_companion() to associate the adapter by channel address.

I have not established that changing the ACPI lookup behavior is safe,
and that change is not needed for software-node support. With the
check retained, OF and software nodes use the generic lookup, while
ACPI continues to use the existing acpi_preset_companion() path
exclusively.

That said, I will clarify this in the commit message for the next revision.

Regards,
Ahmad


On Sat, Aug 29, 2026 at 9:55=E2=80=AFPM Peter Rosin <peda@lysator.liu.se> w=
rote:
>
> Den Thu, Aug 27, 2026 at 09:11:31AM +0300, skrev Andy Shevchenko:
> > On Wed, Aug 26, 2026 at 08:29:47AM -0700, Ahmad Byagowi wrote:
> > > Hi Peter, Andy,
> > >
> > > Yes, software-node handling is needed for the ptp_ocp use case.
> >
> > That driver is a mess. I'm surprised nobody told to the authors of
> > the respective changes to look at the auxiliary implementation.
> >
> > > ptp_ocp is a PCI driver. It creates its board-specific I2C topology a=
t
> > > runtime with software nodes: the mux, its channel nodes, sensors, and=
 LED
> > > controller. Firmware does not provide ACPI nodes for this topology.
> > >
> > > The existing acpi_preset_companion() path only associates a mux adapt=
er
> > > with an existing ACPI child. It does not associate the adapter with o=
ne of
> > > these dynamically created software-node channel nodes. Without that
> > > association, i2c_get_adapter_by_fwnode() cannot find the channel adap=
ter by
> > > the channel software node, so ptp_ocp cannot instantiate the downstre=
am I2C
> > > devices on the correct channel.
> > >
> > > Does this address the concern, or would you prefer a different way to
> > > represent this dynamically created topology?
> >
> > Wouldn't it be possible to use some kind of DT overlay to have that?
>
> For me, the above is a bit unrelated to this patch series, which is
> about converting i2c-mux from of-only properties to device properties.
> That seems like a change that stands on its own.
>
> I probably wasn't clear enough with my original question, but what I
> wondered about was what regression risk that conversion might have
> for the ACPI case. Specifically, there might be ACPI properties that
> match what the code is now looking for. It seems unlikely that such
> properties are actually deployed, but I know next to nothing about
> ACPI...
>
> TL;DR
>
> My original question should have been: Is it safe to simply remove
> these lines from the patch:
> > +     if (!is_of_node(dev_node) && !is_software_node(dev_node))
> > +             return NULL;
> and let the code trawl all kinds of device properties?
>
> Sorry for the confusion...
>
> Cheers,
> Peter
>
> > > Thanks, Andi, for taking the first patch into i2c/i2c-fixes. I will d=
rop it
> > > from the next revision and rebase the remaining two patches once this
> > > question is resolved.
> >
> > > On Mon, Aug 24, 2026 at 10:50=E2=80=AFPM Peter Rosin <peda@lysator.li=
u.se> wrote:
> > > > Den Sun, Aug 23, 2026 at 09:34:38AM -0700, skrev Ahmad Byagowi:
> > > > > Device Tree channel nodes are associated with the adapters create=
d by
> > > > > i2c-mux, but equivalent software-node descriptions are not.
> > > > >
> > > > > Use generic firmware-node operations for the existing channel loo=
kup and
> > > > > accept either an OF node or a software node. Associate the return=
ed node
> > > > > with the adapter so child I2C devices can be instantiated from
> > > > > software-node properties.
> > > > >
> > > > > Save the adapter firmware node before adapter deletion and releas=
e the
> > > > > reference afterwards, following the lifetime pattern in i2c-atr.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >



--=20
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
