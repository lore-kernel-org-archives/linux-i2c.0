Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794012268;
	b=bpPRpDwZ/l5WGDSiAJ0HubS/aiGyDPt2im0LpVF4c/5KWK6aC7KorqEaSFjHI0gwTKe8
	 UPeQIF5nHUCoLOaNK/tJGDfH+QcfCYTaaS8VyvurA6SJICLzuWM/8h6u3/SmCLyXJIyxn
	 uE/3xG81E44TWnwKybhO80jJ4qbdWbK569a9iV/gmf6Rgccqth7Pf55YorwdLKSbQNes6
	 voPrKOYV0dX4LWop9PGw4Uunx9L1wn6hWPXoH6kBN6Ozi4g9K1rRAqmJo2xc9keuewK5i
	 vteuSo/AkwgFwZ2x3pOxt5lA1tWPdgp4ToT7CQgttpDOs5kclW7PXJD9O7oXjb10pVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
	b=iLEXcLMThGWXjLEpYlcODjECAeUDYQa+z+1SKLCEcPhRv2gH+nAQ3vAsumM4/vffHs0v
	 I/9qP0mj36HiMHKZpdVm9wpaYhU8tm+Htw3rdHbcb5N3rS1DyCat8+litNhy6A2Es3/h2
	 ALXo8C/ZmIRXEpHh+JFYVzVYuRTy3JtapLkc9UkV1b6koCh+/6IyBsm9vxM9c9gYfCTvJ
	 BzvAQ5Qr4JxQCPS4IIPK7Bg/LpRjL0cQ0ST+wYTN341rf7xi8Xc3aZmVDaHyrQDUg49Ku
	 G6q0FsFUdoaltfCfLpnZLeHUcoH1+cLOMW57Gp3HyIw9s334FVXIDf6tGdsLLRnFhXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOiLZodl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE85606A33C
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 00:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE85606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOiLZodl
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b33a08df33so1606737b3.1
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 16:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794012267; cv=none;
        d=google.com; s=arc-20260327;
        b=OcKHEhha9ai6DvPkGjTLnu9/DLdb7mkxfHgeJrxJgHCyxsQkokAF351FKY4bVRXsRC
         QDwXb4SQuTmye9k5QoL3CG3gSa+VVq6ECZgc8JSYu20PerOt9gZ70PMDAHBxJ+4qTi1Q
         3MgGYMscSrMPh+RGvP1hx5eNsxHNnz2wlmSjjhlpQqA/U8l6MD9VShn/g43U2OCd659r
         MFExgPY6WrngTHC03txTnVb6aD0g57YrdQkJ9oOdijDg6xX8QKutazO6F1pop0obdI4k
         bfSUNE6hDGKazJzOrb6956g7Fk/rASEqh5qOGSJq09eJ7k8wqTL1tTr5agYIAPNFSGAA
         OtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
        fh=Zk7fq156g0yzfgntaLIJRz1FHW059N+8xsDBdWbonxY=;
        b=o/BuBUL3zrODL6Wh/xvKPMvlXHVDdIkwVdX7IaU5oH7W0N0gwQZ+M80rQVOg94wjyj
         ckJQtR97UybuDIXZFLpxncBsyxndID+DHvIFoYFxPU3VJFeAZcRmnnMRy9wU8wZ8uBBW
         Dl2juEb+X+1emXmi3A+0kD2uyt5/KXbMXX6+cQg0SLKIoVwpj/ugYYh27sjyBDH+oOy6
         +/+Wb9EBYvZHronqttXRv5eXHJFwmmyKrKrjolAzvxxa6fp1YHR4/lWq4sVS5yT7WOrQ
         F38nQlYZxhel+t7MIFcGH/9oKJBMnLw/d200LgnTdZ3oYX1wfKb8uLe7okkf8qRU8cH0
         rN7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794012267; x=1794617067; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
        b=nOiLZodl15ocN+6iPF96n7YgQF16GvHtJCdXQpeUJ+at04+nc5dH5YSLMve7zunCNR
         ySvKXv/yTNJ/9IhuisdrAm5RXeLq9yGCKc7NLECfVd2bq1U+YFjONLwTsHJMM/Vx76AM
         /9J/fEnHkLMoBF54qQGcaub3pxzcWGNQm+hDwtl0syhIO1zDwDXoX4QI63NtWabBixMb
         gwn1yD+iwB/4y9RUkLUBI+YFkzrdo/CVm/VMdXwicheAWG88N4ZPVXzLrZlPr/tM9Bw/
         IVTu5LFLgYh1uEbsdyrFi5FA7gJkpmfWL9/TWxlX06RjuVl8a19PwWiLWkGo4cXBbr+b
         89dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012267; x=1794617067;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9eiigW6hOkRbk1j+4tKF/Fi6rPLvkQU7Pgh902ZJH6g=;
        b=fJAPMgRdJXxtZBAMAVx8KQA5bzNGz8Da3pxsnn3HFQlSKE1t1XfdP976ul7+lz90Mq
         MXKXpkT5sn8dG+Lj4VyvyMT56nVR9b9tO8euAWCCmhMxe+7nf2xJhTyFMzqgbbAyT33J
         W8Gncur4Kz2VxyVC6rqG9jE2SObccPIyEr4wKA7Iy2pzyfqb5Ij1RYaT7Kov/3Hz1g1m
         aof7SUtqAjKsqE8i+cV4MvsvBlGquHkIwlLfzeUuKMQzq0k+WUeRVQcnBagTtLEHInKq
         wdHgUCSDGJvGnEfGb5Ca5Q1aLVIWqSVQWiVY0n/xAHeXH/ciCxKnm5IFJF4rG1qwORnm
         222Q==
