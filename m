Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96215332610
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086857; cv=none; b=oj/buJ2D+zBMAkJlVeZbLxmsCZr2Sl+wiPsDZUyrqMB2XRBOTtfGSZOU/cMZ7AHLBjB6q/iBVAKF8yrW7dfKaW34y+OwXY5qjqqD9H7qlJDIcXqZDpwVm6f0xjtVOijOXhMB8OrMdwADFmhC/rbkbrB9CtIBi+1uscBnFhCbsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086857; c=relaxed/simple;
	bh=4NHSOSyHRDnslI6vpSy5h+xirPhS12RBvplD2Nx+Mt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXrngVc3jk3b2o1Wvyym4sYsu6cL8WDm15uMFYglKhS7e57htvV2SMvwChHgHu2j38aoefSDnni2WaJGe7l68tmwFqtmIhUnVXEQICQC3+n0kvWNmnZAAgbel5CyOWNCYapicDZlvDo2QgEimOViUG23IlL9L8EzOhxoxox7M/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iux2rCpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iux2rCpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4735F1F00893
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780086855;
	bh=4NHSOSyHRDnslI6vpSy5h+xirPhS12RBvplD2Nx+Mt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Iux2rCpvLvH/BUYM++ARtiMUoAGfSbY3Slvh+9iFwrSTkIBmIbrYllRoCYDwTnQo5
	 GKDe/BNObStgTrQIMwrmjdoZga1KWDfWbGr7aaJ9sC0QbNchMFokcunaQAclW55onM
	 e3WcMg9U4NkFovg6zJXY1MFi5snTxR1LmpxxwJX2YN4vHv66RKfIV0hUrEGmwzErxU
	 SjeWZi7AAOtPS+FMM5pNkbyhHoEWbCEY7S1WKhsDTIEuHDbwTKNOGrO3fqTKOmuVIz
	 OPaQBZJNgM+5fTMwUt5MrGsIXr3SjiulCeOzHG3a9oiOQqywOZ0pw+/aNh3QW9dI4H
	 HnHUQLS98i2FQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a887ebb416so17872691e87.2
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 13:34:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy2AOAr7IVCmMvNwlg3t/FEggQDJ7M2fTl8RxQRpN09m8pMw8SS
	trK6B5TqaepIXI1m4iGsBBfv//4RDfM1l4N+KZx4mnm/4hlTApheFqCwbZ4FcJdijeN4E3cfQpc
	r8dOAPLcIMkF9xsz/meipybkxRbYQo3E=
X-Received: by 2002:a05:6512:3b9a:b0:5a8:7029:c5e8 with SMTP id
 2adb3069b0e04-5aa60a26ee3mr463910e87.29.1780086854129; Fri, 29 May 2026
 13:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com> <20260529100838.8896-2-hardikprakash.official@gmail.com>
In-Reply-To: <20260529100838.8896-2-hardikprakash.official@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 29 May 2026 22:34:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLkjjtY-EgWSdU5h7yE6ZMvgTvyjanRNwgqzgO-h=8ij4Q@mail.gmail.com>
X-Gm-Features: AVHnY4JnSx_2QlARRHct3ZSkimmxjsh_tYrrHBo7Qqw4FFWP089sFb_kjEJZWjo
Message-ID: <CAD++jLkjjtY-EgWSdU5h7yE6ZMvgTvyjanRNwgqzgO-h=8ij4Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] Revert "pinctrl-amd: enable IRQ for WACF2200
 touchscreen on Lenovo Yoga 7 14AGP11"
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:09=E2=80=AFPM Hardik Prakash
<hardikprakash.official@gmail.com> wrote:

> This reverts commit 3812a9e84265a5cdd90d29fe8d97a023e91fb945.
>
> The probe ordering fix in the following patch ensures amd_gpio_probe()
> completes before i2c-designware probes AMDI0010:02, allowing the
> existing amd_gpio_irq_enable() flow to work correctly. The manual IRQ
> restoration added by this patch is therefore no longer needed.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221494
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
