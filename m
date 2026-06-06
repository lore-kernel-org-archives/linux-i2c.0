Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C1262FFC
	for <linux-i2c@vger.kernel.org>; Sat,  6 Jun 2026 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780727433; cv=pass; b=ligAeUdIHoTLxyqPemyVN68JEKgBS9f95EIT7iZmShcLBirveCG/d4WMUJXHKHRvNUtYmM1wX0VrEbIjBB5IpNPUX/ZYM1UFVVFdB9TutRbIGLHYVJWoSQosF1NN/cjnZDZ1+YXRvdDlT1fRVrPqgttIHIVAA/JHuf4Eii5weJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780727433; c=relaxed/simple;
	bh=X5eGIKIaAXbMeVaOi/enngMTrc+DGG2Ene5cw0upzEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkQLLMdTTjdeZ6EIcYVdA6B0gINJv5rJd2V9pfYKLPWLmAc/NkRICXvkNVTETx3gkiyEz7ckackIgd+H3xEiH0z4QakUVh2KtlXju1cFLEhLD8lIUNm3X9Kgtcp0rkoWdtEl9Qvcz2Bfw15vQkoj38cNwBICMZAfFQ2ngHCjzaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgqCgDZd; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgqCgDZd"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-660e9ea26b9so2742933d50.3
        for <linux-i2c@vger.kernel.org>; Fri, 05 Jun 2026 23:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780727430; cv=none;
        d=google.com; s=arc-20240605;
        b=WBPVXVMWel+XlSvyO59lAHOcRm94dz6b/srY2S2Ry5ZXgPNN2exBkKBh0+pdy8BmqQ
         Pf6VgESEM+ngXz0Vqd5fLDL1fVdkTDIvlU9fb6g7AOrhVYJ/y2NOpIC4Y4nq1vpAQqZN
         7ZRQbXM7i35eRVEOpTyrZVOp/7M3kfFfVWn7iv928MDKl+eTeZ86QZCRKukWJl++2M4H
         7ye9iQdHtgB6/soC6Vj7CJ06rj9btjubnuIE1gZ4H4ZVQ38/DlM+za/LNStwg+SJbBGE
         J0Oqzd3xAGPsNU6BmIDiW4W3gGY8yixs3FG6NmhJ979NeTXDWHbBqIg83xbCdc6xeob6
         l28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UVijupBHQhJ/W4zWv4Cj+FlQNn4qa4FEf2D0D//0T3Q=;
        fh=1xkiqpfBYDWgnYOpSMv95vWwYAle2nqTfbHA1G+MA1U=;
        b=BRJC08iYtmP5E03g7PDXUhHlnMIM0Yis7g0WykHh7nHhREVwoCmpii64TSpKKzjHJi
         VdxLnlYjzR3dzQ0AkYsWPVjT/cAqauPOpjm+FeLJd/BJncjeg/ZkkqImDAUYyyB8g/bt
         gBjHIZI7KAHA9DSU0Pfk8jgSDsH3ydjQ1HWIE2L2Jd+yTJQYYNH0vyssZuUUwhsw2vZk
         lVJQlDSi6M4UVEfFlu7qPCaiTFHwD6+so+VvSd7+tiuHhqbOBIpyVzRdCYg6ttIWieka
         QWS+tCWGIrRdkWwKrqMKbccCWEnRVYuXMKSavkL5TQqYYKJ4UxcdOdB729kOscj3p6D2
         cJdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780727430; x=1781332230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVijupBHQhJ/W4zWv4Cj+FlQNn4qa4FEf2D0D//0T3Q=;
        b=hgqCgDZdH6FRGaHdHNnPdepxG7tAMzOD+EJFdjMVKR2mxqyXAp5lu3C4guI/U80Xt+
         iGl4vohJJ1QdwGO5f+OEVlSxS+5mxWi0VGD+nrMkYI5YJ48Ue2TtP4d3qccE5ODJIYzR
         lFtnAE5KDAZszfilzZs1J9PVWFoCXC1aX7v9u+F41XR2DrHckuSk1Lx4HfhKdKk0cNMn
         0EfwFNT1c4fdifrHWbnkY57RuKW6zD2aLYfKR6fhbMnqEGDauIC0zJD2aLDJiskEe6hY
         i9W8xmuGW7gcAw5qrztE8JG0H4GjAR09cVnhxEvAZW/iNKNdddNzbEN28D4YNmCKuUX0
         CB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780727430; x=1781332230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVijupBHQhJ/W4zWv4Cj+FlQNn4qa4FEf2D0D//0T3Q=;
        b=VLgHLbqmCGUR6FupIWdExWkgWmOn1uzyEYQK49xV9bLScjGXQAPAC6uIcWE3zNIH4B
         wFhsSezuaQL+KKb1MWrPVNa7rHS7IGtZYgLb0xErAIUNXdo0ijMgxlEV+S6UOXF0oV36
         lf9eLf+GRYuhTiaziN81rIzecIIrNIfnr/rRcz0DLJthjJvAoJeLlz39QjnIyMOs3CJ5
         LlIG9q7KCGyKtZmxQsDdclRJnA9YXcsT/sstj7G1YHsFOfNPV88E0UBCINeu1WOlP/X3
         VEFMD55YBrBatUx83TAZFeJeQ1wb0aIYujjIBk6wOPDrYM7kl3ZR1RuZKxlnhK3K4i0H
         2/vw==
