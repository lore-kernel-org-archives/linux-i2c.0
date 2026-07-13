Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAB33260B
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934621; cv=none; b=UbGeTfLNje5cxvKXedK6fRPT26hiDBWgzHbJl35xC/DEPyN7bAl7IRYInq3obe4Vhxmoi6CV6qUR66INnftOUko16m6cHHMXvFiwKsXGnqDJfhQZmL/eVq15RQxWYhUDcqTan8Ox0/jDzzTh8lJkNeByfMr5ehQGRXN3WoC4rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934621; c=relaxed/simple;
	bh=oolhVP2VmJNZItkOtm2EB0KaMMTi5uCKFNpRtunbNjo=;
	h=Mime-Version:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:Content-Type; b=cuWU+lfDpO4z6qoOvOWUQ7CE9FV1Fyuu5wy5lSmqvDnqaKiO0kmjgiVylBc/ZxxxCRGqPNFrZGCT8nc1GuSSd7HKkL7sgv8OQw58W7+nffqqpcy7rBZUbiRe9NlU753HN1lEQkh+3cHsCaUfAB0n5805fh9XG82mXtafuG0/5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de; spf=pass smtp.mailfrom=sevenlab.de; dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b=G4owro/X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sevenlab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sevenlab-de.20251104.gappssmtp.com header.i=@sevenlab-de.20251104.gappssmtp.com header.b="G4owro/X"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so22928725e9.3
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sevenlab-de.20251104.gappssmtp.com; s=20251104; t=1783934616; x=1784539416; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GE1JtMdkYqtMh2YegEjUcvUR0gp50zjHcYK14LUHGJA=;
        b=G4owro/Xu/rC+4oAfVHEErHsqLpTKuRhTeCr12kpWKiZxRI7apTWxo5iDjBt1CTqWO
         vsUrb+Zjk7GAi/bnbMG1RW1hmNitDVPpxT9ghT+OAuSQYpXXPBWmS4cZ3tHscEFzzX+L
         iLhkeJNAMu6Y9kzVxKDOG65aoWFGKtRV3nKulmkT5XNq/7jDdc0vc+gdG2ZhrWxLawT5
         x5BG8xIom53FC/TK6FOqVj8bw76v7+/61F0/nfvOIlAofQNngNv4JKMN/oOI1bbLVpeN
         H1p12gxaeXNNES3C6k7/EHmqPNyqw5Atxqf6akg95dn8NBXgbjg1kgnu+42R29LiDJD3
         2Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934616; x=1784539416;
        h=content-type:content-transfer-encoding:in-reply-to:references:from
         :to:cc:subject:message-id:date:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GE1JtMdkYqtMh2YegEjUcvUR0gp50zjHcYK14LUHGJA=;
        b=lY0Oon1lQkCCW/jKfDQ/+m9e+sIHjdxInyeFuf+2quCDCUlM1lBQxUUHDyvQqNW+XK
         umnA26r3/7w6dry1epw9GqGseLn18pM3fL26KHuMubtZvtuxTfuhFBuorVRU5YwoIgbv
         k8TPh7Ng+7anLivzbO3+s6p9TsRGECJRkwZ4b9J4dDx40NE2RRxigDYBgw8HrM/jekvq
         poOto2z6PR0lmBSCo6PhZcXvga/Nnpjy52vsOgqSCNE5F0dL2H2sjiXth0+5Epcq0Y9f
         oAmDiuLImsqa3gbATx5OrXymKs5i8RwFcmekCDiufoyrgXEgyXeas+8v08NZFs7t5ImZ
         6e6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoFdEWhgFdSJ4rguyYYQ2FtL2NEod6b30QQtD+rSrkIZ1oHfFEx9Y+tTvHtEk12/kEtmAtnBTdlDHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2+ZXQglQ/jX/Coh7HrToP+KHh0fsgoMBLLZoMvQYTE1mXzcF
	vsTAKRVcbMDCpma7QM6l8Qk0GdYRIFTDQYJMhjKK8oZWb6JibfBtHbajhsWW0SQ+IXo1m5gcw77
	M+VWcBXKw61REXGKwM9d8TI7PEAfLRZSBw+7fmkHPKBFegGQyrIxCK7Mr
