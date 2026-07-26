Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1537C0FD
	for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065560; cv=none; b=aZ8IRfIbavapUBV24QgQsFHEk+E3zribVuaNtDT7a7ku1icM+0IGVM3dStaDNScOLpkkgO1PkmfQbbIAFDluQssZooWZnowUz3BK6M9cg9tKNkJyDcvJSIykQ330t3ppMnrg+oHEZ7jmWpzOz6RHOsDpI6mnD688CxFlf/kAtG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065560; c=relaxed/simple;
	bh=vbeAau4UC3FxrrUR/JcY5rcWcKjuSkJcHQtzTgu6gsg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PKFWqvR43UuNDdNNWzF/Ct7NsWR4LzEBw3t1nKM/HXFAxThIFspCwwJ/OB69qh8EhhjmLBX8LimJUhBmXazyCon6p+U2o/AkYDOCuFWmu+pz+cM38khDljhiH3jbes0wR7Jr3/oF5d7OejlzPb2of9hWDRuPCnaYtwsZ81siruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs8LeU4D; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs8LeU4D"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cca0c5799eso16628585ad.0
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785065557; x=1785670357; darn=vger.kernel.org;
        h=content-type:mime-version:subject:references:in-reply-to:message-id
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbeAau4UC3FxrrUR/JcY5rcWcKjuSkJcHQtzTgu6gsg=;
        b=Xs8LeU4DFTMivitW/Wpuds+U2BIe1coGsc2EiY45wGoRl3sa0t1E5SvrCkL0Nys9b9
         vPzG+QwlJmJtU4nyqugeBsZk6h8iZ6zFdlcMINhFotlsrLNnNpcFA7I7w41jBvmazLR4
         TysMQE/RaY4DapeXFPzuTlfxN8FNHhxMqZf34mvnKc8CEgIl94mx1P/cIAEZ3VAr4hKe
         oaeOcvJbCubP3QthCSaGqu5gr0JEXDj+MiFjMcKP0IdB5Ybu6Bhzy6Yk80Db+aXIGpMV
         ICE6vdJeDA114MaqswWg0RAxq9qAx3BheZTc3rniAjCCNjH2mmFrlHkrPfl5plZqbxvA
         iSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065557; x=1785670357;
        h=content-type:mime-version:subject:references:in-reply-to:message-id
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbeAau4UC3FxrrUR/JcY5rcWcKjuSkJcHQtzTgu6gsg=;
        b=Tw8h/lYxT7A2rWIeXqVXP5c+0dpz8A4aFsQexle9I8iUCRNdyEoC0l56ujYlMiVvwz
         WeevGujNC8DbVJr3ki08WvGOQJlfCEmoCchWfE5hKPuu4MDE/20gWIvMGNNucqe7HzMc
         M43ziPU3fYGQr8drV9q/iDZ4migNz6RtgFij0cgKFjD0WSnWnrFIUvbv+2j1GUj9OLqE
         CJL2oKWoV1DCfcBV/mrgvCay727jVyWWvIlGjWioCeOP/WzYtpefrOeb8iIhD11ARVhk
         zBDky1iXHuSw8yvBOd6NNvsa5OBj0Pty/QhsvmkaSHT5onTbkuvsL6cbkULvkRWxN1au
         HoFA==
X-Forwarded-Encrypted: i=1; AHgh+Ro540sozDQzN2H6UT6t1UnXmMMAqGhsftplWu2BYsKw0Lkc3FTLSmYPDXH2GqtVqPImyh+4CuXeRhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNPtjCOUyPnYuj5I317n+nHjFTf+dWVg5j3RwhFWHpZ/UGCpA
	46Zhk89eDZASd1XCKrc0z+tjfGUIPXgJjwkJYm5aBiU0XXx1cI2FfSqF
