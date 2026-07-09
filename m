Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316319B5B1
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600863; cv=none; b=a8zwxQOMLoZAyokbRFFSRL1U6JQyU5kxDKmkjbESxh8b2iDC9w9RJ4mEGDdeoj1r5KGdPwb1QJxtxsNcZBN8k9yKwqlTRES8fmoUeYdG1gi8rq0eWuk0tWo+M4Uo3DFyHGzHTeRe8YTiNrm4dJUuUP9e0mrgwN1jrMJ3169cJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600863; c=relaxed/simple;
	bh=gWwf4TgpUDy2tQTznkYb+yqRgpv0THbQa0/KUsxklgw=;
	h=Mime-Version:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:Content-Type; b=BuRm83/v/rmn6XGiL+d3dqdWDSazejulnyKrb3VAgy/jUhtQyMrYUyq2t8KATEAgyNpxhbXTv5mR79ZQ7cbHlhcXZXQ7Fbl5jSF0aag3Yvf4cKggcpS6/lJmOdrpfn1a5aRQoPrF6TOC3tVPTw6Cs9YTw36uJimjo8SFgysedGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de; spf=pass smtp.mailfrom=sevenlab.de; dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b=RaTR59FG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b="RaTR59FG"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c029505b389so142989066b.1
        for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sevenlab-de.20251104.gappssmtp.com; s=20251104; t=1783600859; x=1784205659; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:in-reply-to:references
         :subject:from:to:cc:message-id:date:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5CDHOM32b6UfZL208z/DsveisOvcy75D4HomDZSI3k=;
        b=RaTR59FG24WCaJ9spwcs56hhIx7UH6Fg13ca6CLg5aCrWU0hMgbj31FPuC+MBBm8/u
         cWtSolKzQsxW1koo6iz50+jHA2P/LJjhfq72qeD+R2tVjh4pudHCJFyZ/+lndfyxjm3f
         TaiKATRCxCz2r9lwWU+CZenO9SutYN2D/vWBwazyAR27UDMxXwIeahCpAN5FHZDDDagi
         Vno6G0+aygGsDRT2gC10v1Cr5Fh9I1hYX2wnWdMtP4ciBHhHfdO0xYwWtl2cQ4Ef9C7S
         IyiR9LWPHl4K0Gd9Frun/siI+4tBrsdy9D3KMQmAWExjyCpEWrZoj52vSMabW52+vsFT
         8V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600859; x=1784205659;
        h=content-type:content-transfer-encoding:in-reply-to:references
         :subject:from:to:cc:message-id:date:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5CDHOM32b6UfZL208z/DsveisOvcy75D4HomDZSI3k=;
        b=HmWdzLqQRVjIgE0wg/bplW930F93zed/Pk/LlE9jaHuEpVATYxo76PP4yMnYOvWWxx
         4/NzZhDHiSonttiM3Ln7IwNuPazbBokhFJZZtUQp7joo0BTeWLLuqDMgJJWylGsfNhPT
         eLFWQ7sMtU6sk+W/++8zM2FVVAdk5Fi294FkLzSM6HhPqNE7QJsukn+BMmOUz+eR7W53
         LBz9hx5xT163Qs4rgB5kc+l6ZNo+DUZT0hD54J8Sv4DT43dkfZ37JFb2ttCsCL+zvVnB
         9ciKeX7JFHb/a66OEWx1GgFpK30psj4NeIGJubxqyfUdFQ8rUYUvO51B4YGg9PUnk0V1
         ODYg==
X-Forwarded-Encrypted: i=1; AHgh+RrolY1EkoaKYUBqjes2mHMiLxQhVtf5KScu49pexPK1xJ+DYawUuCJi5MmWICoTNRU3DuBAJ7s7XY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxFv9Csl+5CWl3ohyKCAyHe3Q+tKVWnm/F1oxH9bdaW3KzjfO
	UxO9Pbp9iGJkwtMnlgPY8vIRPJ7TmCrTrEztrau1/+Vp1d5Kqkl9+KeBNk4q97ultk4XRPTcPPJ
	beII3gf/uAKxdI31vHzKlFdZ3bWK8bGwIlSWjDOXfMUEG2zW8lQIInk3Sl3UH8HGF1gIW7A==
