Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88D3EFFC8
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180095; cv=none; b=AJyIEJ5Wo7uV0KlfEUteLRNYyYsbXCCFP8pw4i8Lx+YTpqKYJcKbe8P2gnb+fmRMdnfYIxbIs4YQgX6AtksDB0qBWcuHnwU6i3ajwK8Mxe3ooKdvExdBoNZyEwhUsnR2PKZ31mofotak05X5hRIIqAQrMMu3W5XS8g316DfN8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180095; c=relaxed/simple;
	bh=v4hU6Kr/BAVpowzp5fsRs4uKju+1X7rrM4xIJBc7TQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpKM98aMkT9ZJQZ9CPmCEJd6zKs0iDMGOysjWPdTgx0cCIWdAgNZ+Q07jqCTNZpetluvWV+DLFQ1vLOVCHHGjLh2UrCJQWqshV8x2rIbDYKkjw6MqD0iG2Gz5Fk76rxqosFyYIzM5Qwg1sGfNdmlShg7i+uhJ1GXe7w4CmJaimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmkW0Ror; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmkW0Ror"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F51F008A1
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 12:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781180093;
	bh=v4hU6Kr/BAVpowzp5fsRs4uKju+1X7rrM4xIJBc7TQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZmkW0Ror+6nvgPWvOTe+i50+KcQUXQHXk/HkUjMjfj2NtX+GceUtbbNH9WzM0stZP
	 Sw6N5KUIH6f0hkDy8R1ADDHOtvBTJAdccLHQfH5ARcKvm/Pp9oclbJSNXZD7Po2UXc
	 k8hMfmpma44uGwenQol1i4VKt/SsRaM+E0EKfIbkYppAp6uo0jKKf/dcDx5zSn5HLi
	 AHK5CAlqPONkyAHD9q7y01l+eP5Zegcp++0bzEM8qz0bal/lfl/Z3akq7EKYnIXuOz
	 TmNocUHKiersW2lEf5NCBAeaVcEF1VbPz7sLj8Rtssb0k7rr3ipHgwJ/ga1/tAKdyl
	 gzUzNJ/MsXnuA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa63daf2a5so7798800e87.3
        for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 05:14:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+xetscyjY5mg5AH7EieV9FEx7PA0PrMstyOYn54VNa+aQVPSLoPqRC4t0al4I1ySKYHDm/BwaZc4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE50Y9GnrAHnIpgRJSDSkCXVmak56lF+D9PQ+Jmjf7M9+2iXSd
	ccvg8aehtvRZT5nlqdMD6JefFtJNWAWK73DoisAQCmyM5rlxwF6nvdesnvk7gD76pKmm5lVUN6Z
	9Vinxfd6mpvTx0wyM6ToEtRBDjdArrpo=
X-Received: by 2002:ac2:51c6:0:b0:5a8:f6fd:f48d with SMTP id
 2adb3069b0e04-5ad27fb7e63mr741689e87.40.1781180091787; Thu, 11 Jun 2026
 05:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <20260602185339.GA404948@ax162>
 <CANTFpSX0Ehpno7b=xrnqzmENn=sfKj1UcyRzXvMyy4Rcyr7NhA@mail.gmail.com>
In-Reply-To: <CANTFpSX0Ehpno7b=xrnqzmENn=sfKj1UcyRzXvMyy4Rcyr7NhA@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 11 Jun 2026 14:14:39 +0200
X-Gmail-Original-Message-ID: <CAD++jLkx_zx_w_rSm9FxzbPOFMgMrq8NvfZecANLkmrMv=19fg@mail.gmail.com>
X-Gm-Features: AVVi8CfjPcy-5ZJyJQBdt2LZccagAsFKatwmZT0g2ZuMWBUt2mDfmGa4nRJm5QY
Message-ID: <CAD++jLkx_zx_w_rSm9FxzbPOFMgMrq8NvfZecANLkmrMv=19fg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 9:50=E2=80=AFPM Hardik Prakash
<hardikprakash.official@gmail.com> wrote:

> I am preparing a fix that skips GPIO resources with no resource source
> string (string_length =3D=3D 0 || string_ptr =3D=3D NULL). I will test it=
 on
> my hardware first and send a patch shortly.

I have not sent these two fixes to Torvalds yet, so I will drop
them from fixes.

Fold in fixes to the two revert+this patch series and send the
fixed patches again please!

Yours,
Linus Walleij
