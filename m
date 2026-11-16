Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813791;
	b=Iz6vXyknrBIjZ7P3kXZM8rYwsTyZ349ylLZ5QpxnfPG4esg3dk8l6tD+4x/ALpo7cDHj
	 H7TVWnGM5mPRmVqxlzkLNYtWKBotyHH45iCfcaOCmxl70AHV19+fFVC4ba+d2qhw+VOv2
	 SQtBqQ7+s38SGr/gNJp/IMSRGPKl7E2lvkaK0Nwbv1p9p+3z3pOMDrkHf3uLiVRv8ladh
	 qcqJUyHJm/rN4RgDvQZ0xQ3fclzBNldi4X6b7i/UjTY2T0SEF6FuygBUvH4wRTjLGEWjH
	 KEyXmUxvXUzdQvyVuKVoHGImwHILJ27CpS3gxcMEEqU2naTi4AyUV4MbeIPmcu8iGAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=/zKeEI4aCFR6WyEKnutJSqRxIPx3b9HZNNLsRhZf5x0=;
	b=K09GEd4Q7Xrs7lHXEdCRpqsbaBVLafDHyO6YkUDQciLVjGHsm4vwW7xA5k4wSNidNaq5
	 DVpvE89bWossy/Q+wdfMWtgSaDzJgYZTkvE+/dLhwr3VqkNzBEUGNC8hK++eFoP47FaCj
	 dGUzWhY7N3yi79Qb2fiss+CUAeNXyLp+AO+8M4B7IOM0++du0ZpOzGzmVDPwYYZu8Jtri
	 gVcPFkeBO51KUOv2YkyqoXup9oFEsw1qd0Hettk9KAJ7Qn2Q/0X6MN7vqX71LruCy1xEp
	 v8Cs4MiF7WPOWrT+7zvXaV8hHXJI4AXqHz3zUGlcZVBvuP8MhyHRA3b0MYIVVxHweCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brighamcampbell.com;
	spf=pass smtp.mailfrom=brighamcampbell.com;
	dkim=pass header.d=brighamcampbell.com header.i=@brighamcampbell.com header.a=rsa-sha256 header.s=google header.b=CXj1bvnK;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F27606A323
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 07:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F27606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.a=rsa-sha256 header.s=google header.b=CXj1bvnK
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3278597eec.0
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 23:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1794813790; x=1795418590; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/zKeEI4aCFR6WyEKnutJSqRxIPx3b9HZNNLsRhZf5x0=;
        b=CXj1bvnKknwnQplXZ46dhZPwMd7NnqkCbKAGYu6EUrMDn8LubPHAvC+UjQysRw5OUP
         Pr4aUilEvrTqZX98kwz/hWOfSmOeSIN9xec09XeNu+a5B1sYiifnFtf6M7lQ8Dx6XX57
         4C4Xz5D7K00K5ko5lq3tGt6C1P9hif+N52RZRk78f4MefN8AnZ4WSQnLn2OJcIfHfycO
         1oHu7JLvq4tqhc8pLUxPbEwRAVcynw0L+05SpANiZRV4ZWHm5xpqNhdE++LrXXCiEGBo
         ZquMWyvY3RtCH/QnfkAG0n0qq5rKkZLvlbJz+AXvN7VwssnMdf2A7eYioDkro9A8hFd3
         BhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813790; x=1795418590;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zKeEI4aCFR6WyEKnutJSqRxIPx3b9HZNNLsRhZf5x0=;
        b=1DN3hdxkmQTN647n89bsY1eY0PrKJM7D+eXrB+IxkukNouRs0x2rnZziweUK+zwCEf
         wM37h8tMKWtEIlGulV5amoGPY2kZH7iN7rrFLRjg8noTTfzz+LnuMQX306gMdtoOekPQ
         Y0ehPbLvvD4+NC8HTUrAe99/hqj75jzlMhpucZvX5QCnbHQkkYNygVyMU7c4hiPxSBCL
         B43qBmCSzNIr457TzUd3UNJh6JDQmNMaaq4W8jALz+/wn6aXxNo6R5F+n3pbVABb9Zs3
         agYSivQId638bslIB452iUwYDp9ZizVzLJGvezTaiIuUAxE8EbxHmOErnl/5ifLDuUnf
         6txw==
X-Forwarded-Encrypted: i=1; AL+hErHoQCBbJFNlmoLX0WzukT4a4aLPbf2KH21lhAJdEhI2AJHNy1y5fGh/MFB2mGdqEouSZRkY+yBKWKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IQSF2TQxgjXt0hlJAB+fasJ+JV8qJsaUmoBHeq/ytJYnNEGBs
	SwsCQNouXrwv3r1iv4osnxckFab4uACeT/cqILMuNqyoDllvN/IxO/H70JS2J0CHAskmfN5Uz7y
	RKv95
