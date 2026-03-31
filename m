Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468A1C3F0C
	for <linux-i2c@vger.kernel.org>; Tue, 31 Mar 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963113; cv=pass; b=BCG7c3feSwfABBbiwIckt9irkzdZvvhdgxbGOG+LEwCR5pCtfXwfOt5Unzdie6ybjV1E3+ZXJzg5Jby75Yg3za9KjuxSLPhWWgTs09V1WGZSp4REmGWAvs9JqqWB4oEEhhasMl1KIrIYY5FxNwWyU7Zl6kn5ecr8qZyBCsf/SgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963113; c=relaxed/simple;
	bh=7i9l6Cr5g9rzJNC0WK5U8vOtrSsLooKCu3+eTOa+Ulk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWICUWL4aKOk7z6mYDddWW1ROZdX8bx5VgjYK+pOjmXRbDWgZ85EKzMg5YKxCDVuqzu4VjUMWXUskNmx6x97i32fDfoTMI6dahDejUE7WZAevsVldps/zDMJqJ7f+x8qzwRU5+4x3LSWOSOTH4kBYef3Z/X6++VS4izSsLOGPRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhV4aHbm; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhV4aHbm"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so9737314a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 31 Mar 2026 06:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774963110; cv=none;
        d=google.com; s=arc-20240605;
        b=ZbvX9hUiMt58fOZhtYmhhcCvFESp8DppRljf8y5YSXhTxaRAxc+/M/UQi0XzZarrJH
         4QxzSNMIy3lhLy+Rc4XLz8Yuc5VSXPnAzK96aZEBs4D0K7DTo/CHggiKAmxe1dlDRdos
         F6acrtUzCHPE48nBHfWbZ7on1I0gnF3t4Dl35/kR+ReKvkya1o64LDFhv2xSSmLOfNaM
         ejjc8Zq96ZnuQ4XSxdE75XUt84JptdZwpuIKKN1T9A0VBUn6RiYmbD32xtKIzB6KzJlj
         CLmDaqZclVVhQLve4AN9KrNu0ZTPidGlE8L9+jpC6RR1O9hSeJQJoE0jbX4e8f5inXPJ
         i07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6VNbbvUY3UV4c5nAnHb+NpQ9gBlif8YcQdMt8wQ0IbI=;
        fh=FKyJ8KbwJhEh6Ef2DH87G9JhSQgQU+jvuBGFKAXJuLk=;
        b=UJoHQYNkppz9fHmrXpsbf3i4mLwBnauOPLK5aAkRYCDr1Lsz03kzBOB/VBmvi6CSND
         fImt/Gpcwga2C3LeSs3I1OUpv4/FePaF1sOQ3T7LwS239MnzA74qTd6XQoMMG6gJamFM
         VBlaQYAXkgM4oSg9xSY1Nda0gIftif6TyFAAdKgKRexZ0wACQVgn6uzzlt170ij9oCXr
         XAgJfqc1vsSxVzS8irdMC7ao6MDFdU3S8abxBX9epI0bTuQ86DA00xHAIMCoQaaZLlQ4
         adwdoo+PLxBJJkWqOJ+k2CZVrBVDFESF745IhDCOJJKS2sfueOMQbNZB3i06YY7yCXzt
         zY2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774963110; x=1775567910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6VNbbvUY3UV4c5nAnHb+NpQ9gBlif8YcQdMt8wQ0IbI=;
        b=rhV4aHbmudL/uU3Wtn72FsUlTPy/n2YBU/xqPotQym2XUyWyjLE2NCPHlp4z3Jk/BY
         PhjM9o9LXK9XUZxs+1mc/SLufOikdlgb9AJT5HafMn1x38JSKKzvKcS9m+Sx8MDCPp2f
         k7C03EFiBlUyvH+FnQFCwmerucF3CbKqTAGuFSD7zKy4wpAaJ1Jg7D0dyVrQ46SwcXbL
         iO96TxEykmmKMZgdQ67Bh2Jq5KF9sxv/uaWbtRlarb91KbKg6olLXB984kZ1z0UQSsHq
         xjx0jXXaBYlyNg7TVHPn7w/EYSfiRkcTDZhD5N8wV6EbGngtLUNVMdjlLuBvlxdS/GeH
         Gq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963110; x=1775567910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VNbbvUY3UV4c5nAnHb+NpQ9gBlif8YcQdMt8wQ0IbI=;
        b=VdgwhEUOMWLe4P2ZPwaMFZzSRsgE39CyeWr2JEGIfDB8a24UExh4i+zuwi17Ax3FBF
         Eu59Ixm88v2OrxSkCOdU4ObOTNLpe96/C9rIIymo/okv/WYiJ8nOB3ZoLPyLlqsIfwvn
         C0v+SSRRIz77QwjIWFqPspHCOrzejwaPexjbKdS/CSWSbojerqHkj+XF3UH02xpN0feL
         lPMvm2/YDsv7ZRyxOJ3hD7wdYDOk162O6oLIQZBy3kmIuenxvBbw550FmFpYnOZEHbic
         qNjAFhSu0PMQ82gBU/BkMNbz3j4GSIA5T5GcjUxgBFj2VfxZqQ7HuqF87/1Vq/sAvHQN
         giaw==
