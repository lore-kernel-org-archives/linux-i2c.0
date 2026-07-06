Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCB3C3BFD
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319518; cv=none; b=KosLQ9UD04f5rq0Mkwf+JP75s+vdO1LqeSPDcha5ZANZ+ibDIfroFGN0QoUZtjcJu4pHrnrAc9QLPAdEjvAKj42ptACERjkHtDZPfABTGFLYvyXy3Q9pyK3Ga2Hgfew4p0rCDjBsKNHjIwbTOrmCVz7sEMGae3zrLjhu4X46w4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319518; c=relaxed/simple;
	bh=TA+xQH18UL93fWwPjzqg20xYFjNdIrWxFkQU74PgtGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V2dePJqEQXAhsBqlUp+K0nWeUIUxIfcMjU6OZEeazpxMk7umjKTGMAXJxkg5ib3iSgu788VGRhB5YG2wzBaE+CUDHOASRGeDQT+aFf0yPwPeUHLSDZ5zYwJ9bvsZcPcPpYQXMrwXDJ4gpybfYtLbe2MIk4HmzEkhEhWQu4AyePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=FZMKqOV/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="FZMKqOV/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so603454a91.2
        for <linux-i2c@vger.kernel.org>; Sun, 05 Jul 2026 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783319503; x=1783924303; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TDW7NrEtaPMPIp1zzkrumNAmcq9zwhWv23pLo0ZOV+8=;
        b=FZMKqOV/KrulSNB1NVKP8F95LHeq8Qj523N4lhaX1kp2WXll6QS9x1N/TFjcwbXoUy
         yKOuGUsL8I++fgE/FOI8/ktwr1LVlSphsEXjnVhJLrQz/ox9KJEZepVDzfD3XWo6Sb8y
         wwFg1aRjzGfF6riT2rDCOsPowA12OKU1GkWqik3l4CaE1xZuyli4HOToM+ZpaVAn/9y8
         sj4VnfaKgCarRz4tu28xkJnho8AuQTciL1gXqMfKts6aM18gfUQknwx17S8p9cSfg0DT
         fjyxlofNDe2ExTW9Alg0Ng8ahZjNyNDCW/LHKl6dgy+M5DMQSVUMgMewRPAqM2TTYjWg
         1n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783319503; x=1783924303;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDW7NrEtaPMPIp1zzkrumNAmcq9zwhWv23pLo0ZOV+8=;
        b=WgJ9SpB473OfB9y5Jz0PZSkFrkjPQkXE/epz1NS1ju1IEfHkB4nvhSphMfRf0LTvJ6
         PHjz9u4XhhxYQCop8Gb27DwMB/qMn/HnNRs8LK/AzUpeKKM5s5ulGhEF4oBf274gkaO9
         HJ2AUFTBv7s9Xd/HkZenR5i3xgq8reuzEvvXycKq4u782ZImN2Xs8Uow5rBl02GxEnjT
         3YBwrQ1jPB1kMCo6Re6YNojptHVE7ivOoXOUwtqgBxFw6n/7aeolhANoXWQPenvbDiLu
         pnzcYW7aYpSMipJ1VixiGLA0GYrNahGyGvPUBIwsT/hXM8Ytx6IfEUYzF/j8M29ofZsi
         rXIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Bu5wLP52y4li4uQzom2KNlI0LbiKYNpH2mml/vuz6HAfvGyLA+SfiKkUzXHih/oQC74+qfNRo8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGUoyuJrg/BNlKKfp1F7Gl+brdIVZpIdF3CtwZuv3hdl44oci
	5xirE8Omhty1QC4ZXaegmjiE6iSi2POvtLaD3pCZw6sw/Ry8EFWK5YYHlpi4OqKsWz9pfTQZC+4
	YK6tE
X-Gm-Gg: AfdE7ck51TOcge3aESQ0XUjOxkb7aYRSlssdsw2KpgFknNOjELI0nz/xujZDmdPAGRj
	/SBm0Wx/btku/CG7gA8HgpZx+Rx3iDuwOkhNw2eJwMBplcoBz+gNLqAbHZ1oIHfRgbQN0auDB17
	fzfoU4NH65ejInHXCl6Z7xxGJQWX0Lh8PSR8fr/KMYZtTU7/rZtekuHkaoafyorW8DHiIHCxReo
	IrbelSRFDJkKLqD/nT6gd9UkkvlDLryiV5vZtpsTuR7Fb37b32JAQrfqN1/y9Z6220zKm/WuyqV
	ZtrMSKM+z+cOoB4wqFtTVUT9t7+HaDEn4E0531tWcxQC7exU9eTwNK2MwssqBxl3MdvQH6ARCiD
	t3H+M0Ii53yuGGFQ6OaNkz3ChvuHRfjaIWD1wbSW4fYO/cFLPhm/1Ly2MAccbqUtrGznoJn6Ow6
	792P5wZrCqkI2SEpfmUAi6WHKgbYB1jcuba5qi+PkIjRikMPPg6XhNnHRBRA==
X-Received: by 2002:a17:90b:4d0d:b0:37f:9cdf:f039 with SMTP id 98e67ed59e1d1-3829f4e8519mr8910842a91.28.1783319503456;
        Sun, 05 Jul 2026 23:31:43 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm54428793eec.20.2026.07.05.23.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 23:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 00:33:43 -0600
Message-Id: <DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com>
Cc: "Jean Delvare" <jdelvare@suse.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Stephen Horvath" <s.horvath@outlook.com.au>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
 <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
 <SYBPR01MB4586AD69D431CAD2D26ADD68C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB4586AD69D431CAD2D26ADD68C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>

On Sun Jul 5, 2026 at 11:19 PM MDT, Stephen Horvath wrote:
> If you've got the spd5118 kernel module loaded (which usually happens
> automatically), you just have to run `sudo ./decode-dimms`. You can
> manually bind spd5118 if it isn't autodetecting, your dimms should be on
> your i801 bus (or PIIX4 for AMD), usually with an address between 0x50
> to 0x57.

No, the spd5118 module doesn't appear to be loaded automatically:

```
$ lsmod | grep spd5118
$ zgrep SENSORS_SPD5118 /proc/config.gz
CONFIG_SENSORS_SPD5118=3Dm
CONFIG_SENSORS_SPD5118_DETECT=3Dy
```

Using `i2cdetect` on the i801 SMBus controller, I see that it reports no
attached i2c devices:

```
$ sudo ./tools/i2cdetect -y /dev/i2c-15
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
70: -- -- -- -- -- -- -- --                        =20
$=20
```

Interestingly, I see warnings in dmesg upon running the above i2cdetect
command. Taking a quick look at the kernel code, this appears to be
caused by some transient controller hardware busy state which is
overcome by the kernel's bus arbitration retry logic (See
`drivers/i2c/busses/i2c-i801.c:1552`). It's strange that a bus with no
devices attached would ever become busy...

```
...
[  +0.000009] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[  +0.000010] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[  +0.000010] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[  +0.000009] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
[  +0.000010] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
...
```

In any case, if I am unable to exercise your code, I would still be glad
to review it.

Cheers,
Brigham
