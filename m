Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A09425CCE
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013167; cv=pass; b=E4zYsTfImWSp13wUKFVIzAaaLk5m6GRZmS4Z8hl03UsOiey0vm5fFz3E3eXnA8j6lbHEv2U3kdCVVoAFSAxMBn/5gh0vI/XHpy1RjlWIAi/gF45g/m1xQ6LCKAiBXB8Gsv2AIZEOrMiu9QuLipWDvXz/OJMHPMxNEbxW2ZE2jKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013167; c=relaxed/simple;
	bh=nL5mmGZaBR0KGiW9ByLpesO5BFVlQS4oNBhk8WU8xmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5+ugZaTDYse6V3gDke94fur3lmKUQS4mokf93bSzBZnzcJ8orGOmlOQ0vyT41WpLAphjzoJm8R/fiRX7dXYXHxXV6S7cyBCfglAc4ODCD7d8kvsA7n7S52Xye/W4n2A3nG4vmzjEWFVMXRi/iWz8urBf44QGgKa9Hncafm5a6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=AOSmshO4; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="AOSmshO4"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6ec655c80so2990313a34.0
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 06:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781013165; cv=none;
        d=google.com; s=arc-20240605;
        b=YB48q5a1hXcCasdEqVikmX4h0Evs1o03zophoV75JE/X8SfOYlv+u6guQNuzKc6i3j
         CnN0FRRIJ6KcKVItyzFujUzTNJRb38MAb5WenGexdfb+jZKnQ6DuWwGphbamBMI0QToA
         qaRqQzktQnZnS9Qa8MKstzsbkY3IVuwLOVQ7sYpQeVLibhuiHfJhRIZeuoudtkfl/Fyp
         ZaHfBofrlKgqwkRH6vMJTkfHXTOdzkVg8/zhsOsF1svIzmyafK9uh7+KxYbR561mSxom
         2T2Ka3dI1SdqQun77T87BSOZTO2GWliqvZgOZaDTKbbYhUl86i2fgkubwiKXMuO1O1bF
         gCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TPwTixStz0zU1NT3ncpNQzPruivDw+P8CqzY5CxuE/Q=;
        fh=F4vYIYMy7pSKN7xJoUwB2rdKIT5w/DucG8Ceqown+FE=;
        b=S/QFmzKp9mjVdKki4tQSP5SnuEtTKHlm6DGUuv8nDU3choJUCg5iw8PeGiZX91QqLF
         56hZLr87A4go/d+5ICT6tENWw63Z8/8H+aQjnzLzJ4eI9SCSPd+dnyO19/QJrrVqyS+1
         rkvg9TzE3Kx3c8vO49l2MfG8MTDJInjAexu+rmybKGccFUxbsBdm0VEbcZJU9UjgPcHk
         9+QZ8qoGNPJQ8Bqmed5Vfw5bOprhF5T+HRTCPrN5Mb15hFEMQBttLKmN8d1gK5PXvVCw
         v0DEshQDiFsNznBvCiJmq+hiEQwsLKlNxacLwlrLJooOICKUUKddJnDiX4MgNCi0iMgh
         MVag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781013165; x=1781617965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPwTixStz0zU1NT3ncpNQzPruivDw+P8CqzY5CxuE/Q=;
        b=AOSmshO4ksmcQgUp59hyKx/U62AqUpk4oEWCBm1y5nz65qacNIFR2LRKVsOJRf701i
         pVn4tRDl0Odp03WnRXy0N5y/zBkGjvnQ1L6z5KrF9OtliDZoPQCUBKlLc+xjXJysDE5+
         zMl5Sx3QeMacM5nWOUuPmlTLeB4ua3cPFQPv4PbIz47ppWbzz/pcZs6Z/pM6Y/zUzXvv
         JLFEvshgi6Lxrh9YjAq8WPEQHnJl99yTd/IqQm0r7jlf5uHkkKVZxX087JhiBHvCyu3D
         Ul81ERvVPOHDK9ZdmQ3WFHy1MSY7pQmkOh7PywB+vJte2pDzQ613IvAFuwYnxioNWUli
         4xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013165; x=1781617965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPwTixStz0zU1NT3ncpNQzPruivDw+P8CqzY5CxuE/Q=;
        b=lUzcyj2+eph+JJrhT3t1Wnq9PE9/Ri2KhIcUVWHfHB/RobJ8fMFlb1r3dpKa5z4xCU
         hMfoKQpfNzn3OAzJU8US3pw9baRgaWUeBhYhUXy8MkpjhUoc3YZMlcYsKTAdMMFNzOzG
         e1KDNamCGJ1HuFgd92THT3GCMg02Rp/xT9kYIoC4h/4+t8UcDfPit3uf0dol2mCNpCOf
         mfP/qUvseCHP0BM1msN82eD2DzUDneJY4VHrmZnGpDcNR1xrxV0a+T3HjanKJjfC4mRy
         +RTdmHw4aWO3gUHqUngytNF88G/wJ4e1IJZfA7roy7Jam53o5QIMIpwMw+KMusmvAj8c
         uKqA==
