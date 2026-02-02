Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A91FDE39
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769997998; cv=pass; b=pfJUOuMSSYRW5PKgWC4FdGyOivqIWLCJp6XUt+Ocqf3NazdJ9vjdxMwUt/Ef0u2+2v2ZDBneRoGNX+y0deVE0a8/PIpLvkQD10JENTLOsfPTV5/RmCrAheEVmE5+KgQBYObmmhiTtxcuGXynkIitsv+m7Ha/1WQyDC0pGUsUhy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769997998; c=relaxed/simple;
	bh=cZHOuyFSDD0YCiUahnVWqH20bORv4bma4nfHULxUbNM=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHkct9WXeobkJ1n3g+n+R2odKHNOPw6n7O657FmtAaRZbkuK/EZkHv04zsldqqust1dEjovk+kwC4OiV1rw+l1W3J7Ze3Qdk343s2uccKUFfN7/zzfMMURedKB5nYiaogANwslz4O/1wLB3Qpl4ykQ3WEdseD3nalw/OMViinE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=CV6mQGF+; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="CV6mQGF+"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794d58b892cso3948667b3.2
        for <linux-i2c@vger.kernel.org>; Sun, 01 Feb 2026 18:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769997995; cv=none;
        d=google.com; s=arc-20240605;
        b=gF4fUZcPmS3UfE/jDKeRgeyjis+eRfcx+6N31MQIx6zLfJ6CldwCzAq+WbmhKrm/pk
         pymvoC30mFrlFieKY7yHknxYu7gkDTFRT6aMXEcNbQUQKM4PCaOKUHCnsY2U8Su1qQSU
         JdCely/ireM9OlM/lb3Yp+fWCt9T23f8MraCLcIUyouckXjA9PoL7edK0Qxz5UbE+rZK
         UPKKrzpQm8ppQn1BZB/MrmKrKnO6NyIu6pkfhqhPkc95mdYOhCK47sdMlfKUhml05ys9
         pVCwBZcLutyEQ++H+c5ARmJHP9UOrRZo72TDl4/+0iDKX7c4iT2qSh34+eiWICOhV1GQ
         bGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:dkim-signature;
        bh=aMiZMMtcuEUphHiFBhOZs43qw2Jy4XV2UcTsb9dz3D0=;
        fh=NbZWxHsbivZ5wfy42NUhZZOdtpBGOV1BfW8fRf0Nvh0=;
        b=LGKNbe0RDWUvH+/XJ6jbKgRiW6Eiqh7loCAllQvMxBHO/7HeMTGz58LDq1kxvgclB1
         xgDcAdVucN4g3SikDxQqS0m09f4wbo74Gc3sjoSPOTK41sD1XpyQ2xkWswWDHh4aKTHF
         OGwL/OtEdcdEQe8advccMlqGKTNlsk3LIUH1PwMMpJgYiM7UAm113xT4jlxOOrjA9Klf
         xJXLowS2bjSjFSG5s/ecyBk7YMdF4IboJWqofkOYGgM9dm1kqQdxUXLackwhipE6jS0r
         uL6xj+2lmKfTRnyldvarpDYk6prjEQ3gTfEQNdKBQ0fBg7VIxPB9+HHqlGHPTvr53Ooy
         WCRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769997995; x=1770602795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMiZMMtcuEUphHiFBhOZs43qw2Jy4XV2UcTsb9dz3D0=;
        b=CV6mQGF+4ioMLL/OrHOp6SCrZ2vMfrCEV8bxM+SO89R7+MC5J6Tgy9U96Xfysk09Om
         VK+1lyyZOo7eF2V6inK8Uf71Cp9co08/rke+U+9LUOXC9SjfXJ8kWx82aPBRuKK+awB8
         fyWcWOORevBMXNcpFJAj8/DGehUp9KIwd7WBjz1BPSR00/FRJhZxyIhoYHvPU4jILhCU
         APuXRItZnhqMIZspGHsurQSeKJRMOHSkdDKRgUbyaDwlteFSoqLSuVFZ0iTRN3zSeESL
         1kz+ar1NbgWQIPtMwc7TWBwTDX/xUl1rkSY/fsi2dOZglcfkdvsaYFWgWHA7oZBWQsyh
         6t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769997995; x=1770602795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMiZMMtcuEUphHiFBhOZs43qw2Jy4XV2UcTsb9dz3D0=;
        b=NEaZwC5lZt61H500YtFjHO501hZj1GZL2qn/ouQVPUquE8FjGJOAhxq0fAiA3kWbkv
         KnpASlY1+DlrYiacbIu538lZuT7UnPyPJYUtAJUjWj0GadWrC2oytiJSjh9D1dqVxNVd
         a2wXreliIL0ut2lQlQCJ30oQWjcQa8k9SSTsJywgv3OP1B3Hyhv184OFTBWh2Z1TGvNP
         tBJhaxQ6c0cSU2vWjmKJcirwmmAhCAW4jj+d0nyZoVlEpD0jUgbcL0K2DAS0H74AouxO
         l5AVpPIaggOy40R9Il3cfndkpxiMpo3g/AKToxbpq7YM9lp98LfgPumQhBPCe6IFrLvP
         QdDA==
