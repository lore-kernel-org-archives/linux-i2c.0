From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
 without a stop bit
Date: Sun, 24 Jan 2016 12:29:16 +0100
Message-ID: <20160124112915.GA1775@katana>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44882 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbcAXL3Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 24 Jan 2016 06:29:25 -0500
Content-Disposition: inline
In-Reply-To: <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> "If this is the last message in a group, it is followed by a STOP.
> Otherwise it is followed by the next @i2c_msg transaction segment,
> beginning with a (repeated) START"

This is correct.

> So the expectation is that there is no 'STOP' bit inbetween individual
> i2c_msg segments with repeated 'START'. The QUP i2c hardware has no way
> to inform that there should not be a 'STOP' at the end of transaction.
> The only way to implement this is to coalesce all the i2c_msg in i2c_msgs
> in to one transaction and transfer them. Adding the support for the same.

So, there will not be a REP_START condition on the bus? I am sorry to
say that I can't accept this. A REP_START is a REP_START and nothing
else. There are devices which will get confused if there is no real
REP_START condition.

Without knowing the HW in detail, can't you implement I2C_M_NOSTART and
let the touchscreen driver use it via regmap? That would be the proper
way (from what I understand).

Regards,

   Wolfram


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpLWLAAoJEBQN5MwUoCm2l+AQAIgY4+l/7rEBOcC6kUTlPoJo
5hpuGyigAoiJfHir9TaO6LkjKnM4ouhbVjV1AOfHVhwR7q3CvHcpKV2tWxJ6ymJr
snrzRr2akAoB0pVssZLxyE4OOJjEBx+ZVt9/cE+UhWYdWIlEI8JlbELcVFxKGMZv
4+b3Ee52k3SJRX5XQODDlZqoDxF5mBjBASZtjmTlI7IMFY12kqRZIdE8I9m7yGRO
KL+rkl9ZfZPHiSRfdwTRDyVr0iU88t72+FSo7a2qk0/1YOyRkdtXaOo3YRMlCWxq
Bdjl18aGchequPsvRbTlP3RV9jinrmx4E3P6DSmqapwTnA8rZl+SrFRbcnqvq01y
4lQe8J/2vJCnCXTCzhF8o4zm1GD5eBLwdHGIUumOXH85LvZspU0nMgKOkRhgHtW+
+XGoy4d9MxjoyM/1aqa3SPsa+Aew1FKJT32vchlxwUAdiMIPyupqP6tK5778HfKY
QG78Eb/jJEtLZkJCU8XwkH68kgOGeY/6e6mPcBPbFt7ek5L3SMr30Nk2KXz3RFYN
OIRj+TUYLwIjoPUs01bmgBMMEJx9BwAzlkM/SxT1Jv8tw+nGD/AJmyIDDhX0sYz/
KJAcaiX6txLgEkUmQSr7HvuMkQShG70lzt631wlI3NwzgehN9CYHyZtKpeK7hBpg
NYojpudFdMxXS+tj3vGT
=+daC
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
