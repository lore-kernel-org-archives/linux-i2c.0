Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108E220687
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213250; cv=none; b=uMu6hUd3SQUTKhvbnW2nSiYHAANgPCFmEt86OzQggzHu3ua78NRh9vrCgroho+vGjMW8VBPVSNnZ71jKxuu4e8xrhD+ppD4hisK+jlygcTU0w0I1Mm68Z+bsUKXO4B5woxwLSYY2+JzmssPAc5SzuUOHqhmdCqH5V9s6AOsG6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213250; c=relaxed/simple;
	bh=MoNEt62haX0dLkeBlDVNFIkV05SMaWAFL88L06thLr4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NvoupZwN2MRUnNYsxoeC+nCv3iEe0XoAKS3nSAc0F0HuMgTgMne+/t6fkkPr4R0hrxrQqTMf2CWlHpqtBFwklHVV4/XCws0f6+Tm7sj1eMoR6E9XzXF7HqH7J7EtsMLwUGiDhI09I93Zjo0eDoQhObWcFkIj+lDyZ69/L2342b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=bqVHWJIi; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="bqVHWJIi"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e7391839cso3072319a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1784213238; x=1784818038; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3a8IkQ4d1Z0IBLuPcuP7/2BFmRskioPx/kL8MaVVHJM=;
        b=bqVHWJIiNjVpD/40gNT9r+8+ib13kCnn47brSX2qfIc/hTvXm+tao+rSkaBAt/L8kq
         VCzBeKR8jPJ/v9wjsaI5RZMLLX3pYa1aYMwLj77BkRd4I6EHP9mbegomJRbj12Yy4SB0
         imSEQfn5v1YbGDHPeKeY54/k4hhKLBiY4uaVdjsQ6Mk2xZ8dVtvLeJUE3wRqfA2csccU
         humveMA1xv80bDTWOxQwiolI5BgxiNyyc8pwaFIXjX9SrAf5lMJKS5zk75Wq2D9QobtV
         quPxNkEkNHuY5jMYjQ37B8iT05pD2SjXBqEhe9IJoGomI9dYJteXrhHErH1RrzhQmcjY
         KLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213238; x=1784818038;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3a8IkQ4d1Z0IBLuPcuP7/2BFmRskioPx/kL8MaVVHJM=;
        b=mCZtiwmix/YY1YyLjhS4YmqPkU2xXUJSRiqueXPlzHjFwwdhMCuw+KKKKYS8EKuR9E
         h6v8x8sjVyk7JVegO7l4/R/j7nqru8GTXI3x0PoWmscDIF7PQWpggQHaFqLA4mT9uwwf
         y35aWn3+kEzuUVj1P3IO5mPIvMNRoNJz4zh8Djb0m64eefqHZt+bS/ni/7R2tuomTFZr
         7tccGMFUPkD4juKA3kiYezZOzm4VD8HUvJH5kLnrjukzLUX1eyq2AEBiaiE6JqeyiHoK
         vRLco4JNaYxWjDmhL5u57wPMGcE+n9Q2Th5n1z3WoyvgplTBwkmkXktyqCx8uk6E3nO9
         WLbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5OJbPJm0uJD8PfPiNAQfvBSgndG5iQBVOEzwe1mn8kNM+1ipZf4y9kWrrcap/KchD5OtuPrwHSCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBt51IQQZtYWC7MYcL0VdXIIMyuIVl6kfAHF0Ga/UrK4aspKn
	9yh0erZZHbIuG8GcHxlMN8Bs6jKH4z1cydkCWkjX+CV6cMSjX0EyXbdS9fj6iHQErEY=
X-Gm-Gg: AfdE7cllmHTSvXMx6QSHT4sMAd8OFvZ/T/3a24Fez71PJiW2nHFi4BslCGA3Ok9ZH3r
	ApO4pZVF2zb/tg+u0wjrGmSkTuUjS8b+Olpk1qN3F1glKDEK8JbijJv9P+1IfZ54QqJx5YfPGbI
	lalyDndOAwXm8Il7eb3jaQWXvKdZ207A4RpbXQJsyyb5vLuA15ZbdOQ9t4HWkXIrKJhiKkYl4uz
	vYEJj0WlMsLcsA0oewud6yEsz/CoHTofCF4KnBsJ6CJs9I8CbKB2r7XVfAxZjy7WWI6M75uGsEY
	ZBYTuwMwRU51ur+1ggDjIktmz4PPNLNK/IetCMTlUMsp0ghhDK3kq1HtvdEXfRa2LNuxHcrIwBg
	Zv6f4syrOJoWRXJex8uMNE83BaI6AHwEVWelDrtBp1wwxjXyPzfzT556bK1ybYX21oi68Us8+vo
	vR7ffqU0IkUHel5sWDo8W/m4db386Q8r2NzmMLBE7B+1JODtIwhgIwVonfeg==
