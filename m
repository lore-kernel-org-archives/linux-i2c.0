Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2F29AAF3
	for <linux-i2c@vger.kernel.org>; Thu,  9 Apr 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762269; cv=pass; b=Kc6LsCUP7FS0xwc8KghREfe1Y+liW3N24qQhQpUwh86vE8NIHPOhospQQtWwERPIcNM2jZ6YtZ75BIZlGlemRkTvuwsfvmuuuk8VWVVu5mDSknXntTfSTKzovF5jgov1cJeg9RNvgPVWRYbNNcAwAd8wWzzgBkPN/qYP+TVxSAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762269; c=relaxed/simple;
	bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RffLi8svbj42sgqetJjv1qL0m3q5qldFF3zPYQuczBi8+RZ8JJRZxk1kyODY1jzCFwQIeo7NkYE0tRG500PD4VwbGTzPnIV6f4ecUR68mVegrl+gV/ddzvfyTfpBhpXuTOPQDZ4hDFvriM7iKv3uB5fnyhdG6UIXLFJ36AyhyP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRxOTARa; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRxOTARa"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso164655866b.3
        for <linux-i2c@vger.kernel.org>; Thu, 09 Apr 2026 12:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775762267; cv=none;
        d=google.com; s=arc-20240605;
        b=JFTsYBOFG6SAdL1TzAjGOTj+PjUkiF0y0V+fTLbzcQ9/GPQTgJVDm9NzCmmaD6QEAX
         M5yrpZ+PREGfFDKend4fCXu4eyeSUuTusUoh7vpCfcGIC4tHlxoygIvyMR4QVctpEZWR
         w2TTTuIWEPqN4G+N7FPmwHY0X/hMmWjGsFTXq4YsHPsaKI7+tike5vvfEQcg7N8Ntgoo
         LN7/JedbsR5xQz/X+xewTDWckQaBfKmgpHv0LVyWK6fsWef3kbH8etc2+H0xDLuc4nl3
         Xi7E3qheQK2EJVF9ofpUBHvWx/KCbFpmfkOA44mGnj9hOoabP7ZBq1ZVDpphzR+wi/4t
         ZrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        fh=uZoRMUKY+ZNVfNfeNup0IH8KUHZG1QqmyIl4bKmbn1s=;
        b=WC5VycCYTBEFUkbs0LvbylOBp8SBIKR2xDogrQqcSOSGmgFAJxDys8VfFRzS41AHZ3
         roTSiyNJWggPCDExCJ2G6JcBHVr9kZQOV1C9XDylBTt+6zcRx1I/mH4Rvjevfj/QUpJa
         Ry21cMbRDvgSCJHwiNYxMuJ5f5ipENSGB56JOcK16AIB1/jjwLKhz5q4rf1gudMYjAMz
         w6E6BMnN4/Is9iRsFkx8adPZmvmv+EAzjBlc1QKxQqgPTQukaNDatZHKnQNFduIawONi
         koK0UZJW8wUSTsUfUwUYIcYmX8Pwx/g6l4P0VDKIreQtoZl3bMu/WroJ+LibEMOsEyLr
         oHaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762267; x=1776367067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        b=mRxOTARa7KEK/i89Nt5wG/esGfHtqRc+wZKzGDt8l+Mf4F47U59XvNjN4jbdK/lFHs
         lYSqDbgpTyAUrkAZHaUxGbQdrh/T0yN9u4CKjdu9DO1Dw5kteYdPnsZyZuLjsqzLj2Kg
         eyYANlMC3dKz0kCiAmf1O03gdy+XLwwslVsH7yXxfYAyizb5H1rFTNW3AXP2D+7lGJor
         7bZ92RNiycke3zY/JjVCA2323jSIetsrvz/M7e8cquGcTetTTtvJQzoNLyXnOMAr7cTH
         2eZvN4UMtNcAbLACq2RgzcvU9uEqq1vjUsfx3/69fDbKzretMvMRgnzK5Em1dmA1FoHP
         rfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762267; x=1776367067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        b=epC8ubVSF0FjzN+WkAvKkYIjHSusgB4CaxG/bsVeHww3VxrETYk3UD62rhrC1wynke
         ftVIYZQEgR6BaQYYIBmBJcvZrE8E5hHfmKNdHHv4TLnLf3eXrg786O7dEh9sfCojMewq
         op+p7rm88gwqxSONZFY1qM+rJgYd/c65ot6ToSVGOKmxyoVPcxVJoT5rV9mhjZob9DZT
         nFCqapnP+OAuzsu5l24sEOVjhaQl0Pwk6K976POIhO5rRoVb4c6rLaeb5To+1kUiMGkg
         KWb61HGX2YVWdx1AXzs5LVL8/4XRNLWKH5ElLNo2g11uicoB7wqGnaLgrsCNT7PKBvTi
         41rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZmpQ2Eoang/nXJuGOpzVD6kFfEmRSL3OtyGCekFSMi09ePXOJNftOu1zPQY7yRrn9HV9w2I3zQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmHF5mj5X8wxGT0JCFouGghTNBhJ7iGxSYz2gMvERJ+zLFkIT
	FMmRzVVM2OOFJOyCUSljueaibE4MUM1i6lkwVQBnSq/njiIg3mI/cfceZLGgbem2cTwUvMzCXvB
	nwO2URK3oz6JvllODvNMxT0t0T+fxUV0=
