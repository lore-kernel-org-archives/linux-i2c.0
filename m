Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563329;
	b=xbatquAr0H8bPGPFnQCbF1zjjAcVTGgyydYQ96zS148CNbl0ehomPqxaqMDJTP2oFMaX
	 7CqvFMM+QbCzfn0wY97EOWwvgVsB1dS47lLrYEplFunFtHURyHh5LoNZO6jp8jbGff121
	 GyrvzUxIMfEle1botZMCTfrJTnwzF+SSMYYoBAxbD5MiSXTf3gPzQ+T14YoPnh3RHdT/G
	 Xl0V1KvjmfXP9HrSU+DgODJHg+RREkmm7NGSCCFXhLCrk9NlE0a/YlLXJm35XXiHF8sRp
	 4hVNMUQPZZov5v61PprVHGJZft1wOHx33zGLxttCIZZPiik6fK0cyH4VFw/1J4M8gbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ko9HS/rgq/wRVG+QBYDoQ9uLj3LrUPXzZbkboW62IRQ=;
	b=5GMI11aS+Yj/qwepcmzA5/gmKoims+Pvrbo+gbegfzrWAzPS2IYstG74adrnInawRhsn
	 Wc+u6uRyFetYPwvSOZsCZlDSLN+9dZ68rmERP3MS2ivBW6H94uXYv0SwE5URF5NGqGac6
	 Zg84d68WBHc7HvcXmYvSg3p1dhhlW0Gfft4AqaZzpY0w8DoNswK7TqTwwuyRT3byf8dl7
	 GJcBFwfWRJkVPydXbnyyQ0QDIWiWVa6P0oquR6+2RQzuNviFxIGDRcn3zd0EzIQiUI98U
	 LewWKcytgljSyq5GB+ttDqMq2Xcz85D/pF0BPmRWxO7IFY1tmHGZXSyouLQf4KvIKGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OFV2WDWa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FB606A32F
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 06:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37FB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OFV2WDWa
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677dbe051d4so242264d50.0
        for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2026 23:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792563328; cv=none;
        d=google.com; s=arc-20260327;
        b=sLOnziSyaht1G1mo/FDhaGEjXj89999tCRDBSrzz1lrG7pKuyylhYaPBlxsVz/Hvn4
         gzmH8c0VVXhGVRL5dxyQslnnmJ6jX0xXHy23ZbAcuKp7kRLH2Supy7So9hpEaDy7TQgA
         Jg0e/MeAkxziD0evZNibum70G5oFAS4mjgf0yM8dIIvnpc0/ZAPMTLBCDk5dEytpL5rS
         3D/BGSlVT5BqGWGNSy/phNAqrSnDlJitEXcylGs6NC6h8cOIpATAdfBgrB0imG6UTcy6
         CXVnHf6o7jF0BJQ8hxIpRew2pq1DQ7t1EpbGlCwvGFSd8n0DbUGGdgmzb8JTDQQF/aeW
         Rcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ko9HS/rgq/wRVG+QBYDoQ9uLj3LrUPXzZbkboW62IRQ=;
        fh=Krxu450wBfzyyYK0P+2dNmQJqt6nhjKYli7dE6llLnk=;
        b=V5UoWKSp8DqL12grBSYgNIve5chJvtn85l1X43dc8P4wLtpI3oP1eMVFMo/f8CMTxj
         HgAMkggjQIKgiEsFsnUrQbboOB0phK+Vf3WFQ1c/P7eNfyw4Xelveyp0l+G3e9Pb+oiB
         DKCQZBRaqIBIPk6c7EPfIT7pUQ2JZxUdzs4fnuUJo8FUxT+DseclCkH7Ag4YPFuM6U9I
         oXvxuYrhrGysIL0MjvVgeM5UlRHp8lqz1T5fVYJer061cZ1INHY9GVeWaIOjHsddI1Qh
         zvy7q4MiyxUD/tQPw9NUOrlrMLcVT3dJuBe3hjUkXRheoGz/JKV/eFf9KA3vK9UvKR6n
         nq8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792563328; x=1793168128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ko9HS/rgq/wRVG+QBYDoQ9uLj3LrUPXzZbkboW62IRQ=;
        b=OFV2WDWal7okguttPyD6u/gnNRBEBDGGN23ajd4BMHwiSMotvbKAnydynXHX7iKpff
         pKgDZetNTL1hB9CiibEUx4CgrDHpY03wbhHUKxNJXUUoBH4uhAJ2m10Py3uMpVD38KB0
         +UcWfTu7rnZXw06A15AvaVLzN2/4gLjuWgn1AMUMtT+o6sjIy9fKKa+PQIKkcr9d3QuO
         pQpq9RLpEoOgyuEXNCPKqegICZENI5Ymr+k7CCsYC1fvnU0MexnSuQ3x0b18GRl1bwuU
         iWfNaPoftyx83nI/3YRfdoXfNTnu6Uu/WqEv3e0ps1ljAwnUJSwVuQgvrj4hFnnti/Yg
         QWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792563328; x=1793168128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ko9HS/rgq/wRVG+QBYDoQ9uLj3LrUPXzZbkboW62IRQ=;
        b=mwmHW1nXSEqGUuPyCdleSkrFdv1U8m/QApRY8PrDjAqBxsSGrAF2hMLX8m9tUqsLy2
         6I9VgxTOWZoOyL8LIWIk0mUm6e0MT8820e7slXSusWT30JW6eOMPRW2//QJwG5N/o29o
         0W04v3QmMfUmmHZ0mM1g7iDh+PpD64VsIYpRjGMhIrxpopSX+XUKlZRIk3MRbezm9lFl
         9frJejUBUeoVT+2XNhDTlwbZcClfufenJGQW4/XZH8wbmL65qjxlC9ycFaZ5BcPCJ71h
         c23metOS27LxUFP9IGV18y0Q9k/0BvRJnsG+Ta2f9pcUPJGAYA/7KjdqnjzR1miitIvm
         OmCQ==
