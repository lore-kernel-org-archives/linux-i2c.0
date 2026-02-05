Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79D35FF6E
	for <linux-i2c@vger.kernel.org>; Thu,  5 Feb 2026 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278281; cv=pass; b=jpY5CAo643CC0PnNOvENcKwPc/7whXBsGOCd+UoUvltwAuGF1oNBos6AJchhcRjwV9R+osEpVwgO/IVXVUVHjjMs/U3nA5tVkdC9QrG290iQcLdLcq7Hty15+P5la1bHVetlHfBbLNIE+8ZNoy9ON633Hr41j0dydtP9g5V8tto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278281; c=relaxed/simple;
	bh=n380xDQhKqyUOL3yztF2yCD8nvAMmwmV5nZdQBx4gro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BERMTIJz7oUnk8QYSbixUmEzsELLBhdK0Af/MDqGjV/0sxwWeX76pbp7W0BF6LPkYshRUpbZe1GQ82QdcWHqWfGRWogYCxNrG9eKyRsQWu2niauXUEVN/73XgYuECiSvOBJty0GmxbcbJIuCx8dY0uVgUrKf8V7blOULdtquEgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jib2ZUrS; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jib2ZUrS"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso1407751a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 23:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770278279; cv=none;
        d=google.com; s=arc-20240605;
        b=iJF2WTtT1A8pBMz3n/KtkCu7x47FRNFsIASprRbN6tuTEtI/MLg/WXIuBSXjX4ImBu
         W1RG28BOKvh+Fs+RwBibVa+qR0yPkL+OtJKLZYIz78G3ss10n1reYBFaFxLq9rKBJFAH
         VnxwQn9PAtzQNO1DgG9hrbn9X5sxys8MvVMovJerngpMCtCN84ifoqStvOuAjeBt8ROu
         oSrjk+G1kfrZZ3C6p6oTymGJuZH7etd0JNjByOwxnMHTkFhEi1Z1I3jKKHU43wXY3n7H
         R+/u0/Tui7Aql90CqZtDlmp6VnmeEuJ7lD9YXkMlk+IGxtBb8w+jlBt6erkRSlY2gszc
         gD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n380xDQhKqyUOL3yztF2yCD8nvAMmwmV5nZdQBx4gro=;
        fh=oB+Fnt6IdpBK2hkIv5hkOi2NP0vhRrHl7R01HRjEhzM=;
        b=Xg+0tqcvlUcI71CmPl5Cn9oSRsLz5tOk4kDiLY68qqYMey2Kuob4LFeRF/u6lPe1FE
         kDawdWas/5NnMWESqGK1t4C1kLvV0eyzpf/CCNg8lgi9N3sw0KHHAxPBarGUYRiNXYN9
         +hdcgpCOFEIEghoHMPMcF0cgMMOPHPW4cmBmNuEbcsbCVi4pNOM1hHfSTb1S/Od/45t0
         +x2ShVcBIRLU86wOr3A3Xzq3M1DHah3qEa/A1cEeriUfvp54xxaPHQKqec9jLvvBiNiI
         8spLcXtZBuRNf6cQVDEz1wCOEbFqaqZ1cXp9oQqmY5xIbYV8Am//LBhEmvDBvx1IKAAM
         fH1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278279; x=1770883079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n380xDQhKqyUOL3yztF2yCD8nvAMmwmV5nZdQBx4gro=;
        b=jib2ZUrS0pq22xFeQzh5Y0GoN9w5cCBVJMTYHSBGP91PiymEE4wlGg0IFX8mLoUEsy
         u+jP5hZhK4ByJdoDm/k86MUG1sKe6sLNlxavFvpn6c3FTWiQaaln1Eh2jyanDH52/pdb
         0S4yXWHW3MKH7W2uieytKm/qOXV26y43q/8fnn16Z4P7pZqCty5pwEXKlwKIMIGYh5MC
         oZ6mhh36piu1MpkuomC5e9zUBO46VBxIMF66rOMQ+NhKfbFO1D9Uu2KojDEUlcFyN/tU
         gHIvRXqWAuhRMPSL9rg3x62z3Eg7eUEbx+cF+KN2FdqFSJxBtjAO0PloUqQGYX8NO63J
         JMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278279; x=1770883079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n380xDQhKqyUOL3yztF2yCD8nvAMmwmV5nZdQBx4gro=;
        b=UznAMlkGOkhpWGggDs72FFME4MwT8pU8JBTR8XLstPAEwIp77iqb3Yk/ZQBe92Pf2u
         XBB7IilSQwFzDKsEGAYVsEBaU+czbVN7+Bos0ihQuPsnPxQesSouIRhBNxYmaLqc4Uq/
         i5EpWz1oOkaETQFBCYJ+jVaHe+fARnncr+wcuLyRsEVK2BSTaoRHwudwChtkQjVFGa4b
         7g/MRxF+DAhObAeyahHPT/YWWFrtDdnbbhoRwGw7OaI2hcWfRT4XsnelkQiJD7B0qPFr
         RAzHiBI4RTihSfXIq5RHZzLfp3vs1byRkL0f1P+qDG2kvlhFzGHum4LmR7le6y2sZ2WR
         jmBw==
X-Forwarded-Encrypted: i=1; AJvYcCXixVBx/m0vaSWk+PhB6Deqv5ruBIESD7ss8D6k2r44/j59LEHs1rCFGjdbF2mF2vy1JlcyG0NhNDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg50WXx6EYv4U05kzauelda4N1pnHeYxqoiIrf3jhSmien0+Gx
	4KuT1bE3TUFJ1t/Ks8xHfhaU8VVqExDldcvamUYZ/Wo9yn8+BPb8JEnb69UDEzTvSZ3A3X1eJcm
	hut4WsvDXkGCW5PqsPAS7+Lj3UP9lmoU=
X-Gm-Gg: AZuq6aJvdER1GbxksqN3g4TVPmf60IQZp9xXmjKzVrgalvHywF6YjIBkoerHDiQDtWz
	MReSGs4Y+UA/BKNXnY3qin28mSIzoPBfnIoqlg4CyGhfeJfoEFz1lS356eq4uk5XSj+z4zslKrd
	Kt6xcPXBOiEkOu6J6BowzZgUOZWLnYq7qWiRz55QcnS8r1ndGv0yhVtCEuQQWN9ZBCssBHkxzrx
	VRjpRzViJDVL0C5bzuftZiK92EFCrPfZUkSck1jwZIhJzRVyVyKdxDzDTZc3v5uObatIiGQlw==
X-Received: by 2002:a05:6402:5309:b0:658:2dd6:7362 with SMTP id
 4fb4d7f45d1cf-65962a83ceamr947335a12.10.1770278279096; Wed, 04 Feb 2026
 23:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-2-a.shimko.dev@gmail.com> <aYKj31hi1bF4wmsi@zenone.zhora.eu>
 <aYKl9RqkISSV3Fn7@smile.fi.intel.com>
In-Reply-To: <aYKl9RqkISSV3Fn7@smile.fi.intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 5 Feb 2026 10:57:48 +0300
X-Gm-Features: AZwV_QhCB4JwKnlLjHl6pjQ7IbNWWlcDDomy_yJSidBqfU3G33nal02YlOPC36k
Message-ID: <CAOPX746bDN+EW6za0+mr4ii7kAN3X_HETWq+PCpbpCZVL9xwAg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, p.zabel@pengutronix.de, 
	mika.westerberg@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Feb 4, 2026 at 4:50=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> In any case the commit message might be
> improved, yes.

Got it.

Thanks for the review!

Regards,
Artem