X-Gm-Gg: AeBDieuYvZWqasug1YjgVsfbY5ZvevryW+OK0dedd+3HWhN1KZbMBvkyRoMEkODEBgw
	fj7lKZd4q2go03oD27rHuyOQWygS3kRq9QxCV7/a7kol2L7OOBY3/tOtU0YuR1SaC1Rp3oonJoU
	hpsmytzpfjURraWzQ4DYWNuBVH0NM1gtBHUJUoFHr+PIBrjTCxn31JSl+8T4g5duCZTq2gmyF3Q
	qlUfiGTnuTCYzvlEE6HNDEkfNeehe6qXgCKpKz9B+RkqC0sx6mxl3g99rUKNngz1PfKtr7Reuvu
	sBENYjVJz+AQ3yHAIg==
X-Received: by 2002:a17:907:3ea5:b0:b9c:80d5:f01d with SMTP id
 a640c23a62f3a-b9d7248489amr28294266b.15.1775762266312; Thu, 09 Apr 2026
 12:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
 <20260324201858.46591-1-sebasjosue84@gmail.com> <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
 <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com> <7qr72215-4q40-qon4-808o-7o639qq90q3s@xreary.bet>
In-Reply-To: <7qr72215-4q40-qon4-808o-7o639qq90q3s@xreary.bet>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Thu, 9 Apr 2026 22:17:33 +0300
X-Gm-Features: AQROBzDUKfzKx0I6op-NC1K0D3CmW-7Z4_EpR32Zz1oP0pvTVWsGpsyO6bE_-Mk
Message-ID: <CAPnwWgOMNxU+vPx2a3aX4DDOMiW76sE2enVfCKk7gP+pSsoXgg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
To: Jiri Kosina <jikos@kernel.org>
Cc: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 9:29=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>
> On Thu, 9 Apr 2026, Michael Zaidman wrote:
>
> > The FT260 uses different report IDs (0xD0 through 0xDE) for different p=
ayload
> > lengths, with each report ID defining a different report size in the HI=
D
> > descriptor. So yes, the device can legitimately send reports shorter th=
an
> > FT260_REPORT_MAX_LENGTH, and a blanket size < 64 check would break vali=
d
> > short transfers.
>
> Perfect, thanks a lot for the detailed writeup! I was rather suspicious
> about the bold statement in the changelog.
>
> Similarly to other Sebasti=C3=A1n's fixes to various other drivers. This =
will
> need more thorough check.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

Indeed. The original patch would have been easily caught by testing on actu=
al
FT260 hardware - short transfers using report IDs 0xD0 through 0xD3 carry w=
ell
under 64 bytes and are part of normal I2C operation. A blanket size < 64 ch=
eck
would break them immediately.

I'll submit a proper fix with per-report-ID capacity validation based on th=
e
HID descriptor.
