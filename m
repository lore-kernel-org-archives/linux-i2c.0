Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA83D954A
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645544; cv=none; b=u2v7dG/EzCIZKDYMcAkXeLvWDkVWuegcyWyS9e5pipCeQnB+NezkXisdMR33jRw+uy+d7OwK2QuqaDtT/N1s0YN4H6WsimE8kjR5a2Rmq/ux3CvIGFZax0WdPilJ9yo32SIGmwMKVemq+jPheAFVVtwkyvXBLd8I5i/B8aYPpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645544; c=relaxed/simple;
	bh=VmY5gZC2NUTZg2YEQ3wRB4bMwYDcax/nzZBQmUgXNJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxwaJU5IdH5VxoSMuwrEf3vhS0VH4eYDLLwXv9GfYJZQxDeowJykumtAZc+ke0Lmnrake07L1ubdW8ve/R9S3jiUC9XC2iJ2KNOkTAHOpCHKxP/Fn9VWKVFKgnt7Roxa2pnuIyRKDU4V8VQfpPYmLrmX9IwLK/w1+OFU9xRzL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbnqL0bK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbnqL0bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2BB1F00ACA
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645543;
	bh=VmY5gZC2NUTZg2YEQ3wRB4bMwYDcax/nzZBQmUgXNJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KbnqL0bKRJ+WsCQXz7ObnzBt2h89wg1GclRMxmLxRSk4b7KdrU+vmvuoT47fbVvNz
	 cygB//A42mFqzJHJuIdQcC2Qktruxsc3uUejQzt+cWnC08RE0QdERD8SsvrH0bM1cn
	 Uxsc+lnfL5RsiUVY3rjs/W+lA5Daoml13WaFYJxYA+NKIA1VjQ1VUqDkrDcAOu/M0l
	 7m4nC6d3uOV+26oH5x0dNPiHDeEKMpsNgGVviUcknohWOCZDyiLIbBZbzF/3Io0SeO
	 ScGBgKr6sjjCNXwn0tTLkzmrwI5KWqJA1xrTgPdmzJ8/y94t6ABzPmYHn5NHAZfdgS
	 AqSTC5xdYNklQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0148201fbso4041293e87.3
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 01:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqB268c+7/JWEfN3dH6fVGDEBfcvNFd3bF3SLDbDw+++teHocn8Rhnad0Fl64B5OpgPwiRvS/I9klk=@vger.kernel.org
X-Gm-Message-State: AFuF++mf21LBbb1vvwLyRG+shqKUrcDj+bw00DgcZ4wDJNyjFmfe5HK4
	q0z2IH5VwGMoK/5cMMndV+LqLEj5lJJHTle+U/p1hHjstaa2Wyu55/0bVl0mh3PPld8XsVXc39g
	VZJpndxG3XpPHI6rMJ69pK6GxXsa/Wqk=
X-Received: by 2002:a05:6512:a8c:b0:5ae:ba27:ee63 with SMTP id
 2adb3069b0e04-5b49cd7e35emr1348404e87.7.1787645542392; Tue, 25 Aug 2026
 01:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822213941.98882-1-michael.zaidman@gmail.com> <20260822213941.98882-2-michael.zaidman@gmail.com>
In-Reply-To: <20260822213941.98882-2-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 10:12:08 +0200
X-Gmail-Original-Message-ID: <CAD++jLmCVfG4AQ_pTkYouGCcKgN-eh0wsRGQby9dPvZVFMpMDQ@mail.gmail.com>
X-Gm-Features: AcwNN1Vp1-UN2c_RyR6tNJhg4jCKbPTZlYlUypyWst56PShfb-Li9YaR03xN-GU
Message-ID: <CAD++jLmCVfG4AQ_pTkYouGCcKgN-eh0wsRGQby9dPvZVFMpMDQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] HID: ft260: add serial driver
To: Michael Zaidman <michael.zaidman@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>, 
	Bruno Giacomazzi <brunoceg1@gmail.com>, Christina Quast <contact@christina-quast.de>, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Beer <daniel.beer@igorinstitute.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 11:40=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:
>
> From: Christina Quast <contact@christina-quast.de>
>
> Add a TTY serial interface (/dev/ttyFTx) for FT260 USB HID devices,
> providing baud rate configuration, data transfer, and termios settings
> without requiring userspace HID report formatting.

You need to CC the TTY maintainers and linux-serial on patches like this,
just keep in mind when resending, thanks!

Yours,
Linus Walleij
