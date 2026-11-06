Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982623;
	b=be2rikPmWWjic8UKewTfFx7A1hxDcKI0pB39paXz252T59DSK02Ch0lQnZNEHI0zSGzj
	 3xuyXcnqzvcszHsVl+TKdEi4Nlhxtc97Sln2wPSp06iQK5Z1xl1PvO+b5oqB0VPIzyoBv
	 hNl4EMBNPpSgr9fi3Gi3PbAc9WQNrbo9hzL3+F/q1Hx26q+FPPA8E2nWO+kXyaqYqySci
	 SIzAH9nA+T45CZUA05NdEDU7aY6aFz/HAz49Da9Z1UcdZh8cOU6I4bbio0CLvnUIcPLnp
	 T8r4DR3NPab59DGPjIpstZNv91Hrwwll9K3cG+sc2KUPByz5gYOCVOvAkP5dBEhUCyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
	b=yIP1kC32M+7s+W77e2NaHcGWywGcwX+TUOvqxzX8SR54jcu1dPvvQS7Q96O9uhjcSQYV
	 Tmh8ViKLcM7EANgm/e7IbDxxc0k/6r3X/UgXnKElB/lKadraIV0y2/Jm/Z9oa+P8Lpa+q
	 vmr1vFmEgQ0MzqwYtfNBDxdR6D9ifIB29NRTA45m7UpbF5H0D1LP6EIRWheOtE56Z4J+o
	 opxMEeAl80BHJL3/xKEcDHTFTLYxyTdNPB8TIgZbZJmu8Jkc0dGbd665dTnbYFXmSkFYq
	 nBSEleZCVcdyFklILyawisvD9vVgr9VRQSgei8SOrKnQwxLkmn86IG2hMG8CpHtIN5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLWr6qql;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA395606A32D
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 16:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA395606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLWr6qql
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b305d38bafso7043997b3.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 08:30:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982622; cv=none;
        d=google.com; s=arc-20260327;
        b=Xbz1gFpFJP+HfOCxJkCGVAObODM5Eyq6tFsjEvdLZLm2WgUURQ5EWdWYiTJ67glzTI
         ZbuB6t6vYy61S2ASezgS80nxwv9igZWubyVYSYaR/kuUZbtJ+F2WxWq2OOXeAJLJ4l1q
         PiWJILG87fC5CM76WrsZicsZj18QC5epnESu0nqdsFOv+ml+Nhb/vuxTWbZ0vby+Pdml
         U3p1F7cdQRy9imkGNZFimD2ZlOM9nt+gzWOnn0BNpFWAueuJmaTfcrYIE640Ncc1kpHO
         j29J8ArudJFWoNZkElI6FftZu4LUyfdFewweLf495Ix+hVniXzZQRIFJkSSzrTC7381m
         AIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
        fh=iI6R8geS30yNkyciKMa14QMmXQbWKB5EJf781BG2+qM=;
        b=gPaWL+wKg8v8UbgSeip6MfQDrcDTCjaQPRGy/UQ7w4UrvmiprwOCDr3eBL4EFRMrZI
         +p2vwsYw8zJncL7sTdW9Z0ppIJCr+jBRgx3d3SILFCgCvq6EvqbjLO2CITAN6Qpf+fRg
         24qx0sLWWui6MoUQTEJT8oYbFoMJDp+NlU2K63vzgiyRugTE0zbDClZtrNLrpCI4ptc7
         QrVLn1O6V8c8ERcqhBIMuAWh1qWKJbdLo+GexEpXZ5zp3LkikrxLqXO3zDbUNnUa6wMv
         k02xvviKlh82edrYLDJmhwpUQ9JC2sIQ97xmGn+Fde8KfwDnbi9QvquuSGuhBiTJ8KeG
         /+Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982622; x=1794587422; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
        b=wLWr6qql15sYV7yiDKmkPjELYkTZb/66URjn1f3hxyT0hfMfrTHYj6R9jF4Jg2Z/T4
         JX0m1zI3ekCQKQM5FjcxDA2mIZkzQvOAuT7mctFngOk+DqyjFnBnWOCNocsox+V1XC0s
         YGzT4jWsYWF/m7bzwuHjF6gNzCRxKJN90QvgGaAixCTtvmf/6nMu47piDMfMxMKWvRpe
         Ecv/PmkSSAC5ntPknEXG7I+vIME/9hd+gU2CkNsQJPMF9H6h6PqZ4Ev2dxOWq7LQoCCZ
         ECuDOxENpMvmipGcC4aJfcqe+xwrM61m//apdM/wFpvlOZabhnsXSIYmB6TkdVXgAhrq
         Szow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982622; x=1794587422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FH8WzscKogu5XU+7DFOngcgQrl1MXmTxhCA2KDW4bI8=;
        b=gnq6z87E3zLwxGotpEJ7UEc9yqm6KUpUgIl8sQigBhJrvM2wA85yBok2NdAnIZIFPi
         VBAlOBubzZIwEsBVIDEzTGf4jA+sbko/wFNZ7qJSCdDkAK2IoiIdvydThX1qcYy9q+ak
         BqrfIZLBoxLWfnyLWRHPoe7gZ2lDR1D5XGb1Sgoe1/DDmts3zxAK/aJSbBcFr34gh3KZ
         M6eTmcN85i8rjQpEfjjZSDxrvh/u4IWXTDAgxevzf8038A53JfmWAy2iXAjzN/SOz5H5
         QHiXOs3VQEJVjFhdeTyZDDtBtucyuq/lw8N23sRUSD6TKCPSpYH8ev/juqGVoI+IVHSD
         QSNA==
