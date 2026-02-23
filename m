Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196135CB88
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849452; cv=none; b=C6m3zI/Z0SEEAK8+QGf33/t578h7ZpiqQr1Yvp914K4vcDwaFcete2DLpXMc58fhQDEHyFELIMLfzwlWGJukOZYxH9d/4jV0MbXq+BePa5Y92ctUuAG1DOkAmT2NWXMF5TLHCZw/VVCiGMwI8kSGkV6zxlK/Mct1S91tpChOj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849452; c=relaxed/simple;
	bh=XHFXKaxBhs6qPw8s6WYbor1MvvJGijgDWMApY68L/Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijIKIqe9CV4v6doR7F73+/TRPRLGCcCzZ83j6cgVE4ZZ7JX15Q6Pzk0l81+a+hhjhWPsSAb8VkAYM4+HPVm9aSkUiUAnLmS0xS+TtWOjKA8qR1bnPy+e6Va6hYPt/dqMhnG7FhlkazawAsVgk+c0cy8EBCLiodcRwPMpYYGQYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClSzMfw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClSzMfw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F1C2BCB7
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771849452;
	bh=XHFXKaxBhs6qPw8s6WYbor1MvvJGijgDWMApY68L/Es=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ClSzMfw2KGoHmbmLFUNqTHr5b1P9SdFYE4875XrXSwHp9EVpJcT4cAVStfcNuJpJT
	 ywl4dHgQQJFGugpJybkmfUbs8tXr0PRNFva6SeKD2pY9cX9AfhjFt4hYVVJa91cTgu
	 LDuXa3L4pss8seTX67/Q/1RD8qwzkl/cAvdq8vIGL/a7UqaT6bXgaz93V/3BA2958k
	 vFmtE9yXjpTdbLVFMqhaAxebIF8A4jGHG4eobCg3trTYrPv8YlW/r4oyjPAZvoQXb3
	 Avo4KOx2SZaLrhq4oLam2WFQbMRsIU5Sav0kNCPoiXSfL6PKGuJ0lP3BgX/lXXRHWr
	 W3Hz8qqtvmfuw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4993e00aso4368056e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 04:24:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrAiDdXbkcOYIqvJJ/zvXR/1YFeUg8S7yNAd0/mQPkSMIVtannZWhA3eSE+cqWwyl0h4jrsynRvLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2li2oa5V90HTzjeiZmqeui8Ver/dlsoW1kftB8nZt8H58fY0q
	Nmc9QTElV0BNMFSYTO9L7u1EukIduiRvRB1G3qRBlsyNNOZa+CdXlTzzgL5hBoH8Fw8H8SfSJrv
	dVdIlacR7sFpIbRAowvIuJakUW6tJKTp7MWCRl9BgQg==
X-Received: by 2002:a05:6512:2316:b0:59d:d615:4b72 with SMTP id
 2adb3069b0e04-5a0ed9a83f8mr2281473e87.25.1771849450656; Mon, 23 Feb 2026
 04:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-ada-dev-set-node-v2-0-77018c536610@oss.qualcomm.com>
 <20260223-i2c-ada-dev-set-node-v2-8-77018c536610@oss.qualcomm.com> <aZw-MX4NvafqUVsy@smile.fi.intel.com>
In-Reply-To: <aZw-MX4NvafqUVsy@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 23 Feb 2026 13:23:54 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf1==xy31_cf5sNS=GiGxhh8vXzZS1mgPzsro+BmsGEwQ@mail.gmail.com>
X-Gm-Features: AaiRm52Edj1KUe1BtPU4aexOD31BhZqpGcyhXaRBZ1csZIdxbFf-D5NUM1cpEP8
Message-ID: <CAMRc=Mf1==xy31_cf5sNS=GiGxhh8vXzZS1mgPzsro+BmsGEwQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] i2c: designware-amdisp: use i2c_adapter_set_node()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>, Hans de Goede <hansg@kernel.org>, 
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, Hans Hu <hanshu@zhaoxin.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 10:08:26AM +0100, Bartosz Golaszewski wrote:
> > Use the dedicated wrapper for setting the fwnode of the i2c_adapter.
> > This allows us to hide the dereferencing of the embedded struct device.
>
> This should be united with patch 2.
> For this kind of patches I would not make the split like this.
>
> But if Andi is okay to take as is, I won't object (this is minor thing).
>

Gah, I folded this into this series but forgot to squash it into the
original designware patch. It can be squashed in-tree by Wolfram or I
can resend it.

Bart
