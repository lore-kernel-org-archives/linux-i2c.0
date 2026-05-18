Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F844048BF
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107116; cv=pass; b=b0/eSLBwgKe6VE8JCFa72qOMBYjD5TXjGw8Po2330A5dTG23yc1h8SvE1qCftSiSA3gDlDVTiZesEtGG0xsw/4M2RxsfYj+G6l0Iw4kkpKq2JUNH3TOj5A7dyrrfQKGCwcu8SgxLVmyy8+XWxrH8i7sbb3MBrQyNG5rMVsj40VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107116; c=relaxed/simple;
	bh=0hqzCRIw6eHbGaqGb1/qhmAHcg9W6fExRxkcWr0itBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX5QpG8VY+uOfKYPE6HOd24yUBhRhAgGZXf+EdY7xP11K/XtuD541lw9D8rNA+7iqsWg9OX3a/oDFrGRbPBmIUVICcQiGFVJc+F+oASGG7b0xNWPFahSk2tyCVDSRlnRKGwIdkujL7K3iNE5gXwlukz8dvLqclQxHygg7i3rgHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYyj1y55; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYyj1y55"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso2269802d50.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 05:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107114; cv=none;
        d=google.com; s=arc-20240605;
        b=XplFsNpGrFdspwfqF88eqUUgVtxxZDwkauSlj1cCEqKPtwytd9PWullWV8tttK6aZD
         aaIdOpa8D82o+RYi9UXdoSvDAV8v143/Lm+1Ub3HBaMLzApwvPsJXJ0RDqmgJ9vhdQOv
         zi9xEGJ9xfsXxX+v8dU+jL4+LC1RAmMaitLtDHrTRvMRSkzSeGPNIAwP4X0LRwtUey4r
         YbbV441Dgu06YCfn804g2SxVo32dAC2TEQIptwbMO0jBLXpqq9tcxDgODgYachJ8QpQ/
         uaXFScjMeSeQizygslJS/izI19Czv22xt8khR5zIoIVYJcS4AuocWO7GztIKuhOPwtCI
         zlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0hqzCRIw6eHbGaqGb1/qhmAHcg9W6fExRxkcWr0itBg=;
        fh=v/FXibnCO0wu+TSmjWwk9QsPsverxGuSLgbr5YxQSkQ=;
        b=LOThUl0RGImA0wAQbEUPcS2+nryLM4XmlJ+O9NMXs1NtXLeOGXExGA5cvdU5nN7Q/T
         TQK3oZpBoW7iacyXAS193/A8n5M3n7ZjzsTtYzIF2Ha9pXJVHC4MYeW3MPaEm+X0v04S
         BXOlY3AL6hhnacFSU0EMXyjzGQiWwWtRENhas/uLJGRFjSifZbzpnAMiLW+GtyUdSL1+
         9m2IRXJbt1HhAEEkPWzhB4zOE4YSWcjDL1i4Ci0cKfWe/HQaDAPtZri0gy7Z/quMPca0
         n/dP/Fie79tfua3GFBcjluUzUQ/limy4AsnSKqsv/qh87O6WZsDc5vsHM81B2P7vItEt
         IQYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107114; x=1779711914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hqzCRIw6eHbGaqGb1/qhmAHcg9W6fExRxkcWr0itBg=;
        b=JYyj1y55zWx1Das1Htts6mnj7UweswfFIxetCyA9yi9PDl0K2FW/1LSrXE2L0cfr8R
         bWDc/kuYNGg2VZ/exuI7cExyW97/Nik3Xi70SKL8GVUWo0eDOPHEksxMlaS2nOplnLzn
         GmK6ZPvFeMG6jaenvZnuhzHf/unTSC4smbVZoI5K6WZ3Mbl274wsqtyZ3qpOeh8lVe1W
         3FK9yyroB9/QlAUHK2qG4GA+siOlIX2iOyofLwDfFW4e6QePlNFGe3IGhlOdmodqZWHY
         LL4t5Rr9dkahSAT4OIUSZnYnd84kcwp8pT2SnW/NUzzRfRzx+rInRfkQUc3daseDzVeU
         9orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107114; x=1779711914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hqzCRIw6eHbGaqGb1/qhmAHcg9W6fExRxkcWr0itBg=;
        b=WJLuVbhTJwuAGhyUuVSnGzfKSYj4OhuU7zl3G2YhijnwPugHWGXgonKrsxKANpMfSp
         CzRXH88velY+g5eNcnzZYei6FeO86V8eHEttO597j7XLWYVGvuw1TJlNSJg1J6yPw2HT
         LFUycmCtvqCGinu1yMCYkaD8aapUHI9mm4DCM2x1tE5WeGIvjBneJGGulKbikciIo4v7
         zu6CetH9wperRZc3TlxO3IWetDTWo22hVtYW2GSk2wziO3dYZ83WtGK6hIaU9BvzV2/x
         dW6360CDcG71WwQpyQCksaWVg/JklVWmLas9vHw1lnXZ16NpbhHHnWfy6LlfLxHWmeJl
         S3VQ==
