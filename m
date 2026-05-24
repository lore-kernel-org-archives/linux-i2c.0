Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073538C41B
	for <linux-i2c@vger.kernel.org>; Sun, 24 May 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779601232; cv=pass; b=dnjWybEcVU7lL4Qctz+SJOn+TVVJqCX6Q4YjUIMnEIx9/UMDagoLeiWVd7+IWvXFu0hTVhRp5BpdUOkyJO7zSvvfpU7vtefYDpX0zrmBosezTWGV8RNKPkyLDpedTFa2/fb3j12ie5ZZehbQu2O+tsOzdF5SDBswhogFKM10OMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779601232; c=relaxed/simple;
	bh=FFyU0Agp3duT3812ugXRwk1O62+C0JSc7BoLG3Q5SKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVE7DsND8vHQ3jVBSTjNVz0XspA32+h9vxguQVTtykOeFm91g5tE8jw3p8z8kbtjKG+RDuS5nCM2pFbECUsnb0yRLJb4kQhMJ94/Z3eBsvqATSZApUabFY/EMZLWAnXh9kt0wSzWF33VNRZu7Nxj/pbEPMTzSiTlez2h0HBVzPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKlH/3FR; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKlH/3FR"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6530287803cso8671767d50.1
        for <linux-i2c@vger.kernel.org>; Sat, 23 May 2026 22:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779601229; cv=none;
        d=google.com; s=arc-20240605;
        b=RklEbzCslBc4WwLTvJIxVcTrTadj7fq92ibxqhAUCd7jVF4xyvgglWp8r7Ob9IRGrJ
         8YhSLFdbBBttkKX3S1+eThK3pjycK7hFtQwPWoRLfoeaITbAnquOhsru9fmbi23Qu+Ul
         opmVyD/f2Kg4QwQ6TEl/C6wiwMddv6a9jxNV0FdghAlOO7hQiVXz7Mv6QmGiTYdst/gB
         HAYJmw9qL4gS2nhCHffI//uEYMYs1n+Apx85vknF1XugYufsqPaurgsdnZy0i/H567Cp
         AcsZcU2qQ6iQSwE4EQZFBV1CsxYVR1kLhm7J43n7ANI/nZjEdI0BFoUfnQCaWcysnUL8
         ky5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PB3ioTsenX/7iD7ox1ZYbQDoqdQdKnSJARyszLFCgQc=;
        fh=8p13on8Gsxcyojo3YidgmVQgaGFTv3/fs8zbROOHj2o=;
        b=Bhd3rpmbwxp9cmSP7SZ41XgLi9XDPz1J9HRnTI3MBllhHPi1CIsX+YHo8Iyebw7bw1
         NfMxFqumSnyK3xWUPqHdpTn9Jmsz33pZi2REYdKkfkSUKJ3UalP9RX3vYVr3LBKnzV0o
         +2X2Yb3HrAjze0BsJimnxSSEB9D1BxUO3BQaYRP63AhY1kuSMnOH4PeCvNgLGZzYlHpb
         RKw2sGC0Zeb24J748m3dhEVRN5mUSWXoAWQwazJ3c2iCzfE/AsjsX8edZjrSlz5Oy00g
         GZMTeuLbZrGPz6gOvY9R+APWPKVczAZxIWXif4fLyAxmt4OITJ+tx9vPYm5uaZY1BdMh
         Y3Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779601229; x=1780206029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PB3ioTsenX/7iD7ox1ZYbQDoqdQdKnSJARyszLFCgQc=;
        b=lKlH/3FR62bF+/nZ0Rt8+NRyfmFlviDPsRcURCfwx2j5PC56o5TCzeKle/vPtgbv/8
         DQEWzLz6WuuZDclc4IR+fmpgKt/adixj+ZonpOGmM+rhMmr1SkWsuTSfXOU22DUcnHyt
         /J8GgNHFh5HWqxJIc9OZ6ZscodV4bUeUxu3a3l1hZGjo+6Q7Q8qjYRU6x7MgRlngU/SD
         aQ36H+/XCyMIPPR+ZefQXoMEx4gGE2wY8c7/gMc0OMBTSw2EFClhXOVdJQZvRQPTxLba
         2hKG+EVFdajRt0IwL5HHbpNV7AgP1DP4sSpKc7NpygiaOl3qopYVVwrRiVtxFKpdkn0j
         jrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779601229; x=1780206029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB3ioTsenX/7iD7ox1ZYbQDoqdQdKnSJARyszLFCgQc=;
        b=TD/F2YJybmqKfAhiX6Uw4G/qKe7JnObmoU4JC0TKEz+Sp16/l06ojZAixGOb/+hxX+
         hCF9faJmXOo+h1aq1p986Tj9THg8rcwbl5K+POb7gqekswwpAV3MTEe/duvx32HN63rh
         x1rqLed++LeLKKyOCT0DXY+ZgiExJAhRNl13N7/ET2OQo5+rYwN0LxZ1rswu8j5pxzD4
         RAOsH179hy5XBa9kNeP7LjyK2p84OXf1dg/GUMirREU8VCyEnqCl/d9Ps2dq4ZsUvTkE
         ix9/kvxtFXxWldJiZNRHwz968nf3AzquRW9r2l6EGAOVTLNOiuK4iHiqxmFETWotsN+F
         xxzA==
