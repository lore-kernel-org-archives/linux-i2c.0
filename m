Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC43D5661
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643875; cv=pass; b=JVHqPn4jGTgNT5Vo5VEc+9Ofo7ETdfGatDp9h8Tw7rQHe5ZhFwDILQPsgDoBfix/J+6ICtLn7YUBLsQTd4VmOF8fPY+WeoJkYhkH4f0LCWvPTVB2MLQYOJ6QA875X78HsfWKXUwpQGX48mGJckfnRzjsyxHpurlHbvISDthvhKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643875; c=relaxed/simple;
	bh=Mii/DeCzm2nMtl3hgGSjPHkjrDmEfCYXtshu5NQAkD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWMPzP5i0bY7jLGHzdy3xBYmXjFBv0bfEf8UCUeU0K+oBs6nVlTnaxeEEX4Zsu3WrCPv/TbrLmW3ILtJ430UoXwFMKljEJgiNngdlgMUQAbn79clj/Z8ttD52T7yyF8xSQYng5UVKqpTzkDzwoEXk0argfJ7mhWqaE2ujw70Xj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JLr3KL47; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLr3KL47"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66d06b5f023so2815498d50.2
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 00:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787643872; cv=none;
        d=google.com; s=arc-20260327;
        b=cfQP0e3arQlH4dBxOVMVmk3OXF0I+gymTJUuz1EVPrTkKMbJFyuX/F7H1bfoYJGAJx
         KoVYEh1jlNVo1qo2kRhUCsJm9clrTcoD8xhMK2olZLTTjTNq76G8ScELXi2dq3oMrfqU
         15cpX8fSVfI0DEHDe2mJwSDQThFez9MrCr4upMeIULRZJeFtV4Zt1jZHsj3r+eDrPFkz
         dJHxWfnuKQ7dKQ+IcgsbDOyX8NkaDUG5hIS7p2JC5zle8bSYkPetsVN++7GxOnCS+HGl
         U5rlHvmjSmNm4rB0ofpqApeuB4usCvB5UBsFu+BXBeiy3fxFP9B3z5tKkZ7hqduY33HW
         /N1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/xJK88pfs277nwbYNBwPuRxCY6IirnLC5W4+cq/H6A=;
        fh=bk5NgAxcroe8m9ktYeC9HI0h58DSJqm1Q5mAGc1DP0o=;
        b=Rs7TTpro0ckNIpSXjiZ2wf2q/4RtzvuT/YiYq47SXPh6xmjEkWyFWVStnfH+x6kWdU
         PDeKdv5ECbpmlP6boMNXvpJjPdoZKgmh30S4Kdn1z1qSOfJibJ6NBxQtfjP33ocnW19W
         FaHkdEIb/uJDVIYUSkqOBARepsJFml9PgWd3ugaekI6Q99HJgLLrrhXhaZv6gBVati8T
         MIcnwE0xUl78R8IWVwPDyCIKZKvA/YlPc5FMXAUlUr15V6f3fibbeyrzv5huj8dGngXb
         wUnty0QKloM7t1YOt6N64/zeZFyMkTaDaoli7+oPLC+fSRx67hrXOMG946/dn0qUFolr
         yBzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787643872; x=1788248672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V/xJK88pfs277nwbYNBwPuRxCY6IirnLC5W4+cq/H6A=;
        b=JLr3KL47G4Cb+UYRYWyCFGDjVUpsKQwlnkO7htak24Xgd7PDtjfTg2gNjGnWSXY1Hn
         eapcVJmFJBl44VIEq6wcBHEZCnmZ9QYYBV3wC61d3sZei+nIbrcOpHee52YhHqEDDrpn
         4GfuC2xBh6ZJNaVU9czMBJdtJ+TxAZdSBMTA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643872; x=1788248672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/xJK88pfs277nwbYNBwPuRxCY6IirnLC5W4+cq/H6A=;
        b=dGgLmUbkWJF4n0CudIwbpf33kPTb6hEcYFhyHDLIXG90VOcptu9/XloyNFkM/H/HUR
         lMAO+SqgjXobs0lvsMeZGr8S2yo/RH5ixCT6NAajeYPrjZ9MyIqV/apJHrPKUMXVPzb1
         mR5p9BLbpP9aJzDk+ITykE6fDyAQba5+mxUrtip+RSZusajKrnjIRXO9h6LNPrmRklGX
         a5qnQM1atSj86nA5p/KX1Xxlcvhx+jpMkq1iyQjvu60+VuXHp1/bWGQ4kiCO35Hc4Qbw
         0Vj/Lz2zHJ7HWMMioefOy6WbBGzMKo8sJzQY/2vK80ucEhM/jHJnvnbhdJ/585mBGp0Z
         TgoQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Y6ZbB5OoH748TNBQh9JtcAbz/PEBPvk802JZLGFfI2Fi+aBGf74ADFtHszDk9dz66+6YAa/XJ60=@vger.kernel.org
