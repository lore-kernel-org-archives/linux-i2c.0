From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: Revert "i2c: xiic: Do not reset controller
 before every transfer"
Date: Fri, 20 Nov 2015 16:14:29 +0100
Message-ID: <20151120151429.GC1752@katana>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>
 <CAKfKVtGqPPP=bnWH4dPLT1=gjrvZe=0zmix58SKBT79MsR+CXg@mail.gmail.com>
 <564AD886.3060108@metafoo.de>
 <CAKfKVtGFfKw8nJO5RobMtBrtS7dX-m4i+tuYHkNJd0+j2w80Lg@mail.gmail.com>
 <564C4C94.6020406@metafoo.de>
 <CAKfKVtEYaKxC7P=MW7Dh=dOQOwEjmJLQLH_fKy9NGq0OQSktKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59780 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162559AbbKTPOd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 20 Nov 2015 10:14:33 -0500
Content-Disposition: inline
In-Reply-To: <CAKfKVtEYaKxC7P=MW7Dh=dOQOwEjmJLQLH_fKy9NGq0OQSktKA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I think as of now since read is also impacted we can revert it.

I read this as Acked-by.

Applied to for-current, thanks!


--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTzjVAAoJEBQN5MwUoCm2mw4QAKb77zng2/lG1FGNdW3nilqy
5MB0SMGtQMshmwUdWdfAkGQMMdIW57jSonMwI0760Xb12OBjDjc/0xdl8zu4/3oK
45qG/T/06lVd38NhfPn/4lDqeUCWwqZ7EmAkzngdDfB1VdiCbPtq9NAfLGQv/Wsq
jcbiieVzTOrV6KkBx72aU4uUJRDDQNCu8aqPjO0GosvlDO+ize1I8+VQH0aRM3hR
kUdW63VYottjHQuJKOhbVRroMEGVRQonOWYbO4Nd+9510d09o0XU+dhJw1I82qDt
h/BbTl/fQoXxskTGmR/HaeMt9ODBCeTqP/LfG2Qwa+GqDOA2FbTsmqtU7S/wNzTE
CF6B0G6qncmZEb/OPpXtDH7ehoUX7tIOn5QAUeQk3j/HPCgeuAYmHRGA1RoPd30J
/8DtaPwIYwcEVKcdFOt4T7EcEp4zCKgCa16bJqClyTn2CEvE29/x2XgwaBDG7l/n
ZpepyDynRrN/aIKXL5pgjBEf4HWec6PoexMRao/Xc3wRiFJbsx54mI4bVkSXsDwS
U9FIuybO1MZXKghxy5YcFFi4RRL6noXJbmPgDc5cqh/Ftq7O+VDcwx5CtQmBOYkI
nWSFUVqTxnuoIY+brjyxl1XcLDOzFjhNpwvsdaFAdCfe3XpezIqDc7tclIOa9kHm
+zRzGLqzMDS0L202deS2
=J92j
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
