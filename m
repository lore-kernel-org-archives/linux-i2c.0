Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1F280CE5
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514428; cv=pass; b=of2U5Clochf/FuZUBx6cKBqDU3u7+yfZAILE2Vr8nPyyK/VZbvhNI3N4JqRXHR+ISpr1Pax57TFJbvp48bonEq6K6q2zxf7ek689L21gqI+hP8QJs8BU+GShs6Pa5hE7V60nDIbAW5UEMF3Klrt9KgFPIuM1B4oghrTgUlT8e+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514428; c=relaxed/simple;
	bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISJdBt0QG3BTYij9rjoPACdO3Cc6ZKe2aqVz1QWwFGRF1A817m9vWw9bIYDOM6Tp3tUuoOlKbVsIBlVZoaQMgiR9D3Zocn2CHSH37LWoYbIrRRdKBMQihcoU36bPHDVqNKKDUCjAR1BKxGvaCw6R63aTom9jeS5YNeC+AReUIYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sag5U6OH; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sag5U6OH"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39db07589caso52414481fa.2
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 19:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784514425; cv=none;
        d=google.com; s=arc-20260327;
        b=ITIMYm81gGSMJLCNWd714BAuNxm72nrjEIelQrpsCcxRVjYb/lfnQ/tsfXS/zdpcvC
         /pXion5HcYH0H4SI4NoS9sr2WL3pd10Wdh1qpRP/F64EH8BKVcfUp4EqKBI/GpXzpFGr
         9PmVZkUNh6H/3dUh28hpwpwGhUGBQX1iE2RHbTj/YvTq331DUBkFXMkYROmgfmH2qJ3c
         tmPJi8edMWp7gIX50csDYLNfBQ0tcLX8qKLb9niLGsRe3t+mxmZH/ZJVIrVvIBK3Yyrk
         tQOPVPxQ4kjiE3MS14pFiGXnXCLpRul6WryDXbPeSLlGnuK9mWuDMgYC5vMBw4R6k3av
         1ifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
        fh=D0SbZmCZ5a4bS+sTrugEowyY+IMszgyZwR1JHZ516a0=;
        b=FW5nBDFcljjSHHahpoOj0ugLOepXV1IXIQRHMkNkUZvEZwqYtaqmUvYH7pi8ltQasi
         GRnOA/Dhr998sAtyscxP5aXIqrxzm6CLSS3kNmkXz6skyTSq2k/BjVkLuqsxGstVi4rv
         vcstQX7x5Vq0/kM3dWrPGP3uq+CaIhn0VV3GJkfLprUMmXxln4t3UZVSP09ZpgdSS7xv
         bthGeGTWOI4MF1UWtdxbExFR/52iPi7IeczRKu3OWzqCVFq9wdjcp+n1z1Nx2Cz57naU
         lEU8fpTxMJV88pJlbBBORYz5QmRnN8h2wuLOtiu8spajwoDn/KFNmZar1XM5cxkkMWod
         YCZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784514425; x=1785119225; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
        b=sag5U6OH4q0P0q5ooSAcQc6LPEyYvrOn09iZrhEQtS9NnZQqKFeDdHy5XHREGFmnHv
         6Pg8CPBQVj3mlDqBfuROOKxiPMvpWXMv9mxKqp1TdDkGQCqI80zEX6CIT6hNKcdEQtcK
         oqlZcDYCZT3jkKDsmbv0J/PmVqrrNaBh9rUb+qi/kgeUGwnMgJ4sQVgUj0ABH4L1AyfU
         gkz6RbihZ0vPKOzTCkZFdbVUwtVpH/WDeoT9WkiCHqG9qEQOyD0P9y95ZaR1QiEpW/DP
         PwJCiA6zH4piJ2XNiwkfEHJNKgRcfFsnoeLdioIAZkqLJgoWPphtJ67U5h820fYpRgx/
         JE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514425; x=1785119225;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gyoYwJn9c0nIEAroGsaLZs4irS+9OiiRd+4yaMN/EaQ=;
        b=q9GeFkvd6eLjdTfQdWo8k1KWFhsl+OU47sIzb+GxHJoYwZV6hVTNqrC03U9h5FhNp8
         Py4yBHRU3aU0bZWpbqYVW0DkDrNru5HW3sOrKkmr1SHePQj3I00YHVREISU/Lw15Nc79
         r7D/MRnMDq+aasDMs/9yCPpMk7ak60rGQ7248TO9I/kdtK6/bLbBp5Fyb0BjoDIeTHB7
         xUHGMVykmYVyGd0REgkrPcSLcQceU4ayMEnQNuZHr/khiooOOAW1g/BflRKMrfg8Fc+e
         PmRXg3wKQobnICU5R9RCjK36eqPk0mE65jy2Ungla1Lr1wuXCRzfcRMPEtACG5mds7Ox
         P4AQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsHg71WbjozER89xbYG1Mw5o9hzQz2kR6GmubF8EUaVXOr+A18DmRvkJnEmB/MvJWjDzA9wEipPeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5LkuUvthsUaxEsAtEywsfiZgJsiBW+jFW2tUnn4deG76CbD2
	XdxWgPQqJFYERiwF0PJiViid3D/kuo3j5UpHz6mkciKjMw/KYA9FUqA0JV7rsAZQ+Zl8fHhraXd
	CVxHux7k/mgJbt+FOw7cX/T1RPuebrEY=
