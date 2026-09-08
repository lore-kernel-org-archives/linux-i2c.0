Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5171330BB8D
	for <linux-i2c@vger.kernel.org>; Tue,  8 Sep 2026 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841407; cv=pass; b=I3FycFBqhA47QsaUwszpvI7l2INL3bAIW3C8rFcky6eeThF9qIt0ZF7kgVJZO6ohGckKlxaXYDzLF0e9r4KAZ9gGxI84VnzmcLg//HMz2Cek6npXl6/QrmRKY8Sy3nsn0RWuMd/i0Rs+oflj+gDMvl+BlKursYOA+vbtFawcjOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841407; c=relaxed/simple;
	bh=OiwksJVeBYIuZzTcu72Dg7gibbJleKPZw0Sws+Kzavk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcbxjL7kbecb9etBolxPtNNXQJrXkBPjaTVTLcea+2Xfqf76HUjiAswXkkTj8SsIAsRsvVgv1x2x8+8yNFtuYxMQJWLx/IT/ZVmXE2HCgA5ZIy2bveHm1wXk7zHFWx3JAW7bU/dvz/+q/dVnJ5RlDdeAnhWgGD49b517ykG56rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=bhThNsx9; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="bhThNsx9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so31009855ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 21:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788841404; cv=none;
        d=google.com; s=arc-20260327;
        b=d0+QW6qwWygz6cnMj+PUqC1GDZ/yM3YYdVxlX18+R0zk+FyknxvUUgdODdq1tCpvo8
         KLd0jJYdjYzX+TzoYOKkrjRQKe/LOFUY8iCnVQ5QILWhTqPdcPjRnaAy7atVjv1CUmLW
         byoyKr8z6DAj/KlbYK+pngS84AAjlo7xUKMEvf7zGTtuKY/lhrSm8lG6htBD+Necpg2L
         7p275wD6/DxxrMctSP/Sf2a6MsfoSCdLX4yeBNUmweqb30M5ALxi7YvzOBQJ8K29NN+e
         qQIpR+6kpQzmOfH1a4ROYNSX5TeMEfMLNnjlVMFDvoU9qxQyBi6qJbEMBYdBQmHBq4M/
         xHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OiwksJVeBYIuZzTcu72Dg7gibbJleKPZw0Sws+Kzavk=;
        fh=BKoGjp5yIFYXCwpUAUnqRUEgpnVIJ7/RXHxjCgmG1YU=;
        b=FUTtVQSCTJ9anJ5D35pO0m8ub/FfQaBhM+q4ql5xHpi78UpIFrUGthtUQFVl5UFb9Z
         heq+FuiQX4MvLpLFXXHx1wdEuhKPLt3++WrudUiOAmOxAgvbCUdptYiqrttYes8mUI80
         0ooW2/mXfUvedvMP43YGRwOE4KESp5tnc/urSBu2r8JFBGTnwRZk7LA8mMc4JYvxK/ka
         ponblSv4/70ruryl9qpRqfxtWN+DvsDXBkO34TReqkixX0+ZLwL4zW2k6oOmuFu1XLNP
         ePflh3CDc9XP16HwBBIoq32M/ZfFQHG+Y0b508YjjJGzwhR0xVj7q3AzIV2Gpb2lgg7H
         5mWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1788841404; x=1789446204; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiwksJVeBYIuZzTcu72Dg7gibbJleKPZw0Sws+Kzavk=;
        b=bhThNsx99u4M2ti/dtd3Gh/jis8CyR88boUGm/Y5HPpzS5+uGR1PAJABLvOcEFdvKE
         xJL2w40+vRgql4l4YCCudv5+VxzRDL88mp8zlyVORIVWxY6hCCryEg8gQusghgWgq+NO
         ao538ptynLTL6RvtU9WfZubx/oYj7TkgoG5aroIVIM5C3RUVWkkN0dTA0CN1cGlKR4QR
         g3bcRKmE52a52R+QWnR3yVn1Ec8m6659Hs+fRkRr0NpSy6IapLrkJWC/BuqWOWZxl8qD
         wftC0LZQT+M4bDqZ/YT72Ii77AODWbtoaUKLxV6ZTb2+h0Fqxpt8WysXukn3immBqo3+
         QblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841404; x=1789446204;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OiwksJVeBYIuZzTcu72Dg7gibbJleKPZw0Sws+Kzavk=;
        b=Yq9rvdHhbExoO0qjQlwtSHvmL//41Yv1bSS+2ES4wNkwvSsnI4k8BdYTIA+i0wxOpJ
         kF96TzWLbYULWjqU3B7VwIQtD2Df2AAvDo9jwGGzlNXQxFJHspBzyYItixDh15Bt7eJw
         586sKdXYQezsKXflJl3UtSZeW4USVp35O82egkYVzKTKFd7IvkRbPvJEiSXeCV9R+u6H
         RonvDxJrccp26JuQ6a1P1Q1eqcPfhh6ODkvfy3gwxGtZ64n/nt2Q3u7A4cpLx3ZsF5fJ
         W9u9W0c87wlFQIjipd3TICWzhjzxLuBbMMuceDhdskRS5bSNKSvSETqoQvTsK/tLnLiG
         06yA==