X-Forwarded-Encrypted: i=1; AKwUvByOl6xa5GU704pE5/YL+xbms0q6OuS3JT2pav0SMjkkQuFWjegVd0s9jx2n+3W+IDO0RS/lyMCln2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxCm+cw2iJr5vHzcGvPnCQWSOuBDTl0eZ+jywuJ3bAt2aKTCGI
	7bkdkHs91z+7IvRtetRN5eK8540MSjIJ7rh15yNW/60zwkrAc5rV6piQ3Q0mwCnqfPCzgN3n5eD
	EOoAzHSTqnxOmq7J+Cux3rZqMkzlNytA=
X-Gm-Gg: AYBFou39tB9om6xQXqoIyQqNo+xmk6xANGs/nykz/JV0ZRW1DApzbGOS056FOBDQTlB
	1wzXxkSCEGvjh+NJJ0nVIsTbNRJRqKt1cSwOoUvgvf3l3lebhnGIdTd0uuYP+NQBby1oB7uMoAS
	ORzpKz+vFNt6lndivTdC1foQhMkgXUYGSBM5u7kPZVd1GQcYUzgIzGjS2QpZJvfjZJBIzdcPC+Y
	DbXFbwtCAvqbAJuzrFWEdLo4vzP3OERcWqIvv6zVd7GMf/aA0ZKK4Gl+YM20aVv/2xIsDzz1pZ5
	6Cmk+zUkfKyXGtVkjD8VKcKR71qIzGIVjbK24163Fg8E7MEtBDAUOCrJoZCzOwi8Fn5hj+euJtL
	eTAmHT4AzyubVwXEIByuPOhSOdZSuJ4ymY7bzIQ==
X-Received: by 2002:a53:d046:0:20b0:675:3ec2:25e3 with SMTP id
 956f58d0204a3-67a0e4ad344mr360129d50.50.1792563327812; Tue, 20 Oct 2026
 23:15:27 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016125229.1798791-1-thi.zirnstein@gmail.com> <20261016125229.1798791-2-thi.zirnstein@gmail.com>
In-Reply-To: <20261016125229.1798791-2-thi.zirnstein@gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 21 Oct 2026 11:45:16 +0530
X-Gm-Features: AclHuK-ugPzahDAmlROiGz1RBDDjU0-2VRqDCBg2WtlQUTxJejI8BYEhLT9FIjg
Message-ID: <CAKfKVtHXPmFw_x_rzNQeunyudaaw_AQMYgcmvFVzM_tRfp_+=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] i2c: i2c-xiic: fix clearing of bnb irq
To: Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: michal.simek@amd.com, andi.shyti@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 6:27=E2=80=AFPM Thilo Zirnstein <thi.zirnstein@gmai=
l.com> wrote:
>
> Add a function for clearing the bnb bit,
> It waits for all preconditions before clearing the bnb bit or times out.
>
> Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