X-Gm-Gg: AR+sD12Y1VUzfzU9DwkReB7fiRwWOgAiidDzR9VhZU7svyxV6ek/4xyDcqYeP2S/rLq
	Y96uf+X6LjvDe6qBR+1m4l30jzvMEpMW1CsKi0SuLLhnZG/9RGtroQ533ejmdzTXrzTNbM3yDfN
	8BLSMNkYM/l1qo8/eqARPveIxKsAZFKGxJLaGyw+IE+uwW9+TUHxbxC7mSrsBW0Mry9KEgaFbVR
	mnNvRF4bWPvWTisUdmyRDrpwISBp386o18hHhlxBP9Zb6milGNN9hbA7KORVuuqvg0SLMCw+kqz
	SEXvtFQw060kl42U8A95szxnNer+CKuriWNVStGwLN+0/80JTXmgtdLlUkMMiF4lrF932K1KbPM
	istJ3kzWhOcGSbQYXQdMZZKxOWtCbwMsLQjrEueEmNVgOoeIvragB8enl02rziv5Q6v0GFtcwNN
	x9mZTMz/8fd2qwwACsGVdpaOjlZ1DTG8+GCiUJpurkYZifpd9p0bvFhyeyYQWev7ChQvw=
X-Received: by 2002:a17:902:f651:b0:2ca:1b97:70c5 with SMTP id d9443c01a7336-2cfde687fecmr47996425ad.4.1785065557211;
        Sun, 26 Jul 2026 04:32:37 -0700 (PDT)
