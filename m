Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538572DAFDE
	for <linux-i2c@vger.kernel.org>; Fri, 19 Jun 2026 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781839407; cv=pass; b=pPhRzQR3iAtTOC/pkLQi43Y14918zXEEaY7MOgJDWyPGhWBpanELmFa1gb2wCtkqfA7HYnimCUs2jVRSU39bCXEZuQ9sH4Zdy165JIXwi6YPVosAASCCTdZp3GNGHEyr2VbqQpCXHgtO8vaPmxZiUR4TrTS5tAln4oqsE+Pw2YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781839407; c=relaxed/simple;
	bh=4H/LqpJe3Qh18IgUnGD6m4u78QGoXyqQP92TlYlOd54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTjhtlGqfqY8pDs3HIzCtCO4Jk/j3OSr44PZ0utxu2WXxGAibmdoersntPkVvDe/UikXParHql/agT+BnSN8vCOtuc5y8NLKXkn2AvHAwsr2Wd2PTYH8QepKnMo/aYNDeuKUSZbYrHGqmFWx1Q1gondghIS7uf/DZB2VFGYtP3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF66Xjzn; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF66Xjzn"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-72695bd3ba9so983954137.0
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 20:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781839405; cv=none;
        d=google.com; s=arc-20240605;
        b=K/4UT7wwnrVR2CwQ2A1TG50KYBIKs6QWsrJd0RYSlyRZZHB4uSJd5NJxYGJxlywkWh
         q+frJhT2Z/uTw7udr+N0JNYOA6NuIt77/gV8nQu3Bwus4xvcoyHMv/Zd98+V0hbqpCKS
         sUpuWEQl7Kjbx5aMD+dpUcBpRCPGE5FmOi6kvRAgjo0eW75liJtJkgV7kMN0Gy6xtx1D
         +mEW4MC1Gd6nLi34ACjeqjYqsfcDjDUFtnXaxsV+m7ZIFnlGdb5xZDW3a1zazZM4vDTl
         q/LwPohbsgTmJyleJLJf1qkRX4qRNb3FNmMt5jil/fXLRlbP/ItJuA8aSCNOT90+z4be
         35Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=49kYZ/hVh6rzDNnCFZHGbW/8C/blLwA4nIF1mUU+qpg=;
        fh=Q7Zd1RK/ExHsQCOB4u3jIn1GsRpQtek8J6RPCs7BMtE=;
        b=cnRO4mykB7ifG+jSSjVqpEwrOrv3G4X0EbKuPxVKHrqwTpZ7eZJyT1cYArfB1e/Ejo
         KuuTu8wUAESLQPa/Qlx286eBst59IciQiiY8vPbzTn507rDfk15oMdgvoil+riXgVgHu
         3p1feYIAQxLv9r1gIAv6hYbfQzPX8OBMzlifgIKK6EbgqEjSSSgJOFMeRaYXfp9NGM2f
         y4NOsUS/ED+VmR2HUQ6g3qU2be4FO3tv5kGX4lqhMk8+wH2x8B4nLlwc2hHamEFERAiB
         zU2E/BuiJ1ijJxSsRfRzGe6HY20Noyxcy3c9g5O0CVbLJbZaTzkVRWSLQ4gEGgi09GMl
         6iXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781839405; x=1782444205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49kYZ/hVh6rzDNnCFZHGbW/8C/blLwA4nIF1mUU+qpg=;
        b=dF66XjznIYk6U6B6ZZ/l0hjc2G3+YdgCBHjosbZhvcCs5XpXWxQf3okwbnwOIESB46
         fjckmdWhZ/ji7s68/DrclaD5EJB6pQ8hG9XUJxaWgcUXcBUlPkw0Ffc3aOICNdScpsmx
         lacc+HzqHX+rbm9LMO6dV6iTxPUanE/XLbRR4h+KFyeVnmqcy5cpFK2LHwYRMoAtqULU
         DfoqVI0VyEF7m9a3c/yaiylkbTeXmDLG6Xk+o1YjiV1k/1q571DcO2b09XaqZZzc+2+w
         0jswXG2/JUqAA7/n8tE6CQiJYTTUpECKDCc7sRGfoNjIYapowTHcJDhm1Q6bb3gR3L0w
         3Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781839405; x=1782444205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49kYZ/hVh6rzDNnCFZHGbW/8C/blLwA4nIF1mUU+qpg=;
        b=oph+2jjQoxFQI1rW7CoBd8mpGJHrA5j+4Ga1Dl9jvF3SeAe3w3c8b/XuDvlI4dLL/Z
         qms86Sd3cnG7xBNMPUDQIsnXXcIiM+83dv76vGmfcQgnUjlvIyuaoPwS2nYbULZA/A55
         h4Gb0tHgctrNxw6es0NZrepnQOZxF+Rw//u1ZRvz+OPSNoDsHulqrbqq1UW3KwT6SA4q
         /1vnF7NQobLct8JxJ2ak8xLe/zD6Uqv20IAUMwCD0idGjpohq49835J2FIqTHFV/0CaK
         cMdk1Tj1x4V3zpF0eYH7fUlOjOtR8216zsIYoD7dYamdExFYWI9AzdYY3ObvKJbgHaUb
         /pkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rVy5bKY4Kowk9DCDzzyMDliczZv2H/v283SBSR6MA8do8G4Dlvwnw5K5tAVSTaJf0yGWDxxwuV4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2w936IZq7yjg/RnTk4C7c6eipRJ+BoR9jfH5S4qszoIC3okn
	CR5B8wT769J6v+yjtu8+GFc1HnuBXnzl3Bhdz67JkX5d8osQWAhlWNfPevV/2Of2lQqsv2b5lDx
	joFAAtR0f731EU51duowEAkLWqpC+0a4=
