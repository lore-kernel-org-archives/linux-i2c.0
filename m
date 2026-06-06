Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5332FFF99
	for <linux-i2c@vger.kernel.org>; Sat,  6 Jun 2026 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780727725; cv=pass; b=rGhj9DjuWenjN7mFukwwOEwYcKhb9raw8j3lIeeLNi+0YuQyIn0ZpM+d1ffoNeTLQ2d0HpjTaSA4noHY0uMxSMsCXc3fzozWgYGR3wJjZsgZwQEDKv0dySy0KXn9+OEU+gQYonqbCGtJu1pSIOpelmn82xvbwdQZGgBPq6bdRb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780727725; c=relaxed/simple;
	bh=vKwedzqy6mEM19C5I684s46udVlenNF3T1oclqfVZ2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlM7ccbIAWqNdqjmCfK34Gr0p79eSF4hfUHRqbNRhE871Guv7wht13KioTj4xNINBFM1mX2aKvd8/V/3k3hPJKUfCGJg8lQWFpVT2G7k7WlKOJFXohmDJ5yqZMgFNab/K/GuWlD+zTaJAvez917uCYegaB8LJpN5N0dV/GDgTsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sERLTjam; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sERLTjam"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e2cb01a974so30034337b3.1
        for <linux-i2c@vger.kernel.org>; Fri, 05 Jun 2026 23:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780727722; cv=none;
        d=google.com; s=arc-20240605;
        b=Gq9nX9lgw0wslYZOboyzbisSPd36z4JZsYCE2qTOrr8XYhY8JxctMqqOa3Pr7tsBhZ
         zVg189+B2LERym1t1eauprHDXwZ/o1Rw8V9acotkaiz3IMfddawtDCSz1pvZ0gkYy0OH
         kVf46y5yZ60pPULhfQNArmgOBqmRIttfnxhblD0IvMk/Zu1hJbjYo4jE4Y9OnL9zeQYF
         zlrJIWpEMcuCunjAaA9JmxiR5pUaLe4uZqnigD+Z8wDr7yRzUSWmzm6EsN4YFhN6rDnl
         /SIySzjSHsa/KLpIcqhZ38B9oAlKIBLL9UNVTNUzT4zWc7PChKFSpymL4+2zXjgIiGgk
         beCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0qoOBC6EVVCwpzzqJdaViwVAGo8hVP2pFjp7UJvoZwY=;
        fh=oiiMPL8Q/YJBe2hi7zmZlC35oDYlusxBqaznAXUWp+s=;
        b=XxAnDUyPYsJxx48DZ9yQfHkJXYT5hU+p7Uh6GTx+xB+SDr6D0B/aJB9ubQbmeF0bk4
         CDCZdrl/o8ZeaPIWs23CAjgdAxfDENuUmJMqrp29xgiEC3X8u9UgMtTOYK3BG+a4zz4d
         eMhNTWYx7Zk2+0MFwG/A78WM5DoWttwwTm3tD94O8iO+/QuvHSQKsVVaSv+2Q5xp/Xiv
         cZvkogFFcAE4HSCJJpTGFvDSEYcFedRSFTGzZSOsJnbZf5TEotkWgN+QEkjCoRvtFJtc
         tFbYXWpteETxDaP9gWAXXCYw6CZb+8lVIlOJa+X3xso5/sNganY5V302pKAzspcCQlSn
         fbTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780727722; x=1781332522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qoOBC6EVVCwpzzqJdaViwVAGo8hVP2pFjp7UJvoZwY=;
        b=sERLTjamFcawKFp8MQfCskJLzc9YD90x58BDlDcATBCOC8TRLF09nXDF0sF5xOMjE/
         H9XzQDD0CU6BbhJMKQYHhx0WEoq1SucIcdRPZCvT9/wG0iprKtB7AQGINH8SPEJUAKnU
         cd6LHV8ARGXJf2/Y60aDse9xGO15DSRG8if/RqQnaWjjCPIT/vTI1TMCchjuafRSj+2v
         9m4ySS2Kl7k5uLkJa1pfu5xj/CEWV0DSXetd8PQ2h5paLci6BGPBcdYVwjKXCneW3x6c
         ExDPc9VbWsMujKHxJMiOcs0lLeucgsZbblPIsW9I/z+dmeq7gmGLfV59Az0oThZPIQ/H
         R3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780727722; x=1781332522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0qoOBC6EVVCwpzzqJdaViwVAGo8hVP2pFjp7UJvoZwY=;
        b=A4wyCTEAPsMxZfHlI8GUKFlypsC9ZsalQz9EAVGgLeGtcTqZYYRZGVjqOcNWtq0RRD
         a6wEStWL+OaDotPfCVAQAprdd29Iu56x8wDysgVHpAXcSP17bZOoTaeO4VKCLr2MFkkM
         kAIw3Kz20QHiiZSSP1pIRiycWYvVEmQAIJ9M+8ILPZogOdMG4ZL2VP3W+tIZZ6HYeGk4
         9ZujhSfniN7UwQW5k2RR6xgdd5nGGQaUm5AxwTPMx3SWjp0Wjw7Kyl4wyOBr2TTVaGh7
         sXbqypADnLqCey+VUsb6JP02cdB4eL4KeHB1esfI33u1UdMgMkPBLEX393N/nJ4o+aFc
         Ix6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9aW4qCO7kVsgCvYx3gpm2N4otRDuOD95pPhEwKuOzKnd23RUrdY54T6voEjOdRjRQI09RDF+ZBp9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybi5UYQ1jidzh4f+LycFyPMdADlscEjfUlh1YmBPF1XSsj5BCw
	730wFloxPio/QA3n1ixNt/rE4b7iLC9GQSYwMkcU4mLJkPdpLZiowHagvbwM0+Px9UMRHi5vhb2
	qjBlGoGoRnRLSRncblbdbkzLOBPT48bc=
