From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2 0/2] drivers: i2c: qup: Some misc fixes
Date: Fri, 13 May 2016 13:44:36 +0200
Message-ID: <20160513114436.GH1778@katana>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 06, 2016 at 05:01:12PM +0530, Sricharan R wrote:
> One for fixing the bug with CONFIG_DEBUG_SG enabled and another
> to suspend the transfer for all errors instead of just for nack.

You haven't stated what was changed in V2.


--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNb4jAAoJEBQN5MwUoCm2LNMQAKVZxV7uA1RNk7Z1aIT3TzoX
bb7+ZU2/Am9mreamhGOWCYCS0etyNGwY6msb1L0HAZX8iB3syC+L11cDUxJLCH5C
kSY/g994r5I5NZggONmEjeIxQ+J+qXyqOKj1ewE2Q7x0W/8ZWsp03uhdc1wLL6TK
n+ZUH8Cg5nbBFK04Z3sejBz91s1JmvzLP0LwSIJpNxLlsOOjfGJrX1V+FG7tNGxG
HaSRV8pnc+38LU3ph3oSOt4D3hjX+G5qtAI8eWWYolHNTPtYGXnJrXx3500devrn
dbBHCDeJr03fh1oLTP/AeqnoLzZ0MmSg5ucKDKQaT6fXBPnhzr3WnujLB+u6TN3+
kGKAWtaFj/ayIEciKIkiR0WojT5fLVjH322vMLrDw+728zylkGewUSUgC5P+PnJB
QAXHisiIrnJQkkqMaPXQ9PUJPchEHhorqsN18iAvoqZWZF+0AyR3PbALZF2SbtCC
4CegQItlKxSr6zyLEsKkKsRW/+1Ywu4gg+h7qvICPzm5mIfM/cFr7cgotd5Tk70S
VFXel7DK+Y/l0yd6A57c4ln2cPY7/U4jFsibPAbFdwdrOlBj1+fGmSZCmqEiU71z
x8RabflG4iiOi7DQmiwF4Btt1doeiTY9mkPtHtHA+ofeuVRy15pJwua3aWTTdPC0
JQzJr2TAH4rqDq+2egLb
=Tp76
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
