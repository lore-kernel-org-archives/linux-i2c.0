Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825823AE6EE
	for <linux-i2c@vger.kernel.org>; Sat, 11 Jul 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772001; cv=pass; b=SFEHBrepMqQuF4XR6YbWjUGFALSZnauytl7Cwmdl+ICfNRs+6qpZDHIpGzCvInd0TS5v/FAp9sLCR19utDT4zeINScVo001jf0QjRCXFz3vB1YwYKXPI6rzjQmipB5PjHN8GDW6nfIVIxgagEFWEnw+kxtKr/TBlNjQJtqVS7yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772001; c=relaxed/simple;
	bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7AeBtbrysa03RQO7Y3e3j90F0Oj8Y6kqi8oFT5O9O/KXnXblwMPAU2wVGM9GF2DN3xVD49rkliVk0YqmesNZWob/gxkt/tJ7cgaEUt7GlN9CTovTwp2udZGGVawJ9ZALJAQMa1RN/zPLSjf4gr0UTIWC1K5RR51PHCjG5q4Sss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHFB0fSe; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHFB0fSe"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381f03d7be0so286574a91.1
        for <linux-i2c@vger.kernel.org>; Sat, 11 Jul 2026 05:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783771999; cv=none;
        d=google.com; s=arc-20260327;
        b=fvjVjrSu5Bxvq4L5yJMazwIJrjh6ywsM+7kcbbDF1tBsJmpV7hC0p8jGfLvzHLcivn
         7HG2E+VPWVT5zYF16Vdpt+NOXc2jT1PWahwv9QgSu2B6mRW5VK4O4KFsJqKJppsXo39d
         9MatiXkGWu59sd3L8bnoByBnhsI3YQ35UssXuAxleBDV2UVhG0DP+n89vTP1d8dtVF8l
         ZAlCTInQdC9vROhNERvrrqy5Zj3YvhwX8EP5G8auAGnNy/Qh4IN1+ET7J84qYrXOTCYE
         qKWfe3LkbD/w5nYLqDkCDcaD1Rrrl8S880DURObCGP5oPrisUhWXPtCP+IHvlWG2mXQS
         xuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        fh=TSOO7C4nAnQ3W18SndwQZkWIP1KFspXFB0X4qTB/1Sk=;
        b=pcQy6jdu0jzhoWTgFd1bPMVxLB7hZX3MWbAr5MgBCZSo6vvwzDvpmqpsOUKGkHcjVi
         GznK+7G4t3TXb3DBj4nIc3QhS1fvgNNNNS+tsOpp5BToIjRsmaNcgexI3mddByPyFl8X
         yBOeKQgGBDhBxQ3cnH80SQ5nu2w786paC2OXfcIrZXfd1NbP2ShnRMVq2yvcQOM0/021
         xEiDvuAnevRcOetQ+Xux8CpGBrXzNQcJ+9YIG6fT5OEcZ1DyRCeLQbNWn2OcK5LRef2Y
         XFshcIhk8jXNMK2zoqz5rff5Taq4NAKByWJeFCgBuG/e/XqeuBTu2Rtmhk9E5tGKFulc
         jzew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783771999; x=1784376799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=gHFB0fSemSn6s4jVp/EuBtir/qlPGO8Vq2wg3sOO56WQSEm3m1wgLV+PH+YCzCwe4w
         40XUJ8N3llKffVv3KvwlpEx0PwjFhEP4ejwfKckXHhOrs4COlZYMuCDJVCD700HVWfby
         Wef44AYzEvkwlRh4pmvCSPrnSSb+EuoMS7xAp1fqanhd4vgQUbVFs9DMhr/aX2ve4EZi
         XKK9VbugY1ax8izR6ls1BpqL9Fr7yUJMtkts2rZtlWUvAdEs5tvYZoRcRU9pXB0Y6W76
         RQw5PmUpYS6rrCfKNmEtUvADgYNWM7gb8xCEbJGzjwstKv7ju7GWWD5f6bQVByQhgD9b
         Verg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783771999; x=1784376799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=dLG8b1nk4Ki/PF1e0CdzbDTwYQRyLV2yj084N/fkBycqRFyLsqMeI0yqJNZNmxagZs
         AdETW9YSGeMcdVbEkXHlqr795FYV4tHxfI0yNFz+ysb92OzaHlropRvskDTYBnfFcH/Z
         GQjvMCAEHzjaalqtm/waQR+CheUDEN3aYRpDEk96IrSW9Q2hfwfZjVHk5QgDnqKJOc8T
         byRkUni7GdwElUHLm7FTHaMrqZcOzDkV+gbBw7UfievKiXhQrgwxv0pjNnCNq/uYLqTd
         1RMdgYIyn47ZzYQNOPcDxd8nwkbeEGJHwcdTCjNdVghrC8vJp2c8JD3ltjB+d/jJkHEq
         ppYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdpUtSmPgzQ45OcRAl33b4wdIa7xCE2sQSLFqwtcpywoMmEXGS6UxihJ0rBkOgfPc73/y/4oi1juk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29b0pHC/SnOuiBgbBKcuNGWI1POsnmX1383l2kh5p4xGK3/Yk
	B46ZANpUTt8UraSY3EwumC5/0qslp0hM3jb15i98ML9b8nmhEFrdDv7gNKs3VdbRFL+uXgC/vFy
	XVKRuSobur3XE0qZpFMh845qELZVJnT8=
X-Gm-Gg: AfdE7clhc4DGcBBoMu6oPexwFvPhXW1DgNxQVpPdoHG2/CSPhzbD+hIe3+hGfCfQ7KZ
	HsFPnauvYrK6C/wLxFGO90axofjuTd2b/5bbEXeRhFjL/alwsEIkG3RRmz0CMkbh+MGTorcbuNb
	24IbUR4DrmNA5CbsyqGXGsUkhMD6pJgdhpXeMfVF8fgfOa+oxowp1gKyqToZQ9g4Yr8z3HyzmJQ
	5L97hqS60dE3GgMGoZWYME6ULZlHb2LxrG+B0gZo4+AOb4hY57Ujtb9vKbpqeU5JHe1zaS9MzXK
	HU0+drgbsbGexRTaR79XJF1fnaBNaEgp5a9V/tiILJ1O5gBYXhVX0yWN1Djjw0sHhgBEI21inr7
	UwOa5ulGNo8nX
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38dc7c111a8mr1909664a91.6.1783771998816; Sat, 11 Jul 2026
 05:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706061928.66713-1-byungchul@sk.com> <20260706061928.66713-40-byungchul@sk.com>
In-Reply-To: <20260706061928.66713-40-byungchul@sk.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:13:05 +0200
X-Gm-Features: AUfX_mwWK6GqFCLIKCx9ivosmcno3i0b64L6R15FyNFXSSwj0HKdZlNefQKWcgc
Message-ID: <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
Subject: Re: [PATCH v19 39/40] rust: completion: Add __rust_helper to rust_helper_wait_for_completion()
To: Byungchul Park <byungchul@sk.com>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com, 
	kernel_team@skhynix.com, torvalds@linux-foundation.org, 
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, will@kernel.org, tglx@linutronix.de, 
	rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org, 
	daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com, 
	tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, 
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org, 
	linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com, 
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com, 
	yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com, 
	her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, 
	gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org, 
	arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com, 
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:22=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code, which is required
> for DEPT to play with wait_for_completion().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Apart from what Gary said -- why did you need to do this in a separate
patch in the same series?

Cheers,
Miguel
