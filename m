From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH V7 4/6] i2c: qup: Add bam dma capabilities
Date: Mon, 21 Mar 2016 17:44:40 +0100
Message-ID: <20160321164440.GA1505@katana>
References: <1456142895-32646-1-git-send-email-sricharan@codeaurora.org>
 <20160224101949.GB1391@katana>
 <004901d1837a$2df9f620$89ede260$@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60812 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756270AbcCUQou (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 21 Mar 2016 12:44:50 -0400
Content-Disposition: inline
In-Reply-To: <004901d1837a$2df9f620$89ede260$@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> enabled.  I have patch like below to fix it, but wanted to ask you if it
> would correct to have this in the
> original patch or should I sent a separate fix ? Sorry for the mess on this.

Once a patch is applied, it is in linux-next, so you need to send
incremental patches to fix things.


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8CT3AAoJEBQN5MwUoCm2I5UP/0vsaD2iwzsEVosdBTn94JUm
moJEPUKgBF4iO23MINiBjCvUla5iwjF+ELscEUNn+pizKX2r1GuWWBZgsiXG7Rqv
E40dAt2kEX9edKoZRT59GSfH4xWcvdOzVS5QMxPM/oHsrG8ayljFsk5Up4j06ik+
u72FMiXBo21LRdvMY5NbFzydw8XEzVY0Y1suNDQW/6dPfmo3SzUKcbQvBWqs0nBB
R/d6JIHv9IcEg7lm6fS6hP/1GI0OvjYvyZBFjPL90w8R6lSKCCOQ+JBZssoxV8O1
tkvkPUKA0DFe5X/TVCSlMwPVqist/FWuWLBl959ZaEAwPvzwsY03ODva3mrv5HhN
0JijU6ryx9ZqT072dmsu0Xzk3UizVATqDjP7HrVj359Ehxmd9HRFzbCFeUi6Fy4j
NODIOMLVjOtJteuSElXLL/QT6qvTW3MzeZvVgMkwyk2b7KRstXLpHF4FRVeBdVA+
ln9k4PsZ537AJ5Ia/Q/S2fmJWAXg8DNuPyQXe7UBt3CA2EciA+GSVScRGa0ZE2Ja
ZbdWgWomJ7mAk3DMN7rH5KijKwaylIRJP7eJY8EvoS7rS9G9SMliEJ8Ygi91djOZ
1EHOxCVCro1qzCRjHSEWW6aNAFEVzP6r3cYKDQlP7wkT2n8JU5fmozozHGXcP6sR
cVBt/PZpa8hAgBjck0ho
=wWEw
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
