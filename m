Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93143B27EC
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848866; cv=none; b=S5Kg1F3pUjBgbnKokmbnpdh3kjSncG/r5y3BmSGaYO64D3QUVh8eEQXXyE8PEMETTSxlOsuX5GGnaGaQ1SbTflqlkC1rv1pfrp3FH0N9CUU2OH/Gq5m4v3Kaj4y2V25h4ehJlJYvxaz3tYNChPTvwDd139aafcburv7m/LJUtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848866; c=relaxed/simple;
	bh=l1XwqDtKAXYajCf9ghnOjVigNNAL92jujTw6dHjG998=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkTzvdpiWGAIb5IdNDbkY5x3VFSXdoBWz+5wkCZr5MRhaDxr5Y/6mLGDzjWRlxl46jZZOQi9uxOigK+yS2yJJGIBu2ZhjlO8+D5WR1B6ZUXa8hjHgJmZIgj3B29sBO30lfukdrQ2vNlirTCkPsFxFh8KwYJ5khBcIQep7q6UWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7ZqF5h+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7ZqF5h+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4B5C2BCB4
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776848865;
	bh=l1XwqDtKAXYajCf9ghnOjVigNNAL92jujTw6dHjG998=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I7ZqF5h+6rX1+4f0PNChyCXnJLG9lLo05DNKav9yQv3HJKcGnTyozvBSxqb+ydGmW
	 TO0f2eeFcDFQYnhuCcyrXLvfnZ4dzKRo/d994S7B6Bd6px/EE7S8wE2EDWAQ2v/Gc8
	 QALlI1+/NhNx0GGFje48tLoZLhGwbHNbNucZNy8eNYZ/rb/4KGRgl+6dsJ8BiG3PhQ
	 CVR08kJdubD+/fWsX014SyE3JFIygb9Pp5E6OSQoGBW0rsdKHILjWl+1OlhxwOGDJd
	 AG4OdpcQEK5nA0w8MlatALh4pfBHGKnvTHuajMDnABwcOzQuGGacOUW8dwXnzW8gPV
	 feZGlLvio1Hag==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38cc8708d76so44231311fa.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 02:07:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YzCX/3xMpJjaVMOmapZc7/7UHlabFSwu1huIi3L+FumuCs86Mx0
	1XBbJxUbkBkzgfGe6ctUSRXASDtcndfJ/QqrfTLsz27IQxKEQcKJwm6F21x8J/e1CTjWP+Hc/la
	3UFQgl0rAMBAVLP2nhI/FYbrlhGLchY0BzuScwPfuWw==
X-Received: by 2002:a05:651c:420d:b0:38e:da87:ce3 with SMTP id
 38308e7fff4ca-38eda871158mr42706671fa.23.1776848864232; Wed, 22 Apr 2026
 02:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421140755.54222-1-marex@nabladev.com>
In-Reply-To: <20260421140755.54222-1-marex@nabladev.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 22 Apr 2026 11:07:32 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
X-Gm-Features: AQROBzAz-D97iW3JhzcFyiuF0lV4G1jR_LWWGU2qGTILq9KVbYJAE_N-yWssG9Q
Message-ID: <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:08=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> Handle special-case of AT24 EEPROM described in DT, which contains both
> "read-only" and "wp-gpios" properties. Interpret this configuration as
> default read-only, but with the possibility of unlock via force_ro sysfs
> attribute.
>

Patch looks ok code-wise but does this really make sense? If an EEPROM
is read-only, we should forbid writes in the kernel. Which board uses
it? Can we simply remove the read-only flag from DT?

Admittedly: the DT bindings do allow it as read-only and wp-gpios are
not mutually exclusive but I think it's more of an accidental omission
than a planned feature.

Bart