X-Forwarded-Encrypted: i=1; AKwUvByggj47IScQ4rmwGr84dzH176zROK/kQFUpqdJhp19RcJLqcaaS7PXQ6l+8tCvSpzVJg6jw+FkBdrE=@vger.kernel.org
X-Gm-Message-State: AFuF++mMPlnf5a3y9Day/W7mEsm9KqA5HjRqyzwFk2FJO6i0ZkvMoF5z
	JAsaYyPE7nf0OXROWPU+cRrXIIxYNp3/gSLdOB1A1HqdIoayqY4yWfnzAhtBDqtUYdTKD8OJ5pl
	TGLIwcjK2h/e9DwdSHbgjB+AQZWydsuxzWRuMvj3YzDSmbqwW4vBzepCIf3U=
X-Gm-Gg: AYBFou2xNutSVAhoyfRPKgaLPVOmvqjvpniI//t22dCEExKe+2SrLQFLYpe55xiS5Jg
	pJ0BLXZ0x+MfYHBURBUnSYDQoq0s1PzUXaC5FrJBOr9zfRcPyZodzfE6inu5u24q8iP67NYheQN
	ATR6qPe/00d8e1sXJiG+sK8exgHnVfdvJBDbIdpn1/9S5tHCG/0wAOh62P71DhgIuzLbxbXucNk
	+yI2MZufdG+IdB8+l0zdqJ7yaIDbVw91Gpg6NQgcb0TZxhTOfrVy72zNdBd25cQLAKfnv15u/er
	FhzKKBdJ4jSYBg3ubR/Kvn7oYvnB6y/Y6Qtct91dq4D3ypep6kNjH1Jrs5SdoRQmpCmSTIPeTmU
	DfhqAfx5Z04b+dSsuczH83ae8deClBBM=
X-Received: by 2002:a17:903:22d0:b0:2d8:d4ce:7e40 with SMTP id
 d9443c01a7336-2db12674f20mr381151415ad.21.1788841403193; Mon, 07 Sep 2026
 21:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com>
 <20260830041303.1934825-1-peda@lysator.liu.se> <apSAfJARPgsbSDYb@zenone.zhora.eu>
 <apSdR2m-uibYHxVI@gryt>
In-Reply-To: <apSdR2m-uibYHxVI@gryt>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Mon, 7 Sep 2026 21:23:11 -0700
X-Gm-Features: AcwNN1Upvo6GrSqmHicQ1hWJ9pTtZsthHj9TpYgDjsDKN3gq6BnDnB1FTbnfUDo
Message-ID: <CA+0ovCg6zgs3Udd3tGCw-2gf3fV_THt2r1LrUsmdyx-R+kK_9g@mail.gmail.com>
Subject: Re: [PATCH] i2c: mux: avoid WARN on benign symlink creation failures
To: Peter Rosin <peda@lysator.liu.se>
Cc: Andi Shyti <andi.shyti@kernel.org>, falemi@asu.edu, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000671af2065af11849"

--000000000000671af2065af11849
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the delay in response; upon our run, the patched kernel
(your 2 patches augmented & applied on 28924df2a08f) no longer panics
on the attached reproducer.

Thanks!

On Sun, Aug 30, 2026 at 2:14=E2=80=AFPM Peter Rosin <peda@lysator.liu.se> w=
rote:
>
> Den Sun, Aug 30, 2026 at 09:13:24PM +0200, skrev Andi Shyti:
> > Hi Peter,
> >
> > On Sun, Aug 30, 2026 at 06:13:03AM +0200, Peter Rosin wrote:
> > > WARN() is a bit harsh and causes a crash for panic-on-warn users. Deg=
rade
> > > the error reporting to ordinary dev_err() calls.
> > >
> > > Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > > Link: https://lore.kernel.org/all/CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w=
9QZXz8uD3Agws31g@mail.gmail.com/
> > > Signed-off-by: Peter Rosin <peda@lysator.liu.se>
> > > ---
> > >
> > > Hi Farhad,
> > >
> > > I assume this patch helps?
> >
> > I sent this patch for a quick test:
> >
> > https://lore.kernel.org/all/20260828135950.454799-1-andi.shyti@kernel.o=
rg/
> >
> > Maybe they can be taken together, as I agree not to fire a WARN()
> > there.
>
> Hi Andi,
>
> [sorry for droping you from cc, that was unintentional]
>
> Yes, sure! And fixing the root cause is of course always nice, good one!
>
> Cheers,
> Peter