X-Forwarded-Encrypted: i=1; AJvYcCUt2Lv/i1kl4DJdbAFriQsp1qaIYwY63ZJSQfBbWHS3MavzF74ESlQK0ZQ92cUqGAmDMNL86uUr8RU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0BuMUfp3Kb+3NNT8Ronv4pxuC28nU/UGuu1+0ymY390jmdla
	nOf9Ud9f14z3DzEraUdytj+WVqdJnNup7Rofa8jTRws0QQKz+tQXf0Rqh7XRHbyAzHnOeosXSGu
	FRfQGSRpsrnp/Hl638D7Oc03Esw5SLml6yYcMu+xt7A==
X-Gm-Gg: AZuq6aJ/y2rsxisgsSGt/flHf9P5Cd++dxQrqsLA1a6lMWb7ZpLUHk+zru75cHFZ1Ym
	SkpmJ099n2vdMuhz3WwI4OHBrVjednkdIcu/ajcW7IObGv2eU7jujLfCHd/F8+43BuVzjMWikW4
	0PquE4fVZo1mzKrDMGJmL7DZH40UqgWgannjtOPMCVzwxv60BeLF7Uf6RTmIXwydn5kH81N05Jf
	JF19WBTX2SQBbAogcQGo+QJfrrpLtI/NbMX69taBw2NhYZ1+SSY2tFBD9xSFL5OW+/O2KKT
X-Received: by 2002:a05:690c:e3e1:b0:794:198e:943b with SMTP id
 00721157ae682-7949de7f6bfmr88706007b3.8.1769997994805; Sun, 01 Feb 2026
 18:06:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 02:06:34 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 02:06:34 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <202601311615.10yziOui-lkp@intel.com> <81522270-1703-48E1-B64C-8CF174E1EF94@nexthop.ai>
 <r2qkeep6jf7xxjzckn72z4avgx3qiqh4g2fkvzeyu2p2o54bff@xs4kzlong7cn>
In-Reply-To: <r2qkeep6jf7xxjzckn72z4avgx3qiqh4g2fkvzeyu2p2o54bff@xs4kzlong7cn>
Date: Mon, 2 Feb 2026 02:06:34 +0000
X-Gm-Features: AZwV_QgA40VM4P6w_-3GskOG6YPGtVtQKONh5VU7M0VmOxyGKRkaTPHiN25oam0
Message-ID: <CAGYn4vxTAJwO3GiKmRtD1gTit-Wm4VOMnxZPxUfUJ0JEwj8dEw@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] i2c: xiic: cosmetic cleanup
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev, 
	Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun Feb 1, 2026 at 10:23 PM UTC, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Sat, Jan 31, 2026 at 06:14:58PM -0800, Abdurrahman Hussain wrote:
>> > On Jan 31, 2026, at 6:35=E2=80=AFAM, Dan Carpenter <dan.carpenter@lina=
ro.org> wrote:
>> > kernel test robot noticed the following build warnings:
>> >
>> > url:    https://github.com/intel-lab-lkp/linux/commits/Abdurrahman-Hus=
sain-via-B4-Relay/i2c-xiic-skip-input-clock-setup-on-non-OF-systems/2026013=
0-054653
>> > base:   63804fed149a6750ffd28610c5c1c98cce6bd377
>> > patch link:    https://lore.kernel.org/r/20260129-i2c-xiic-v7-5-727e43=
4897ef%40nexthop.ai
>> > patch subject: [PATCH v7 5/6] i2c: xiic: cosmetic cleanup
>> > config: i386-randconfig-141-20260130 (https://download.01.org/0day-ci/=
archive/20260131/202601311615.10yziOui-lkp@intel.com/config)
>> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 8=
7f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>> > smatch version: v0.5.0-8994-gd50c5a4c
>> >
>> > If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
>> > the same patch/commit), kindly add following tags
>> > | Reported-by: kernel test robot <lkp@intel.com>
>> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> > | Closes: https://lore.kernel.org/r/202601311615.10yziOui-lkp@intel.co=
m/
>> >
>> > smatch warnings:
>> > drivers/i2c/busses/i2c-xiic.c:1539 xiic_i2c_remove() warn: pm_runtime_=
get_sync() also returns 1 on success
>> >
>> > vim +1539 drivers/i2c/busses/i2c-xiic.c
>> >
>> > e190a0c389e601 Uwe Kleine-K=C3=B6nig    2023-05-08  1529  static void =
xiic_i2c_remove(struct platform_device *pdev)
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1530  {
>> > 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1531   struct device *d=
ev =3D &pdev->dev;
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1532   struct xiic=
_i2c *i2c =3D platform_get_drvdata(pdev);
>> > 36ecbcab84d023 Shubhrajyoti Datta  2016-03-02  1533   int ret;
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1534
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1535   /* remove a=
dapter & data */
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1536   i2c_del_ada=
pter(&i2c->adap);
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1537
>> > 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1538   ret =3D pm_runti=
me_get_sync(dev);
>> > 2557b4ba04df79 Abdurrahman Hussain 2026-01-29 @1539   if (ret)
>> > 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1540   dev_warn(dev, "F=
ailed to activate device for removal (%pe)\n",
>> > 810199f7315604 Uwe Kleine-K=C3=B6nig    2022-10-19  1541   ERR_PTR(ret=
));
>> >
>> >
>> > pm_runtime_get_sync() can return 1 on success.  Perhaps use
>> > pm_runtime_resume_and_get()?
>> >
>> > 810199f7315604 Uwe Kleine-K=C3=B6nig    2022-10-19  1542   else
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1543   xiic_deinit=
(i2c);
>> > 810199f7315604 Uwe Kleine-K=C3=B6nig    2022-10-19  1544
>> > 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1545   pm_runtime_put_s=
ync(dev);
>> > 2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1546   pm_runtime_dont_=
use_autosuspend(dev);
>> > e1d5b6598cdc33 Richard R=C3=B6jfors     2010-02-11  1547  }
>> >
>> > --
>> > 0-DAY CI Kernel Test Service
>> > https://github.com/intel/lkp-tests/wiki
>> >
>>
>> This maybe a false positive.
>
> It's not.
>
> The blamed commit 2557b4ba04df ("i2c: xiic: cosmetic cleanup") has:
>
> -       ret =3D pm_runtime_get_sync(i2c->dev);
> -
> -       if (ret < 0)
> -               dev_warn(&pdev->dev, "Failed to activate device for remov=
al (%pe)\n",
> +       ret =3D pm_runtime_get_sync(dev);
> +       if (ret)
> +               dev_warn(dev, "Failed to activate device for removal (%pe=
)\n",
>                          ERR_PTR(ret));
>
> So we need
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.=
c
> index 37a15065db60..a5334b7c46d8 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -1536,7 +1536,7 @@ static void xiic_i2c_remove(struct platform_device =
*pdev)
>  	i2c_del_adapter(&i2c->adap);
>
>  	ret =3D pm_runtime_get_sync(dev);
> -	if (ret)
> +	if (ret < 0)
>  		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
>  			 ERR_PTR(ret));
>  	else
>
> Best regards
> Uwe

Hi Uwe,

Yes, indeed, I missed that. Thanks for pointing it out!

Best regards,
Abdurrahman