X-Gm-Gg: AfdE7clj8UFzy4u1iVzdfJ9moMk2DLYyQ/y8UVK+vtV9ZbzR1kn9Hjhv2ptK3P2wynX
	51armGrOfUBOVQ/U0kGjGTJqcmTRyOFiz2LuIZnE783yBydVVeyuH11h5TVcI6vWDUainnUpURJ
	Ytywi7cRZjb7uYMcXGRT6OlPL4RjmNgHCNezHmHycyCRLl/fwY3yMn5aA/XAhPMMtz1ujxm9sq4
	9WlKeB9+vhDAmjao4fXY16J+XbCfaG2t7FYnHyJK/DyFBpS45ByN17h8jfslkoPg+C9RUXu8430
	bNnEQLcj9WmcLR9uVSLbkK9QdjS1FD8j6Pb+S7FusrAqlfgo9jiRqXG2CORN2/X9dtAoWay2Uqp
	b8Awdtel1Pe/qOC9pj8yS7MvWR03tQCljsbBxKZ5NHI1qS1g/s80WWa48z5gZsvmRfo6R285sDe
	K+rdGXxZsXSibKEqAW5Runq1XB
X-Received: by 2002:a05:600c:198f:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-493f882994bmr80524015e9.28.1783934615742;
        Mon, 13 Jul 2026 02:23:35 -0700 (PDT)
Received: from localhost ([2a02:8109:eb8a:6200:1387:c6ae:4e5c:a893])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f744e8d7sm218692335e9.15.2026.07.13.02.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 13 Jul 2026 11:23:34 +0200
Message-Id: <DJXC1KBY7IXJ.32N5ILIXL8J4N@sevenlab.de>
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Cc: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
From: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: aerc 0.20.1-26-gcbffbc9ac803
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com> <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com> <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de> <alKYhB6PKffxI2vt@shikoro>
In-Reply-To: <alKYhB6PKffxI2vt@shikoro>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Sat Jul 11, 2026 at 9:24 PM CEST, Wolfram Sang wrote:
>> > -	i2cbus =3D lookup_i2c_bus(argv[optind]);
>> > -	if (i2cbus < 0) {
>> > -		help();
>> > -		exit(1);
>> > -	}
>> > =20
>> >  	/* read address range if present */
>> >  	if (argc =3D=3D optind + 3 && mode !=3D MODE_FUNC) {
>> > @@ -321,7 +317,7 @@ int main(int argc, char *argv[])
>> >  		exit(1);
>> >  	}
>> > =20
>> > -	file =3D open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
>> > +	file =3D open_i2c_dev(argv[optind], &filename, sizeof(filename_buf),=
 0);
>> >  	if (file < 0) {
>> >  		exit(1);
>> >  	}
>>=20
>> Removing this will change the error path, so a call that would
>> previously fail in lookup_i2c_bus() may now fail somewhere else,
>> changing error code and message. Same for all other tools.
>
> You mean that help() is not printed in some cases then? The error code
> is 1 in all cases, or am I missing something?

You're right, all error codes are converted to 1, so the error codes are
fine. Yes, I meant that a call with the current version may have failed
in the lookup_i2c_bus() call and printed for example

  Error: I2C bus name is not unique!

but with the new patch the lookup is done later, so it may fail in a
diffent location and print for example

  Error: No address specified!

instead. (Example for i2cdump)

This would be a problem, e.g., if someone wrote a script to check if
they have non-unique I2C bus names which uses i2cdump and evaluates
stderr for the string and if instead it returned the no address string
it assumed the check passed and all names are unique. Something like
this:

  i2cdetect -l | cut -f3 | sort -u | while read -r n; do
    i2cdump -y "$n" 2>&1 >/dev/null | grep -qF "Error: I2C bus name is not =
unique!" && echo "DUP: $n"
  done

That is the most reasonable example I found which may run into trouble
with the change.

Best,
Gero

--=20


sevenlab engineering GmbH <https://sevenlab.de>
serious engineering.

Gesch=C3=A4ftsf=C3=BChrer: Christian J. Pereira
Amtsgericht K=C3=B6ln,=C2=A0HRB 121730
Anschrift: Hansaring 20, 50670 K=C3=B6ln