--000000000000671af2065af11849
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mts5xxtc1>
X-Attachment-Id: f_mts5xxtc1

LyoKICogUmVwcm9kdWNlciBmb3IgMTg1LXdhcm5pbmctaW4taTJjLW11eC1hZGQtYWRhcHRlcgog
Ki8KI2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZGlyZW50Lmg+CiNpbmNsdWRlIDxmY250
bC5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxz
dGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUg
PHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2lu
Y2x1ZGUgPGxpbnV4L3VzYi9jaDkuaD4KI2luY2x1ZGUgPGxpbnV4L3VzYi9yYXdfZ2FkZ2V0Lmg+
CgojZGVmaW5lIEVQMF9NQVggNDA5NgoKc3RhdGljIGludCByYXdfZ2FkZ2V0X2ZkOwoKc3RhdGlj
IGNvbnN0IHVpbnQ4X3QgZGV2aWNlX2Rlc2NyaXB0b3JbMThdID0gewoJMHgxMiwgMHgwMSwgMHgx
MCwgMHgwMSwgMHgwMCwgMHgwMCwgMHgwMCwgMHg0MCwgMHg3MiwgMHgwNSwgMHhhMiwgMHg1OCwK
CTB4MDAsIDB4MDEsIDB4MDEsIDB4MDIsIDB4MDMsIDB4MDEsCn07CgpzdGF0aWMgY29uc3QgdWlu
dDhfdCBjb25maWdfZGVzY3JpcHRvclsxMjVdID0gewoJMHgwOSwgMHgwMiwgMHg3ZCwgMHgwMCwg
MHgwNiwgMHgwMSwgMHgwMCwgMHg4MCwgMHgzMiwgMHgwOSwgMHgwOSwgMHgwMCwKCTB4MDAsIDB4
MDEsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDgsIDB4MGIsIDB4MDEsIDB4MDUsIDB4ZmYs
IDB4ZmYsCgkweGZmLCAweDAwLCAweDA5LCAweDA1LCAweDgxLCAweDAyLCAweDQwLCAweDAwLCAw
eDAwLCAweDAwLCAweDAwLCAweDA5LAoJMHgwNCwgMHgwMSwgMHgwMCwgMHgwMSwgMHgwMCwgMHgw
MCwgMHgwMCwgMHgwMCwgMHgwOSwgMHgwNSwgMHg4MiwgMHgwMiwKCTB4NDAsIDB4MDAsIDB4MDAs
IDB4MDAsIDB4MDAsIDB4MDksIDB4MDQsIDB4MDIsIDB4MDAsIDB4MDEsIDB4MDAsIDB4MDAsCgkw
eDAwLCAweDAwLCAweDA5LCAweDA1LCAweDgzLCAweDAyLCAweDQwLCAweDAwLCAweDAwLCAweDAw
LCAweDAwLCAweDA5LAoJMHgwNCwgMHgwMywgMHgwMCwgMHgwMSwgMHgwMCwgMHgwMCwgMHgwMCwg
MHgwMCwgMHgwOSwgMHgwNSwgMHg4NCwgMHgwMiwKCTB4NDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4
MDAsIDB4MDksIDB4MDQsIDB4MDQsIDB4MDAsIDB4MDEsIDB4MDAsIDB4MDAsCgkweDAwLCAweDAw
LCAweDA5LCAweDA1LCAweDg1LCAweDAyLCAweDQwLCAweDAwLCAweDAwLCAweDAwLCAweDAwLCAw
eDA5LAoJMHgwNCwgMHgwNSwgMHgwMCwgMHgwMSwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMCwgMHgw
OSwgMHgwNSwgMHg4NiwgMHgwMiwKCTB4NDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsCn07Cgpz
dGF0aWMgdm9pZCBlcDBfdHJhbnNmZXIoY29uc3Qgdm9pZCAqZGF0YSwgdWludDMyX3QgbGVuKQp7
Cgl1aW50OF90IGJ1ZltzaXplb2Yoc3RydWN0IHVzYl9yYXdfZXBfaW8pICsgRVAwX01BWF07Cglz
dHJ1Y3QgdXNiX3Jhd19lcF9pbyAqaW8gPSAodm9pZCAqKWJ1ZjsKCglpby0+ZXAgPSAwOwoJaW8t
PmZsYWdzID0gMDsKCWlvLT5sZW5ndGggPSBsZW47CglpZiAoZGF0YSkKCQltZW1jcHkoaW8tPmRh
dGEsIGRhdGEsIGxlbik7CgkvKiBhbiBPVVQgdHJhbnNmZXIgaXMgYWNrbm93bGVkZ2VkIHdpdGgg
RVAwX1JFQUQsIG5vdCBFUDBfV1JJVEUgKi8KCWlvY3RsKHJhd19nYWRnZXRfZmQsIGRhdGEgPyBV
U0JfUkFXX0lPQ1RMX0VQMF9XUklURSA6IFVTQl9SQVdfSU9DVExfRVAwX1JFQUQsIGlvKTsKfQoK
c3RhdGljIHZvaWQgaGFuZGxlX2NvbnRyb2xfcmVxdWVzdChjb25zdCBzdHJ1Y3QgdXNiX2N0cmxy
ZXF1ZXN0ICpjdHJsKQp7CglzdGF0aWMgdWludDhfdCB2ZW5kb3JfcmVwbHlbRVAwX01BWF07Cglj
b25zdCB1aW50OF90ICpyZXBseSA9IE5VTEw7Cgl1aW50MzJfdCByZXBseV9sZW4gPSAwOwoKCWlm
ICgoY3RybC0+YlJlcXVlc3RUeXBlICYgVVNCX1RZUEVfTUFTSykgPT0gVVNCX1RZUEVfU1RBTkRB
UkQpIHsKCQlpZiAoY3RybC0+YlJlcXVlc3QgPT0gVVNCX1JFUV9HRVRfREVTQ1JJUFRPUiAmJgoJ
CSAgICAoY3RybC0+d1ZhbHVlID4+IDgpID09IFVTQl9EVF9ERVZJQ0UpIHsKCQkJcmVwbHkgPSBk
ZXZpY2VfZGVzY3JpcHRvcjsKCQkJcmVwbHlfbGVuID0gc2l6ZW9mKGRldmljZV9kZXNjcmlwdG9y
KTsKCQl9IGVsc2UgaWYgKGN0cmwtPmJSZXF1ZXN0ID09IFVTQl9SRVFfR0VUX0RFU0NSSVBUT1Ig
JiYKCQkJICAgKGN0cmwtPndWYWx1ZSA+PiA4KSA9PSBVU0JfRFRfQ09ORklHKSB7CgkJCXJlcGx5
ID0gY29uZmlnX2Rlc2NyaXB0b3I7CgkJCXJlcGx5X2xlbiA9IHNpemVvZihjb25maWdfZGVzY3Jp
cHRvcik7CgkJfSBlbHNlIGlmIChjdHJsLT5iUmVxdWVzdCA9PSBVU0JfUkVRX1NFVF9DT05GSUdV
UkFUSU9OKSB7CgkJCWlvY3RsKHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfQ09ORklHVVJF
LCAwKTsKCQkJZXAwX3RyYW5zZmVyKE5VTEwsIDApOwoJCQlyZXR1cm47CgkJfQoJfSBlbHNlIGlm
IChjdHJsLT5iUmVxdWVzdFR5cGUgJiBVU0JfRElSX0lOKSB7CgkJbWVtc2V0KHZlbmRvcl9yZXBs
eSwgMCwgc2l6ZW9mKHZlbmRvcl9yZXBseSkpOwoJCS8qIEJPQVJEX0NGR19TVEFUOiB3aXRob3V0
IHRoaXMgaW5pdGlhbGl6ZV9jeDIzMXh4KCkgZmFpbHMgYW5kCgkJICogcHJvYmUgcmV0dXJucyBi
ZWZvcmUgdGhlIGkyYyBtdXggaXMgZXZlciByZWdpc3RlcmVkICovCgkJaWYgKGN0cmwtPmJSZXF1
ZXN0ID09IDB4MGQgJiYgY3RybC0+d0luZGV4ID09IDB4MDAwMCkKCQkJdmVuZG9yX3JlcGx5WzBd
ID0gMHg4MTsKCQkvKiBBRkUgU1VQX0JMS19QV1JETjogdGhlIHZhbHVlIHRoZSB1bmNhcHBlZAoJ
CSAqICJ3aGlsZSAoYWZlX3Bvd2VyX3N0YXR1cyAhPSAweDE4KSIgbG9vcHMgd2FpdCBmb3IgKi8K
CQllbHNlIGlmIChjdHJsLT53SW5kZXggPT0gMHgwMDA4KQoJCQl2ZW5kb3JfcmVwbHlbMF0gPSAw
eDE4OwoJCXJlcGx5ID0gdmVuZG9yX3JlcGx5OwoJCXJlcGx5X2xlbiA9IGN0cmwtPndMZW5ndGgg
PiBFUDBfTUFYID8gRVAwX01BWCA6IGN0cmwtPndMZW5ndGg7Cgl9IGVsc2UgewoJCWVwMF90cmFu
c2ZlcihOVUxMLCAwKTsKCQlyZXR1cm47Cgl9CglpZiAoIXJlcGx5KSB7CgkJaW9jdGwocmF3X2dh
ZGdldF9mZCwgVVNCX1JBV19JT0NUTF9FUDBfU1RBTEwsIDApOwoJCXJldHVybjsKCX0KCWlmIChy
ZXBseV9sZW4gPiBjdHJsLT53TGVuZ3RoKQoJCXJlcGx5X2xlbiA9IGN0cmwtPndMZW5ndGg7Cgll
cDBfdHJhbnNmZXIocmVwbHksIHJlcGx5X2xlbik7Cn0KCnN0YXRpYyB2b2lkICpnYWRnZXRfZXZl
bnRfbG9vcCh2b2lkICp1bnVzZWQpCnsKCXVpbnQ4X3QgYnVmW3NpemVvZihzdHJ1Y3QgdXNiX3Jh
d19ldmVudCkgKyBFUDBfTUFYXTsKCXN0cnVjdCB1c2JfcmF3X2V2ZW50ICpldmVudCA9ICh2b2lk
ICopYnVmOwoKCWZvciAoOzspIHsKCQlldmVudC0+dHlwZSA9IDA7CgkJZXZlbnQtPmxlbmd0aCA9
IEVQMF9NQVg7CgkJaWYgKGlvY3RsKHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfRVZFTlRf
RkVUQ0gsIGV2ZW50KSA8IDApIHsKCQkJdXNsZWVwKDEwMDApOwoJCQljb250aW51ZTsKCQl9CgkJ
aWYgKGV2ZW50LT50eXBlID09IFVTQl9SQVdfRVZFTlRfQ09OVFJPTCkKCQkJaGFuZGxlX2NvbnRy
b2xfcmVxdWVzdCgoc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqKWV2ZW50LT5kYXRhKTsKCX0KCXJl
dHVybiB1bnVzZWQ7Cn0KCnN0YXRpYyB2b2lkIHdyaXRlX3N5c2ZzKGNvbnN0IGNoYXIgKnN5c2Zz
X3BhdGgsIGNvbnN0IGNoYXIgKnZhbHVlKQp7CglpbnQgc3lzZnNfZmQgPSBvcGVuKHN5c2ZzX3Bh
dGgsIE9fV1JPTkxZKTsKCglpZiAoc3lzZnNfZmQgPCAwKQoJCXJldHVybjsKCXdyaXRlKHN5c2Zz
X2ZkLCB2YWx1ZSwgc3RybGVuKHZhbHVlKSk7CgljbG9zZShzeXNmc19mZCk7Cn0KCi8qIHVkZXYg
cnVucyB2NGxfaWQgb24gdGhlIHZpZGVvIG5vZGUgY3gyMzF4eCByZWdpc3RlcnM7IHRoYXQgb3Bl
biByYWNlcyB0aGUKICogZmFpbGluZyBwcm9iZSdzIHRlYXJkb3duIGFuZCBwYW5pY3Mgb24gYW4g
dW5yZWxhdGVkIHVzZS1hZnRlci1mcmVlIGZpcnN0ICovCnN0YXRpYyB2b2lkIGZyZWV6ZV91ZGV2
X2FuZF92NGxfaWQodm9pZCkKewoJRElSICpwcm9jX2RpciA9IG9wZW5kaXIoIi9wcm9jIik7Cglz
dHJ1Y3QgZGlyZW50ICpwcm9jX2VudDsKCWNoYXIgY29tbV9wYXRoWzY0XSwgY29tbVs2NF07Cglp
bnQgY29tbV9mZCwgY29tbV9sZW47CgoJd2hpbGUgKHByb2NfZGlyICYmIChwcm9jX2VudCA9IHJl
YWRkaXIocHJvY19kaXIpKSkgewoJCWlmIChhdG9pKHByb2NfZW50LT5kX25hbWUpIDw9IDEpCgkJ
CWNvbnRpbnVlOwoJCXNucHJpbnRmKGNvbW1fcGF0aCwgc2l6ZW9mKGNvbW1fcGF0aCksICIvcHJv
Yy8lcy9jb21tIiwKCQkJIHByb2NfZW50LT5kX25hbWUpOwoJCWNvbW1fZmQgPSBvcGVuKGNvbW1f
cGF0aCwgT19SRE9OTFkpOwoJCWlmIChjb21tX2ZkIDwgMCkKCQkJY29udGludWU7CgkJY29tbV9s
ZW4gPSByZWFkKGNvbW1fZmQsIGNvbW0sIHNpemVvZihjb21tKSAtIDEpOwoJCWNsb3NlKGNvbW1f
ZmQpOwoJCWlmIChjb21tX2xlbiA8PSAwKQoJCQljb250aW51ZTsKCQljb21tW2NvbW1fbGVuXSA9
IDA7CgkJaWYgKHN0cnN0cihjb21tLCAidWRldmQiKSB8fCBzdHJzdHIoY29tbSwgInY0bF9pZCIp
KQoJCQlraWxsKGF0b2kocHJvY19lbnQtPmRfbmFtZSksIFNJR1NUT1ApOwoJfQoJaWYgKHByb2Nf
ZGlyKQoJCWNsb3NlZGlyKHByb2NfZGlyKTsKfQoKLyogdml2aWQubl9kZXZzPTY0IGV4aGF1c3Rz
IHRoZSAyNTYgdjRsMiBtaW5vcnMsIHNvIGN4MjMxeHgncyB2Ymkgbm9kZSBmYWlscwogKiB0byBy
ZWdpc3RlciBhbmQgcHJvYmUgZGllcyBiZWZvcmUgdGhlIG11eCBpcyBsZWZ0IGJlaGluZCAqLwpz
dGF0aWMgdm9pZCB1bmJpbmRfdml2aWRfdG9fZnJlZV92NGwyX21pbm9ycyh2b2lkKQp7CglESVIg
KnZpdmlkX2RpciA9IG9wZW5kaXIoIi9zeXMvYnVzL3BsYXRmb3JtL2RyaXZlcnMvdml2aWQiKTsK
CXN0cnVjdCBkaXJlbnQgKnZpdmlkX2VudDsKCgl3aGlsZSAodml2aWRfZGlyICYmICh2aXZpZF9l
bnQgPSByZWFkZGlyKHZpdmlkX2RpcikpKSB7CgkJaWYgKHN0cm5jbXAodml2aWRfZW50LT5kX25h
bWUsICJ2aXZpZC4iLCA2KSkKCQkJY29udGludWU7CgkJd3JpdGVfc3lzZnMoIi9zeXMvYnVzL3Bs
YXRmb3JtL2RyaXZlcnMvdml2aWQvdW5iaW5kIiwKCQkJICAgIHZpdmlkX2VudC0+ZF9uYW1lKTsK
CX0KCWlmICh2aXZpZF9kaXIpCgkJY2xvc2VkaXIodml2aWRfZGlyKTsKfQoKaW50IG1haW4odm9p
ZCkKewoJc3RydWN0IHVzYl9yYXdfaW5pdCBpbml0ID0geyAuc3BlZWQgPSBVU0JfU1BFRURfSElH
SCB9OwoJY2hhciBjeDIzMXh4X2ludGZbMzJdLCBjeDIzMXh4X2ludGZfcGF0aFs2NF07CglwdGhy
ZWFkX3QgZ2FkZ2V0X3RocmVhZDsKCURJUiAqdWRjX2RpcjsKCXN0cnVjdCBkaXJlbnQgKnVkY19l
bnQ7CgljaGFyICp1ZGNfaW5kZXg7CglpbnQgYmluZF9mZCwgd2FpdGVkOwoKCS8qIEZpcnN0IFVE
QyBpbiAvc3lzL2NsYXNzL3VkYywgZS5nLiAiZHVtbXlfdWRjLjIiIC0+IGRyaXZlcgoJICogImR1
bW15X3VkYyIuICBkdW1teV9oY2QuTiBvd25zIFVTQiBidXMgTisxIGFuZCBoYXMgb25lIHBvcnQs
IHNvIHRoZQoJICogZGV2aWNlIGxhbmRzIG9uICI8TisxPi0xIiBhbmQgY3gyMzF4eCBiaW5kcyBp
dHMgaW50ZXJmYWNlIDEuICovCgl1ZGNfZGlyID0gb3BlbmRpcigiL3N5cy9jbGFzcy91ZGMiKTsK
CXdoaWxlICgodWRjX2VudCA9IHJlYWRkaXIodWRjX2RpcikpICYmIHVkY19lbnQtPmRfbmFtZVsw
XSA9PSAnLicpCgkJOwoJaWYgKCF1ZGNfZW50KQoJCXJldHVybiAxOwoJc3RyY3B5KChjaGFyICop
aW5pdC5kZXZpY2VfbmFtZSwgdWRjX2VudC0+ZF9uYW1lKTsKCXN0cmNweSgoY2hhciAqKWluaXQu
ZHJpdmVyX25hbWUsIHVkY19lbnQtPmRfbmFtZSk7CgljbG9zZWRpcih1ZGNfZGlyKTsKCXVkY19p
bmRleCA9IHN0cnJjaHIoKGNoYXIgKilpbml0LmRyaXZlcl9uYW1lLCAnLicpOwoJaWYgKHVkY19p
bmRleCkKCQkqdWRjX2luZGV4ID0gMDsKCXNucHJpbnRmKGN4MjMxeHhfaW50Ziwgc2l6ZW9mKGN4
MjMxeHhfaW50ZiksICIlZC0xOjEuMSIsCgkJIGF0b2kodWRjX2luZGV4ID8gdWRjX2luZGV4ICsg
MSA6ICIwIikgKyAxKTsKCXNucHJpbnRmKGN4MjMxeHhfaW50Zl9wYXRoLCBzaXplb2YoY3gyMzF4
eF9pbnRmX3BhdGgpLAoJCSAiL3N5cy9idXMvdXNiL2RldmljZXMvJXMiLCBjeDIzMXh4X2ludGYp
OwoKCS8qIGN4MjU4NDAgcmVxdWVzdHMgZmlybXdhcmU7IHdpdGggdWRldmQgZnJvemVuIG5vdGhp
bmcgYW5zd2VycyB0aGUKCSAqIHN5c2ZzIGZhbGxiYWNrLCBzbyBjYXAgaXRzIHdhaXQgaW5zdGVh
ZCBvZiBibG9ja2luZyBwcm9iZSBmb3IgNjBzICovCgl3cml0ZV9zeXNmcygiL3N5cy9jbGFzcy9m
aXJtd2FyZS90aW1lb3V0IiwgIjEiKTsKCWZyZWV6ZV91ZGV2X2FuZF92NGxfaWQoKTsKCXVuYmlu
ZF92aXZpZF90b19mcmVlX3Y0bDJfbWlub3JzKCk7CgoJcmF3X2dhZGdldF9mZCA9IG9wZW4oIi9k
ZXYvcmF3LWdhZGdldCIsIE9fUkRXUik7Cglpb2N0bChyYXdfZ2FkZ2V0X2ZkLCBVU0JfUkFXX0lP
Q1RMX0lOSVQsICZpbml0KTsKCWlvY3RsKHJhd19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfUlVO
LCAwKTsKCXB0aHJlYWRfY3JlYXRlKCZnYWRnZXRfdGhyZWFkLCBOVUxMLCBnYWRnZXRfZXZlbnRf
bG9vcCwgTlVMTCk7CgoJZm9yICh3YWl0ZWQgPSAwOyB3YWl0ZWQgPCAyMDAgJiYgYWNjZXNzKGN4
MjMxeHhfaW50Zl9wYXRoLCBGX09LKTsgd2FpdGVkKyspCgkJdXNsZWVwKDUwMDAwKTsKCWlmICh3
YWl0ZWQgPT0gMjAwKQoJCXJldHVybiAxOwoJc2xlZXAoMik7CgoJYmluZF9mZCA9IG9wZW4oIi9z
eXMvYnVzL3VzYi9kcml2ZXJzL2N4MjMxeHgvYmluZCIsIE9fV1JPTkxZKTsKCXdyaXRlKGJpbmRf
ZmQsIGN4MjMxeHhfaW50Ziwgc3RybGVuKGN4MjMxeHhfaW50ZikgKyAxKTsKCXJldHVybiAwOwp9
Cg==
--000000000000671af2065af11849
Content-Type: application/octet-stream; name="185.patch"
Content-Disposition: attachment; filename="185.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mts5xxt80>
X-Attachment-Id: f_mts5xxt80