X-Gm-Gg: AfdE7clcvSIE492+MpSmk5JuNS9lUwMiKwAozfX6GYkOggz7H647GCtTz8sTiS+4zqM
	9C1Hxwpkdq+3GtoUNpk88gKuZ0n/q8aOBqzaWXOYRueVIS5Exxu39t0iutjTy9Wt/Asmui5pTP0
	KLrjqiBEdFOLNaAK2Qhbz5GlFyRnOWz1Hl/VNXqhptYiFMLH4zdfHpCwrl5VaPckeGL4LS6KvhN
	rDUNuJsx9I/r8PGnC+nwswGO2m9STAFFVdjd2W/mW0lpoVWDmg3wsEKHuZg899FQRl+xw8SQgUU
	5SXhdoGfp/bsy3QQDU9+0Lhh/M6fpyfc52sL8bw4knbAOtFUZ9Lae18A55SN+vPjeXP9sh+ONzk
	WEIERDSOVWAOVTLmM5WUzdIbriCVPiIcC9N2qpUhF1himt5A3xLICfBgeLAVsbdcR34b8RguXDM
	cT5TCsGJhh/E+ejJqmwj86Fowb
X-Received: by 2002:a17:907:bd09:b0:bd8:bc4e:fb8c with SMTP id a640c23a62f3a-c15e7415c31mr110386266b.4.1783600858709;
        Thu, 09 Jul 2026 05:40:58 -0700 (PDT)
Received: from localhost ([2a02:8109:eb8a:6200:5542:7c19:f627:21b0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15e84a1ad9sm92675566b.24.2026.07.09.05.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 05:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 09 Jul 2026 14:40:58 +0200
Message-Id: <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
From: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
X-Mailer: aerc 0.20.1-26-gcbffbc9ac803
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
In-Reply-To: <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Brigham,

I just finished reviewing your patch. Aaand I saw Wolfram beat me to it
by 20 minutes. I hope you forgive me for sending it as is even though it
may now contain duplicates to his findings.

On Mon Jul 6, 2026 at 6:27 AM CEST, Brigham Campbell wrote:
[...]
> @@ -410,7 +406,7 @@ int parse_i2c_address(const char *address_arg, int al=
l_addrs)
>  	return address;
>  }
> =20
> -int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
> +int open_i2c_dev_num(int i2cbus, char *filename, size_t size, int quiet)
>  {
>  	int file, len;
> =20

The lookup function uses suffix `_by_name`, so for consistency maybe use
`_by_nr` instead? That is what it's called in `struct i2c_adap`.

> @@ -446,6 +442,38 @@ int open_i2c_dev(int i2cbus, char *filename, size_t =
size, int quiet)
>  	return file;
>  }
> =20
> +int open_i2c_dev_path(const char *i2cbus_arg, int quiet)
> +{
> +	int file =3D open(i2cbus_arg, O_RDWR);
> +
> +	if (file < 0 && !quiet) {
> +		fprintf(stderr, "Error: Could not open file "
> +			"`%s': %s\n", i2cbus_arg, strerror(errno));
> +		if (errno =3D=3D EACCES)
> +			fprintf(stderr, "Run as root?\n");
> +	}
> +
> +	return file;
> +}
> +
> +int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int qui=
et)
> +{
> +	int file, i2cbus;
> +
> +	i2cbus =3D lookup_i2c_bus(i2cbus_arg);
> +
> +	if (i2cbus < 0) {
> +		*filename =3D i2cbus_arg;
> +		file =3D open_i2c_dev_path(i2cbus_arg, quiet);
> +		if (file < 0)
> +			fprintf(stderr, "Failed to open `%s' as a bus name "
> +					"and as a path.\n", i2cbus_arg);
> +		return file;
> +	}
> +
> +	return open_i2c_dev_num(i2cbus, *filename, size, quiet);
> +}
> +

