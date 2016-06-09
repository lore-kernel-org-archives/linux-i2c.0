From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V3 1/2] i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is
 enabled
Date: Thu, 9 Jun 2016 22:46:55 +0200
Message-ID: <20160609204655.GN23522@katana>
References: <1464164212-11377-1-git-send-email-sricharan@codeaurora.org>
 <1464164212-11377-2-git-send-email-sricharan@codeaurora.org>
 <20160526184805.GC1614@katana>
 <002201d1b79a$22862bc0$67928340$@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zbynv6TNPa9FrOf6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35023 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcFIUrA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:47:00 -0400
Content-Disposition: inline
In-Reply-To: <002201d1b79a$22862bc0$67928340$@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan <sricharan@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, nkaje@codeaurora.org, absahu@codeaurora.org, linux-i2c@vger.kernel.org, galak@codeaurora.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org


--Zbynv6TNPa9FrOf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>  The coherency is not dropped here. dma_map/unmap used
>  makes the buffer coherent before passing it to
>  dmaengine. Previously it was not required.
>  I can add this in description if its not clear.

Please do.

>=20
>  >> @@ -1268,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *=
adap,
> >>  		}
> >>  	}
> >>
> >> +	idx =3D 0;
> >> +
> >
> >This looks like an unrelated change.
>     Ha, wrong. This should have been in a separate patch.

Exactly this is what I meant with "unrelated" :)


--Zbynv6TNPa9FrOf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdW/AAoJEBQN5MwUoCm2p8MP/jmhyC+EM6YozdvYQzh5fwpf
E8oDOuYqGVDpUpLog8PyeD2/gXjMrnZ5eCRet3L4UtrOBpCpnYlyj6FLtOncphfL
KKcw0wicL1UZKIjM+wEamFzQHm/5xx5mc5uSOiF5ccBHzWJA/MFzNxI0JJ7IINKz
1PbdMFLrQRHfAbfssXMziCxrfz5IB8NPu5Sv/l8K8CH3uULtyKelJ0fCIG9b/9zG
Z9IyvVDcIByKGqBbVDo4XQsG2eqouzAaw12w3SAxYr9gLAVwh1PtPYxKK6SJy4Yg
pVzj7d+ki7Pk5+zvtbu1uxAKc1arx7ea1uCgyfN+mWCC5rZMPnNJokxo9jHP86me
lAy8wDABjLeKe771RSVInO/CXbtgl8bqCG0iOmdm0nBaQuIvflQjqkp5T7ZFsy8T
Rp+ZVB+HVelH5FmfpEQZAkSf0BRazutkHNtNrfUOc534AGyIBt7Ex6hzID+n1Yel
Ctucp0wm+fgIkJ/yxY0PBG74HyNdgK2a/sjvHW+rMPzu6j5JfjmZkzjlyoJU5jNg
LzRz/7Vmvi0vE4Vwg1XfzrWbVnMx/QtMQVmz20PVAr+kC6D7U3lWbpHfhEUGu+sc
PbfU+1J+OOnG+CLY1y33cNkf9gJiChEQgy8STgv5mdFHQZ7NhZSzJYNqYbA9gWF6
srzEx79tMYYX9EM5M/Zk
=hHLu
-----END PGP SIGNATURE-----

--Zbynv6TNPa9FrOf6--
