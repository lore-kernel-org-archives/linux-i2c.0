Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1913A3ED
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499623; cv=none; b=c2oA1oHC0b04m3hd3KjFInFMj4UERd3c1uJVxsLkRmUFysDOG/LeZ/1LWigBsW4PFeAMu3AxG+rp7HscmbBRyFM0LSxjWsiy9BrEzlJO20a6A9QWfQ3DgWqxj0R5GUFwtr3keXMtprQe16sSvh9KkTAAhvCRok/pJ4Vf1OaxxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499623; c=relaxed/simple;
	bh=HBxrval126OsSIfUV/m/TtYykz7BR0Po+Gosn2ztWhs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KpfstJPHPr4Lq2/GM/T01jSnq1W4PCJjYG5zcqFCvDbqzJtkVjqlYFy1thhFswvP+XtuHlvkaIN7p3tMLV3Ok756ZOde0w/9vB4buhBXyjFkErVw2Jgg7t/nXNepkaTeRu5TteVcXvnbjk8YP7yVShUBnf0dMc044qMoif/OS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=j+KTbnOv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="j+KTbnOv"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca913a601fbso6430886a12.3
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1784499622; x=1785104422; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=68SLrkV226FLOU2H1Ncgh6uShsGhFui38dyfzWAcvR8=;
        b=j+KTbnOvsB7bRvoiq4piOU6IYDGMVfxsLagMb0xt52jALlOhAdLAseJYe9LOBJyY6J
         ScucvsMLr68gLXqDtYxaoGrPK5hZkktEuF8krlCkCu52jLPxhpT01MdT0H9fqqn+FVFZ
         9nH3rDg/JFAeLAuBfGUR67qp65fSmWQ1e4OzJ3i4WLMqrnb/0ZoSo8H/N8Cq2BlUqi5G
         lxpmBMIoOc3glF4JXlxYfPX8QNe+tqevj5dW9L82O+4JjpeO2mELHfn1qXp07/dqInDg
         hVQC2EUGItW0TXaz/yWtj9uhoMnuYzYBC8pcl5jqgFHoqg4aFWBmCUvItCnpbG0BooZv
         6zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499622; x=1785104422;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68SLrkV226FLOU2H1Ncgh6uShsGhFui38dyfzWAcvR8=;
        b=l7kBGjdKYI2mgzjctwaBGAiFJ9k3/GzgGxDGxNL69EBuu7Hc482+Y+axvYsIHZHNH0
         PDbQpgzn9G0vU43hMRiVpWZp+YdjqZ/cv6706qXfigcfeLCPN2msnFIrZ56q14NjrxRp
         dhwYR5Q9m5ESHbGDpOtt6oZ+BhmROUnInI5PoySP/Hjx0nc6sJOi7NdonnUD3LgkKa18
         P/xagVqJojPxed4QP8DzubT1ig19uVcxNIv8UJmUgIq7I//w+uB0S4ztHgV5eIDAIYDR
         KYlFmdGxXA1EqGLHcUx8FvPypARL67zR3vXIOZMW9M/RSTrfOCmXrK8jNsiwSpNkfkt9
         tlcA==
X-Forwarded-Encrypted: i=1; AHgh+RrcjGOhA3P0OWO3Q29BWe+ZmdC/lA//3hhQOAY/yd8MGK+6BYqGob5LAMGf2GpsgO9FrxZZWChGZAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6XbtuprPZKt2bID5hfHjUpqckJ+bKBC+w7cZh7J5sWF6rdy5
	HfPqDun4wkU9+UPDrR4pdzihPNdIsdIHMrQ4JkDybNZPnmFbnc+I05PM3AMN29LFK2IkM+Sgrz5
	cVz5Mixw=
X-Gm-Gg: AfdE7cnOubvoly+2EFEFQFsKrGKNucH817eDgU/je9kT+TWVRnTf5KqI++HMCluKyIX
	9WqBfYv0qi/2AmBQcnDuHUSHvVKjpN05gcPTOYZ7X0/xM+dSxKqpjxHsEWXssJy5f9CZ5w1yb9Q
	D6IqTd5/rKHkyZT7BksiTft/7uMW1dxa+J175X3o2r+u7IHP/7agj4Y6FJ6f2rOzH/sg4dcr/TB
	YB+4DMJWz6I8ycbY3gUP6l63KrT8BGr2jbLR55xP7pmk8t1f7LXFw1v/KXLKfOegiduaK8D/Yog
	dQr1GNy28+2byMTqalLPlCH2MGGX2bE9bMqbR/XoxtjgpwjAXO95sCzUjpFD2aWzkyd1o83ldVc
	vvZx/wEvKE5v8ZpR9cu2AXN5416gQBmaf4kqgqCk7Vdyok7lGxGd+iuWS4/oD2hK/Hg8p2fXo86
	n1go/d9dTTDW3nlw753RPmINYfw+p5lsX9DgJPdkaaaNftQS2r
