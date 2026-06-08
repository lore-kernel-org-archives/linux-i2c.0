Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0923D291
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940786; cv=pass; b=KMZIun6p9eurtyCuZhTr5aNriaPyZN3mtHGZIXTT5LHWGD8Mzq2Yno5lm3WqY6f0pEF0t45Gp9U5N2019jJkSeNQ4UzEUQqOaZLG7247OhZjzIvqkIBerrCjj4JgUn3qmGxzgoatM9N/yVeUa0Iw8CKwB71UjYNl2gsqHHj9Oro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940786; c=relaxed/simple;
	bh=0uT9yNIgAk/8+RqiGIhyhgxr89MaPNXDMlEgD8xjAWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+5kuvAyN1jJQxOI/GyypxfSukSCYuuiLCEGCtI/8dPPEvoHMC0gASVujr7KDw5eHSSNx8ga28rWicoyQPtpHbl7NYTlSLlbU17CYaxOYoCiT6DOX9ij1ZQ3BqlCX4f9JV9B4ASwQc06gmo70pMQvv2ibEE/P0KkxUfwMjZODrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=FkEOvwMR; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="FkEOvwMR"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69e8583107aso795625eaf.3
        for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 10:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780940784; cv=none;
        d=google.com; s=arc-20240605;
        b=URxZ2gIxSyjB8sGiUq5fiHrSl9lG7EDO2g9WF/5yt6KHyTqVvh7Z0N4FQOepVpZQ8L
         WehCZpK8euycbsKbMG9g8lpp9pRtdMwmbXyAHmLsPJR3SQ0LmtgxYyBw9tl6VwhMvmd5
         E3FuOtIPvftiiAmB4vEfWLZVYPvV+AgV9kPa5qe1+rdKryhiv9NHwxNpJbOXRm0Dou9l
         xUwav0FCd8p2T3hndmYwxxaJcieFA+zuEc0BNCniamyWFIRTSLJug++dWRw60enyyR8N
         sonIAtdVW0dLusaepdjzK3GYcbh8MagO54sHBaRhj2x+8VkknduiheAhOETjZ4jqrvpw
         E5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nurm0VcFWadxHMGIIRZaG/YNpWN0YfQDmN6L/EoaYoA=;
        fh=F4vYIYMy7pSKN7xJoUwB2rdKIT5w/DucG8Ceqown+FE=;
        b=g3H8tlFERmpBzcXtOR3QJsi9ZcESnW1r/7xuTeu3mcthtUx3JuVFK6EImyCF6JtHtU
         9/Gfim2CIb6sot/0JnuuMnzGXrm31IvfsaoeskZyhvxha5cnLg5f6BFOsUhd8DH/zvdZ
         CkH4cxcUDXXdP/Eypu56FZJ8x5VCY1wkfQoivzRPVmW1TYUBTzAXaJs0lT+X6Af6/pMU
         0tcU/KPV2QihC0nTT3/tbLHL3/N8akPRmpDKf9Pt2fdPmRcTiLVPBaOPXWbBoSzmfMWp
         NRW5vO9gmSVHj8SKPieiWCvG5OrzmeMAK4SO18u03gsWcqjPYmKPpMw+h99OVJpXVJNG
         TJWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1780940784; x=1781545584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nurm0VcFWadxHMGIIRZaG/YNpWN0YfQDmN6L/EoaYoA=;
        b=FkEOvwMRFABNHnDpVtFMZaM5Yv2YdToPkMsi7KcMWeTLfTPWHXdK3ORWqvZd7Fl4TQ
         AfpdFFk4trnxAI4wqp86jNQrd5S65KIQqt310ObBt8X0uyRdh1BN5mqVSurz8CsaSlFi
         4UVNizexuQV7d/TJIDke1xPz5z313D7cZhf1/ZTdGvs4/TjcfDhnzqUBxDxF5eA1W5Rz
         8hZegs6r61/UHAI+70C0sPJRw4DNOMVjPNZKgOUhjrALZG0Bw/urvtBsEXTYVHFDOcAH
         +WSklKaVKVB79vPSKlEUdLCqfQhUaW7YRzUOD1uZV7PXhPh2p6hoRbBQUrXykff3rG9k
         8KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940784; x=1781545584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nurm0VcFWadxHMGIIRZaG/YNpWN0YfQDmN6L/EoaYoA=;
        b=lRMvKslUFV1KS/OUoX7BJp4F6kS1QvBLUloL9MfQk2EkPMNILL86cBYFw8tNYE1MG9
         4oTz1iGXM3ln5IwPOUCZrm7Ay1LpkwxYNAatjvI6LvG0fqys8onH9Xd/qwQmhjX1YmsD
         uLcaPtKfVfuHL5qnT8wGJnYas8Hu7VuqvbTpEuIOcPHH746qzwJHI9yNWhN4liAiCDqd
         imH/cYDFOXuaaUTiM1jXQ6ap+POPNVoZR84VVHy9NLWOd3nE2ayYwEUw3dC02eKeWyww
         xlHiO43W8UNPzKC7HVESYzej1J4HvgMHPpaaiGG6S5HRTWFgeGF3nIy10zoFXHdjIEuy
         /OZA==
