Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C53D5C05
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656940; cv=pass; b=C2LgYK67s3kh9QZCIB+hJxhDLJekeaMVxZRdSpHkeNr73cl7edznEZf42Lz4je7xQFSZ0VK2id3TtYlNNuJrHNKDU7IszvFHx0pdqbsQrsEJfsCzZ4+Ku1p4yfsoPUvT4Zizs5UEo+f9+6LvyZEe9W/8yfBYtiATYCuoLOs1SoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656940; c=relaxed/simple;
	bh=fw4l6Y9kpKC050algLTER/1Mw6N22TkDOhBPegwIMFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKvToq1VVeSKEjwOLlvzmljfga2MfIHt5Z5gFkLe0JetoJbSBAVauC5t3gGdFM5T4LPKuwEgQxCZc+DBMbZCMWY1NIfa6qaR/pn5+ORM47kEBklVdyzLRx6AcCDrN2zbEeSkCOxe/Np3T0o7kFyWURxclwunDbUBs0sROXc+TC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkzzLs2D; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkzzLs2D"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso100465786d6.3
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 00:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778656938; cv=none;
        d=google.com; s=arc-20240605;
        b=W1XH0Ubr141OP2rXrhUwatwybQidW0U6g9qB7Gkq45ty3lSS7nUeGtDwaG3xxodfPW
         RmMXHUDZ70wmY62xGBY0+pJav7zvPsCfc3O+glp7CpmiNKo7ifZuTxcHGoeQK2QqaP/g
         Jz4ZJg3fl2MM9IdTjr1XJs+GoE/ygpnvpSn/5wynty6Tv5q2TA5srwGWJFLuNDJtG4ep
         Jwwjb3UWATolV3N3Yqopmz/TS9U6o74p2mXLMd1pVBlbPB4paXPSuhQ06JshBb6YpmIz
         Qq3YJZROhsWdOltjodrbjd/X7/sgCDzrMleCxhkXvooi2O20YgYoaZdTRGXX0+0z20RA
         wvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxIsDtM+kZD8aHQyQ8BqjHfjjKGIY780pGvgJoNLbYk=;
        fh=h7cCRJRETyi6M3+DnFSrADr3tPHGPuzub3e8YehYYYw=;
        b=BlvSS+DnlB8iWW5TkhQSk4WfhU228aO4pHE2Afai52+CrFlqlR5omwMLnfWcffZ13J
         1DeWL9yN2jzXQvAbcMJk1WZCESSiritpuh5eRHOsmgrd1Mkt50B5Rhx2ByjnD8m91LlD
         hVcc5VlxjJVPCMLaZauBcmrD7NaG1NPOGVmM8fQxTqb0HGHe6QhAfqlpKH1qXs8930Ln
         gNULGLDmP2Kd/45IXexoV8v/cqvlqEf0WgR3sfHxvvvIIJwpa/GlgCOvvMwfWNBpawWT
         1DZRcdQc6Zpgk2N98uZojVzk9MpcYNqfO68RsuVm/+4plTXWrag5UYzkr1IbO34bUKjp
         3+3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778656938; x=1779261738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxIsDtM+kZD8aHQyQ8BqjHfjjKGIY780pGvgJoNLbYk=;
        b=HkzzLs2Dih+BwcgUDmz1NLZe3ljwG9wAFZC74s9bW0CJylx8Fqk0F7+wbnhpgbD8pL
         I+T9j4UM4LkpYUEHHGIsVZlGD7aeZQo2GnBsgva/gW3d/BeNG0MWIXOn/rpCCaMeERr/
         NestRZXOy/nv1A0AduJ/m2RkmZ+7TfBm2Q3emO2X/tsGIRTVOenuhYanrXaSrBuU2TqD
         Mu2/VoUMQhW0rp0YG8TTa48sZnK02fuBkPHU8XcmhOfVowQ1wF7B/bci8oSuez2aqteG
         I+tY1qqnxiHbnHsq+iZQ0HKCJgTKTV9U5s/mDwIFfyYwGlUFzI/UQEKgztBRwta5fdeN
         DLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778656938; x=1779261738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxIsDtM+kZD8aHQyQ8BqjHfjjKGIY780pGvgJoNLbYk=;
        b=G4oe1TfTXdb3mULpPNkMYWr3y3+yU4kmen29i/V2h9c6dmGzh3P2S27mBD7YgtKr9N
         WR5orjosF+2mkfnYtU76T7i6c8chaJDkyT3l0QUfyydCyDj3ZoIIrRwXFa09PoNFtPXX
         zwLIfg0q8UJV/wgELXhX1RijdyaLCa3T7okrU8uqgbq3vXnEftGmywIKwb7DZjPDEnIS
         nFqjhdKtngBRL2Ag5rx+guqgFTiAT20rDqmLn90BdzZFTalE4tJCcma3kNkw87Pv1ADK
         CbKQt0ceuUKjZcZMJVBR2r/BOPly5LCwkXJuNevdeIiJVNq8pCDVW/FNTvPYk41GtSDR
         DIsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9beReyR2Gkx3+KYZJlV9C2QL8bXYrdTDYS/NodFwJotttLOQhq0GXHjswO0gpq3609yrhMYw9GQjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLQPEMacKGETeD4VpU5FEkFvCkPs65GxNI2VaYtK1WEU32fpD
	kURemyZrcLaSMMKngzrk8t5rc18jrmXDXAuxPbAtHfsPDJ3kbD6pghfMFtVkqsI8QHUrgZGTw6b
	V7m/2gPYFKCDVy+1XXdRYYRQUO5yea75F0OQTN6sU
