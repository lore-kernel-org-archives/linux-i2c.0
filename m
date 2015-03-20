From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Fri, 20 Mar 2015 11:19:25 +0100
Message-ID: <20150320101925.GC2071@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana>
 <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana>
 <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana>
 <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana>
 <550B3725.10209@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <550B3725.10209@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Gabriel Dobato <dobatog@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Ok, I see what you mean. I had a look at the place in question and
> wonder what to return from i2c_add_mux_adapter() in the disabled
> case so that i2c-mux-pinctrl is still happy with the returned value.

Ouch, you are right. The crux of interfaces returning NULL instead of an
ERR_PTR :( I'll have a look, I maybe started to fix this somewhen.

> I guess what you want to have is that i2c_add_adapter() is not called
> for the disabled case, right?

I think that makes sense.

> Is the i2c_adapter struct prepared in i2c_mux_add_adapter() still valid
> if i2c_add_adapter() is not called?

I will have a closer look to the issue this weekend.

> Sorry, I am not too deep into i2c subsystem, I just reworked i2c-mux-
> pinctrl to make it work on Dove. If you are fine with giving me some
> guidance how you prefer to have it done, I can try to free some spare
> time.

Cool, thanks. Learning by doing is a good way to get such knowledge :)

> Unfortunately there is already little of it, so please don't
> expect a quick tested patch.

I understand.

Thanks,

   Wolfram


--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVC/QtAAoJEBQN5MwUoCm2EMgP/jVuRMu+PrDW4W0EbaLS3skl
nMjRYJ3VdWxmRkdWhzRfpIxdJTDOsIbEnTe82qI/uD3jqNnEoE8c47gQrVtqi7dt
ShzL4Ly15jIjjsM6VnkjJIKqGyM2Lxh6MTqsSIPzyxKQSREaQj0ND5kBljFPehKa
NnAi3+EMmgmeUkmSlCPjC1JDrjxj1bkrHujYMPpQglenCJboITc9yPmCd5EDYtG4
Jk7lXt0aEQjgpLm6tjbcvtk9F8H/awyxN59ZBJG3DHbk5o8mTB/dnAZNSbW0tySg
UiO0POTt/nAIX4qmyomRoq9W6xCYZyoa6JNPwOu49oXlEXWvzRZgf6crr1uo0gMR
f/CkVOTtolgHmawLBmIUym71sp1sSGG0uEoJJeXCkBEmviUFzumEBMHt3YHiDfSM
5fXy/q61pfCULPZ4AA4DhbbOKXJ9A48y9iy6HzUKlfll+s05r3vDTRzVCS7EQkOC
q+dvcaTS/+oQexp5MJFRMCXDn0eUnWPNpeDoF5X91vVryLxruBsetCz/ZPEMOJF3
juymoK94k/94iM1CHzfLgNMZb+vjP7wprZSEW/jYzhi1HLjFPj4wJA1oeU0/QeB5
pIFM4uoC0Ew4vDrWJB6OPSHFLHH/mo/6Sr2IEPXdVlShLuI4UF90IdGTrGF31Be/
jzCCobSPUBR/iBLWtajH
=ZrDm
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