X-Gm-Gg: AfdE7clvBN7rmHy7IE9t9xfMEFtahPAgJwJ+V0W+FtqGt6t7SeA4fqk6vRwAkqT/5Oa
	BrTWYU6fvcvchH9t23qt2ILv9Rf7Zv2HYl5RX2XoGA0EA5un3BlwS32StXB2KQMf+Fb6AkHG86v
	JmsqLUcJidgkODYB/DZYt5bucig1juENFnAUF+AGd5eP9N4yQKc3wr/zWiFQqfWe3+A9Jas76N7
	YedEiLUrOS8D7M1D/2BwdsDYLP8jMDTToG6S0YCejNGH+37YBDnHqkLLBTlmzaO
X-Received: by 2002:a2e:b554:0:b0:39c:650d:2f63 with SMTP id
 38308e7fff4ca-39eb27bfd13mr16775171fa.1.1784514424490; Sun, 19 Jul 2026
 19:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <178376430529.16552.7043868463863908196@linux.dev>
 <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com> <DK2X7WBPOPWC.TY09ODVGYUVM@kernel.org>
In-Reply-To: <DK2X7WBPOPWC.TY09ODVGYUVM@kernel.org>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 20 Jul 2026 09:26:52 +0700
X-Gm-Features: AUfX_mxO2nw8yshtd2cq0NKG1rKFw6860AP9INvd-B0IXOj42RQUBgfvJzIRFAQ
Message-ID: <CAO26r3Sv=ZZkq--POXmwh+XrAB34COL=A2Om47tnM71MTwNwjw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Danilo Krummrich <dakr@kernel.org>
Cc: Igor Korotin <igor.korotin@linux.dev>, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 06:02, Danilo Krummrich <dakr@kernel.org> wrote:
> The patch series is merged in driver-core-next [1]. You can check the
> MAINTAINERS file to see how patches for certain subsystems, components and
> drivers are usually routed.
>
> If unsure you can also check the linux-next integration tree [2] which merges
> all development trees in a daily effort.

> As mentioned, I/O projections did land already. Regarding the FallibleIoCapable
> change, please feel free to pick up the diff I posted and send it as a
> prerequisite patch in your series.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/log/?h=driver-core-next
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

Thanks Danilo. I will rebase on driver-core-next and carry
FallibleIoCapable as a prerequisite patch in v5.

Coirul