X-Gm-Message-State: AOJu0YxzKFoM5w2GyrO6NqGaFQgu89mGjoGc6Iz2f0yPH2seQxd0MHyA
	6MpWRwiQUye1BN1HXx3ZtASlQsT7mw5RC6C4Z0ULVGNL51Gw9Kk4jNqYjq1zalK7A95H4J7beHK
	I7xKyZ0wbcPtXIGfGzPdUa/AoGMaDFHm4mtkwmCRa
X-Gm-Gg: Acq92OEU7YwTdbwyItJjo+iAeTG8uFgS8jW8gPnPe9PWnukGHUo8scscSF6EmaujiEu
	HBdif3toVhMzi2P0dL/Fl90ptAFXhD7N9AwENcUF8i/Z7u6E8PIwuiWFAEffroZlju+agzNkCd3
	phSXI9U7EobCYtklZiyczcaHAqQ0oBnTA6zbnjsG8EvSUxVekX/mKRO7VCOmoxib3IBU2r9EViR
	eu7dUAmyjNLMIBxn97YdRpywffCXWHuyvZOHlaJIVSjMPoU/I+OQLCxArYts6QkXgDy8j2OM5oe
	tsH4vPctwjQ4j6D5fURtmZSf8uxTN+sfJqzzsQ84c3JCifv6
X-Received: by 2002:a05:6820:83d8:10b0:69b:5486:e85 with SMTP id
 006d021491bc7-69e68c19e38mr8248758eaf.36.1781013164660; Tue, 09 Jun 2026
 06:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607143608.76122-1-gavin.li@samsara.com> <20260608174435.62359-1-gavin.li@samsara.com>
 <ae754hwynvlfnuway2jdjuebyammfrz225pxymfhuqpusp4xkp@joyqrrkberpc>
In-Reply-To: <ae754hwynvlfnuway2jdjuebyammfrz225pxymfhuqpusp4xkp@joyqrrkberpc>
From: Gavin Li <gavin.li@samsara.com>
Date: Tue, 9 Jun 2026 09:52:33 -0400
X-Gm-Features: AVVi8CfBHfQw5II0WmIUH72AfGIkRVcNlAUwEU5ehCyFP8GxD9ZsZTPnT_N1E80
Message-ID: <CAKvMnUVZEnH3z-dVmCLgP0cFTjuYCcfaXhOOOy9KNG6kh-RdhA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, Viresh!

On Tue, Jun 9, 2026 at 3:35=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:

> Maybe move the comment above the code ? Can be dropped too.
>
> Also, maybe there is a small race here, not sure. What if the other
> side (polls and) processes the message as soon as it is added to the
> queue with virtqueue_add_sgs() ? In that case virtio_i2c_msg_done()
> will call complete (which won't harm) and kref_put(). If this happens
> for the first req of the xfer, it may end up freeing the xfer while
> being used here ?

Good eye, thanks for the catch. Moved kref_get() to
before virtqueue_add_sgs()

> > -static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > -                                 struct virtio_i2c_req *reqs,
> > -                                 struct i2c_msg *msgs, int num)
> > +static int virtio_i2c_complete_reqs(struct virtio_i2c_xfer *xfer)
>
> Maybe rename to complete_xfer now ?

Done

> > -             if (!failed) {
> > -                     if (wait_for_completion_interruptible(&req->compl=
etion))
> > -                             failed =3D true;
> > -                     else if (req->in_hdr.status !=3D VIRTIO_I2C_MSG_O=
K)
> > -                             failed =3D true;
> > -                     else
> > -                             j++;
> > +             if (wait_for_completion_killable(&req->completion)) {
>
> Maybe do this in a separate patch ?

Good idea, reverted to wait_for_completion_interruptible()

> > -     return j;
> > +     return fail_index >=3D 0 ? fail_index : xfer->num; /* number of s=
uccessful transactions */
>
> If this comment is required, maybe add it above the line instead.

Done
