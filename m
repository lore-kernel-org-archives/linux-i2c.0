Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BED32D7FA
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605450; cv=none; b=J43G5xeytlA1K1+ZuI6MciEpvYcSy/3T09Q864Vv65TNA+LG0vuV9CLUvkfZ7wFdHvVp/LFsVDarAknyh6dmoI6lCo6S2RLsCrVoErXzsrt169h5WUQvI9gv3AyHKC4Ii7Fqmbd6gcg30H8m+oOMiiNhxUuU7TNk1uFh98N/Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605450; c=relaxed/simple;
	bh=ndx+vEwy5V365gtO3J2ZYlHpfklAxwEqKnsupgJSgcY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=AiwIkGCsPr5UslCOGdmZ6ZPkSokC90MyDa/1NmnLxVgFUKDgPabO0IEbmamCtM8EUjcz5fn9aHjmqZIPvld848VSoDSV8TZ3BZHnMH+EASVwPDeXSBGVM/i/880zvSZ1ZJSwJtGMYfJ2Smh+9n8ihI54DA1WM0bo/fHG1MiNOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=fpc3uXiG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="fpc3uXiG"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1521123a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783605448; x=1784210248; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wAVmdXDJ0ET9bm3IqIw69WkaCziyrbeBeSRteP0bKvI=;
        b=fpc3uXiGO9ZoKpNvB3KoRxFOsgb9URfALMtxFDGLuE5AiC4HTSpPK1QKQE8VkZm3JT
         fg1eY/UcVHUcf9T0QaElrt4UJJNlmwom6FLJ0kDNUMSx+FgQM7nqy3DX+5C33YOaSdaD
         o9uOBE6PX1nK0J2yLviAzMxW8XjAB3e3WTGRsOabCVHn/lItkdH0/Xz/ONyq56JFzrz0
         aX61M6/hm4li/hKvLF6f2ERARGl89bj690AZZRMhWIQm1q5kwFLMkyrGrq5yvnBnPeYV
         H3h1VP2iio4iTZCnJqEtvFIFEnCNxzwIF26gBAAR0vzGDwKYXS75GYGaEVFUa0w/xAol
         YiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783605448; x=1784210248;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAVmdXDJ0ET9bm3IqIw69WkaCziyrbeBeSRteP0bKvI=;
        b=CGn9XpwqW8lw8S1b77tugkizBHRr30hoiV9PcvVk2A5ltCW06OS6kttVBvDQwA+HJT
         eX1eB19fC2MmtKngFjQjzuYyuIv74lPKkdwZuB5EfvHim7+pqR3Tw9QxXfkG7A0M7SJq
         ZJd3gSQtRdrxXfDiPYOGfIBChweowFlxRyS2JIOnmao6eUkJ9g+bCaNSUZlbaO9cx/Ze
         1kxFyZkXt2LuE8qWVUx6wOcNF2qyZ7IMXux6jG8uhBfduEdwd7Iv+b0jg2SN+w2mlDs9
         WwzSshU1ZoAEWxJOnT0pL5u7flZYrLHQTHumvxzA+RnQjON9e7hwe0KJTEylsYrdaHxM
         g37Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq5UQmCitbYHhYd2rX6Ac5ka+g2EbrsXLFMQHxIxeTmq1Y8OdW0Is9izqqp1TlmXD/uZ1e1S1OjTIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64O5/TxbU2H4vYjfiA46GAlkrApOSvSVDRAiHqEnqcYXejx44
	dbkWwCP8nlV7wRm/cUURCSmQ5X/IdFOhS3cG3Z7kRvilHHtYqsghK3/E7erkoQ0iAoPQrpNJQMk
	XgMc/
X-Gm-Gg: AfdE7ckRcjtPCF7CH39fkmDx8ZSHXo/wrd/s+sgegRR5/VlYZun3zVDL10LkFTbCJhU
	u6SJqiwti+DQrek2I3t2j2lpk57AfLNw93rmyu32RCVApNk0A+Uys4g2FMKjuTvTbhD52+7ILhJ
	5NTB1hm/wg4vAPdAhVOoKbOtletjkAwOg1/1IYVT4mObvWGvgHtUOq8f6/HYPT5TMMiKl20cuI/
	Sl7NM//frIoMsU0dgWj5q8KZSmCq1Lrds3Yv2upMhLXMxxEFeASwviz+7LcNUPWYXjctq1Pmoto
	wrLTF4IeaA+b3Nv6hWOWtuTKA1HM7ij4I6MtLXAQhFAjMA0jbsNfneDtr+PhIJrQ4IX/7jZYbJ0
	PmSNWTKEcdVn09oPVHpjnSIi7hLJHpx5wgv5SkhpxI5ar2T72V3bcJ9twx0UDccBQBgvlxPvHEG
	updwN7S+1mmzHisS6N8R61CmlX4gQVIDV0yDGFEV9acZHlWog0+/ogGVq1kQ==
