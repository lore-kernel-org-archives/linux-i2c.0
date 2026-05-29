Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13073375AD0
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091980; cv=none; b=rs1CnqcPTY3yPrHdluIhTC4R85pak3Ez2eXilxqZtapVyg9PpxfQZwRw4QwNuGgPTviPaE3lmqGej3G77YPBnPq4bH5MKoCiBpzSn9dcidgeKxz5La2w2rlEEuk8rx3diItS9+v9PIBHeG316nKCHeodFEAP8wXzuJCi6zorCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091980; c=relaxed/simple;
	bh=AWNQPph1dBwM6atY/G7aYUANLN9LVL7NPRf2jYbLt6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbFCX/jBI/FxNL45ccKuLX7iD7e4V87Uuu2pX68BZ8Djy05hvpUslQfVPuYoVdS87eo6xSNABCET0oTDAZrHJR4fzs9iP2UWkD3WrHzl0znAiocs0rM4rw4698W0qByEq8p/bwkvU4Pc57Ni75H7W7n4nws+dbbsdK3rBkHHcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU6MBpsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU6MBpsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FF91F0089D
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780091977;
	bh=AWNQPph1dBwM6atY/G7aYUANLN9LVL7NPRf2jYbLt6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BU6MBpsBDcOXErsendlVPtVfkd+4wYFnkxfYlhru7SoOEhewKiDjXoiBT8Jj5hRRZ
	 xs6EQ+YAf1o4a7TBMq9CI2mQ+pJ/QQLZBVHtnLp8A4hjUXcZyNtqpereFE0LjRPJv8
	 Aq3xL/UUQXj1yUUOdwX4Tdm84CNxHIUyJeWC1YEZHA3IZiSdeFtAnazLEO9cY24nky
	 uSm2eL6/OkZy1FidxnIs0XHv5PQHHeOKe8Bjj/qSUCqVMQHY8sWrWwkvCRJUZlfZUe
	 Kql+HkEm0L6CclXpwSSI28n3TElZOkrdrhoFUi8hCEiE++q3/MiJkenjTReUu3Ky1D
	 r3GTwc5NEgrQw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so497077e87.1
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:59:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+zQSok0S7pqvDuzyOR15rCU7OM3uiTdBlh+Wg0Q5pT++zS3RFHE8NDMTmuwz5TFXhaeQSE/m512WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/76rrNCZfgbfSU1je+OMo3QAdvj03vAu5QoAFr6ANfn13Sm8
	3I79jZdktQQ7b2on6Ajj2DKKz0wn+zUBsbkPdx4Wz9Op6MJNIjWHuHSdXK+OVsMg9dPz+L2ik6v
	n+hMnmRBIwyUW919raD19Xa9OopGrx+k=
X-Received: by 2002:a05:6512:398b:b0:5aa:5c8c:9cf7 with SMTP id
 2adb3069b0e04-5aa607c4fcfmr512997e87.14.1780091976513; Fri, 29 May 2026
 14:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <ahml-rVa2PIA5DDC@shikoro>
 <CAD++jLmWV9WizdqXfwvTUCbJDisurLBa7sAC6DH1BehDTHZDYA@mail.gmail.com> <ahn9Q-9eHjBSj39h@shikoro>
In-Reply-To: <ahn9Q-9eHjBSj39h@shikoro>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 29 May 2026 23:59:24 +0200
X-Gmail-Original-Message-ID: <CAD++jLk7L-XPTpThNbvxzYSuw=Gy-dDci1eTy8wLo9O0o4_uqQ@mail.gmail.com>
X-Gm-Features: AVHnY4J6rdiM9KsLn3kqHZ__ULwLI1RBnXXrtgghRURL6TqmdgUX3m3OAFEYCRU
Message-ID: <CAD++jLk7L-XPTpThNbvxzYSuw=Gy-dDci1eTy8wLo9O0o4_uqQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 10:55=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > In case this goes in via some other tree:
> > >
> > > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > I queued the revert in the pinctrl fixes, you can take this one (2/2).
>
> Is there really no dependency on patch 1? I'd feel safer if you'd take
> this as well...

OK then, you're right. Let's keep it together.

Patch applied!

Yours,
Linus Walleij
