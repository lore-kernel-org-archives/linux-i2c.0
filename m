From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
 without a stop bit
Date: Thu, 4 Feb 2016 21:09:03 +0100
Message-ID: <20160204200903.GE1958@tetsubishi>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
 <20160124112915.GA1775@katana>
 <001401d15988$59f6dcf0$0de496d0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001401d15988$59f6dcf0$0de496d0$@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Ah, so what I meant above is there is no 'STOP' bit between each msg in
> i2c_msgs,
> but 'REAPEATED_START' still holds true.  We are sending 'START' bit for each
> msg.
> So these is how each msg in i2c_msg is sent,
>
> |------MSG1--------|-----MSG2---------|------MSG3------------|
>
>   |START|DATA|------|START|DATA|---|START|DATA|STOP|
>
> If my commit text does not make this clear, I  can reword that ?

OK, now this looks to me perfectly fine: A number of *messages*
concatenated into one *transfer* by repeated start. That's the way it
should be.

So, I'd simply remove these words:

"The QUP i2c hardware has no way to inform that there should not be a
'STOP' at the end of transaction. The only way to implement this is to
coalesce all the i2c_msg in i2c_msgs in to one transaction and transfer
them."

This sounded like the HW needed a special handling, so I was under the
impression REP_START was broken. However, unless I misunderstood
something again, this now sounds like the standard case and we can keep
the commit message simple. If you are okay with that, I can update it
here, no need to resend.

Thanks,

   Wolfram

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWs6/fAAoJEBQN5MwUoCm2l9EP/2YW4P7Q7WjD3s5W8Ye8dwuA
lEuDYPqy/qPBib0jptWt+X0x0m2FCG3G0WCJMItdJIJQkxR1AgIBW41xtuvKxRGx
HHduonZ67IO60X3OAWNo3c5D1eY6WAb5uoJ6B6LRITLk9pQ7BLrDCzk+yKM3OpKu
7CYZo8uh+4JaF5zdatAuXwciNTTs4eczrW72y25Xbj2nAgIED8ls5rB+D1rF9oyT
HzOUJcWIxVFuTWTC5ScGugHhcsLFKU7AIYHikJfl1+pa9VTGAdO754gndeNbCpcf
SbGxBRyvS8m0DGgn6e7+eVq5fsO4YL2lknBKTXFjvTsQnh7X/6JQISVNWW1si1sN
WX23ddSV/E+ZTDEyFoIqFTV1VjyEXmSXPzcO7QdCTBzaVB37bakyQA0awMIMyr+9
XLRTKYwZ2bWOMalG8JbJtG9PAXdrgYLrwV8ZTDWrRv+NsFzXNvvse7ptuwsjboek
rrX11gJWyqve5DZJFuO2DT444LrKxzP6UlY1mN1HbeH5YsW+RMTbpFXq+hgGxOE5
WHYCxZlo+2tmK6ygSB5t/pLBSit7GgvvAz7hKdCARLoRgq+iGNs2XNexKYWXb5qX
NNDdPBMgvKWs2hzy6S9LY9e+vrjnZ8cson6lXDHtRUm8F3ekfI/w1IKmUG1HESTx
MrwVfaeVdfFmhf8XBbBy
=mQ1m
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