Received: from [100.91.161.120] (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d5297sm19640845ad.56.2026.07.26.04.32.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2026 04:32:34 -0700 (PDT)
Date: Sun, 26 Jul 2026 20:32:25 +0900
From: skyexpoc <skyexpoc@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Andi Shyti
 <andi.shyti@kernel.org>, linux-usb@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Israel Cepeda
 <israel.a.cepeda.lopez@intel.com>
Message-ID: <e6ce9251-fcaa-4833-ae6b-12a5d46415ba@Canary>
In-Reply-To: <2026072622-refusing-smasher-6eed@gregkh>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
 <2026072622-refusing-smasher-6eed@gregkh>
Subject: Re: [PATCH 0/3] usbio: fix two out-of-bounds accesses and a
 hang
X-Canary-Draft: 2
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="6a65f049_6b68079a_e5c"; 
 protocol="application/pgp-signature"

--6a65f049_6b68079a_e5c
Content-Type: multipart/alternative; boundary="6a65f049_41a7c4c9_e5c"

--6a65f049_41a7c4c9_e5c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I=E2=80=99m sorry. I should have included an attribution.
That was my oversight.

I did use an LLM this time to assist with the audit and translation. It p=
erformed variant analysis on the code around 8c6314489550, identified the=
se three issues, and wrote the patches and changelog. I ran the build, re=
viewed the results, decided what was worth submitting, and sent everythin=
g out. The Signed-off-by line is mine, and I take responsibility for this=
 work.

I have now read =E2=81=A0coding-assistants.rst and =E2=81=A0generated-con=
tent.rst. The following has been added to all three patches in v2:

Assisted-by: Claude:claude-opus-5 asan

The cover letter also explains what the tool did and what I did. There ar=
e no code changes compared with v1.

Thank you,

HE WEI

> On Sunday, Jul 26, 2026 at 8:11 PM, Greg Kroah-Hartman <gregkh=40linuxf=
oundation.org (mailto:gregkh=40linuxfoundation.org)> wrote:
> On Sun, Jul 26, 2026 at 04:59:10PM +0900, HE WEI (=E3=82=AE=E3=82=AB=E3=
=82=AF) wrote:
> > This is variant analysis around 8c6314489550 (=22usb: misc: usbio: bo=
und
> > bulk IN response length to the received transfer=22), which fixed a s=
lab
> > out-of-bounds read in usbio=5Fbulk=5Fmsg(). Re-reading that function,=

> > usbio=5Fctrl=5Fmsg() and the I2C client built on top of them turned u=
p three
> > further issues.
> >
> > Patch 1 fixes the length checks in usbio=5Fctrl=5Fmsg() and
> > usbio=5Fbulk=5Fmsg(). They are computed as =22<buf>=5Flen - sizeof(*p=
kt)=22, u16
> > minus size=5Ft, which wraps for any endpoint smaller than the protoco=
l
> > header. usb=5Fparse=5Fendpoint() only clamps wMaxPacketSize downwards=
, so
> > a device can advertise 1 and turn the check off entirely; the first I=
2C
> > transfer then overflows a one byte slab object. The overflow complete=
s
> > before usb=5Fbulk=5Fmsg() is reached, so it does not depend on the ho=
st
> > controller accepting the transfer. =46ixed by validating the three
> > lengths once in usbio=5Fprobe(), which is the only place that assigns=

> > them.
> >
> > Patch 2 is the equivalent arithmetic in i2c-usbio.c, where the overhe=
ad
> > is 10 rather than 5. The interesting value there is exactly 10: the
> > chunk size is then 0 and the split loop in usbio=5Fi2c=5Fread() never=

> > advances, so a device that keeps answering keeps the loop alive
> > uninterruptibly while holding usbio->bulk=5Fmutex. That is a hang rat=
her
> > than memory corruption, and patch 1 does not address it. This is also=

> > the one patch in the series with a behaviour change -- a bridge whose=

> > bulk wMaxPacketSize is below 11 no longer gets an I2C adapter -- and =
the
> > commit message spells out why such an adapter could never have
> > completed a transfer in the first place.
> >
> > Patch 3 is a different bug from the two above, and the one that affec=
ts
> > existing hardware. usbio=5Fctrl=5Fmsg() and usbio=5Fbulk=5Fmsg() hex =
dump the
> > reply with =22%*phN=22 using a length the device supplied and that ha=
s not
> > been validated yet. hex=5Fstring() caps the field width at 64, not at=

> > the buffer size, so the dump reads up to byte 67 of ctrlbuf and byte =
68
> > of rxbuf: out of bounds for every low, full and high speed ep0 packet=

> > size and for the bulk sizes these bridges actually use. It needs no
> > malformed descriptor at all, only the dev=5Fdbg() calls enabled.
> >
> > The new probe checks do not reject any supported bridge: the low, ful=
l
> > and high speed devices this driver binds to have an ep0 packet size o=
f
> > at least 8, and they use bulk endpoints of 64, or 63 via
> > USBIO=5FQUIRK=5FBULK=5FMAXP=5F63.
> >
> > What was verified, and what was not:
> >
> > - All three build cleanly with x86=5F64 gcc 14.2.0 at W=3D1, with
> > CON=46IG=5FDYNAMIC=5FDEBUG both disabled and enabled.
> >
> > - The out-of-bounds accesses in patches 1 and 3, and the
> > non-terminating loop in patch 2, reproduce against a userspace model
> > that copies the struct definitions from usbio.h and the checks and
> > stores from usbio.c and i2c-usbio.c verbatim, with only
> > devm=5Fkzalloc(), usb=5Fbulk=5Fmsg() and usb=5Fcontrol=5Fmsg() replac=
ed; the
> > memory errors are reported by AddressSanitizer. The same source
> > built with the patches applied is clean, and both a normal device
> > (ep0 64, bulk 64/64) and the USBIO=5FQUIRK=5FBULK=5FMAXP=5F63 path st=
ill
> > work.
> >
> > - The decision space was swept exhaustively, endpoint sizes 0..2048
> > against caller lengths 0..4101: the mainline bulk check can be
> > bypassed for exactly 0..4 and the control check for exactly 0..3.
> > After patch 1 no accepted endpoint size admits an overflow, and no
> > size that could carry a payload byte is rejected.
> >
> > - I have not run any of this on hardware or on dummy=5Fhcd. The
> > reachability arguments are read from usbcore and from
> > lib/vsprintf.c, not observed at runtime. I am happy to build a
> > raw-gadget reproducer if that would help review.
> >
> > Patches 1 and 3 touch drivers/usb/misc/usbio.c and patch 2 touches
> > drivers/i2c/busses/i2c-usbio.c; MAINTAINERS lists all three files und=
er
> > the same INTEL USBIO entry, so they are sent as one series. They appl=
y
> > to mainline 3dab139d4795, to usb-next and to usb-testing.
> >
> > HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) (3):
> > usb: misc: usbio: reject endpoints smaller than the packet header
> > i2c: usbio: reject bridges with undersized transfer buffers
> > usb: misc: usbio: bound the debug hex dumps by the received length
> >
> > drivers/i2c/busses/i2c-usbio.c =7C 14 ++++++++++++
> > drivers/usb/misc/usbio.c =7C 50 +++++++++++++++++++++++++++++++++++++=
+----
> > 2 files changed, 60 insertions(+), 4 deletions(-)
>
> As you obviously used a LLM for these, why did it not properly tag the
> changes with an =22Assisted-by:=22 tag=3F That is required.
>
> thanks,
>
> greg k-h

