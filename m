Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E158389DF0
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709274; cv=pass; b=F7d2lwObN6JQh+FsR7REp5lN880Royj1zGusw8jJ4KJct1PBR7/d165p9wvYkURJo7e0tQxyRGyAzR6BI2YxUGqT3zMgyeRFXW8KrMkTVy60hgAA1YhZ1TDWrBUiv/I9I6IT2RmAMMwkkZqADsPGqflMTqn7/Yuv182X6G/NGGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709274; c=relaxed/simple;
	bh=nsI28AOe10DwMfFECWTYXs7YxbtRBLvRLKMl55KqieY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSj4PdUBwvkSV98jCZHgJnNMmmNiZ7fxpgV/cVuXkJ6aXucbU97Uwycn7dkBtXsLbvBaYZhxao3hZ2W7Dm5RtBTEPHSQGrIj/74b52BDDyix8Z55ubSoOywOniOy4nqBI5Hdwn0CAVvaHkwarAsNql/J+npeReOLEnEeCPqEPUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RWUIahWE; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWUIahWE"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80814edb536so92472817b3.2
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 01:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784709267; cv=none;
        d=google.com; s=arc-20260327;
        b=R+t/MRA0eK5GvCoLqD3Vp5IGhK/t8HTR8E7DXvR1Y5z+hh9ByGRBvcVOHEmPcyWH5E
         XwmmYQSnNtgTYeeLTJYbCAoP/T8fNkdjqvZOxwxAm+DlkFMkTQrG3+OtcytIOYGk3SHQ
         Ob6jWl7nRnw+8Yh9b8t5nTk6Mnda27drHz+gOsP1RRBYZ9dt4ufa/yisPkrlmJuk50J0
         H9LhSL+SVsJKOJDuBKnMYljwaamhleNWnn/+Ef2bLt0XUdsRJJjcw9tk85K9ednzECoS
         lFjXpfII0Zr1fK47+cqA3LySU4pIIIjhFrtMF9Ar3ws06vqBDjxE7vx0hW0ED+noHdfZ
         bXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mo8WgYh25ldjyX8DCM5vtgvNxtGzO4105EDC10m83EQ=;
        fh=vU7L6aQ4/Exj5G7R/QtRP1/9O2bxeXqv6t5lV/fNgLE=;
        b=eHXHuqOZ6VOC+0QiuVPwj/UKr+6kESzXlvn1+ZQCzEW8wM/No1VnMolK/hNJ2pnwnw
         E8RrteRQ6gWTa5JueUne8kxLqfqbC6X51foSoOXMixVodbod/4nHqadtO6IJC7IcNAqA
         23lydcFyNNONDlrFZCs7R1VqrR92K4pYl0f05y8s91PYJj0yxi7VQNAB5yWD/n3MBTOk
         iBuJGNbiRDP5cgMGPp3zMa33s5fVeJzdPWh2xFP96gb3gWLFsQkYIJ5BgsdiM0rghTos
         bN7qKNqu8gXbirooZA/xwTFsDYl296lrr5CRw9mcZB3hr7nwpKFJdg0ieLzxN9ahOF0S
         c68A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784709267; x=1785314067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mo8WgYh25ldjyX8DCM5vtgvNxtGzO4105EDC10m83EQ=;
        b=RWUIahWEmhU3BvBkZbity1BNYB/Eenyu3p4xEb3lXaQGwCayDs/ICdYUkdFJIxZZPa
         WHjVR/qucmaAcuUmqM5TLYPBhmmCsQ7WOjIk2AK7kbxHEzZJgk4P0iHS8JqJg2iiEET+
         REScANg4FtV6kYkmXLaOm6qYzdjNFCKd+3xec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784709267; x=1785314067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mo8WgYh25ldjyX8DCM5vtgvNxtGzO4105EDC10m83EQ=;
        b=UbdSqUheGDsDTrSBE6nmdP//aFr8C38D9n+9Q+vxGit/JfisSYwYTR1AiFE370Vt36
         IeuGUCi66anrwUgWtmR8PBJcUQM5N99snpF2VGXJCv2esKYrE8KEkdBuGV1OQl+c3QRa
         55FB1/sK8Qll3j5OGd2ScxRhsNLwJDErRJITytgsafFmhyzOYfR61p7yYUgPPMc8pk98
         fwyIJRcM2ofDnS+vdspMO6437t5w942c/QPPBCek1bUBvraHm7D0VDWsm1X36lS54MLm
         S8cnGgzcQgOvxg4GY6EESdCMCUoi3w15JRg0OvkqqSnI9zcGz95nDl7wwRNGJTcqpgJ+
         WLbg==
