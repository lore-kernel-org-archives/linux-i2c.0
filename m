Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257638;
	b=KEO9JMaEX2Ab6RcCGfBuiUl98r5U+qW3814/0Wx0llCf137O+3jfvcvJhFNGtO+4HB2Y
	 xnjH+djq+a0mCXg5fX59l0s1N7cb4kbV8jtdyk7WGUWIFDdYZU3Tgiv0NRbfcMabEvVPj
	 lvRucwM35Ls12uh7Mq3R70JBOMlGqGMprXbMkZJNvvzqvSBPaz0Ayx/AFOoCTKfsrt9bv
	 SS9jS/uxpNr9KfULoNdbR5WxDn66BlgsGFQEGOCwupCj4SfIUtA1WhivMH48TXhPTdMX3
	 Fo9wNAg99Yvwr7Bcjnl37owoc47y2NzUW9bQ+tTWzdTEdNhchAUreHayykJ1+ae1Q1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
	b=yMb+5QsuAi58ZRooexYMnqnJs3WtxbCmA234Gsy2CFVM8id6Op9+J4ETzIE5JrqX3/Yu
	 4z1SXTIO0trKFahnfz9tCtJKJqdI+s8uCqoQsXWs8mZEdjuHk7zqwHCT4ijby6P6SvNES
	 Bt7odWrUFm1dSTtxHO+WtnR8X2tXWcfmSfFJ+EAFeTtneeb0nevjUx0EQnZj8BSSdCezY
	 BUj8YPBgv/D8wEdEkAckllJMwGlLDdRemDx/6UAOTsyBeB9dPB3nYs4lopX7ZbBywUusj
	 bhcpOR5PTylLAq61rZnfum2qO1SN/zWX35U/YIYlW1oR32oqQqz8ImtABFEAPDo8lDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfOffgL1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD05606A321
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 20:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD05606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfOffgL1
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso18402327b3.2
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 12:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257637; cv=none;
        d=google.com; s=arc-20260327;
        b=iQ2AvguG7i3kBuAPcNsIvX23BkkxNnTKA75Q22hA88fM9ItfsWDyyKnxtRwD1JqQVW
         nkPYgUlgNIshIW+YnJ8oWewoyckBCELhG+AhgemGS3vz+wMVj38o5I+bF8Vjx9TjbVKx
         TPo6Si3KGzMi9lEdK89N6eDw2cDRYQiNnw2vwLCW8XL5algWLv8/UgBCujXuEQYTNDFL
         RWWYTytpDPUbiAORcyx3aN0ri2tOawad2YIVdb1IK0lM+bPOCGjK5MsXlbDqHt+NO63B
         19eqrScBEPf2rpNFI/uLxkv0Yc3DlTqVaVrELugnQt3bI2N2my32NG6W0nGc8NgVCa5r
         O7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
        fh=yjE2NReDmrG7u2ubJRVEYkptl66kIxIrTZO2orFQo+o=;
        b=fQp1G8ronEw0t0y8rtkCaxTAi6IL1kC7N4h6Ker9Kc1nsrY6BLl3HaF7VMGVm3o39m
         D1UXysFpnTql/73soE/iYuFLIV9Ik07m/lQIGd/cLncASUIBhVgK0Jqjig5TS2YCSCA4
         HgC4Z9VDMnmi0uexbRT7nQNnDG4pNciahatv5YzMhiCxA/+tglgzUiAD+CKXduTEs0Jo
         njek6qC8Okr0jrb7mJ96SJ18nreCSFt7ngX42InE7n3IIrXXn0vgD3Q9YRgcXjOJAJgH
         ccIN1h5VIdUwXEW9KeeeSqS8j308vVUD6dtAZHe7QtWH59TbVDqFLJ8gO1sUsB2umFV3
         tA6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794257637; x=1794862437; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
        b=OfOffgL1e5pS9KApLqMKSOtYp/PiC4nEGAGeABKgi0XaPguyLagXG4iTOIObju11mY
         ROboINMPx18T8yjS+hrOxAcZ1PoOSowoXNRoXA+OAXblcktUcyiJTHd8rK9ki3QFOZVF
         HLcPhfhHUHFtyDCymVL9EXd7xgGfN2NY6SSME7K1lEUir1iBe8Gz8HsuA5Gx6IRihVKZ
         JCC7REJDFMQ/yNTOJ1OwLEeF16uJME3Se+a9A0tLVgaFLbBQDN9Cn2ObQjWvF/sagiO6
         J2jvlkVdlK5SiAY2XBpq4ImK0D5Hz8ApR0zoHw8hZTG3l3r1QdI56yeLarMivwmfYTZ8
         +WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257637; x=1794862437;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jmt38VSybUfRmaDQpT1smyRUpyrHpCkYyLBz6czP0+E=;
        b=jcKNQPfrylMykhpiw20ezLXsIi8o9Y27jra2Ot0Z5VsYFdf+/OERjy3xEIbVoZKylC
         SOXOh/PQC5XLHDnGc08RTN9dHvf9QOpf7iny4B3UXjWbThWaqhvIK5Zpt57wRW9xENzG
         uZ9k88e0AUnnIH67y8cswkWfQywTmNASuUosDMw4fpCio+R9hEQSbI2x6Pkq8PUmTpxR
         ++0risqhmUpr/LeMbimoTFJWact9tLrYzNpNtYiFu9vZS2UOzDUabAwvHDTlvicW1z4t
         zNSrZ/MRqElHFD/6CMCM7OKsvrMag4afdGCA+SGyL/Ij7hxOafsf/lEhr3T/euhEmXD9
         mPGw==