X-Gm-Gg: AfdE7clPgaYRzDOFGh139L2lNaT9w/SGycOA2h1e/ftL0ZK10Crr2DV66p0ETPqI+fw
	A0asMrQYF/E+QfY440cSlMiKaQ5WGZ9Sj6ZQASnkVU60cI7HWJsWJJxJ84uOdcjl3cKlFdnkmjf
	VbqpBjsfk3v09RYq7cAsVzs/nIKkba8zOpPdHReoFXcvTcQ5r/oWWodDNgMQsKyGmCRT7ILyku/
	ibdivB9fTsUDUmA51iVZ86DKCA75rWMZme8BwghJr5qfHcM8rGVhc0Z8+mJemk1ehJK8MnWTQ==
X-Received: by 2002:a05:6102:50a3:b0:6c6:432c:84d3 with SMTP id
 ada2fe7eead31-72a772a3830mr372090137.12.1781839405225; Thu, 18 Jun 2026
 20:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618184610.6536-1-tejasmutalikdesai@gmail.com> <ajRaej6d2npPBeca@shikoro>
In-Reply-To: <ajRaej6d2npPBeca@shikoro>
From: Tejas MD <tejasmutalikdesai@gmail.com>
Date: Fri, 19 Jun 2026 08:52:47 +0530
X-Gm-Features: AVVi8CfWuksPB2IkcMgSHqE7FgwqxNOxO2yW6SwXmnYkTNcCj8MvjePWp0Q0-YA
Message-ID: <CAH_Vg8ZUy8CmequdD9i6h7y9kRhiMe7Jmuq3qy=_BDsp2iANuQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: core: move idr_remove() in i2c_del_adapter() before device_unregister()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: andi.shyti@kernel.org, wsa@kernel.org, vladimir_zapolskiy@mentor.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for letting me know. Will check before raising the next patch.

Learnt something new :)


On Fri, Jun 19, 2026 at 2:22=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Fri, Jun 19, 2026 at 12:16:10AM +0530, Tejas Mutalikdesai wrote:
> > There is a race between i2c_del_adapter() and i2c_get_adapter() that
> > can trigger a "refcount_t: addition on 0; use-after-free" warning.
> >
> > The sequence is:
> >
> >   1. i2c_del_adapter() calls device_unregister(), which drops the
> >      device refcount to zero (the adapter's release callback fires
> >      and signals dev_released).
> >
> >   2. The adapter is still in i2c_adapter_idr because idr_remove()
> >      hasn't been called yet.
> >
> >   3. A concurrent i2c_get_adapter() calls idr_find() under core_lock
> >      and finds the adapter.  try_module_get() succeeds because the
> >      owning module is still MODULE_STATE_LIVE (this is a hot-remove
> >      path, not a module unload).
> >
> >   4. get_device() is called on a kobject whose refcount is already
> >      zero, triggering refcount_warn_saturate() with REFCOUNT_ADD_UAF.
> >
> > Fixing this by moving the idr_remove() call to before device_unregister=
().
> > Once the adapter is removed from the IDR, any concurrent
> > i2c_get_adapter() will get NULL from idr_find() and return -ENODEV.
> > Callers that already hold a device reference are unaffected:
> > wait_for_completion() correctly waits for them to release it via
> > i2c_put_adapter().
> >
> > REPRODUCTION AND VALIDATION: Tested by inserting a msleep(500) after wa=
it_for_completion() to widen
> > the race window, and using a kernel module that spawns two kthreads: on=
e
> > calling i2c_del_adapter() and another calling i2c_get_adapter()
> > concurrently while the module remains MODULE_STATE_LIVE.  Without the
> > fix, the WARNING fires reliably.  With the fix, i2c_get_adapter()
> > returns NULL and no WARNING is observed.
> >
> > Reported-by: syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc0291c8c9aaa473c7721
> > Fixes: 611e12ea0f12 ("i2c: core: manage i2c bus device refcount in i2c_=
[get|put]_adapter")
> > Signed-off-by: Tejas Mutalikdesai <tejasmutalikdesai@gmail.com>
>
> I'd think this is fixed with b1a58ed9eab1 ("i2c: core: fix adapter
> deregistration race") which went upstream this merge window.
>