LS0tIGEvZHJpdmVycy9tZWRpYS91c2IvY3gyMzF4eC9jeDIzMXh4LWNhcmRzLmMJMjAyNi0wOS0w
NyAyMDozNzoyOS44OTkyOTg4MjIgLTA3MDAKKysrIGIvZHJpdmVycy9tZWRpYS91c2IvY3gyMzF4
eC9jeDIzMXh4LWNhcmRzLmMJMjAyNi0wOS0wNyAyMDozNzoyOS45MjUzNjcxNjUgLTA3MDAKQEAg
LTE4MjYsNyArMTgyNiw3IEBACiAKIAlyZXR2YWwgPSBjeDIzMXh4X2luaXRfdjRsMihkZXYsIHVk
ZXYsIGludGVyZmFjZSwgaXNvY19waXBlKTsKIAlpZiAocmV0dmFsKQotCQlnb3RvIGVycl9pbml0
OworCQlnb3RvIGVycl92aWRlb19hbHQ7CiAKIAlpZiAoZGV2LT5jdXJyZW50X3BjYl9jb25maWcu
dHMxX3NvdXJjZSAhPSAweGZmKSB7CiAJCS8qIGNvbXB1dGUgYWx0ZXJuYXRlIG1heCBwYWNrZXQg
c2l6ZXMgZm9yIFRTMSAqLwotLS0gYS9kcml2ZXJzL2kyYy9pMmMtbXV4LmMJMjAyNi0wOS0wNyAy
MDozODozNy4zNDIxNjQ5MTUgLTA3MDAKKysrIGIvZHJpdmVycy9pMmMvaTJjLW11eC5jCTIwMjYt
MDktMDcgMjA6Mzg6MzcuMzYzODA1NTQyIC0wNzAwCkBAIC0zOTMsMTQgKzM5MywxOCBAQAogCQl9
CiAJfQogCi0JV0FSTihzeXNmc19jcmVhdGVfbGluaygmcHJpdi0+YWRhcC5kZXYua29iaiwgJm11
eGMtPmRldi0+a29iaiwKLQkJCSAgICAgICAibXV4X2RldmljZSIpLAotCSAgICAgImNhbid0IGNy
ZWF0ZSBzeW1saW5rIHRvIG11eCBkZXZpY2VcbiIpOworCXJldCA9IHN5c2ZzX2NyZWF0ZV9saW5r
KCZwcml2LT5hZGFwLmRldi5rb2JqLCAmbXV4Yy0+ZGV2LT5rb2JqLAorCQkJCSJtdXhfZGV2aWNl
Iik7CisJaWYgKHJldCkKKwkJZGV2X2VycihtdXhjLT5kZXYsICJjYW4ndCBjcmVhdGUgc3ltbGlu
ayB0byBtdXggZGV2aWNlXG4iKTsKIAogCXNucHJpbnRmKHN5bWxpbmtfbmFtZSwgc2l6ZW9mKHN5
bWxpbmtfbmFtZSksICJjaGFubmVsLSV1IiwgY2hhbl9pZCk7Ci0JV0FSTihzeXNmc19jcmVhdGVf
bGluaygmbXV4Yy0+ZGV2LT5rb2JqLCAmcHJpdi0+YWRhcC5kZXYua29iaiwKLQkJCSAgICAgICBz
eW1saW5rX25hbWUpLAotCSAgICAgImNhbid0IGNyZWF0ZSBzeW1saW5rIHRvIGNoYW5uZWwgJXVc
biIsIGNoYW5faWQpOworCXJldCA9IHN5c2ZzX2NyZWF0ZV9saW5rKCZtdXhjLT5kZXYtPmtvYmos
ICZwcml2LT5hZGFwLmRldi5rb2JqLAorCQkJCXN5bWxpbmtfbmFtZSk7CisJaWYgKHJldCkKKwkJ
ZGV2X2VycihtdXhjLT5kZXYsCisJCQkiY2FuJ3QgY3JlYXRlIHN5bWxpbmsgdG8gY2hhbm5lbCAl
dVxuIiwgY2hhbl9pZCk7CisKIAlkZXZfaW5mbygmcGFyZW50LT5kZXYsICJBZGRlZCBtdWx0aXBs
ZXhlZCBpMmMgYnVzICVkXG4iLAogCQkgaTJjX2FkYXB0ZXJfaWQoJnByaXYtPmFkYXApKTsKIAo=
--000000000000671af2065af11849--