--6a65f049_41a7c4c9_e5c
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22><head> <title></title> <=
meta name=3D=22viewport=22 content=3D=22width=3Ddevice-width, initial-sca=
le=3D1.0, user-scalable=3Dno=22> </head> <body style=3D=22font-family:Hel=
vetica;color:=23000000;font-size:14px;=22><img id=3D=223110BEA40212E49033=
572E6C=46A=46EE699=22 alt=3D=22=22 width=3D=220px=22 src=3D=22https://rec=
eipts.canarymail.io/track/954209=46B9=463EB=462E9B6BDA7EA95317=46A=5F3110=
BEA40212E49033572E6C=46A=46EE699.png=22 height=3D=220px=22><div id=3D=22C=
anaryBody=22 dir=3D=22auto=22> <div> <div>I=E2=80=99m sorry. I should hav=
e included an attribution.=C2=A0</div><div>That was my oversight.</div><d=
iv><br></div><div>I did use an LLM this time to assist with the audit and=
 translation. It performed variant analysis on the code around 8c63144895=
50, identified these three issues, and wrote the patches and changelog. I=
 ran the build, reviewed the results, decided what was worth submitting, =
and sent everything out. The Signed-off-by line is mine, and I take respo=
nsibility for this work.</div><div><br></div><div>I have now read =E2=81=A0=
coding-assistants.rst and =E2=81=A0generated-content.rst. The following h=
as been added to all three patches in v2:</div><div><br></div><div>Assist=
ed-by: Claude:claude-opus-5 asan</div><div><br></div><div>The cover lette=
r also explains what the tool did and what I did. There are no code chang=
es compared with v1.</div><div><br></div><div>Thank you,</div><div><br></=
div><div>HE WEI</div> </div> <div><br></div> </div> <div id=3D=22CanarySi=
g=22> <div> <div><br></div> <div><br></div> </div> </div> <div id=3D=22Ca=
naryDropbox=22> </div> <blockquote id=3D=22CanaryBlockquote=22> <div> <di=
v>On Sunday, Jul 26, 2026 at 8:11 PM, Greg Kroah-Hartman &lt;<a href=3D=22=
mailto:gregkh=40linuxfoundation.org=22>gregkh=40linuxfoundation.org</a>&g=
t; wrote:<br></div> <div>On Sun, Jul 26, 2026 at 04:59:10PM +0900, HE WEI=
 (=E3=82=AE=E3=82=AB=E3=82=AF) wrote: <br><blockquote type=3D=22cite=22>T=
