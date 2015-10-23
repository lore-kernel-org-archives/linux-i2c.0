From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Date: Fri, 23 Oct 2015 12:07:49 +0200
Message-ID: <20151023100749.GG13380@katana>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <131418014.1WnDGNUZcn@avalon>
 <20151022110505.GB1572@katana>
 <1917001.aD8sIkvx7f@avalon>
 <20151023080601.GC1642@katana>
 <CAMuHMdUQCBUyFWO1Jm7BqEVb2kC4v6pKpSrwdGytCuS=d-oZDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34523 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbbJWKHx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 06:07:53 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdUQCBUyFWO1Jm7BqEVb2kC4v6pKpSrwdGytCuS=d-oZDQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> -                               error = true;
> +                               return ret;

Yup, did that, too :)


--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKgb1AAoJEBQN5MwUoCm2go8QAKGVL3GePRft33KGRwxV+LZx
NmQkqo4Je02IdlzLQJIVtc7wBf/7uSXHxir6CUOCCg28oW7+VHallfI+N8RKBYMz
vMPRzkrl7bXaPZROFPmo9VWnIDNhJxJ6sTFvQylEifkrMna7yUNhQiHjb8aU0cNO
KkcnGDue3yGfwY7l276yRxv1ZmUhbnlkEZfIO+c6r4b49fppjIPSEUh/3lMjvGE7
iYSXXkz1opig3VqTlk5vsSCQlvIgQXpnDb1lVPx9w3SOejzX+IixzzTq3+E9PZUu
gW7xDOyWZitgsnxPIX+e8Bm0nogxVIlxudMiCm3QcwzKDSaMqRbMGhNW4n+Jknuc
ARvG6omNQ1EHzPUPy4f8ckZKQmFqnkp62x4Go4RY9tsHsAlzYIGJGmIONsIreeI6
wfyE77dbcnDkbuLlNJDushFg8lvf6mUhr3Gp/YS9O0U2wqMGh6ksObY6/jSK7KkU
Xy3aRUEcNQl1ZC8lYMOJ7k18yuTc5gmUNXEPO4MIN8SbFiw1Dqz5MwRAMY8UI/PB
XLhhUyQOgT4Z6yfWQ1NcN7YC18bjGmpCGATeNfh4Fju/bWdDxgEoFZoIC2u8nxRg
6i/pVULlVehU3/2y9n/3kVBEViqW1hsT+lrHF604La93Rzm0Ci7ELRN6S8tCoOob
n3L3BTP5rt9Rbnsq9nhH
=ylsU
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
