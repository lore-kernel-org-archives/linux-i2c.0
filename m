Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730C3D8918
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286552; cv=pass; b=eOxOLXMhCEOn+OuYQa3SKte9D0N0KFT6IrSJrbb58cJtBxkRLaEXK8UwSajWJ4TLJgJ8oJtz+kjuVuxPmCsuA2rAVhMzg/a4Wlnq3NvSe+9SEHiFnNR9UMbEaKYHZME2N56iVQduOe3vlWS11B5bN2fkjtRKnc/uJ3qKbrf1ZOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286552; c=relaxed/simple;
	bh=NQEYEBoyqjqknpCw2ohp5AC8OUnw9jB9IsqAEmf8A0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahux4v+kGYYX5n0tCaiqUozmLeYRY1c/VNYmIcGVWJ+83yUorkyOEq4k8O14xRhkqwAEpf0+qCmiWkYBcT10dHyix54KtEmPK7Ov7nOB+pwebUlBECvkxUe9Ob3/fYdkbl0aGSI0hJVEFfp8S0B/WhcL3LAhJpp69utYgaecHoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bisdn.de; spf=pass smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn.de header.i=@bisdn.de header.b=CLSNiJce; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn.de header.i=@bisdn.de header.b="CLSNiJce"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb99bc721so845944e87.1
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 04:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784286545; cv=none;
        d=google.com; s=arc-20260327;
        b=P2+bT0pMywJ5IYaOFz8xUlTnuaI2eD68P/p4uCft5OG7xcWwDdjix4RTZ6FHKzxnNn
         84jSavG7goB+mriDRKd0XCr4E0fBeZBejnjPxm5aTj/MY1OsyVpGa13R+BF4fTFUqRCa
         1Nk6MaiYiPnh6HMGrRWGlS0rt3pr9d+dgBu1EXcOjh61l9uDb9YB4zNe2B5lsKbBBIHQ
         k4d1fN9viRUJDhuWv5IneeCKKSy+2ouzXZxPYoYTnyvbW13kVux77JgIqSnWslVDKpV+
         5fBTmk2Kaq68cuwrm7+nVJDkeKk8oeeTH3CVoii+sr4EgxniSGBG1839WdyJ4w33W1XP
         m5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IVMjIqA5wERc1VK0TSVspzDmfYe5coCITH1bpAnvXTM=;
        fh=/7Dp/tB0qdSJl1OyXCUevB+0Gz7oYu5tS3TfXR3lxYY=;
        b=sFd2RrUeJLFubBwxieRj6IkDUf18Si6lHFxO7ZtIzqZ0nhw28M0r8C4KQ+TocHzd+z
         eYQ4z6/LZNdrvIIc8Dbzb/lsCGN2eLLCRI7EFgj65ioOife2ml1xM+HqlzRdZ30IWm2c
         BuPvWjBOPSmR+bukdx2QrEYq2kdvr1sANLP3knRRsiR9tn9nD1l7qXB4Aozb3F3FZ+ri
         2zPI2qwaSPlWs21GeGhjbZhSoSnZ58kNNQ78jsxkLfqMclh3GrOwGhC/l2SAC0VJ1UVm
         w6DWzZ1po2DIQf755oXKXqPWytC1gOCWWkdj0ykS4CYz7JGjIRG3JPet3gCb74ArcsGB
         Pncw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn.de; s=google; t=1784286545; x=1784891345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IVMjIqA5wERc1VK0TSVspzDmfYe5coCITH1bpAnvXTM=;
        b=CLSNiJceAWBp6jDn5uFq7scWBfUDwruVLMfEUh8G97Kav82NDqgqY90HWT9wOjVKl3
         tTh7BLuHcyX27VANamW9Pyn8fxkMQscEXUwqSrZGq5M+FZ5TUX7dcZ4T1tzYIALpBlhF
         dFA85wIU/zgV0uJYlfZ2YwSNijHNIq4HVDNmr6n5NvM/860ogPziI62w3JXQSf1Gwm79
         hJ6f9T/lPtaRk/HDa7Ijk/XP+Aery165Ye/MVwkjPbCIFvA/XLngUZkVyJIE74764e/b
         8FsSF0+mtyoHaT3m5GmMVXQiR+sLd3L0ILKngziFO/L/IBUBkxQaVJxUnRvLIb9+AI83
         aoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784286545; x=1784891345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVMjIqA5wERc1VK0TSVspzDmfYe5coCITH1bpAnvXTM=;
        b=dKZx4pkh/sF7YaD1LKZxUeulv3kIR/2N9mCMIzVxVP/OrYIJ1PQ8agYISo7alajthh
         lJVTzT3T7kCJ8nh1UwXCkalFy18UwJPcYnKarFPnzIF80Jnl9HnKaCvqjDQNHuzksvPD
         p1XIGv4KGW1Q4lksZiFiKVH4DSgWzKxt3bpq6bn3TMIaJaCM86knUOVqWvlUw6l8dT9+
         V1ZHbcQ06jAGjLy1fBfC8amEo8YUQnCi2kYo7OKrpC0RN7l7lS1r8AmIYOG6GL56jGST
         FxpW04sT43djLxQiwlCEFKfII+TY/li/q87oGHsHLesGAqHzno/6kNWt7ANsZFlcciad
         juaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzgK5y8yz2oGd+jM2D7gCsA0tY2PoODdmGQik7LrNS0/n6m3JpG1ULztPdEN4gbLEgzjXOtUeiAOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmRgqEYyFJSUe9FqMJt0kxN6WcJEeq/lh8Nhi5AxagF7Pti7m
	dQR4F6gWlrD2uyE4xDna3OEVJm6G8WrN3Qw7wqWY1sxIO+NirTcuFSEs1UBpMY7ShP67NW3CllW
	ad8tHvLZH/QUUQyVjBYui7PZRI+wXlhIZPWxZqbWzWzllmITTIOzRAYb6YFiX5BWlCUVNK6nOuA
	+wtMFOEtfX5dB6rydYzKoMmitcDlrEQBQKUlC0QUoRG0E=