his is variant analysis around 8c6314489550 (=22usb: misc: usbio: bound <=
br>bulk IN response length to the received transfer=22), which fixed a sl=
ab <br>out-of-bounds read in usbio=5Fbulk=5Fmsg(). Re-reading that functi=
on, <br>usbio=5Fctrl=5Fmsg() and the I2C client built on top of them turn=
ed up three <br>further issues. <br> <br>Patch 1 fixes the length checks =
in usbio=5Fctrl=5Fmsg() and <br>usbio=5Fbulk=5Fmsg(). They are computed a=
s =22&lt;buf&gt;=5Flen - sizeof(*pkt)=22, u16 <br>minus size=5Ft, which w=
raps for any endpoint smaller than the protocol <br>header. usb=5Fparse=5F=
endpoint() only clamps wMaxPacketSize downwards, so <br>a device can adve=
rtise 1 and turn the check off entirely; the first I2C <br>transfer then =
overflows a one byte slab object. The overflow completes <br>before usb=5F=
bulk=5Fmsg() is reached, so it does not depend on the host <br>controller=
 accepting the transfer. =46ixed by validating the three <br>lengths once=
 in usbio=5Fprobe(), which is the only place that assigns <br>them. <br> =
<br>Patch 2 is the equivalent arithmetic in i2c-usbio.c, where the overhe=
ad <br>is 10 rather than 5. The interesting value there is exactly 10: th=
e <br>chunk size is then 0 and the split loop in usbio=5Fi2c=5Fread() nev=
er <br>advances, so a device that keeps answering keeps the loop alive <b=
r>uninterruptibly while holding usbio-&gt;bulk=5Fmutex. That is a hang ra=
ther <br>than memory corruption, and patch 1 does not address it. This is=
 also <br>the one patch in the series with a behaviour change -- a bridge=
 whose <br>bulk wMaxPacketSize is below 11 no longer gets an I2C adapter =
-- and the <br>commit message spells out why such an adapter could never =
have <br>completed a transfer in the first place. <br> <br>Patch 3 is a d=
ifferent bug from the two above, and the one that affects <br>existing ha=
rdware. usbio=5Fctrl=5Fmsg() and usbio=5Fbulk=5Fmsg() hex dump the <br>re=
ply with =22%*phN=22 using a length the device supplied and that has not =
<br>been validated yet. hex=5Fstring() caps the field width at 64, not at=
 <br>the buffer size, so the dump reads up to byte 67 of ctrlbuf and byte=
 68 <br>of rxbuf: out of bounds for every low, full and high speed ep0 pa=
cket <br>size and for the bulk sizes these bridges actually use. It needs=
 no <br>malformed descriptor at all, only the dev=5Fdbg() calls enabled. =
<br> <br>The new probe checks do not reject any supported bridge: the low=
, full <br>and high speed devices this driver binds to have an ep0 packet=
 size of <br>at least 8, and they use bulk endpoints of 64, or 63 via <br=
>USBIO=5FQUIRK=5FBULK=5FMAXP=5F63. <br> <br>What was verified, and what w=
as not: <br> <br>- All three build cleanly with x86=5F64 gcc 14.2.0 at W=3D=
1, with <br>CON=46IG=5FDYNAMIC=5FDEBUG both disabled and enabled. <br> <b=
r>- The out-of-bounds accesses in patches 1 and 3, and the <br>non-termin=
ating loop in patch 2, reproduce against a userspace model <br>that copie=
s the struct definitions from usbio.h and the checks and <br>stores from =
usbio.c and i2c-usbio.c verbatim, with only <br>devm=5Fkzalloc(), usb=5Fb=
ulk=5Fmsg() and usb=5Fcontrol=5Fmsg() replaced; the <br>memory errors are=
 reported by AddressSanitizer. The same source <br>built with the patches=
 applied is clean, and both a normal device <br>(ep0 64, bulk 64/64) and =
the USBIO=5FQUIRK=5FBULK=5FMAXP=5F63 path still <br>work. <br> <br>- The =
decision space was swept exhaustively, endpoint sizes 0..2048 <br>against=
 caller lengths 0..4101: the mainline bulk check can be <br>bypassed for =