X-Gm-Gg: Acq92OGiN+PLoJAgHhz8fy45w+BQKrorhm4lm/+aCCEtLkgNwufGu+3VrNpVIyN74Mn
	9oof6uGf/ttKuidhQ9TqkJFEMW4J7gMbfCuUhSZLJQz1i1M6NuH38HfMONjNQ+e8c5MltbqrqXE
	ZVYAIr6fr9E9xIHuPnHmaw782XFjJMQd5UvE55yQc2xZ5nnWOILgjgY73pPLDoKPZevVO9xmCpL
	lrjJXGwAEXrqKFUD55KI7ysAwlQjK5/pdbNj4i/TxZPUm9lnWXN/WhVNTXVdfx/dwtNi47VvL5G
	i18wLr4VDCDRZNYRA9b+nKpQ3Fcdx1LFxLN1W/2C44V+kgY=
X-Received: by 2002:ad4:5de2:0:b0:8a4:58ff:f0f8 with SMTP id
 6a1803df08f44-8c7bc91aee7mr39517186d6.29.1778656937884; Wed, 13 May 2026
 00:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415114752.1181079-1-bsevens@google.com> <417rqoq0-1q2q-r96q-p258-240n74nr3n14@xreary.bet>
In-Reply-To: <417rqoq0-1q2q-r96q-p258-240n74nr3n14@xreary.bet>
From: =?UTF-8?Q?Beno=C3=AEt_Sevens?= <bsevens@google.com>
Date: Wed, 13 May 2026 09:22:06 +0200
X-Gm-Features: AVHnY4Izbu0Ai7nyIzCLs8uOUlEqsAXjajieTz9n8wj66x1tZU2-nY6BVcW8kjg
Message-ID: <CAGCho0UsyC5-c9r-EvNE1TG-O=jQDGdSu1gz18aY1hdaKpwC9A@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: Fix heap buffer overflow in mcp2221_raw_event()
To: Jiri Kosina <jikos@kernel.org>
Cc: Rishi Gupta <gupt21@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 at 17:47, Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 15 Apr 2026, Benoit Sevens wrote:
>
> > From: Beno=C3=AEt Sevens <bsevens@google.com>
> >
> > A heap buffer overflow can occur in the mcp2221_raw_event() function
> > when handling I2C read responses. The driver failed to check if the
> > total incoming data length fits within the originally allocated buffer
> > `mcp->rxbuf`.
> >
> > Fix this by introducing `rxbuf_len` to `struct mcp2221` to keep track
> > of the allocated buffer size. Initialize it in `mcp_i2c_smbus_read()`
> > and `mcp_smbus_xfer()`, and ensure the copied data length combined with
> > the current index does not exceed this length in `mcp2221_raw_event()`.
> >
> > Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
>
> Unfortunately the patch seems to have been somehow mangled by your mail
> client:
>
>         patching file drivers/hid/hid-mcp2221.c
>         Hunk #1 succeeded at 126 (offset 7 lines).
>         Hunk #2 FAILED at 324.
>         patch: **** malformed patch at line 173: u16 addr,
>
> Fix for the same issue has later been submitted by Florian Pradines [1],
> so I will be taking that one and adding you as Reported-by: or so, ok?
>
> Thanks.
>
> [1] https://lore.kernel.org/all/20260509094517.2691246-1-florian.pradines=
@gmail.com/
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

That sounds good to me. Thanks for adding me in the Reported-by

One thing though: Florian's patch doesn't set `mcp->rxbuf_size` in all
places. I believe it should be set in every place where `mcp->rxbuf`
is set. There are 2 places in `mcp_smbus_xfer` where it is missing
(see my original patch):

```c
@@ -538,6 +541,7 @@ static int mcp_smbus_xfer(struct i2c_adapter
*adapter, u16 addr,

                        mcp->rxbuf_idx =3D 0;
                        mcp->rxbuf =3D data->block;
+                       mcp->rxbuf_size =3D sizeof(data->block);
                        mcp->txbuf[0] =3D MCP2221_I2C_GET_DATA;
                        ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 1=
);
                        if (ret)
@@ -561,6 +565,7 @@ static int mcp_smbus_xfer(struct i2c_adapter
*adapter, u16 addr,

                        mcp->rxbuf_idx =3D 0;
                        mcp->rxbuf =3D data->block;
+                       mcp->rxbuf_size =3D sizeof(data->block);
                        mcp->txbuf[0] =3D MCP2221_I2C_GET_DATA;
                        ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 1=
);
                        if (ret)
```

Thanks,

Benoit
