Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17D3EBF16
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168159; cv=pass; b=FDNNOXaTj5FnrrJPCMD1r9zgERaBBPs6QmvdCuwS2Uu+jc7K/VyotRgJX+BSnOf/xgHGNB/rezJhbDXXJuqdpboinsgmYeZKBdH94VP9ftrFzO8sd9gXtqE4UEZU+ZAf82S/DeKyZJTukroEmr7knmYjfXk8/ceJ9a2gM6HZZGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168159; c=relaxed/simple;
	bh=OE1i/9Ptz9WxZ92YJl17Q6KATL4iBAMC4F1ZCkxuhSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA4D9usTihjBin6/MnbefyPYSXplUfMrRc1kUFey201bl6pZpXiQLEdAoTzD0hpiuAgMZtoafc/U/NoLbBiPZK92DNw4eeEd/NR9J8RVmlWeYWKiyCsRJceUp/aawydHxi0M0iA/i58Y8kv0k1rlRiLnPTYH/3EkbSDPw47bXZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYWGmnE5; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYWGmnE5"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so3322140a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 03:35:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769168156; cv=none;
        d=google.com; s=arc-20240605;
        b=g4U2nPIdT1jJ266c5QQHlniEGxsml8lv6r8cIJdDxR5j67JzLsThI/X3PWtkmwJl/s
         Olr9TqK7ooimi9dve5Wj0kmN4OqJGJAZ7/xe0z/JTmxxLO5N9Sh/Y94pISRpwvkG8KO/
         PTSJZhpt+9aMOj5uxjE/VQOM1jmQdYsfCh7luUhh352XZzaUPRFOsFkBYMzYhBmSIk3r
         6wEO1CAYVTsLIdiNIy7FjKOLlMrmnXBqlL1LGL4ROnCQEA+J43VISApFcPLQlUnKgaTd
         XNhqRUDLP/B2dHblSYaXIBYYucz2sqbIIhLMJowylt5zDk7DlESIuC3n7RNlF5ywB0js
         fz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OE1i/9Ptz9WxZ92YJl17Q6KATL4iBAMC4F1ZCkxuhSk=;
        fh=2VC11ZQBzYTJb+sMwcueOp290KrlhNvZFCUlnS0Bneo=;
        b=eSOZGvcdEJxmVEBM3oEQ6UxswhPH8pW1G8Qx11T4hscWUgPU13IZq4utYmN1Oap0ye
         rFF3hP0wevr8bR3q61d/3LcIOiregXUfFgqzR2M1unE0sRA4DHLj+v1C6TcISxCtyofa
         W11dlU7iSYO3X/OjJ+Hip10fFJzzPVhnCuHo9yDqoNQRFD20nTIhoRBCM7zu1jCauxvR
         yM7UcH7rpRPngjanPex+y54OyR0Xmk+6ONj/ckTkX0HNaYgeAOMFmsRJcTc8olKH0tCS
         NL2nLlufHkh/AeW6aUllzL2Ahdz5/WhHQSfroCsaSwSM5hFbKq8pYQHRO6gl0REfuUKB
         hc1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769168156; x=1769772956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE1i/9Ptz9WxZ92YJl17Q6KATL4iBAMC4F1ZCkxuhSk=;
        b=YYWGmnE5TluC8D6ItQnm4FxxVAn23Dia5J75uqyVNs9L2j72S+6zm1zBN6KTLOihSH
         mBsQVbRX9m1vrm3ZEaxM7GdlXGU2Y5O57xU1kTyrr+AcolYdlW0Wbw7tYLMWAC5IcZJT
         5v5xtDxEq7R9oipLMIMVYObwnP0TmxNF1fnnF2RihwGlDdflaoz4NtGFhA0+dG7+1VSW
         z37dVpTknjXHJgmyiaZ875mtveuyoe5m9h0HQSrTDdhEWdf/y5N9YDFxiFZtGZ27HYCt
         1RQLnZW3yzP2jcldDX1vRpKbkHPX0NwcffzqQy6Smoi9GI27hK8ldaBNvryGDZpvzSBc
         Xaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168156; x=1769772956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OE1i/9Ptz9WxZ92YJl17Q6KATL4iBAMC4F1ZCkxuhSk=;
        b=FkLwHx7qtNteDAslhYORYhMSCbMsXkY3yvp+YZHpXNTI2poRKeZAxGuBHFl5uObYF/
         IAgmPp7P9NaIhHbgoy+2X4ArTtCoSWC/gf62yZV3tQ1jQk5u7ChOut9lJvuF/4GWhdJj
         qyceGow3zWgLJzyY9trsHiZDpwsdlZjmLSDimxhRlBphjgh+f93ySdtJnDcYre2SyA3t
         b37DuM8G8LpimOolQBsFw1YOrifQH93tmPYdodR7a6FZmnV1x/cqPAyRJJpFsxSIMQz4
         XumF+6PGg6iVWsLMMVVQ6YMmVBI9Txqh8eJU0oJGaOE4IMAPbFLRbdJiH8qkb3T2m7Tn
         Rslg==