X-Gm-Message-State: AFuF++nLbEqaipMomFdUtn3ffh1wwe+weWzak6OvxmphTPIReJBsR10k
	eRnSWJIWHggCwzCllOSSvGu2XV28aMmto0HG095amsN1nCsVxkrZQaA9S9do7bGaFvrK2QdIvr7
	TFRyfy0X8+0CYAHzRNPEdxMasYxnokHJ7eu6qefcV
X-Gm-Gg: AR+sD11xxQf+rKrFdOt6BsV4PODVML4k1QdmH+glULtaSuUKm8W4PiQcU345LpX5G/k
	7qLZTsSWTUwxZDKiwPsu4bpxGHGnGwJjtrdm9StdpUdOinA75uHeKGubGQZaT2vtOhrt92RlidM
	VV0mymgeX++WXCWZSPTgI7wt7gdsAdZFRFwh6AFnhyDUWFNfCHlM4WY5GrQQT6GgO8/tC0PS3Z6
	0ti/FwbRhnwYBQerMaDrZOUUXqEw9DBtyb1aVhR7hzXX9uL9Lm0OLFwWQpqEWugGexJ1gd5snm+
	M/4iM01i3VRrZdSSAYi7VSSJDqWf0Jk0AraxJAj9iTWj/EQ6KhaYwIbi0iEuJXflbJJ7goOR
X-Received: by 2002:a05:690e:1449:b0:66d:1131:b81d with SMTP id
 956f58d0204a3-66d1131bc41mr2549091d50.29.1787643871703; Tue, 25 Aug 2026
 00:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825041628.988369-1-wenst@chromium.org> <20260825041628.988369-2-wenst@chromium.org>
In-Reply-To: <20260825041628.988369-2-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 25 Aug 2026 15:44:21 +0800
X-Gm-Features: AcwNN1VHbO3y1ftfkF_7R2W7KDk8RFMySudnf-TTSiUhjGplV2Fwnh0fieb32LM
Message-ID: <CAGXv+5Het3zp_OTp=_ktg+_d5Q55zkE0SwQnM7TVyJDmOdBtyA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] regulator: core: Add "enable and wait" functions
To: Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 12:33=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> In device power sequencing and initialization use cases, it is common
> for the driver to enable the regulator and then wait for a certain
> period of time to pass before continuing.
>
> In cases where the regulator supply is always on, or has been turned on
> or left on by another consumer, the driver could shorten the delay or
> skip it altogether, provided that enough time has already passed since
> the regulator was _actually_ turned on.
>
> Tracking this requires support from the regulator core. Introduce a
> "last turned on" timestamp field to the regulator device, and "enable
> and wait" functions to the single and bulk regulator consumer APIs.
> The existing "enable without wait" functions are then converted to
> macros that expand to the new functions.
>
> The timestamp is updated each time the regulator is actually turned on.
> For regulators left on by hardware default or by firmware, the core will
> set the timestamp if it detects it was left on and its supply (and their
> supply, and so on) is on as well. This is unfortunately best effort
> only. The core can only assume a dangling regulator (one without a
> supply) has power. This also applies to the dummy regulator.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v4:
> - Try to update last_on timestamp for regulators that were left on

Sashiko flaged a few issues with the changes:

- _regulator_is_enabled() called and subsequent timestamp update
  without lock
- bulk consumer wait_us incorrectly assigned
- _regulator_is_enabled() could return an error

Will fix and send a new version. I probably should get a local AI review
working first.


ChenYu