X-Gm-Gg: AfdE7cmQzSI/X0dpisV3cAluoGSkInZs6Xg1TiclqBDcXbFqogyMpsTGtKdC8dLbMzq
	IQ6t201ligtjL1vUCMsGWD7cazHn3hMG7wf+GqwsPdKlm/VQJCWct6+1i78zi/UFNasbX5/53Ux
	eJCke2o8n+svMejTgM1PKhRwqFOIOZugwsh7lGAPOS0skZFI8JTqqeCWxxZW4MO9k6neBo3c1f3
	esV2GVrG8JzHmjgIiJ20f0g/0kf03dHm4yE2xPhHBDntHrdaWzW6v86ujKFwWGmm5Qo8VA=
X-Received: by 2002:ac2:51c6:0:b0:5b2:8d3e:723b with SMTP id
 2adb3069b0e04-5b28f87712fmr299173e87.1.1784286544689; Fri, 17 Jul 2026
 04:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717085507.34209-1-jonas.gorski@bisdn.de> <eba6d3b3-b5ee-4543-a437-4e7c16c5653e@oss.qualcomm.com>
In-Reply-To: <eba6d3b3-b5ee-4543-a437-4e7c16c5653e@oss.qualcomm.com>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Fri, 17 Jul 2026 13:08:48 +0200
X-Gm-Features: AUfX_mw54--TNQFoTYsWHV7VstC3XqvwiGDE0dEj18UkhlySQ3jSOQB47lLuss0
Message-ID: <CAJpXRYRyTaYgKGz6_JvFFZhQD6ioe1cnRUgGuZK2TxnOB0rH_g@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: iproc: reset bus after timeout if START_BUSY is stuck
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Kevin Cernekee <cernekee@chromium.org>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 17 Jul 2026 at 11:40, Mukesh Savaliya
<mukesh.savaliya@oss.qualcomm.com> wrote:
>
>
>
> On 7/17/2026 2:25 PM, Jonas Gorski wrote:
> > If a transaction times out, the START_BUSY signal can stay up, and
> What's exactly START_BUSY signal
> > subsequent transactaction attempts will fail as the bus is still
> transactaction =3D> transaction
> > considered busy.

aah, I was so concentrated on getting the recipients right I forgot to
spell check @_@

> >
> > I can easily trigger this by attempting to read from an address with no
> > device, e.g. when running i2cdetect. After the first read times out, al=
l
> > subsequent read attempts return busy.
> >
> > To get to a working state again, the controller needs to be reset to
> > clear the START_BUSY signal. So check for START_BUSY still asserted on =
a
> > timeout, and do reset in case it is,
> >
> what's here after it is, ? wanted to end the statement ?

I think I forgot an "it" there, "and do reset it in case it is."

> > This is also done by the original non-upstream iproc-smbus driver
> > implementation [1].
> >
> > Works around situations like:
> >
> >      bcm-iproc-2c 1803b000.i2c: transaction timed out
> >      bcm-iproc-2c 1803b000.i2c: bus is busy
> >      bcm-iproc-2c 1803b000.i2c: bus is busy
> >      bcm-iproc-2c 1803b000.i2c: bus is busy
> >      bcm-iproc-2c 1803b000.i2c: bus is busy
> >      bcm-iproc-2c 1803b000.i2c: bus is busy
> >      ...
> >
> > where the bus never recovers after a timeout.
> isn't there a max retry count ?

In this case it is an already bound driver(s) trying to do (new)
things. Each busy (likely) comes from a new request. In our case there
is an RTC and several SFPs behind an i2c-mux.

So there are two scenarios where I encountered it:

- during runtime after a few hours of uptime, a timeout occurs
accessing an existing device with a bound driver
- and recently while working on a different device I noticed that
reading from an unoccupied address triggers this also

> >
> [...]
> >       if (!time_left && !iproc_i2c->xfer_is_done) {
> > +             /*
> > +              * The controller may fail to clear START_BUSY after a ti=
meout,
> > +              * reset the controller to recover in that case.
> > +              */
> Make it simple ?
> Recover controller if START_BUSY signal is high after timeout

That's more or less what I had in the first version, but was asked to
expand it (split about two short comments)

> > +             if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
> > +                    BIT(M_CMD_START_BUSY_SHIFT))) {
> > +                     bcm_iproc_i2c_enable_disable(iproc_i2c, false);
> > +                     bcm_iproc_i2c_init(iproc_i2c);
> > +                     bcm_iproc_i2c_enable_disable(iproc_i2c, true);
> > +             }
> > +
> >               /* flush both TX/RX FIFOs */
> >               val =3D BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_=
SHIFT);
> >               iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
>

Best regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany
Phone: +49 30 610 816 100
Managing Directors:=C2=A0Dr.-Ing. Hagen Woesner, Andreas K=C3=B6psel


Commercial=20
register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569 B
VAT ID No:=C2=A0
DE283257294 <http://goog_1008408251>