X-Forwarded-Encrypted: i=1; AL+hErGtpb0Aq3+X24Fo0+pthnG0/0h2TdDlerR/wXYKJgdkvePhlfQ+ML5L6G7wPLex//n35YXTxff4w+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z//HguK0JhWKYpbPTm4i6FkrGaupUQax4J2VpVXL1vhcCn65RGP
	caCz0Zxg37TlkxsvxizN3+RErb+U0Nd9hI+npggC2GYQ3pwFt9AGE6b6Bam2LdCNiN1fvo66dav
	lw1XMeXxB/juTBVTFRAES2AafvKForGg=
X-Gm-Gg: AYBFou3yRKaFMXFz61LfGnnLoZiNKCXLXT/JvMpIiv/iemfH23VxB6DuAsudncsajRK
	IJ50wq6i2JbyDH9YoKitT+x599rspqKZAtJOMlFp7ggOYWyeNAMBjU7lgmxGtul/zMBE2f2XpaM
	bC7eR5SR8hUB/QrDv6/46FlHHZdS8BIbx1V+eiTwul7UKuhGvwVP52HRq6iVax3WMtc51QLac19
	913LxvmzQlZwxi77Eds69iPejf2uJIOT5eEfQP9VOrYw0n/AGC363UU4JHEFUmktiwkksVVKBB5
	ymccHgpcCo9nE6ClFH2kvf1HxUcXWqWIZVLukB0Rasuidj4x4h6wSeeYpbHMDDFYotkNLX2/MgM
	szOAAlqeb7QAW3JkUfnaMxjY/Q6pVGEdJ3hHEE07bIHDwAGhLtZ4W0cHy77HqD61lS5hy+SBuHx
	av9uOQoSthdD8hV/LsRZyNwJ9U1H3+rIlLCfDkG1x+WkpTp43ZVtkMn+GGOmJqfsa9nV6UT74ur
	mQpmSJVxg==
X-Received: by 2002:a05:690c:a006:b0:8ab:3918:33d9 with SMTP id
 00721157ae682-8b341b65b54mr16819607b3.61.1793982621872; Fri, 06 Nov 2026
 08:30:21 -0800 (PST)
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
In-Reply-To: <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 6 Nov 2026 08:30:10 -0800
X-Gm-Features: AclHuK8v0JSVhaJAzidw4U6zc9uGSHU7HDuopjMhviWvbGm_U0W3rhAX7PpRRzM
Message-ID: <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
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

On Thu, 5 Nov 2026 at 13:27, Jarred White
<jarredwhite@linux.microsoft.com> wrote:
>
> > [You don't often get email from sidchintamaneni@gmail.com. Learn why
> > this is important at https://aka.ms/LearnAboutSenderIdentification
> > <https://aka.ms/LearnAboutSenderIdentification> ]
> >
> > Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> > on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> > in acpi_apd.c.
> >
> > Without an explicit MSFT0006 entry, ACPI device matching falls back to
> > its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> > the controller's actual 300 MHz clock.
> >
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
>
> Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
>

Thanks!
Do I have to respin the patch?

> > ---
>  > Cc: Jarred White <jarredwhite@linux.microsoft.com>
>  > Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>
>  >
> >   drivers/acpi/acpi_apd.c                     | 6 ++++++
> >   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> >   2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> > index 9fc667d6776c8..a1baa056931c4 100644
> > --- a/drivers/acpi/acpi_apd.c
> > +++ b/drivers/acpi/acpi_apd.c
> > @@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc = {
> >          .fixed_clk_rate = 200 * HZ_PER_MHZ,
> >   };
> >
> > +static const struct apd_device_desc msft_i2c_desc = {
> > +       .setup = acpi_apd_setup,
> > +       .fixed_clk_rate = 300 * HZ_PER_MHZ,
> > +};
> > +
> >   #endif /* CONFIG_ARM64 */
> >
> >   #endif
> > @@ -272,6 +277,7 @@ static const struct acpi_device_id
> > acpi_apd_device_ids[] = {
> >          { "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
> >          { "LECA0002", APD_ADDR(leca_spi_desc) },
> >          { "LECA0003", APD_ADDR(leca_i2c_desc) },
> > +       { "MSFT0006", APD_ADDR(msft_i2c_desc) },
> >          { "NXP0001", APD_ADDR(nxp_i2c_desc) },
> >   #endif
> >          { }
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/
> > busses/i2c-designware-platdrv.c
> > index 1da6b0314b6a0..f359d38cc63c7 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -280,6 +280,7 @@ static const struct acpi_device_id
> > dw_i2c_acpi_match[] = {
> >          { .id = "INT3433" },
> >          { .id = "INTC10EF" },
> >          { .id = "LECA0003" },
> > +       { .id = "MSFT0006" },
> >          { }
> >   };
> >   MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
> > --
> > 2.45.4
> >
>
