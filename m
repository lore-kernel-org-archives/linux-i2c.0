Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C22DECBA
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007318; cv=none; b=btm6q1krtROqk2GPVCPs59NXP89VEKMaEEkZBZCgh2MqSrHsAyWqyWSJKNiAbFvIvvOs9z57Nx0Kcy82h0rYNSssvAUI0gF5cAJ5p8x21Ld/bBXklgIA2P4FCl7dxEm/HZHAi3tLgxzIIuPt5wQirDrDam9Bi8Wxj1ZEQqIRe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007318; c=relaxed/simple;
	bh=Rq5dQz+PP17L4r1wvU3SlwqtBYvwqWTIGszmzRr5pTE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nxt1qcVNSzx1yb4HQ6Q873z3yWvpZfXUbUTqVhrsqJpzj6NQgUN9NLrgZklth/fTTbpMTKdyluNWUaKFbXA6DSS7RPzW75KugnnMw89OH2LfnbDmDqLzjXreFz8P590BQ5RlkW35zqHuxALgI+JdP98YdrDRNPVIEhUgkooIOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=ajGmhyFS; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="ajGmhyFS"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3045c195251so7161281eec.1
        for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1780007317; x=1780612117; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq5dQz+PP17L4r1wvU3SlwqtBYvwqWTIGszmzRr5pTE=;
        b=ajGmhyFS8i/LluAwIpA3esuSfQWll4BFVQdknkNQa6Lp28vCIQNgiE+TnjMn/Kcbnw
         ZwLcVkmkNTlzvtLrG/0lIefGqPVrJCAtHSjzcYePyCrnYo3HKFXDqihiITGGmngPrwYf
         NU9qjGuacw2B626DiaGynO+xBx8x5C4j2PohAazvW8EhDR3TZp2VaZ9UcMoaeWyzIGkV
         gCzZ3CeKaQOoe0uTOhDe5fTft0WuyWXwDvkHc9zpexsXkPeQNrCMZHlgxc+hRB6v0YWe
         RBTQXTdS03qz03a7c+y925TAEmYEZDYFtkESKtVqq6V7SDWal466qxqQUAX1Qf1DipY4
         KxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007317; x=1780612117;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rq5dQz+PP17L4r1wvU3SlwqtBYvwqWTIGszmzRr5pTE=;
        b=nEivA08Y24XGj2saNhYPXdeQ6GTEuf7nbd/BjLhwIpx2+HEtY9iuEyrHCO3qmGNU4M
         9z47pppYsbqjvFomKm8uMNp5ZUC4ZNKGsOVCMM/R4gHP64J/dS8Wc5dFyoY4KBXu33uC
         DMrMHy2VROYTEK45QqkQmytK2PENMAVtyWlSK5og8yjopoKEdUhv40hylojn2U3aFYF2
         h4JHRpJjiMr0rBcR4EHQsxg+Sny1dASkvLXTJSpvCKvCrq09D8yp03r0HSmmBcWfsENK
         sPyqS+mS3zBTcRXGGBBXSU8Pf1I0vctFJ+NLd81o4kwKkZzWBi1zIiu89Xf5VXhG6FCw
         aAyg==
X-Forwarded-Encrypted: i=1; AFNElJ9EitMaTKStW6qNGFMI55Cor+z0FjAbEzixanE1KZQuFf+fLnl+t8Il9mJdQxEQl0LwzERY8sBXWHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtd7OO6vZRiDPGSJd88776bG5uvDSvgIyjpm89zsxi9XGSrpv
	G44RxBl7XOjkW4lLbZpOg2f8e/q44mdgcXwzh1CGTJkgNkaagQcFPIHnRd8amwUtbGmO6cKU1Vj
	kHIZw
X-Gm-Gg: Acq92OGjDXLFgGiy21aiAKkeKYkC6pAUoN63RSdwDW3gQ/xT5N5TAS6RrO88XmVjWg2
	OsAS9JBdd5ZhRFjSIfA2pXNatdNOcZ88ud+XR+1utjA25oLFxhGDeNaN9R98nzNI7MteQ2Rufi9
	zVNS9paVFdqwwNsQe29Fj2IgklrwcBWAHonsmm33FkeD46ZAeZUiAyvOwCQEb9ys6/X6Gi7ZgfT
	sHGaSvLJ1SthXGMJ9xqBlK3H4o3Q7/Wzg9PQUUOyLtFON03aRgOMV/3akg38KsG7f4Wks5bsGnI
	M3DpQ1fThWuEmNco51ggJTpcQWQga5O3CkjqiGiNAvTduDszcHdRx+7zLOL4fTn2BkUWlCwnnTH
	LTFjZw1OBr4RowY7QuM5KmtD3nL5SkAgtHE++chx9GDvmiP7n05AmzX5eFGKZnxFz3a07LqZHle
	ff25YB/CssH44HQQftsOK3dr0Q4TtFN5jj3Q==
X-Received: by 2002:a05:7301:6093:b0:304:8114:8d8f with SMTP id 5a478bee46e88-304eb224aecmr202368eec.31.1780007316751;
        Thu, 28 May 2026 15:28:36 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304eb9cd4e9sm176489eec.8.2026.05.28.15.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 15:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 15:28:35 -0700
Message-Id: <DIUNXJWCANC2.DI7DZW8G2S85@nexthop.ai>
Cc: "Peter Rosin" <peda@lysator.liu.se>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] i2c: mux: reg: use device property accessors
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260519-i2c-mux-reg-v6-1-a27ff50dee67@nexthop.ai>
 <ag1a5TLH7L-BSWWp@shikoro> <DIUN5NSLIH1U.1U1TFC7N4CJR@nexthop.ai>
 <ahi54pXClIW7OENa@shikoro>
In-Reply-To: <ahi54pXClIW7OENa@shikoro>

On Thu May 28, 2026 at 2:55 PM PDT, Wolfram Sang wrote:
>
>> I noticed this patch didn't make it into 7.1-rc5. Is it still under
>> review? If not, will it make it during the next merge window?
>
> It is not a bugfix, so its time to go upstream is the next mergewindow.

Got it, thanks!