X-Forwarded-Encrypted: i=1; AL+hErHW9IZsYD1DkkoG5KkH4PEiO1xqnAZ8Ctkj6cSriJZV7yS2TtdE3l01s6hHQWRWYZ9s++fJbEjud4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/y54jRhz56G4BId+oJqY7/BIiDQwSBviOOm97OW+Rd7c4dRMtr
	VwdzNI4vWiuqvjXjcJtenRXcuQMMZKwYPzsb4AFhtZmmhtp9+JiIZq1N3mnLo/1wU7C0tVaN/Uu
	Zb7Z1uuG1lEaMABASV3Cm+MLJUHCtR5k=
X-Gm-Gg: AYBFou1AthlLfhKOvmTJQKtogUSxHUAY9mOEX09Nu2wFHiwBpDIVaQsEujli6y0KZ3Y
	pW15MaNlCDBKlwpyKtJzl9kQpVli07o7jwWzI81fCISUunqmIcy+9WfYNfk9otvcNISS+63PvKl
	oS1msSym3nMhvkT/SD84Ukno2A5ZPOiQimpwCJQAjahNsmdbLt+JKK3JUeqZSJyiiXHaWCrQYXT
	OgaWrBIqxvHOE2QQhZw1bofeCVrNNyA6b/G/l4qtEoxeJu1QQ4Ji85QjbNadGlJeh+s9wO00BE4
	hd+mc3mro+YoVysSawbuASgdsPXLj2GAA3CqzjPW9K3EihA7vWK8snw5dDiC87jhxX5o/GJr4mG
	1VHHwPw72W7jL/WFzar1i2YreH+pcR69emfMQ3+d8OG+hosSoVfZ6pS3sR/RMYwH+P6HqBVRdeB
	UTtYzpkzIK61m9dgJ1j8xppPuMQrWDIr3s88ikD21EKb164N7PTl89efPXhj2IWd3yIpAaTpnAH
	qqdjkE=
X-Received: by 2002:a05:690e:1442:b0:67c:c1d:e5ff with SMTP id
 956f58d0204a3-67c56156f8amr601035d50.0.1794257637455; Mon, 09 Nov 2026
 12:53:57 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
 <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
 <CAE5sdEi9iOwEmuhzWZ=O5u30UVCbCerckhggBqEY9qU5jBce4A@mail.gmail.com>
 <avBSrChTZTQL2rNj@shikoro> <avG91GDyffzeuBVg@ashevche-desk.local>
In-Reply-To: <avG91GDyffzeuBVg@ashevche-desk.local>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 9 Nov 2026 12:53:46 -0800
X-Gm-Features: AclHuK-KDMKaM_e9NpAk3xqUpIS_Ve35CQkQb83drMO2sX7vNTmcfNH71KM102c
Message-ID: <CAE5sdEg5YMcJd0nkej92VKWDK5kpCzfyXSf279Ri+k6y9r=qNQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Jarred White <jarredwhite@linux.microsoft.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Allen Pais <apais@microsoft.com>, 
	"rlmenge@gmail.com" <rlmenge@gmail.com>, 
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>, Jeff Kirsher <jeff.kirsher@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 04:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Nov 08, 2026 at 11:45:00AM +0100, Wolfram Sang wrote:
> >
> > > For Cobalt, the firmware exposes the designware input clock frequency
> > > through the ACPI HCLK object.
> > > Is there an existing way to retrieve or configure this clock frequency
> > > through the ACPI tables, rather than hardcoding it in the driver?
> >
> > Calling for Andy here for being the designware + ACPI expert.
>
> We don't have the common way, it's unspecified. However, many drivers and some
> firmwares adopted the "clock-frequency" property. Unfortunately for I2C it means
> the clock of the bus, and not functional clock of the controller. So, I'm
> afraid you will need to have your own custom solution. Also makes sense to look
> what ARM people do in the same situtions (I know that Qualcomm tries hard to
> enable ACPI on laptops, if I was you, I would ask them first).
>

Thanks Andy for the suggestion. Not sure how to reach out to Qualocomm
ppl, I'll figure that out. I'll re-spin the patch for now.

> --
> With Best Regards,
> Andy Shevchenko
>
>
