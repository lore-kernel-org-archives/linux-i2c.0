Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B137DAA3
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447573; cv=pass; b=jQMo2sRwJGKHOOp+QcdD/suyAos8pWyrevefN9RIA1dby3Ja1OpZxG1ovKpgAGtHpauyfMkWdlZDYyYmGDC28+27QLfJxsCD5QMUTqXbh9yt3dBKzulc/rsAgGFBTEZID/kcsg66L5+w7FVwu1QgyTKK/fpLaPnYL6PwMyYxy5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447573; c=relaxed/simple;
	bh=wVqxwstIHuyjrO98o8atf5Z9wy2i0J0wupEq1EeMQ7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4+dJhMTvUVOqCNjxoN0KMyC6YKHIdhZMN5X+XDu6gdynSrLBK3qwXkWZGMP3vlpumWiKsUE+/3bqeL3N1wXt6a2zIfsriDnEdxHRpVAzdi1eTVnTtRL7eLdCPOjujWLwxeJuacIgrWJNhcLO0dgjeTJ0QKBmZ3bUS9QIQ1Yft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic7Dec6f; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic7Dec6f"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2935350b3a.2
        for <linux-i2c@vger.kernel.org>; Sat, 22 Aug 2026 18:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787447564; cv=none;
        d=google.com; s=arc-20260327;
        b=DodWQ27wGNGsDUDQMews52rEPkIFF7MQu2RqifVbC3w45vZyD2vKmsJE/HPGn8u+uJ
         +1Dr1ovr1j1T2Emwk2XdPPe8mDp1TXc1Et3Ek/7ujgQdIdmhvhiFDchw71mpL2VwgEWh
         Zj+CSJkE+Ct7qohrov+Xvluo70N7TOf8qxH+va/pJYbkHrhUXAKhkDF21S8W1w6UF//2
         7UEGR+AwxuhAXKM1gS2ilg+yicHQ66hFRdFMwD2flXCNksgOz9w/Xn0fEpokjJ9eJo58
         gnPAg2ZgH5mqU1G2rvlKoh5C0jW2u37z/fsNnl7Dm9cNuooztw5QWS0HHwgUnutKcpvQ
         O3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wVqxwstIHuyjrO98o8atf5Z9wy2i0J0wupEq1EeMQ7c=;
        fh=rAhMnYxrRXVXz+N7HGFVJYXLGCPWpgfewWF7WWQgiA8=;
        b=H7r8Cj/IIDLyh36/NoXvQzMtFRDLmx5K9oW4lbH3sfZRyY7/W7XmaecKGsV9khwHrc
         ifHIDtW87CmVigicPwIdP1/ljPcx7CWlF+P4HyC0KYEDjpRazTz0avZoPJhcwKfwESj6
         ogA6Ln64ZSNuO1gL5hJsU0oYQcHiJR7VHLFjXphrOTPW7c1fHUFe4qfynqw4a7wAgctj
         jBHnpgemNOydAz6GPMbgNBdUHU1hs9CIpwLzyBjdJweX3JMjm98mXCmc4a6z9/4W+f/c
         1UTwx4YoeU8QDYutFCBFsOpPnkLiE4Up8/ktdfFasGqXnZt2SaNHmeV4tMJgqyDqjcGy
         V5cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447564; x=1788052364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wVqxwstIHuyjrO98o8atf5Z9wy2i0J0wupEq1EeMQ7c=;
        b=Ic7Dec6fyioknKGCtgF6sQ9rXrP0js9cklGAbp0BAi5t+ZNGinWITQ02MYP9/Mx/XM
         3ygq7WNn6aKU4lbqF8z+9HboZ48RHAGx1lrfqG95a6m8Vb5tjrLUrgFxY3rSIQ5PP2Xd
         dkSmR5qHK4JhXrf0JLlcsKuBXzLxPsimLqgwRuUw2Vbr4HgC2o6TgoDoT0mwm2jPUxca
         SGJi/EkZiz9Z1Ekzt2GhOABK2LnrKIzztIzwa2sTNVz3EtyeB9pagamuE1pYRu8MA1UZ
         Sil98ew4sWrQfjRWLAQDEIw2x4zz3DzyklXZljWM2UWHrLELe0OW52q5LyPO9k9PyU1c
         J9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447564; x=1788052364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVqxwstIHuyjrO98o8atf5Z9wy2i0J0wupEq1EeMQ7c=;
        b=d89QpIEnmeC6uH3CbFy8651FfjJ+0mKsI03nPLP2nHHHQaJKnhGLoPIMb/uAlRgELt
         ffI225PoTnUUhI48P+BJlbE6OHpE6m8MrSYmUczIz0EuCQMDDxbjvjjo1nmvuhj3zRFJ
         Xr6yAOMzBbRiXX5ec8nbAn4Db/Dkb4SF3e3OJuLvzvH94FK7NadjGPuiBkgoYKBRkOTU
         Nqmfl8uT07y/6GxKgbjLAhj+JZmWuH/Fg9Fou3vZbsegVhfISQNkIaKlYkZMO2xmWj5z
         N9aAoYO9Gl4M48e+kUauQrp1S9pQ5KKJG3+DW46yf/WN4b5mmF5CsqAXi/w0jlSCxapr
         OQSA==