X-Gm-Message-State: AOJu0YzQQlruIv8TpImmwi9F5lpSGaelpPlMrX68bDoo7+QItmHFTrX8
	/LTAVKaDhEm33ZKy21+ylVsmih3d4fxebAr9RU/7Oh0K2edTNgcMHIJaHSq4n6yGbsuDcQz/bkz
	lSNIJgCDNa7+WibDEO+ZIuerQYS1MMu3NnZbrsWH9
X-Gm-Gg: Acq92OEhSfIxt/fN6zZc1mauI5anH60Mz0FcjU5wZMpSZyIao3bvcg7yYgtvtyxUhZq
	KM841V1YI69EWhtRg1hH4ihLkk1ZERkarowxqXpt4dp261fL3lP8XsPgw5LmMrSXMDsui73dx4J
	6yyDDY9RvV7sVusw8FKoLORMH5XIg7KCwxEHTq/pvUfBqNxPooRcPXefbbWdBFz5ACmdYxzOOiu
	OzM9q4zj3mifFzyM158Pm3KazGCmCpsQMBuVi4RyqxbfT0Wha6wTmsDgtGc+P4PVGAPyWUS0ylv
	XU1YP9TRExFlo80+p5SXw6oywabWz0EflOHHzHosfn7f3Io8
X-Received: by 2002:a4a:edc8:0:b0:69e:2f7c:693a with SMTP id
 006d021491bc7-69e68b5096amr8980344eaf.20.1780940783613; Mon, 08 Jun 2026
 10:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607143608.76122-1-gavin.li@samsara.com> <ars6vptfsifv3zvdbx2p7ihcw4rbwbgkvft3xpqyjbvkdckfzy@zxx2exbtuib4>
In-Reply-To: <ars6vptfsifv3zvdbx2p7ihcw4rbwbgkvft3xpqyjbvkdckfzy@zxx2exbtuib4>
From: Gavin Li <gavin.li@samsara.com>
Date: Mon, 8 Jun 2026 13:46:12 -0400
X-Gm-Features: AVVi8CcLftJeS8P3lA2_hIyMST_fRgbgPwFISVUdQEQq81kVuHGgYJacZdtgjks
Message-ID: <CAKvMnUUuqPPrPzkktdDmmwqjgiw2RquYEktoxGahNSGRJAzWpw@mail.gmail.com>
Subject: Re: [PATCH v1] i2c: virtio: wait uninterruptibly for completions to
 avoid UAF
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Noted. I have sent a v2 patch that allows a hung process to be killed.

On Sun, Jun 7, 2026 at 11:44=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 07-06-26, 10:36, Gavin Li wrote:
> > virtio_i2c_complete_reqs() uses wait_for_completion_interruptible() and=
 stops
> > waiting when a signal arrives. virtio_i2c_xfer() then frees reqs and th=
e
> > per-request DMA bounce buffers while the device may still hold virtqueu=
e tokens
> > pointing at &reqs[i] and DMA into read bounce buffers. Additionally, wh=
en the
> > device later completes those requests, virtio_i2c_msg_done() calls comp=
lete()
> > on freed memory and can corrupt the slab freelist.
> >
> > Wait uninterruptibly for every completion before freeing reqs. This
> > matches how other virtio drivers retain request storage until the devic=
e
> > completes it. The virtio spec unfortunately does not provide a way to
> > cancel an in-flight request, so waiting uninterruptibly is required.
> >
> > Signed-off-by: Gavin Li <gavin.li@samsara.com>
> > ---
> >  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
>
> This is a revert of (and maybe better if that is mentioned in the logs):
>
> commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible comp=
letion wait")
>
> I don't think this is the right approach here. We shouldn't hang the kern=
el
> indefinitely if the other side is dead.
>
> --
> viresh