X-Forwarded-Encrypted: i=1; AHgh+Rpv80NchOyZ+NUfVjjNN6UbPZ4CETnnEVuaqaiESxqw19NGqAQwxkWMMw2+TbtnJoB/M5p/t+7YH5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuIyZrjGIMgRpFbmLuJW1kvNaqUke/UAaD/wscNtIK7mi4zCr
	+WQ7pAcW1AFHrJSyiRfaaR4KMoG9gn7kOAXJcxFhP1u9s5ntRuxn2kGYvFV1sHiG9I/+tV1VS03
	0I3nqv8bsGAWKzjH3T1oGCKl4gd7fiuLSEcmgFPmv
X-Gm-Gg: AR+sD10i9kov4XGSpbBxHNpX9HPlmQfe/Vv7EWN8BUl1BY1Zs5m0vMMHoMShGzgc1oR
	8jEF6h189FS0UXMW0aP3X2240FVZuRjLKjvle9JcHJS7TVoCUN65zlOtCcF6tTMQ4/wS+lVclTa
	ONrY44wIESVE2DqBs9xPX625u/nqZJV1dkVxm1QPC871srYQ4L6RPxKXGmDV3xBWddM0rkVHzyj
	Y9D6a2TfD9Z/UtmfDGtWCAgGfqGqis784nQ2fhRKbpZ5bIb1K2smFW/q4la6AEF+wvomJOi7tgM
	9SdyBP34MAfxpzmR
X-Received: by 2002:a05:690c:c453:b0:81e:bf0e:55da with SMTP id
 00721157ae682-81ef260c885mr66446937b3.48.1784709266701; Wed, 22 Jul 2026
 01:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721075226.2347933-1-wenst@chromium.org> <20260721075226.2347933-7-wenst@chromium.org>
 <al9IwVR7Whw2DiXU@ashevche-desk.local>
In-Reply-To: <al9IwVR7Whw2DiXU@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 16:34:15 +0800
X-Gm-Features: AUfX_myMObbdQM6Uou8RDo9wMrLkt0Z3Ce7LljI10q7k1rjjaXzvygc1Ey8OWtE
Message-ID: <CAGXv+5EkcASZ__Cyp4PnwemPd2xAe+WL-ics9jqHLuxWjWyT7w@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 03:52:20PM +0800, Chen-Yu Tsai wrote:
> > When a I2C component is found, it's device node is immediately enabled.
> > This triggers device creation and driver binding. The prober will hold
> > the regulator enable reference across this part. If the driver probes
> > synchronously, then it happens within this window. On the other hand,
> > if the driver probes asynchronously, there is high chance that it
> > happens after the prober's cleanup function was called, in which case
> > the regulator would have been disabled when the driver's probe function
> > is called. This would then require the driver to wait 100 ms for the
> > hardware to reinitialize, even if the probe function was just a split
> > second late and the regulator was disabled a few milliseconds ago.
> >
> > Recently, some of the drivers for the component that are targeted by th=
e
> > I2C OF component prober gained the ability to skip waiting for hardware
> > initialization if the regulator was left enabled. This happens when the
> > PMIC has them on by default, or if the component prober left them on
> > after probing the component.
> >
> > Wait a bit of time before dropping the enable refcount on our end so
> > that the actual driver has the opportunity to catch and increase the
> > refcount on their end. The 100 ms delay was arbitrarily chosen.
>
> ...
>
> > +     /*
> > +      * Wait a bit of time for async drivers to probe and increase the
> > +      * regulator enable count. This allows the drivers to check and
> > +      * skip waiting for re-initialization.
> > +      */
> > +     if (defer_disable) {
> > +             dev_dbg(dev, "Deferring regulator disable\n");
> > +             msleep(100);
>
> How was this value chosen?

I just chose an arbitrary round value.

If both the prober and the driver for the probed device (trackpad in
this example) are builtin, the time between enabling the node and the
driver asynchronously probing is between 5 ms and 30 ms, but could
also see outliers exceeding 100 ms.

If you're worried the value won't suit every user, I could make it a
parameter of the simple helpers? And the user itself could be made to
probe asynchronously to not block the main code path.


ChenYu