X-Forwarded-Encrypted: i=1; AJvYcCUPeYYC4UkhlrfggF40HKuKuqYWcZJtr1xkd6Uy3YiE64yuVBVTw+WL895vHr9bSjRsbkjoOKCC4tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy220CIu+Gh6X8PW1lbaoPFMWZOh7P3WGIYoWvqaQ5UebkRuN1P
	IX62pnZXwGVCoht0QF1vqbKJZcV14mlLWq98UEIvx8MRTxCds36YwJ3nsXVK/UUrLnK9OgGPbZa
	jxOK/9IlEaTR/9/q4yKL5nXKeHRNJxdI=
X-Gm-Gg: AZuq6aKD6vXrqJh358W6/C0w0v22HiQ6aP95wmJ8GIE2xr1g0PhI08NcGaIBUbdMUQa
	tlVSHZ2vLLkJCRPKTZT/faGj0UsToe6kIdG4PH1mV5lC7cOzAil5bNqf31FvgeEUf/hMrXrce69
	JXY123m7aHsbyd2xcWfhG+eEZm2+GlniDkk9azr6gmNwiG7xLF/TNMJYN9U90cHnQcjXq8NmM0c
	hgVYP+GRTLZTED+f9+ZDGnRE7o4FhtffCD17Q6TQvUU+9ehnjioJ5wfeaqwMPupESbmqw8ftg==
X-Received: by 2002:a05:6402:2808:b0:656:a153:f0f8 with SMTP id
 4fb4d7f45d1cf-658487d3f3dmr1583414a12.29.1769168155960; Fri, 23 Jan 2026
 03:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123100537.1429497-1-a.shimko.dev@gmail.com>
 <aXNXx4elBVRpWCWf@smile.fi.intel.com> <aXNYBahiKTnVkRfg@smile.fi.intel.com>
In-Reply-To: <aXNYBahiKTnVkRfg@smile.fi.intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 23 Jan 2026 14:35:44 +0300
X-Gm-Features: AZwV_QingZge1s24wh3etpuPzpi_64b2qEhpPaQHwAkyw1JX40mRdgLAEm3P6is
Message-ID: <CAOPX746Fo4VP9tCTz+T42Uhy_LnbmNNSx8MtMJbRh41YtfHhpw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] i2c: designware-platdrv: simplify reset control
 and error handling
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: andi.shyti@kernel.org, p.zabel@pengutronix.de, 
	mika.westerberg@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 2:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On top of that, this is marked as v5, where the changelog for all previou=
s
> iterations?

Hi Andy,

Got it, yeah... Thanks!

Could you please advise, should I send it again with changelog as v6?

Regards,
artem