X-Received: by 2002:a05:6a20:6a11:b0:3c3:9df8:2eec with SMTP id adf61e73a8af0-3c39df84e24mr962417637.65.1784213237725;
        Thu, 16 Jul 2026 07:47:17 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e530689sm11696025eec.10.2026.07.16.07.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 08:49:41 -0600
Message-Id: <DK02UVSWWGTN.2M4XXGFINRT1V@brighamcampbell.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
To: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>,
 "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de>
In-Reply-To: <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de>

Hi Gero,

On Thu Jul 9, 2026 at 6:40 AM MDT, Gero Schw=C3=A4ricke wrote:
> I just finished reviewing your patch. Aaand I saw Wolfram beat me to it
> by 20 minutes. I hope you forgive me for sending it as is even though it
> may now contain duplicates to his findings.

Not at all! I understand that it takes a lot of effort to carefully
review changes. I appreciate your work.

> On Mon Jul 6, 2026 at 6:27 AM CEST, Brigham Campbell wrote:
> [...]
>> @@ -410,7 +406,7 @@ int parse_i2c_address(const char *address_arg, int a=
ll_addrs)
>>  	return address;
>>  }
>> =20
>> -int open_i2c_dev(int i2cbus, char *filename, size_t size, int quiet)
>> +int open_i2c_dev_num(int i2cbus, char *filename, size_t size, int quiet=
)
>>  {
>>  	int file, len;
>> =20
>
> The lookup function uses suffix `_by_name`, so for consistency maybe use
> `_by_nr` instead? That is what it's called in `struct i2c_adap`.

I don't have a strong opinion. Happy to change to `_by_nr`.

> This is a minimally invasive change that makes this work, but it also
> spaghettifies the code base a little. `lookup_i2c_bus()` tries to parse
> the input to a bus number or, if that doesn't work, tries to resolve it
> as a bus name. And if that fails we try to open as path. The issue is
> that `lookup_i2c_bus()` is not very descriptive. Without reading the
> code it's not understandable what's happening. Instead I would propose
> to inline `lookup_i2c_bus()` and then have the logic inside
> `open_i2c_dev()` be imparative like:
>
> 1. try to convert input to i2cbus bus number, if it worked
>    `return open_i2c_dev_by_nr()` with the bus number, otherwise,
> 2. try `lookup_i2c_bus_by_name()`, if it worked we now have the bus
>    number, so we `return open_i2c_dev_by_nr()` with it, otherwise,
> 3. try to open as path.

You make some really good points. I'll make these changes in v5.

> I think we can also inline `open_i2c_dev_path()` and remove it's
> `fprintf()` in the failure case. We're just speculating here that it's a
> path, so printing at the end that the given input could not be found as
> bus number, bus name, or path is sufficient.

I agree that `open_i2c_dev_path()` should be inlined, but I don't think
it would be a good idea to remove its `fprintf()` altogether. How about
something like the following, which would make the error messages more
orthogonal?

	if (errno !=3D ENOENT) {
		fprintf(stderr, "Error: Could not open file "
			"`%s': %s\n", i2cbus_arg, strerror(errno));
		if (errno =3D=3D EACCES)
			fprintf(stderr, "Run as root?\n");
		return file;
	}

	fprintf(stderr, "Error: `%s' is not a bus number, name, or device file "
		"path!\n", i2cbus_arg);

If the i2cbus_arg parameter didn't appear to be a file (ENOENT), it will
print an error indicating that all three methods failed. If it did
appear to be a file but couldn't open the file for whatever reason, it
will print the error along with a suggestion to run as root if it's a
permissions issue. This behavior reflects the behavior of
`open_i2c_dev_by_nr()`.

> I don't think there's a need to expose _num() and _path(). In fact, you
> can even remove lookup_i2c_bus() as that is not used anymore by any
> tool.

I'll clean up the header and remove unnecessary header exports in v5.

--=20
Brigham Campbell
https://brighamcampbell.com

