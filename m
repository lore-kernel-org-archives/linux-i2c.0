Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E13451B5
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087602; cv=none; b=tlsEuhtGwnzrPDmTtmzL7KYxMXRoCpxqUcgLTmC4ql9QAuldWQbesHxdLIoP0V3X8cFgGPDFMLDpEFoHbECb7TY8yPfVyBGdj67j3tQyWmo7d46d6EPnL59+O2u94Qq/Xe0qsxMcvDeblbIM+pdBm9rH1T02iWrJ8fmbWxvczeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087602; c=relaxed/simple;
	bh=Hu990MXFDmsHaml1m3y26LLBAUFsB4ATxoDsDS/egKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ga6HbeZlsKzzktceZKSWaoCNOT7f81YgfjToEaoz84zqNG7dO3NPgIhhshmSn2KlBZUGmNEi5R9UYxc6bLNrqt7ccRbJegTqdskyXj1gw41+HnFWOtz9B+Nzc0EzNpSfCfeRFJ527AxXGq4Qhu3VI/K4ctU78BCwWG0aqQ4Y/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac6t8HID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac6t8HID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D241F0089D
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780087601;
	bh=Hu990MXFDmsHaml1m3y26LLBAUFsB4ATxoDsDS/egKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ac6t8HIDWIPDQS2t26VON6npElemBina3b7Pb3pWArkFEq6obvKdGtFMbjLItfppj
	 eppu4ZtIuO0L6we9kCEzXNHvMw2UaujMXtTVWG0fzMb9JPQberLiAHpmvcHobZWiGY
	 WE8ckH8hOOvoNIXHnsDIxWqP19NIRziLtNhf4S/7ydcvM3Umo0w1u96NKBdPOWejSC
	 SYE/nxcyVJM7UNtwpWaopomey2oI8zL22JXh3cei8YFwAcSif+iwmczTq+2tlclFbX
	 wIwYqzKRIZFinQl+AEehFOFzOf282Vaj41fFzJQ64kTWNzt8mn3EvMlCzWL7rCSU8R
	 1bAN4pm0YinoQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso219008e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 13:46:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+YJ8GVpQplCOJxlsKPtkuuug+W0TqugiV51dm29v46RDHw3V4xdizxlwshrlQXgVRjwIiu63b9lHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymeqmyXHR9TzK0TVAb64q2rWWSKRxOoweUayMWlCny2APf9r+9
	/gWSXSg6DCHjQU6Y9q1xuGVeqYTLzYLcDXug/bS/VWBULmiDFJi8d/iNJZyAwpgbxXRhsGZcRhI
	9WZ6kPK33CdgE51QuoPu1e2aE7q4n+gU=
X-Received: by 2002:a05:6512:b9b:b0:5a7:46f9:be3b with SMTP id
 2adb3069b0e04-5aa614260c0mr232192e87.14.1780087600222; Fri, 29 May 2026
 13:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com> <ahml-rVa2PIA5DDC@shikoro>
In-Reply-To: <ahml-rVa2PIA5DDC@shikoro>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 29 May 2026 22:46:28 +0200
X-Gmail-Original-Message-ID: <CAD++jLmWV9WizdqXfwvTUCbJDisurLBa7sAC6DH1BehDTHZDYA@mail.gmail.com>
X-Gm-Features: AVHnY4LikLXubPACR1IQvbYvGs8DVaKgCis8LOnURnh9gKeda2OwXHTi-bVfjZM
Message-ID: <CAD++jLmWV9WizdqXfwvTUCbJDisurLBa7sAC6DH1BehDTHZDYA@mail.gmail.com>
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

On Fri, May 29, 2026 at 4:43=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> In case this goes in via some other tree:
>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I queued the revert in the pinctrl fixes, you can take this one (2/2).

Yours,
Linus Walleij