X-Gm-Gg: Acq92OHxYy6vydgNFdwkV6dmPaG5ZUgzRDZFudOiU8t9Dwl8tnl9kGMJoRiROuY8vjJ
	k+TqiYfRw+0ghklcK2xrdohQ7bxlLf6VX4Mx3q3NcnzXN1H28WXXFDJobXYF1T4R8y/4P3k1D/w
	/uNZxETYzMQuToGTksDD6LtpZ623NjiMZ5BPZfrpH0gFbGhze3x3UEbVwOyvDBaFNApJxDa1342
	M0GAKwcHi9xSu6DIh0oQAHJF4txQ/RL85JKYXS5CpdlJfCKev08hs2yAFY6mblkBBJHnquzby+T
	qJN8ePzoeVEwDbTFah0=
X-Received: by 2002:a05:690e:4388:b0:65e:14b6:b1ce with SMTP id
 956f58d0204a3-66106e078d0mr4462469d50.9.1780727722199; Fri, 05 Jun 2026
 23:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505053201.5795-1-chaitanya.msabnis@gmail.com> <177815512250.1119572.9279436421990255678.robh@kernel.org>
In-Reply-To: <177815512250.1119572.9279436421990255678.robh@kernel.org>
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Date: Sat, 6 Jun 2026 12:05:11 +0530
X-Gm-Features: AVVi8Cf6rCMok-6bvEkyOosdfvSx8NV93NAyUuh-KyB4WoE3yoeqMwf8uY47djM
Message-ID: <CABjkosEpkuErYAaeDT_aPvcnYSDTwpZkCO9Nvnxjb=T=m-ow=A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: convert altera i2c to dt-schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	thor.thayer@linux.intel.com, wsa@kernel.org, devicetree@vger.kernel.org, 
	krzk+dt@kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram and Thor,
Just a gentle ping on this patch. It received a Reviewed-by tag from
Rob Herring a month ago.
Is there anything else required from my side to get this merged into
the I2C tree?
Thanks,
Chaitanya

On Thu, May 7, 2026 at 5:28=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Tue, 05 May 2026 11:02:01 +0530, Chaitanya Sabnis wrote:
> > Convert the Altera SoftIP I2C Controller bindings from legacy text
> > format to modern dt-schema (YAML).
> >
> > The hardware constraints and properties remain identical. The example
> > node was updated to use a standard 32-bit address space to clear
> > compilation warnings.
> >
> > Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> > ---
> >  .../bindings/i2c/altr,softip-i2c-v1.0.yaml    | 62 +++++++++++++++++++
> >  .../devicetree/bindings/i2c/i2c-altera.txt    | 39 ------------
> >  2 files changed, 62 insertions(+), 39 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/altr,softip-i=
2c-v1.0.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.tx=
t
> >
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