X-Gm-Gg: AYBFou1b1Mgfs3VTsnNufyD2gc9R5g0dp9Shw8it28i7err7cvbVybIJWigsvtl0WVd
	39PBb4L91paRWMajyrKxn6MlwP2j7Gj/2+qRDXt+TjR4nWab8yjJarDlseTrTlP36bqu9AAskbc
	VaNrYrk/PM8p00K/uExKwpWfyNgjiTSj3ALotu69Tysb1RVY9XkEFCJ2RP7wyakr3F9TOYlpH5/
	l1Ldpxhny1PPi/tPLdVkltrS/QEPULLS5mTba9+cOng5WI5uTbdHLyL7d3Mz/oayt6UqfjeTgK1
	H5SiUIdRCF+5DPl8ZkIm0QF3i1qnfi0xVJ3aNzMCAviouVPMKr+4cn9dHULfIlZktEIg5MWZi52
	uIWR4OQSO2W3c2nWk9+P+5PC/T9W1zlQQY8egLMj5mqiW6DY6bbYHiOX6zkMicv1e07/mbJxS52
	7CGfPDVNCDjRiM9bfAk1IhfGjrAdlus7qQXM49/PGVJNETzeVzngjizyY5fmYZdCAnUsd2UsZZ4
	bjrZBfRiP6pu3c+sGGocSOJx/kseALU9xaczmD1HWkuKQvPXg/FkX11MvouPIH6HN66B5JytsFf
	UeMIm2b/lvZU5zSyjjSE7OZKMV8mIUx7tlBJ1eavYNWvXj7c6Loc+Nan+np8GE8F3VXB/YSq
X-Received: by 2002:a05:7301:1625:b0:36c:9f1a:30b8 with SMTP id 5a478bee46e88-37966c4a5fbmr10336476eec.31.1794813789601;
        Sun, 15 Nov 2026 23:23:09 -0800 (PST)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm34607127eec.23.2026.11.15.23.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:23:08 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 00:23:07 -0700
Message-Id: <DMWGDZA99U2V.ZHHILKEL821X@brighamcampbell.com>
Cc: "Jean Delvare" <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>,
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v5 1/2] i2c-tools: Allow passing device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Brigham Campbell"
 <me@brighamcampbell.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com> <20260722-accept-device-path-v5-1-9c0bf9b4da26@brighamcampbell.com> <avB0jS2RfBHgZ6Zi@shikoro>
In-Reply-To: <avB0jS2RfBHgZ6Zi@shikoro>

Wolfram,

Finally getting back to you after a good friend's wedding.

On Sun Nov 8, 2026 at 6:09 AM MST, Wolfram Sang wrote:
> On Wed, Jul 22, 2026 at 02:52:40AM -0600, Brigham Campbell wrote:
>> +	i2cbus_ul =3D strtoul(i2cbus_arg, &end, 0);
>> +	if (!*end && *i2cbus_arg) {
>> +		if (i2cbus_ul > 0xFFFFF) {
>> +			fprintf(stderr, "Error: I2C bus out of range!\n");
>> +			return -2;
>
> This fails if you use a name/path like "1111111111111". A diff like this
> makes it work:
>
> diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
> index 40d863f..47ebffa 100644
> --- a/tools/i2cbusses.c
> +++ b/tools/i2cbusses.c
> @@ -436,12 +436,7 @@ int open_i2c_dev(char *i2cbus_arg, char **filename, =
size_t size, int quiet)
>  	char *end;
> =20
>  	i2cbus_ul =3D strtoul(i2cbus_arg, &end, 0);
> -	if (!*end && *i2cbus_arg) {
> -		if (i2cbus_ul > 0xFFFFF) {
> -			fprintf(stderr, "Error: I2C bus out of range!\n");
> -			return -2;
> -		}
> -
> +	if (!*end && *i2cbus_arg && i2cbus_ul < 0x100000) {
>  		return open_i2c_dev_by_nr(i2cbus_ul, *filename, size, quiet);
>  	}
> =20
>
> That should do it, or?

Yes, this looks correct to me. However, the behavior of v5 was
intentional. It's reflective of the behavior of i2c-tools before my
patch: If the i2cbus argument can be parsed as an unsigned long, it will
be treated as the bus number. i2c-tools will never even make an attempt
to interpret it as a bus name.

$ pacman -Q i2c-tools
i2c-tools 4.4-4
$ i2cget -y 1111111111111 0
Error: I2C bus out of range!
...

Printing an error instead of trying to parse the argument as a name or
path is an undercommitment on the part of the user interface. It makes
breaking changes to that 0xFFFFF boundary easier. When we increase the
boundary size, we don't need to worry about users passing
(PREVIOUS_BOUNDARY + 1) and expecting it to be interpreted as a bus name
or device file path.

Even if we know the boundary will never change, I think it would be
better if users can always expect unsigned long values to be interpreted
as bus numbers directly, even if too-big values always result in an
error.

If you disagree, I'm happy to make the change or you can make it
yourself, but I'd like it to be a follow-on patch to this series because
with respect to this particular issue, I made an effort to preserve the
original behavior in this patch.

>> +	fprintf(stderr, "Error: Couldn't interpret `%s' as a bus number, "
>> +		"name, or device file path!\n", i2cbus_arg);
>> +
>
> I think this error message does its job very well. In my book, no need
> to make it more fine-grained.
>
> The rest (including patch 2) looks also good to me.

Thanks again for your thoughtful review!

--=20
Brigham Campbell
https://brighamcampbell.com