X-Forwarded-Encrypted: i=1; AHgh+RrMLVJtlO+dr7R6Oe81l2dRQcq07wFB/rQB1X5skuc6WpY2peyDg2Dsne6OINAR1DfbW7pFd1HrDgU=@vger.kernel.org
X-Gm-Message-State: AFuF++mkyTz0DC0Ifbnk2P7Ym+tq9oAU1YTJDwJqBuZJpiqIMKvwMp4i
	PAy2kk9jps+GrfV6g03HHab5hc7OVKEA0ZNSiy3zP8PvOxXtwIP9C0i0SHsaIVLqcH5tk8rQWZK
	P+cqei/VPEZC/vc8cXD2RetHF5+WnLi4=
X-Gm-Gg: AR+sD13r6nBfoW/uNSs06yo6F4urjMpMCEyMuxPLU80c0mNe2O1vh9agdrJ3OQPNpn+
	Z4i0iF5cUYCN/kpw1yh3YdUB82vSnqN8xFtfVDJnvqmipvfqlK0+6F8JtckBAAZ3UNITp49ZrB7
	a3KIbLw2l8joCB9UAzDs6r3jFzYidXDgoGFN0ANqDeWYyfn++ORDg/Uhp9VHqJGWP5pQlw1DJ72
	/oTzrjOpkJ+Zw2+kM8bU/v1+hidhV3K+F7VzhepnYe8FV11bEuMukbmnXPhJ2FQr+ZgqSFeQiaI
	IYkJFWBqiJSvKpluX150aVG6EN5vTTFICWBsab4czIrxAwT+VOeYH10JoNKjTqSxRIscGXY+1o8
	=
X-Received: by 2002:a05:6a21:3295:b0:3c3:bbe6:95c7 with SMTP id
 adf61e73a8af0-3cd300f9f4cmr28505499637.17.1787447564030; Sat, 22 Aug 2026
 18:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062621.769921-1-rafad900@gmail.com> <20260822085155.1409-1-hdanton@sina.com>
 <CALp66yH7QzvGmo+N7BWykYjoaGT-yAezwRv0Pc_ir6qDRTsKvw@mail.gmail.com>
 <CALp66yFrutQ2h8SNyBZn04+LMPMnSEtWxW_Dr0vzfoHvEahSsQ@mail.gmail.com>
 <CALp66yHBUOH6R55KXP9kS4-XYZiOF6xb3CC6jcVjiUJ5mGQCKg@mail.gmail.com> <CALp66yHXAF8M2YmFi_czHWOU_EgsEEog__Ga13m_=TZmL0ctsA@mail.gmail.com>
In-Reply-To: <CALp66yHXAF8M2YmFi_czHWOU_EgsEEog__Ga13m_=TZmL0ctsA@mail.gmail.com>
From: =?UTF-8?Q?Rafael_Alejandro_D=C3=ADaz_Cruz?= <rafad900@gmail.com>
Date: Sat, 22 Aug 2026 18:12:32 -0700
X-Gm-Features: AcwNN1W6jrLf3Liv2re90zEVM6aF-TP7jN5S7aQ2vY2bjQOaAQ7VbtbyrSExmUg
Message-ID: <CALp66yEv4MUw_a_LFtStaEpg55_bei6pbbyPBzSeDCy_je3jnA@mail.gmail.com>
Subject: Re: [PATCH i2c-fixes v1] i2c: core: Fix use-after-free during i2c
 device removal
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot+227dbc9afd022922d624@syzkaller.appspotmail.com, 
	Andi Shyti <andi.shyti@kernel.org>, syzkaller-bugs@googlegroups.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.g=
it
i2c/i2c-fixes

On Sat, Aug 22, 2026 at 4:16=E2=80=AFPM Rafael Alejandro D=C3=ADaz Cruz
<rafad900@gmail.com> wrote:
>
> #syz test
>
> On Sat, Aug 22, 2026 at 12:37=E2=80=AFPM Rafael Alejandro D=C3=ADaz Cruz
> <rafad900@gmail.com> wrote:
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git
> > 48a5a7ab8d6ab7090564339e039c421f315de912
> >
> >
> > On Sat, Aug 22, 2026 at 11:26=E2=80=AFAM Rafael Alejandro D=C3=ADaz Cru=
z
> > <rafad900@gmail.com> wrote:
> > >
> > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git 48a5a7ab8d6ab7090564339e039c421f315de912
> > >
> > > On Sat, Aug 22, 2026 at 11:13=E2=80=AFAM Rafael Alejandro D=C3=ADaz C=
ruz <rafad900@gmail.com> wrote:
> > >>
> > >> I see syzkaller failed to test the patch due to some VKMS/DRM
> > >> issue. It's unrelated to my patch.
> > >>
> > >> I have tested on my own local x86 QEMU instance with proper
> > >> .config and C reproducer. The error does not persist after my
> > >> patch.
