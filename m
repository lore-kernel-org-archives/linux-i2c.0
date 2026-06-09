Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD664352C2C
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990478; cv=none; b=EiI+UuueWr8hZ7EozYokEobP+GH2gpi9L5Kgi0UqsE53A11fjttn/I7M6dTU0VyNpjx64j2j8sZ07MGoXKISWCI7v36/V322sSJmUlGnyL9j4dAxscuGR4o70CoqGUeRRYjBDMsUYtkP1FnrGjBaAfWv2z+Hoqe2bwx75p0812s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990478; c=relaxed/simple;
	bh=6qJV/Kr0DwToY3AEHALDZVHTE0nSoiYFRdznk9zEy/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/fW0znfJ+ALKM5kvRRuHwg+r6DEqgDEgYQEXFcAjpAqCFFyzQcfHvk3iBEMVdtDK5DeYSP42Ms700rpNm+yd3tRf2XKSipiqiTAz4xh7iIplVdT1NDOl4hnylOCOus/lYtzDo9vQRCvL69n1L9kjjwZDdg1Zt6A7z5+/KUBhdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhGorgvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhGorgvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D871F0089B
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780990477;
	bh=6qJV/Kr0DwToY3AEHALDZVHTE0nSoiYFRdznk9zEy/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QhGorgvlYs633aPZNRB92cMMvXPCfIKE+GaJZORY95maQSbjmA61L9hTIz2y1ScPa
	 7Hq/Zh3w7CB/MClw2o6FrSZ0QaMpCRLHsWAiBnTWSScHLSGk+Rpz3S6ehHiukXmfcB
	 0rhr8MDnWI3BA3FTr4imtcvBOZeHc9rm4JGzKDBmKHqnAaMEFlH/U4cQP4WVvr5znt
	 Z6aKeITSVh0Lu5dvZsaZJxbTePqgM86rk7wgVXIQkF7CR5zT6Dzs/n30/KQIhviZ8l
	 kCZHir5UGblFNq1g2Whu68euNdt3fVrQoJJt1A9aXBpxGYoBTVxkMqExzgK/zXLSha
	 0mzhg5e/w4tkA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68e66128so5313903e87.2
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 00:34:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8T3lcOYajoKMnqp8drCPfcWzAC+Ye/FNpYpd1KDfdpgePBUtcWCANWB2bJuX4Y9siyn6uHxsnLAIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/ij+PYGXqlp2AEUsVzSpDROEJmB8huDcnY8kBxVIcXN6L1c0
	hHVmIT+QoqHyu+nGL9TszxC8DftG7EQMk4OWwAHNFZ9vmSwXwYwXfjX/QeCsxQrhCsMQuMGyLDn
	y8gRp0Dh609Vb1LBh43ppOxX4/A3WgRreCH6kf3B6Vw==
X-Received: by 2002:a05:6512:39cd:b0:5a8:eaec:7567 with SMTP id
 2adb3069b0e04-5aa87bed80bmr5241485e87.35.1780990475896; Tue, 09 Jun 2026
 00:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601122923.3714-1-bartosz.golaszewski@oss.qualcomm.com> <aib6P9jvkFhmd-LI@zenone.zhora.eu>
In-Reply-To: <aib6P9jvkFhmd-LI@zenone.zhora.eu>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 9 Jun 2026 09:34:24 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdVvUDa5THVNRr-O5PzEKdCDf7wW+t7N+FBoQJGOLqXkQ@mail.gmail.com>
X-Gm-Features: AVVi8CctB2w6qrsYLj3gc25A4_rzdg-pmPvcM4iMA46f5NpbTXBVlLS8SvguR70
Message-ID: <CAMRc=MdVvUDa5THVNRr-O5PzEKdCDf7wW+t7N+FBoQJGOLqXkQ@mail.gmail.com>
Subject: Re: [GIT PULL] at24 updates for v7.2-rc1
To: Andi Shyti <andi.shyti@kernel.org>, Srinivas Kandagatla <srini@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 7:22=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> w=
rote:
>
> Hi Bartosz,
>
> > Please pull the following at24 changes for v7.2-rc1.
>
> merged to i2c/i2c-host.
>
> Thanks,
> Andi

Ah, did you take over from Wolfram yet? I'll make sure to Cc you from now o=
n.

Or maybe we should just move this driver to drivers/nvmem/? Srini,
what do you think?

Bart