X-Gm-Message-State: AOJu0YwqtKURzuWEguXYG0MHUG7HOkSc0K58THAPe6rGblb7U22MP45h
	A7alfD0YcCODDbpdsCMHIFGUYwxHJRScd5q5sipNuoDnK4l2yzQIR8BTAArVPnX0wACJFgYZobq
	PWhBSuv6MSNF+PP4ZDwl0VoBVHSMiU8AfuAotJcjy3Q==
X-Gm-Gg: Acq92OEXMb+X7WPVES393RUBEVRlegLSl/Cz9oRsNjU7lzme/Lc/d0F3GB/Qj1hnVHz
	cBAnjZ+YFd17w42UScPNdUPYsskLKs26jVblWhyRQvmT2YG2QLKnDbQSYHw/CNUUz4WXZ5KT9Ur
	yua0tsJBCjMe+begTF+jCXkdJtgY4MTzvlbkToHCFV9KnNaqgVYE0nsThlki0Ih9Lz//L2nHdi4
	UefV4WsKxFypw0q1/ECS3ptqXs6ufzELWETOagvDBZv9FyuRfsykwG1WbNABTJuoLYwlH5e84q9
	8edVxKfZ6iyum11sBk+mnUAxu2jiQ4iwGc24jvaUJyxH6OrBnmNYrlJ6M4Mbrbv9XRaCjwJzpY6
	C1E2K8wmmSutHuBDZg4JBPyQfVfPytaS73Me/4MEqC2xMe/1G4e+peMR6uUs=
X-Received: by 2002:a05:690e:d02:b0:64e:f106:60ea with SMTP id
 956f58d0204a3-65ec9938bb6mr10304651d50.44.1779601229184; Sat, 23 May 2026
 22:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523174440.9629-2-hardikprakash.official@gmail.com> <202605240959.Kcf1lIg4-lkp@intel.com>
In-Reply-To: <202605240959.Kcf1lIg4-lkp@intel.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Sun, 24 May 2026 11:10:17 +0530
X-Gm-Features: AVHnY4KFGm1FRMDp57VE89vJQfBy8s3Xij_f6JIE9wMxIq8ViEfXwrWfjlI0icU
Message-ID: <CANTFpSWd3ysA7qNurHFuCPmEah1dGSfDTiFJRteU08A3kHE3=w@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: kernel test robot <lkp@intel.com>
Cc: linux-i2c@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, May 23, 2026 at 23:27, Mario Limonciello wrote:
> Is patch 1 still needed with this approach?

No. Tested v6 alone (without patch 1) on a tree based on
63d2059cd665 (the commit immediately before patch 1 in Walleij's
fixes branch). Touchscreen and stylus fully functional, no arbitration
errors.

This confirms your original concern was correct -- the existing
amd_gpio_irq_enable() flow works fine once probe ordering is fixed.
Patch 1's manual IRQ restoration was only necessary because the race
prevented amd_gpio_irq_enable() from ever being called.

v6 is sufficient as a standalone fix. Patch 1 in Linus Walleij's tree
can be reverted if desired.

Also noting that the kernel test robot flagged an unused 'ret' variable
in check_child_gpioint() -- I have a fix ready and will send v7 once
the question of patch 1 is settled.

Thanks,
Hardik

On Sun, 24 May 2026 at 07:18, kernel test robot <lkp@intel.com> wrote:
>
> Hi Hardik,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 3812a9e84265a5cdd90d29fe8d97a023e91fb945]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Hardik-Prakash/i2c-designware-defer-probe-if-child-GpioInt-controllers-are-not-bound/20260524-014648
> base:   3812a9e84265a5cdd90d29fe8d97a023e91fb945
> patch link:    https://lore.kernel.org/r/20260523174440.9629-2-hardikprakash.official%40gmail.com
> patch subject: [PATCH v6 1/1] i2c: designware: defer probe if child GpioInt controllers are not bound
> config: x86_64-randconfig-001-20260524 (https://download.01.org/0day-ci/archive/20260524/202605240959.Kcf1lIg4-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260524/202605240959.Kcf1lIg4-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605240959.Kcf1lIg4-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/i2c/busses/i2c-designware-platdrv.c:192:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>      192 |         int ret;
>          |             ^
>    1 warning generated.
>
>
> vim +/ret +192 drivers/i2c/busses/i2c-designware-platdrv.c
>
>    187
>    188  static int check_child_gpioint(struct acpi_device *adev, void *data)
>    189  {
>    190          struct gpio_dep_ctx *ctx = data;
>    191          struct list_head res_list;
>  > 192          int ret;
>    193
>    194          INIT_LIST_HEAD(&res_list);
>    195
>    196          ret = acpi_dev_get_resources(adev, &res_list, check_gpioint_resource, ctx);
>    197          acpi_dev_free_resource_list(&res_list);
>    198
>    199          if (ctx->ret < 0)
>    200                  return ctx->ret;
>    201
>    202          return 0;
>    203  }
>    204
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