X-Received: by 2002:a05:6a20:430a:b0:3c3:90e6:48be with SMTP id adf61e73a8af0-3c3ad77b3a1mr12466848637.30.1784499621799;
        Sun, 19 Jul 2026 15:20:21 -0700 (PDT)
Received: from brighamcampbell.com ([50.220.100.118])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a18a47sm25343260c88.8.2026.07.19.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 16:22:53 -0600
Message-Id: <DK2WDITRVN2Z.2QAZXR6BWBFB1@brighamcampbell.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
To: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>,
 "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de> <DK02UVSWWGTN.2M4XXGFINRT1V@brighamcampbell.com> <DK0V64S4JWAS.3PNF8V2ZQEDPY@sevenlab.de>
In-Reply-To: <DK0V64S4JWAS.3PNF8V2ZQEDPY@sevenlab.de>

Hi Gero,

On Fri Jul 17, 2026 at 7:00 AM MDT, Gero Schw=C3=A4ricke wrote:
> On Thu Jul 16, 2026 at 4:49 PM CEST, Brigham Campbell wrote:
>> 	if (errno !=3D ENOENT) {
>> 		fprintf(stderr, "Error: Could not open file "
>> 			"`%s': %s\n", i2cbus_arg, strerror(errno));
>> 		if (errno =3D=3D EACCES)
>> 			fprintf(stderr, "Run as root?\n");
>> 		return file;
>> 	}
>>
>> 	fprintf(stderr, "Error: `%s' is not a bus number, name, or device file =
"
>> 		"path!\n", i2cbus_arg);
>
> I'm unsure about this: Yes, this reflects the behavior of
> `open_i2c_dev_by_nr()`, but we only call that after we have validated
> that the input is indeed an adapter number.

The input is not necessarily an adapter number. We call
open_i2c_dev_by_nr after parsing the argument as an unsigned long, but
that's no guarantee that the input is an adapter number.  For example,
if a system has /dev/i2c-0 and /dev/i2c-1, `i2cdetect -F 100` will
dutifully try to open /dev/i2c-100 and eventually fail without trying to
interpret the number as a bus name. That's ok because it's just a
heuristic and we don't expect the collision of file paths, bus names,
and unsigned integers.

>                                             With the path we don't do
> that, we just try to open the input as a path. We know it's not a valid
> integer, and not a valid adapter name, but it may still not be a path,
> maybe it's a mistyped adapter name.
>
> To that I'm not sure we can conclude that `errno !=3D ENOENT` means it is
> indeed a path.

This is a good point. `errno !=3D ENOENT` doesn't necessarily mean that
the parameter is a file and that i2c-tools should be able to open it.

> Looking at libgpiod (`gpiod_chip_open_lookup()`), they solved that by
> assuming that all paths must start with `/dev/`. Unsure if we want to go
> that route as well. It would definitely simplify things and I think for
> the sake of progress that whould be fine. Thoughts?

The approach you suggest assumes that when the user passes in a device
file path, the path is _not_ a relative path, devtmpfs is mounted at
`/dev/`, and if the path is a symlink, it's also in `/dev/`. Maybe these
assumptions are ok (after all, libgpiod makes them) but they seem
unnecessary.

What if we only indicate that the argument couldn't be opened as a file
specifically when open() returns EACCES? Otherwise, we'll print a
generic message, indicating that the argument couldn't be parsed as a
bus number, name, or device file path. Even when i2c-tools should have
been able to open the argument as a path, but couldn't because of some
unrelated error, the binary will print a less-specific error message
which is still applicable and correct:

	file =3D open(i2cbus_arg, O_RDWR);

	if (file >=3D 0 || quiet) return file;

	if (errno =3D=3D EACCES) {
		fprintf(stderr, "Error: Could not open file `%s': %s\n"
			"Run as root?\n", i2cbus_arg, strerror(errno));
		return file;
	}

	fprintf(stderr, "Error: Couldn't interpret `%s' as a bus number, "
		"name, or device file path!\n", i2cbus_arg);

	return file;

Sorry to double down on the bikeshedding (again, I do really appreciate
the feedback)... I'm interested to hear what Wolfram has to say. I may
send out v5 (which includes the above code) along with an invitation to
either make editorial changes to the patch in case the maintainer has
something different in mind or request that I send out a v6. I have v5
queued up which includes the above snippet.

--=20
Brigham Campbell
https://brighamcampbell.com

