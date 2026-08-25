Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57314478E56
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664376; cv=none; b=rqCw3zobAAFEdePNOQSwWxSZNuY5RTFDsrdD8uF5u7ZVPcJLKdL7TF2VUiKz9kq8krBwcb2X+PbhUMdtV94X01rA3Vv7Ll84aSyZHwMumJavH28s39LgBvCokLQ0kv1rzmZPnD/5KgnhaFFN1ZFkneHqQL+3bJGreajzu/9YJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664376; c=relaxed/simple;
	bh=7k/DsBnev/NpUwQENuaPfi7YDsBm/CoemCRBs3TwNFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUS75Y52bz4F4qFzWcBH1spQxpX+jrjsCzPaQJcVm1PUowCOLCuvf0xWOKeaxctYZ1j2WAx6VOyFMEgYMHA7J9kUgm10N6IpL4GBMmCQ6hli3uRaAwdynoL97FjDe0eYQzr+YhLcLnzBXI16Nx/O2iMbq33KYeNdogwFuMYn+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c207cb16cf5so750838866b.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664365; x=1788269165;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XvnEH8RyPx/YIkplbykqCJEgDyu56g+0LDhL+b1yTf0=;
        b=EW/cPMaMAzDOTebJhcXuXvbdNpPiMNBcEPvokJsXElFyDmLCc+HyBzc+nGTIzXM93Y
         Rfzo8E83FXKNFWkoDCFFsCXHEwsxH+E1HIGhWEZeGBWC99Keyz1uTIgqX++CUqcksaKp
         4o1DYLXMGHeqI2GjNPdOmWrMtKzdJgu20b+CCsI2aoliCIkXuNFvduZcBbKFVbIAg3tU
         Mm9/D/T+WwRjsLriNxQG6H/ov4Q9aoAqRq8NEqnaTyV8AKq6vRi64ZDw8IpzJ08jwf2p
         JRSUYJBKSJbTPpwSTpoOkGzpf9oIAJ8w07bdbdJzuLlbtxQocPYJsKwiTGxR48Gr8ST0
         TIcg==
X-Forwarded-Encrypted: i=1; AHgh+RraatcK46AubNbWIrE4AZ2OXnuliWK01pnIhw77wYITOrChE8F1NPXN7csZ0cKnOLQHCxsC4yvewEY=@vger.kernel.org
X-Gm-Message-State: AFuF++ml1iYFLfLRjsrjE+zXBz4atmlI8AL8+rS/1006hSdV5SqXPZXA
	nwoX7ae7SIqA3+Xgy8V0KGUdypbgsGHRhhjCqAVvL6+gltOIQZXb6wFvWy/VAk7iRb8=
X-Gm-Gg: AR+sD11eM8ZryPJKtd/UCd99xTc8YZ4zQdqJQXRIFcyXounWGn0ONrW3i0gXws9hSSl
	syM1xc8wyHvdWzLPe8JsTXgDqzm/bYaNe6T/3ki+q4ubU5Z0/EyX4KfIUV3La3FR+jAUqo6MRx0
	oatgjod31Lx+ftvETSKBLVGKPjsvCmjb+kq78ZP4wK6GPc1VjIWQYvHn/Sypzmy47y1bdhJIVzj
	3w8xvEB5zrDX8zqjmTVUlfsnWsNWHjTrDhZAMic/ekGoKQ2UxEyUNqDl5+CHtYAcxKOETAqcsIa
	C8B9aArDT5z3EVI/pbI2sfA55jWyg0cslGRBl0OmSPPK0+lyQEqUrOE2W8a1sFsexYfLKYBhH6a
	cs55d7kqd0h9QoyMpQDpP6ATzlusI8nhdBkyjOo/54EOlcRmRcOcGe719Yga6alCgirRZe+Oy1x
	vMb2HGS8sldA662KpqWIpHWvr6cimPcv2+GItbVdBWuoWrOfSVmGwF0isbxjGpz/JvhUNJU3VEc
	1i8v7TcnFqSALK0WxD21o6Nmg==
X-Received: by 2002:a17:907:da16:b0:c21:34a3:4df9 with SMTP id a640c23a62f3a-c246a2cf648mr3835486166b.3.1787664365291;
        Tue, 25 Aug 2026 06:26:05 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1922402466b.25.2026.08.25.06.26.04
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:26:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c247f6687dcso570831466b.2
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:26:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpcdHHycVSh2ix8nrZkzjKXp83gWqI9cRo1gT2xlJjU1Xkpy6wODu7qhYtYQmo5+hH0lfTGlMAlARc=@vger.kernel.org
X-Received: by 2002:a17:907:a4cb:b0:c25:23d:5295 with SMTP id
 a640c23a62f3a-c25023d5366mr258635866b.17.1787664363766; Tue, 25 Aug 2026
 06:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520131206.932050-1-claudiu.beznea@kernel.org>
 <20260520131206.932050-4-claudiu.beznea@kernel.org> <ahhMX0hdr43K9eLa@shikoro>
In-Reply-To: <ahhMX0hdr43K9eLa@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 15:25:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtGizx1R05Q9rdV7TDoqSP_ydN=k032uDN1QuHETxBYQ@mail.gmail.com>
X-Gm-Features: AcwNN1XrdhXunWbM84RFR619swSSfNC2ju8fMMD8rs7CEKU82Z0-godPeY2rQF4
Message-ID: <CAMuHMdUtGizx1R05Q9rdV7TDoqSP_ydN=k032uDN1QuHETxBYQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] i2c: riic: Drop the space in front of the "out" goto label
To: Wolfram Sang <wsa@sang-engineering.com>
Cc: Claudiu Beznea <claudiu.beznea@kernel.org>, chris.brandt@renesas.com, 
	andi.shyti@kernel.org, claudiu.beznea@tuxon.dev, 
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Thu, 28 May 2026 at 16:10, Wolfram Sang <wsa@sang-engineering.com> wrote:
> On Wed, May 20, 2026 at 04:12:05PM +0300, Claudiu Beznea wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Drop the space in front of the "out" goto label from riic_xfer() to follow
> > the pattern used in tree.
>
> Time for this quote again :)
>
> > > "> It is generally accepted to indent labels with a single space. This
> > >  > avoids breaking the -p option of diff."
>
> And yeah, I have been bitten by that.

Looks like "git diff" improved upon that ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