X-Forwarded-Encrypted: i=1; AJvYcCUfTgKnqCPlBu+XAzUHPcshspB6jmeHEEpoTZp+OW/SPepAZO4zUF9snC2QCtXqkyGROghOryPTn40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nDKNEgOJAS+fVbt9TKAhNpZSPntfV0N5tUe50b6vtrSOtvYq
	SRWwrPLneK7vh1t5FShfZpnv1JwwBKGz5eK7KsOXgGjd+JPUd33uMbk6LaFDmq2igY9ViM6YDh7
	T+V9rDaHSILSyRoeHk/ArE90dAsM/3T7Rm60/
X-Gm-Gg: ATEYQzwsUD66hpT08ug0kVsR7yIThwpkc6XWKcBKq8w78RQ1OwXhkZ0EUjkfbZcsxki
	Z3IHamBAvrOq9NbPzfwt2u8Byg98JZ4AoZiMSVYBbdDHqZNH2nSI4lOrmrnaT917iL4biDhps5j
	VZrGlsgOtJ9XnvPwDwqe+JqzswiVLpFmzlQmfW+9M3fcP9w7pYWx188Cq2Ex223NHpurRmfJrCR
	dvb2hKb6zfm7YcY2gVgWqPX/+Q9a8o+j4z7BCjpQW4s7HWDJUtJczwlZ5XtrVGWeS5NhFXPh5di
	2DbhqQ==
X-Received: by 2002:a05:6402:3549:b0:66b:a9bf:2f with SMTP id
 4fb4d7f45d1cf-66ba9bf090cmr5857704a12.2.1774963107139; Tue, 31 Mar 2026
 06:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321105146.7419-1-linux.amoon@gmail.com> <acaO5ouMmGA8-tqJ@zenone.zhora.eu>
In-Reply-To: <acaO5ouMmGA8-tqJ@zenone.zhora.eu>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 31 Mar 2026 18:48:10 +0530
X-Gm-Features: AQROBzByRXPbx7tA51z_8CluOw54nEqGeZC01-m9c54wTUWKrbejLJocvfXsXnk
Message-ID: <CANAwSgRVXd4PLAV3NGVdmxcJUVe6UUs74HkRmOG7TkkoLBCFeg@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: add support for SCL OE debounce and slave
 hold recovery
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	David Wu <david.wu@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andi,

Thanks for your review comments.

On Fri, 27 Mar 2026 at 19:43, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> Hi Anand,
>
> ...
>
> > @@ -1125,6 +1141,17 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
> >               }
> >       }
> >
> > +     /*
> > +      * If a timeout occurred and the slave is holding SCL,
> > +      * re-apply the timings/dividers to attempt recovery.
> > +      */
> > +     if (ret == -ETIMEDOUT && i2c->soc_data->has_scl_oe_debounce) {
> > +             if (ipd & REG_INT_SLV_HDSCL) {
> > +                     dev_err(i2c->dev, "SCL hold by slave detected, resetting timings.\n");
> > +                     rk3x_i2c_adapt_div(i2c, clk_get_rate(i2c->clk));
>
> argh! this nests i2c->lock. rk3x_i2c_xfer_common() already holds
> it when calling rk3x_i2c_adapt_div().
I agree; the current implementation can lead to a deadlock.
To resolve this, I'll split the function into locked and unlocked variants.

Note that this deadlock only occurs if REG_INT_SLV_HDSCL is active in the
interrupt enable mask, as shown below:

 static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
        u32 val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
+       u32 ien = REG_INT_START;

-       i2c_writel(i2c, REG_INT_START, REG_IEN);
+       if(i2c->soc_data->has_scl_oe_debounce)
+               ien != REG_INT_SLV_HDSCL;
+
+       i2c_writel(i2c, ien, REG_IEN);

Thanks
-Anand