exactly 0..4 and the control check for exactly 0..3. <br>After patch 1 no=
 accepted endpoint size admits an overflow, and no <br>size that could ca=
rry a payload byte is rejected. <br> <br>- I have not run any of this on =
hardware or on dummy=5Fhcd. The <br>reachability arguments are read from =
usbcore and from <br>lib/vsprintf.c, not observed at runtime. I am happy =
to build a <br>raw-gadget reproducer if that would help review. <br> <br>=
Patches 1 and 3 touch drivers/usb/misc/usbio.c and patch 2 touches <br>dr=
ivers/i2c/busses/i2c-usbio.c; MAINTAINERS lists all three files under <br=
>the same INTEL USBIO entry, so they are sent as one series. They apply <=
br>to mainline 3dab139d4795, to usb-next and to usb-testing. <br> <br>HE =
WEI (=E3=82=AE=E3=82=AB=E3=82=AF) (3): <br>usb: misc: usbio: reject endpo=
ints smaller than the packet header <br>i2c: usbio: reject bridges with u=
ndersized transfer buffers <br>usb: misc: usbio: bound the debug hex dump=
s by the received length <br> <br>drivers/i2c/busses/i2c-usbio.c =7C 14 +=
+++++++++++ <br>drivers/usb/misc/usbio.c =7C 50 +++++++++++++++++++++++++=
+++++++++++++---- <br>2 files changed, 60 insertions(+), 4 deletions(-) <=
br></blockquote> <br>As you obviously used a LLM for these, why did it no=
t properly tag the <br>changes with an =22Assisted-by:=22 tag=3F That is =
required. <br> <br>thanks, <br> <br>greg k-h <br></div> </div> </blockquo=
te> </body></html>
--6a65f049_41a7c4c9_e5c--

--6a65f049_6b68079a_e5c
Content-Type: application/pgp-signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: Canary PGP V3

iQJIBAADCgAyKxxIRSBXRUnvvIjjgq7jgqvjgq/vvIkgPHNreWV4cG9jQGdtYWls
LmNvbT4FAmpl8EkACgkQ5NEvu1xWDZQDZA/9ELa+84vzg8YPpHJlMjX1E2vFifWI
Dm05aoGwplYXaRgsnIrRW/g2wI/63mwFIx1IScSVSm7TBIn3vdpMOy9j0RQfbFFT
XuRIy1+foSZBQXNAEpp/KCDLDYUT2EHEOzy5eLuEh9xvNyQ9M+OdztEUM5yXly7g
DEgmONhzcNa/R+8wB3JJ95Kya+uD5xWQVDcNV2Oqslr61g80zWlA16S34+72EZVL
HaIIrfqRpeyDZPKPk1444mIlJ0R2mRhAH+uP5xF3EWtIeu8Y1spYkYEw9Xs6sdS3
2t5NSWLmK/ri5Mhi7NjiFRTPVdJkLCoGbqINkqQHZZV1o+pJMNshBqS/OqHiwJDg
e0/RA/EnaefO+TSN1dI6Xww0e+nKFMyrPVdyrme431fyJP0gVOptYWIJb5JY20p5
5S9e8VX9ux+glBEZPW0s5vxSOof304Jfge1E7cAEjLYd23f8NWs0wIQgtuNs5RJw
HpC7vN7yKPh25jAhD0Yw/WJlxBcxDHeOoykJfB0D/4ta2meAUwnSE5FCsEkLegkt
XkeYQw04EJvAxpDvcl4y/DdwlLzQMQMR6zGY2wi7rf43yDuCulngkUwPEHYHL+mc
hiojSQZ9sG9T5iSkTmn9LKg5KpGdkNAJm4cQybeRS6ROScsFxXsuMnWJ1O5J/Jao
QQVNYqrdaPewkDY=
=fBHz
-----END PGP SIGNATURE-----

--6a65f049_6b68079a_e5c--