X-Forwarded-Encrypted: i=1; AFNElJ9iE+Kie/qSF2vD6OTE0kExyPfF/R2pultJQdyuUlgJZG6E4ZvKX8RqMunt7IjEnk1hOzy86tdRZ9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbDS41WyR1YLTm1E8XcRGHSzdLWycXKwzaexJrXJYQb4vq+Zq
	DqrOpQ6e3l80QkNVmBvrOds4JR/LFejFyM3t4odbgCSCHlPjIaN0lh5IxlF2YqXcExna0jfIFU5
	1vw95RxmYc0miYz5xTLbcFwUkwUWCITo=
X-Gm-Gg: Acq92OGJ2NXBt8oAKJLTxIhzyhJo17mSY95PpDaMkuMZqG0LqXWg4BLvvBcgDoeIHCB
	zmNHPzo/T2qHu6PTYEjNMqkim+xT4Iv9PPzVJzqIDytEAxP/78teLN2SGqPrf668rk98TP3HYY3
	bI81RWiBW7dBmLwGhveKfMuitOWbGDy8hvb2YBrR+0ZjstLSURcI1daEaZMb+GSPw1peaqAmF0l
	Aq8dy7Otq9r8MPof7iFdOIklQHFfF09vU2rrPIFPkUiUGcIo1kr6eO/2o46Hx+hlZchjRwSw+wH
	9W5EE5Ughjtu/RBWv28=
X-Received: by 2002:a05:690e:144b:b0:660:8e61:1a60 with SMTP id
 956f58d0204a3-661073da64dmr5860503d50.14.1780727429976; Fri, 05 Jun 2026
 23:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505100854.5258-1-chaitanya.msabnis@gmail.com> <20260507192923.GA2429305-robh@kernel.org>
In-Reply-To: <20260507192923.GA2429305-robh@kernel.org>
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Date: Sat, 6 Jun 2026 12:00:19 +0530
X-Gm-Features: AVVi8Cfnh4kQyyE6tnAd7qDVPyvuU5534L8kK9y1BmkNv7zqyOcjeLX3vVPdgMI
Message-ID: <CABjkosH9OT3fQUhzryxnXkZL9EO4sgAEQ7hg2Y42UWrDDLbN4A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: convert axxia i2c to dt-schema
To: Rob Herring <robh@kernel.org>
Cc: andi.shyti@kernel.org, wsa@kernel.org, anders.berg@lsi.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi and Wolfram,
Just a gentle ping on this patch. It received a Reviewed-by tag from
Rob Herring a month ago.
Is there anything else required from my side to get this merged into
the I2C tree?
Thanks,
Chaitanya

On Fri, May 8, 2026 at 12:59=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, May 05, 2026 at 03:38:54PM +0530, Chaitanya Sabnis wrote:
> > Convert the LSI Axxia I2C Controller bindings from legacy text
> > format to modern dt-schema (YAML).
> >
> > During the conversion, the obsolete `device_type =3D "i2c"` property
> > was dropped from the example, as it is deprecated and not utilized
> > by the driver. The `clock-names` property is enforced as required
> > matching the driver probe behavior. The example node address was
> > also updated to a standard 32-bit address.
> >
> > Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> > ---
> >  .../devicetree/bindings/i2c/i2c-axxia.txt     | 30 -----------
> >  .../devicetree/bindings/i2c/lsi,api2c.yaml    | 52 +++++++++++++++++++
> >  2 files changed, 52 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-axxia.txt
> >  create mode 100644 Documentation/devicetree/bindings/i2c/lsi,api2c.yam=
l
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-axxia.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-axxia.txt
> > deleted file mode 100644
> > index 7d53a2b79553..000000000000
> > --- a/Documentation/devicetree/bindings/i2c/i2c-axxia.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -LSI Axxia I2C
> > -
> > -Required properties :
> > -- compatible : Must be "lsi,api2c"
> > -- reg : Offset and length of the register set for the device
> > -- interrupts : the interrupt specifier
> > -- #address-cells : Must be <1>;
> > -- #size-cells : Must be <0>;
> > -- clock-names : Must contain "i2c".
> > -- clocks: Must contain an entry for each name in clock-names. See the =
common
> > -  clock bindings.
> > -
> > -Optional properties :
> > -- clock-frequency : Desired I2C bus clock frequency in Hz. If not spec=
ified,
> > -  the default 100 kHz frequency will be used. As only Normal and Fast =
modes
> > -  are supported, possible values are 100000 and 400000.
> > -
> > -Example :
> > -
> > -i2c@2010084000 {
> > -     compatible =3D "lsi,api2c";
> > -     device_type =3D "i2c";
> > -     #address-cells =3D <1>;
> > -     #size-cells =3D <0>;
> > -     reg =3D <0x20 0x10084000 0x00 0x1000>;
> > -     interrupts =3D <0 19 4>;
> > -     clocks =3D <&clk_per>;
> > -     clock-names =3D "i2c";
> > -     clock-frequency =3D <400000>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/i2c/lsi,api2c.yaml b/Doc=
umentation/devicetree/bindings/i2c/lsi,api2c.yaml
> > new file mode 100644
> > index 000000000000..2d1c3069c3a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/lsi,api2c.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i2c/lsi,api2c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LSI Axxia I2C Controller
> > +
> > +maintainers:
> > +  - Anders Berg <anders.berg@lsi.com>
>
> I don't think lsi.com is valid any more. We'll see if it bounces.
> Otherwise,
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