X-Gm-Message-State: AOJu0Yw+mRsKA30vbieTQT2QwHrgAFMLzxYPa7u8IPWYKPFnk2yv56gD
	Y7ZNDaIyMwHc9PU4p0ACeCYhjl03KSnJ/Ch2WKtXC398URabouNaE1L03f+6z9aaO9EKUN8a1Xx
	18eEUCcAl5WvX18/ylEfZwT6zyb4BqraxTg0hME0eZw==
X-Gm-Gg: Acq92OGmQRZs00d13dEJL/9ZvkjbX2oQIDBD2sAKD52KKjbQ/yy2HmBGqe4a3JNaYxj
	FNS+mD7PZqdpK+Uv1pR8i0zljt0cNpxk1SxzPy+cff8zjNkzspSeBKFthKyNgE64p6eqHY2iJjg
	/acp4J5Ia6kxYIgZJMy+XJISRRP2P33wf8RChTPKKDal416XXc0N0x/KnThRGoN1gwRkZcHTCn8
	eoLVRh+8Vp73XCI3hLBPgLtVBt6Qj956wJnspCtzlm7kwdD7wwjAjw7XWn1ngKqwOK3/+/kPhyc
	XFBDlZW+2RRfznb3RpNi0+P2iNaz17MndkcQgdHahGr32LORHxwu7pn8qn2DzCFR2NekE/itd0I
	j2CP+/HQ4mrvy2Vg3yq9emGapQeU1DGb1O8f+Psb5T+WjsZftg+MfjSFS7WNl3aUroKYvpd3kby
	nJSZ/b
X-Received: by 2002:a05:690e:191b:b0:65e:c81:3a6c with SMTP id
 956f58d0204a3-65e226dcb9dmr14933711d50.15.1779107113719; Mon, 18 May 2026
 05:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518071816.26629-1-hardikprakash.official@gmail.com>
 <20260518071816.26629-2-hardikprakash.official@gmail.com> <CAMRc=Me8ieVzXojZ=eNhBPvjjmT5gc6hJXnpC8Bc6WofDbXP4A@mail.gmail.com>
In-Reply-To: <CAMRc=Me8ieVzXojZ=eNhBPvjjmT5gc6hJXnpC8Bc6WofDbXP4A@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Mon, 18 May 2026 17:55:02 +0530
X-Gm-Features: AVHnY4Jzaa6fZJ1A-ABz9gfnbZXIeHp2ygD2-Qv9xk6fes24nlc7tQzjR2wEdcs
Message-ID: <CANTFpSU_Ba1c_R9wbjSSqnc1+_vBMAOKDvD=EVtct8hWU+Dxqw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 16:24, Bartosz Golaszewski wrote:
> The patch looks fine but I too would prefer this to be handled at a
> higher-level. If we know which ACPI devices we're waiting for and what
> the ordering should be - is it possible to somehow setup the devlink
> for the platform devices that will be the children of these ACPI
> devices?
>
> If that can't be done, I'm fine with this as a workaround.

I checked the DSDT and the kernel's ACPI dependency mechanisms. The
DSDT has no _DEP object linking AMDI0010:02 to AMDI0030:00, so there
is nothing for fw_devlink to act on. The GpioInt resource is on the
touchscreen device (TPNL/WACF2200), not on the I2C controller itself.

Setting this up at the ACPI layer would require either a firmware
change to add _DEP, or a DMI quirk in the ACPI scan path to synthesize
the dependency =E2=80=94 which would be equally quirk-based as the current
approach, just in a different driver.

I'll send v5 with your two style fixes applied.

Thanks,
Hardik