This is a minimally invasive change that makes this work, but it also
spaghettifies the code base a little. `lookup_i2c_bus()` tries to parse
the input to a bus number or, if that doesn't work, tries to resolve it
as a bus name. And if that fails we try to open as path. The issue is
that `lookup_i2c_bus()` is not very descriptive. Without reading the
code it's not understandable what's happening. Instead I would propose
to inline `lookup_i2c_bus()` and then have the logic inside
`open_i2c_dev()` be imparative like:

1. try to convert input to i2cbus bus number, if it worked
   `return open_i2c_dev_by_nr()` with the bus number, otherwise,
2. try `lookup_i2c_bus_by_name()`, if it worked we now have the bus
   number, so we `return open_i2c_dev_by_nr()` with it, otherwise,
3. try to open as path.

I think we can also inline `open_i2c_dev_path()` and remove it's
`fprintf()` in the failure case. We're just speculating here that it's a
path, so printing at the end that the given input could not be found as
bus number, bus name, or path is sufficient.

>  int set_slave_addr(int file, int address, int force)
>  {
>  	/* With force, let the user read from/write to the registers
> diff --git a/tools/i2cbusses.h b/tools/i2cbusses.h
> index 6f901b6..5de3056 100644
> --- a/tools/i2cbusses.h
> +++ b/tools/i2cbusses.h
> @@ -31,7 +31,9 @@ void free_adapters(struct i2c_adap *adapters);
> =20
>  int lookup_i2c_bus(const char *i2cbus_arg);
>  int parse_i2c_address(const char *address_arg, int all_addrs);
> -int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet);
> +int open_i2c_dev(char *i2cbus_arg, char **filename, size_t size, int qui=
et);
> +int open_i2c_dev_num(int i2cbus, char *filename, size_t size, int quiet)=
;
> +int open_i2c_dev_path(const char *i2cbus_arg, int quiet);
>  int set_slave_addr(int file, int address, int force);
> =20
>  #define MISSING_FUNC_FMT	"Error: Adapter does not have %s capability\n"

I don't think there's a need to expose _num() and _path(). In fact, you
can even remove lookup_i2c_bus() as that is not used anymore by any
tool.

> diff --git a/tools/i2cdetect.c b/tools/i2cdetect.c
> index 3c22f17..b62f395 100644
> --- a/tools/i2cdetect.c
> +++ b/tools/i2cdetect.c
> @@ -213,8 +213,9 @@ static void print_i2c_busses(void)
>  int main(int argc, char *argv[])
>  {
>  	char *end;
> -	int i2cbus, file, res;
> -	char filename[20];
> +	int file, res;
> +	char filename_buf[20];
> +	char *filename =3D filename_buf;
>  	unsigned long funcs;
>  	int mode =3D MODE_AUTO;
>  	int first =3D 0x08, last =3D 0x77;
> @@ -277,11 +278,6 @@ int main(int argc, char *argv[])
>  		help();
>  		exit(1);
>  	}
> -	i2cbus =3D lookup_i2c_bus(argv[optind]);
> -	if (i2cbus < 0) {
> -		help();
> -		exit(1);
> -	}
> =20
>  	/* read address range if present */
>  	if (argc =3D=3D optind + 3 && mode !=3D MODE_FUNC) {
> @@ -321,7 +317,7 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
> =20
> -	file =3D open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
> +	file =3D open_i2c_dev(argv[optind], &filename, sizeof(filename_buf), 0)=
;
>  	if (file < 0) {
>  		exit(1);
>  	}

Removing this will change the error path, so a call that would
previously fail in lookup_i2c_bus() may now fail somewhere else,
changing error code and message. Same for all other tools.

@Jean Is that acceptable or against the targeted stability requirements
of i2c-tools?

Best,
Gero

[...] the rest is tool changes similar to i2cdetect

--=20


sevenlab engineering GmbH <https://sevenlab.de>
serious engineering.

Gesch=C3=A4ftsf=C3=BChrer: Christian J. Pereira
Amtsgericht K=C3=B6ln,=C2=A0HRB 121730
Anschrift: Hansaring 20, 50670 K=C3=B6ln