X-Forwarded-Encrypted: i=1; AL+hErG2tFJeqwg/t3hLQ8eVbS1bfvExJot/Ab75JvpP5M2vFo4fS3JHN7gaVcrn3J2jOytS/mP0aLRF7GY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/n6BcN4qCMBbqxFrSONiuDvhbsC/IVD2cXwkA9BJhRoHHnkdGu
	jseQgrLW9NgDDeABxsex9gYu0dU3dF/ZyPnMdsn1DWg1Ael2od1YMqQ/mNeUvCD+Lhy1t5zuLe0
	GjKa4KeY+5G8HPS55e7kRPwvsZlFNpiM=
X-Gm-Gg: AYBFou2uhb4fD9jNWyjL7KRwVcdmKRpZ86pV8j+XNoAeckhtxc9L4vWsXUJrMhBtkcr
	jS0FvnRh3kAOIigewj0X9R8RhlnupCnL54KVAz4O37xzVe1hKjxIvMLQ4RbL6u5CAzGfAvy167n
	BQjh6U+utYsuSed9fzsKBwykaxa+t6Lx/mmF6inEJ7db+knI/AxYzwI8i6ZJ3OM7fKV1NU0z+yl
	OOx+uAAU6kW6hxOjhbXAPO1u8s2hDbPzmX+Xu2envreTTIXMKyzXVrOlT0iJUFJ15Ewk3mjZGOt
	lW0Wpo0d61+utKoIq0GOZSlLB5y07KjgkNVYRLCprgwO8OvoynhBK8K7vgDDBEvkYe5Bu2K9mDe
	PYUMVAC0gdXLaUU+XFe0UhKwS3MME8c/we1sq9cObbkhzEyTNNGJ9hU5CU38dJOdZPE5FCoPUkd
	KS/5qJZGaZK5GEgXdNOWrsum8p+HqjfOj5vSs00WIiNqo4EgqbPLhWJ3NcaEXv2P/xWDxi9K9KZ
	CzqBUcPWw==
