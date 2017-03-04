From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: lis3lv02d i2c access on shutdown
Date: Sat, 4 Mar 2017 23:32:22 +0100
Message-ID: <20170304223222.GA2386@katana>
References: <647cd755-3554-0719-6811-c64ffae0fc1e@revolayer.com>
 <33dcfc02-67ef-ba6e-30a6-e2cd26aa9f71@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:51790 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbdCDWc1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 4 Mar 2017 17:32:27 -0500
Content-Disposition: inline
In-Reply-To: <33dcfc02-67ef-ba6e-30a6-e2cd26aa9f71@tremplin-utc.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?utf-8?B?w4lyaWM=?= Piel <eric.piel@tremplin-utc.net>
Cc: James Maki <jamescmaki@revolayer.com>, linux-i2c@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> >issue with i2c since other drivers have the same design. What I don't
> >have is clear understanding of if/when/how i2c_transfer() can be called
> >post kernel_power_off().

Not sure if it is exactly the same issue, but last year we concluded
that we probably need an optional i2c_transfer_noirq callback in
i2c_adapter to talk to PMICs very late or very early. No work has been
done so far, though. I hope I will find time for it this year.


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYu0B2AAoJEBQN5MwUoCm2rb0P/37TjVztL4Ah/YFJxqRU6rUi
PV1Olzxrf9w7YhoFH0gSCevtIn1n5/igDycal0qDWEwtbqX6MWbHo/rNcxuRIHVV
4Gb0zjGZAW3FW43q70qwmdZo59qxsR2puCUxTD4xE6PCTFb0FbfHE/Mix1K2E0xg
lkMHlFTCP88FPWpUlDBL8nVv0R4qW3JDuBG5/jI12swJhsJJChnsIrzFuvPNgJJA
RQ2MDWlQKOr5XpqgySBHj0Sd9MRXyEJASztKrzOJFdq2ii4/QanpndX2bTo5EI6R
zDUiJd8R0atCuRPQ0nWWVSJXXwADsoVColhCCT4i/T1SO8rY4EBa3yZQt0rD1yxj
/zD7pMff4O0H9vlLM0ooPwvYQai1gcBcCrCUX3fK1OWerOkeoy29D08CSPeIPATI
usQxR0fQb/Yy/yXQ6luDrXm7BK58NFnonAged+wqGw3ywgF5/AC0Vjsbjxlv7lV2
m1uaK/SyVsmp6GUNn3sqWpjuqnM9JT7ZALVxbfMJAmk+aghq0EKAUH1Zz64vB+VL
Y6tAU5oAwFx0zMxQSVZmhTpeb7L+A30Wlx91ErDWhXH3q2CxAbyGF9d4V2LwOaeU
vBON1TBtGq0ehhKjlDkS1vn1MquRrOWMzqNQcSD0BjIquKBQbw4qFSOG5utGjriZ
v2zS+h5tb1/ZEcGI14+6
=qlGO
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
