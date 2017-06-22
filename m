From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: cadance: (bugfix) ctrl/addr reg write order
Date: Thu, 22 Jun 2017 15:26:11 +0200
Message-ID: <20170622132610.GB3820@katana>
References: <1498095926-51264-1-git-send-email-matthew.weber@rockwellcollins.com>
 <20170622083546.33glkhns4hlodrbe@ninjato>
 <CANQCQpbmhfD0jgW2bQm6hjR_CTJiPHbNE_jfU9uicH7PVd6xjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:55838 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753104AbdFVN0S (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 09:26:18 -0400
Content-Disposition: inline
In-Reply-To: <CANQCQpbmhfD0jgW2bQm6hjR_CTJiPHbNE_jfU9uicH7PVd6xjg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Matthew Weber <matthew.weber@rockwellcollins.com>
Cc: linux-i2c@vger.kernel.org, soren.brinkmann@xilinx.com, John Linn <john.linn@xilinx.com>, Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Not urgent, fell free to work it in where it makes sense. We're on a
> older LTS at this point and will carry the patch.

Okay then. I'll add it to 4.13.

> For the Fixes: tag in this case, should I just prefix my last
> statement about the issue as there isn't a public bug report or
> specific commit I can note?  I could add cadence ref manual section
> and a link to a public download of the doc.

The Fixes: tag is for specifying the commit ID which introduced the bug.
So, all stable kernel versions having that commit ID know they want the
patch carrying the Fixes: tag. I can look it up as well, but it makes my
life easier if I get it provided. No worries!


--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllLxXIACgkQFA3kzBSg
Kba9vw/7Biyh6iD46wt5mDSkpfN9k4AjBYcU7xBQZmCjzEmUMIp/+wa+tlm3w3Gp
4JbCgURKfYaCRRnHBw/OvAMM5tNrMGzhJ9QcGnLqYM0jIE8SrJsDVeFjbu8MJy08
JG8JwUd1598A/EO2tWV3dFva4cbOn0WTVQ255NjuCnraa2sxuzGYwRLtnZ6dQrn+
KKnTxZ88bCIkg2zf42rjgSOxeniZAmPDAUIO9KS4CWg4dorYWPJUEZfyaMkRWRTC
vX2qBgQN7znxzfWQoHALYgtise8PE0sPHZRWm/FlpYYNRhrwR3+ssgB/wVYrY35M
Mo/RxGiXl8OmChHYPpzQxa8PuoBBKC8+TEqfiRyQ+omd3XNbrwgTnia22XTg4T9Q
Rsue87sY1azaD92TnM7cSNEHmEt0QtR1hsfygLe7HSKBMgnHt0pMoBzLsGTNoMay
IrSYI6CD7w8sJkIUrVuZwp4nRnWBpfb/s5SzV673t6dunBQvnuDadKLwL/pTg6Rw
Pc9Tp5CNJG2vI0gdTM+onIaCLgE1q3lWvQgFDEctcJsLc+DrEPt2YKO8x9a6aN+t
F02m7yICKWMtF14t6Ms4C0yngYBBdnKhqBFBc0luEd93LW8fuAJ/2nydazKycswq
ltlnajmNLOZL931LYCayXLiH7Kj9LFwzbq2cC1Rqso62WvFXWo0=
=AiUq
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