X-Received: by 2002:a05:690c:e184:20b0:8b3:310:244a with SMTP id
 00721157ae682-8b3566382bemr2930967b3.9.1794012266766; Fri, 06 Nov 2026
 16:44:26 -0800 (PST)
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
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com> <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
In-Reply-To: <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 6 Nov 2026 16:44:16 -0800
X-Gm-Features: AclHuK9IwxmZ3zJg_UWR4NgkA_z56Ff8mEcKQ6deQjlglJnLrk3UFQi4VN7saZA
Message-ID: <CAE5sdEi9iOwEmuhzWZ=O5u30UVCbCerckhggBqEY9qU5jBce4A@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
To: Jarred White <jarredwhite@linux.microsoft.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Allen Pais <apais@microsoft.com>, 
	"rlmenge@gmail.com" <rlmenge@gmail.com>, 
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>, Jeff Kirsher <jeff.kirsher@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 08:30, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Thu, 5 Nov 2026 at 13:27, Jarred White
> <jarredwhite@linux.microsoft.com> wrote:
> >
> > > [You don't often get email from sidchintamaneni@gmail.com. Learn why
> > > this is important at https://aka.ms/LearnAboutSenderIdentification
> > > <https://aka.ms/LearnAboutSenderIdentification> ]
> > >
> > > Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> > > on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> > > in acpi_apd.c.
> > >
> > > Without an explicit MSFT0006 entry, ACPI device matching falls back to
> > > its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> > > the controller's actual 300 MHz clock.
> > >
> > > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> >
> > Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
> >
>
> Thanks!
> Do I have to respin the patch?
>
> > > ---
> >  > Cc: Jarred White <jarredwhite@linux.microsoft.com>
> >  > Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>
> >  >
> > >   drivers/acpi/acpi_apd.c                     | 6 ++++++
> > >   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> > >   2 files changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> > > index 9fc667d6776c8..a1baa056931c4 100644
> > > --- a/drivers/acpi/acpi_apd.c
> > > +++ b/drivers/acpi/acpi_apd.c
> > > @@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
> > >          .fixed_clk_rate = 200 * HZ_PER_MHZ,
> > >   };
> > >
> > > +static const struct apd_device_desc msft_i2c_desc = {
> > > +       .setup = acpi_apd_setup,
> > > +       .fixed_clk_rate = 300 * HZ_PER_MHZ,
> > > +};
> > > +
> > >   #endif /* CONFIG_ARM64 */
> > >
> > >   #endif
> > > @@ -272,6 +277,7 @@ static const struct acpi_device_id
> > > acpi_apd_device_ids[] = {
> > >          { "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
> > >          { "LECA0002", APD_ADDR(leca_spi_desc) },
> > >          { "LECA0003", APD_ADDR(leca_i2c_desc) },
> > > +       { "MSFT0006", APD_ADDR(msft_i2c_desc) },
> > >          { "NXP0001", APD_ADDR(nxp_i2c_desc) },
> > >   #endif
> > >          { }
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/
> > > busses/i2c-designware-platdrv.c
> > > index 1da6b0314b6a0..f359d38cc63c7 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -280,6 +280,7 @@ static const struct acpi_device_id
> > > dw_i2c_acpi_match[] = {
> > >          { .id = "INT3433" },
> > >          { .id = "INTC10EF" },
> > >          { .id = "LECA0003" },
> > > +       { .id = "MSFT0006" },
> > >          { }
> > >   };
> > >   MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
> > > --
> > > 2.45.4
> > >
> >

Andy,

For Cobalt, the firmware exposes the designware input clock frequency
through the ACPI HCLK object.
Is there an existing way to retrieve or configure this clock frequency
through the ACPI tables, rather than hardcoding it in the driver?
Although the frequency is currently constant, it could change in
future hardware revisions that use the same ACPI HID. Would it make
sense to retrieve the frequency from firmware instead of relying on a
fixed value?