X-Received: by 2002:a17:90b:54cd:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-38941cc52b4mr7215187a91.23.1783605448178;
        Thu, 09 Jul 2026 06:57:28 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119d5cf176sm9958976eec.12.2026.07.09.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 07:59:35 -0600
Message-Id: <DJU3EPM5DUEC.2QZ9MDI7NCDVT@brighamcampbell.com>
Subject: Re: [PATCH i2c-tools v3 3/8] decode-dimms: Decode timings and other
 data for DDR5
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Stephen Horvath" <s.horvath@outlook.com.au>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Jean Delvare" <jdelvare@suse.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "Guenter Roeck" <linux@roeck-us.net>, "Kamil Aronowski"
 <kamil.aronowski@3mdeb.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
 <20260629-ddr5-v3-3-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-3-07f45075a51a@outlook.com.au>

On Mon Jun 29, 2026 at 1:10 AM MDT, Stephen Horvath wrote:
> Decode size, timings, and other data for DDR5 based on the JEDEC
> JESD400-5B specification.
>
> @@ -2128,6 +2128,280 @@ sub decode_ddr4_sdram($)
>  	}
>  }
> =20
> +# DDR5 Rounding Algorithms
> +sub ddr5_min_round($$)
> +{
> +	my ($tck, $ps) =3D @_;
> +	my $correction =3D 3;  # 0.30% per the rounding algorithm
> +	return int(($ps * (1000 - $correction) / $tck + 1000) / 1000);

This subroutine seems to assume that $ps and $tck are passed in as whole
numbers. In the datasheet, these quantities are wrapped in a trucation
operation before they're used in the calculation.

Maybe it's worth wrapping $tck and $ps in int()? However, this is not a
problem if the caller always makes sure the values are truncated.

See "Rounding Algorithms" below section 8.1.20.

> +}
> +
> +sub ddr5_round_twr($$)
> +{
> +	my ($tck, $twr) =3D @_;
> +	my $correction =3D 3;  # 0.30% per the rounding algorithm
> +	my $new_twr =3D $twr * (1000 - $correction);
> +	$tck =3D ($new_twr / $tck) + 1000;
> +
> +	return $twr / int($tck / 1000);

Is the body of this function equivalent to the following?

	return $twr / ddr5_min_round($tck, $twr);

No need to duplicate logic in ddr5_min_round, unless there's some reason
that's not obvious.

> +# Return combined time in ns
> +sub ddr5_ns($$)
> +{
> +	my ($bytes, $index) =3D @_;
> +
> +	return (($bytes->[$index + 1] << 8) | $bytes->[$index]) / 1000;
> +}
> +
> +# speed
> +	prints("Memory Characteristics");
> +
> +	$ctime =3D ddr5_ns($bytes, 20);
> +	$ctime =3D ddr5_round_twr($ctime, $twr);
> +	$ctime_max =3D ddr5_ns($bytes, 22);
> +	$ctime_max =3D ddr5_round_twr($ctime_max, $twr);

The datasheet indicates that these quantities are in
picoseconds, not nanoseconds.

> +
> +	my $ddrclk =3D 2 * (1000 / $ctime);
> +	my $tbits =3D 8 << ($bytes->[235] & 7);
> +	my $pcclk =3D int ($ddrclk * $tbits / 8);
> +	# Round down to comply with Jedec
> +	$pcclk =3D ($pcclk - ($pcclk % 100)) * 2;
> +	$ddrclk =3D int ($ddrclk);
> +	printl("Maximum module speed", "$ddrclk MT/s (PC5-${pcclk})");
> +

... I skimmed a little here, rather than verify every single register.
It looks pretty good. :D

> +
> +	my $taa;
> +	my $trcd;
> +	my $trp;
> +	my $tras;
> +
> +	$taa  =3D ddr5_ns($bytes, 30);
> +	$trcd =3D ddr5_ns($bytes, 32);
> +	$trp  =3D ddr5_ns($bytes, 34);
> +	$tras =3D ddr5_ns($bytes, 36);

These also appear to actually be picoseconds.

> +
> +	printl("CL-RCD-RP-RAS (cycles)",
> +	       ddr5_core_timings(ddr5_min_round($ctime, $taa),
> +						$ctime, $trcd, $trp, $tras));
> +
> +# more timing information
> +	prints("Timing Parameters");
> +
> +	printl("Minimum Cycle Time (tCKmin)", tns3($ctime));
> +	printl("Maximum Cycle Time (tCKmax)", tns3($ctime_max));
> +	printl("Minimum CAS Latency Time (tAA)", tns3($taa));
> +	printl("Minimum Active to Read/Write Delay (tRCD)", tns3($trcd));
> +	printl("Minimum Row Precharge Delay (tRP)", tns3($trp));
> +	printl("Minimum Active to Precharge Delay (tRAS)", tns3($tras));
> +	printl("Minimum Active to Auto-Refresh Delay (tRC)", tns3(ddr5_ns($byte=
s, 38)));
> +	printl("Minimum Write Recovery Time (tWR)", tns3($twr));
> +	printl("Minimum Normal Recovery Delay (tRFC1)", tns3(ddr5_ns($bytes, 42=
) * 1000));
> +	printl("Minimum Fine Recovery Delay (tRFC2)", tns3(ddr5_ns($bytes, 44) =
* 1000));
> +	printl("Minimum Same Bank Recovery Delay (tRFCsb)", tns3(ddr5_ns($bytes=
, 46) * 1000));

Datasheet reports that bytes 42-54 actually are nanoseconds, so this
usage is correct. When fixing the other measurements, be careful to not
switch these from nanoseconds to picoseconds too!

> +	printl("Minimum Row Active to Row Active Delay (tRRD_L)",
> +	       tns3(ddr5_ns($bytes, 70)) . " / " . $bytes->[72] . " cycles");
> +	printl("Minimum Read to Read Delay (tCCD_L)",
> +	       tns3(ddr5_ns($bytes, 73)) . " / " . $bytes->[75] . " cycles");
> +	printl("Minimum Write to Write Delay (tCCD_L_WR)",
> +	       tns3(ddr5_ns($bytes, 76)) . " / " . $bytes->[78] . " cycles");
> +	printl("Minimum 2nd Write to Write Delay (tCCD_L_WR2)",
> +	       tns3(ddr5_ns($bytes, 79)) . " / " . $bytes->[81] . " cycles");
> +	printl("Minimum Four Activate Window Delay (tFAW)",
> +	       tns3(ddr5_ns($bytes, 82)) . " / " . $bytes->[84] . " cycles");
> +	printl("Minimum Write to Read Delay for Same Bank Group (tCCD_L_WTR)",
> +	       tns3(ddr5_ns($bytes, 85)) . " / " . $bytes->[87] . " cycles");
> +	printl("Minimum Write to Read Delay for Different Bank Group (tCCD_S_WT=
R)",
> +	       tns3(ddr5_ns($bytes, 88)) . " / " . $bytes->[90] . " cycles");
> +	printl("Minimum Read to Precharge Delay (tRTP)",
> +	       tns3(ddr5_ns($bytes, 91)) . " / " . $bytes->[93] . " cycles");
> +	# Optional? Not stated, but not present in my modules.

Is this "Optional?" comment referring to the following code? Sections
8.1.48-50 don't appear to indicate that the following information is
optional... Maybe you already mentioned this somewhere, but did some
behavior during testing give the impression that these values aren't
present on all DIMMs?

> +	printl_cond($bytes->[96], "Minimum Read to Read Delay Delay for Differe=
nt Bank in Group (tCCD_M)",
> +		    tns3(ddr5_ns($bytes, 94)) . " / " . $bytes->[96] . " cycles");
> +	printl_cond($bytes->[99], "Minimum Write to Write Delay for Different B=
ank in Group (tCCD_M_WR)",
> +		    tns3(ddr5_ns($bytes, 97)) . " / " . $bytes->[99] . " cycles");
> +	printl_cond($bytes->[102], "Minimum Write to Read Delay for Different B=
ank in Group (tCCD_M_WTR)",
> +		    tns3(ddr5_ns($bytes, 100)) . " / " . $bytes->[102] . " cycles");
> +

This patch is looking pretty good! Impressive work.

Cheers,
--=20
Brigham Campbell
https://brighamcampbell.com

