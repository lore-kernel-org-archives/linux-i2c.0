From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 0/3] i2c: mux: pca954x: Add interrupt controller
 support
Date: Sat, 11 Feb 2017 03:40:48 +0100
Message-ID: <20170211024048.GA1441@katana>
References: <1485307868-5408-1-git-send-email-preid@electromag.com.au>
 <8a11d374-a9f9-0e58-d01f-1cc72827c5e9@axentia.se>
 <20170210125205.c2gzgi65x4bi3eys@ninjato>
 <3632e933-6bc9-4d40-f489-1af958f0fd4b@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39860 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbdBKCrc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Feb 2017 21:47:32 -0500
Content-Disposition: inline
In-Reply-To: <3632e933-6bc9-4d40-f489-1af958f0fd4b@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> No trouble at all, and I'll certainly have a look at the script, so
> please send it my way. Thanks!

Some notes first:: sparse and smatch are probably the most useful for
kernel builds. spatch (=coccinelle) is nice, too, but needs quite a bit
more time for checking. cppcheck occasionally finds something that the
others don't, flawfinder not really. There are some false positives,
too, so you need to get a bit used to read the output. So, here you go:

=== ninja-check
#!/bin/sh -u
# wrapper to call various static checkers for kernel builds.
# Use: make C=1 CHECK='ninja-check' ...
# done by Wolfram Sang in 2012-14, version 20140514 - WTFPLv2

check_for()
{
	command -v $1 > /dev/null
	ret=$?
	[ $ret -eq 0 ] && echo "    $1" | tr a-z A-Z
	return $ret
}

# Get filename (last argument)
eval file_to_check=\${$#}

check_for sparse && sparse -Wsparse-all "$@"

check_for smatch && smatch --two-passes --project=kernel "$@" 1>&2

# Don't provide include-dirs since number of code paths increases drastically (#defines!) and '-f' checks all of them. Just suppress the warning.
check_for cppcheck && cppcheck -f -q --platform=unix64 --template=gcc --enable=all --language=c --suppress=missingInclude --suppress=clarifyCalculation --suppress=unmatchedSuppression --suppress=variableScope "$file_to_check"

check_for spatch && MODE=report scripts/coccicheck "$file_to_check" 1>&2

check_for flawfinder && flawfinder --minlevel=0 --quiet --dataonly --singleline "$file_to_check" 1>&2

# RATS mainly checks for dangerous functions. Not so useful for kernel analysis. flawfinder does string checking, too.
#check_for rats && rats --resultsonly -w 3 "$file_to_check" 1>&2


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYnnmwAAoJEBQN5MwUoCm2sK8P/RYAEXbDcvaTYHaUSeNP1fC3
AYJwZun6N47uJ1MXu6gmRCkXOV5395/HyRWadiogTESdIm5JA8K83ZO1UbXgOg1L
RkeDSBVj749w77QXOYxR0pfbE7/kaRg08ITByYwxQ4IZ7rrU8ysvnN+XjQRkEy1I
gGjSYGYMWQbcP2+l5Cxkxm5RvtEvqY5aYqGJzYQB1NtCZA92goPihALC0H9i6CL7
bHBdZCIT3THS0APSCDGc/6ADcgI2gDUsxsaJiy5++/70BWWgMsL+EmUfbb82hAqo
k5poUENbWJg/lHl62d6q1t2hPLZ16lMIcllrpMjzUTOXtk0SebwxxvLSej7KGG4X
Mew2Ok6pX3bUbmdl1YadRmKKp/qIRjpNygK2OSniguxhqQG11oBXHrzJzJRuAD/8
ex4HRQlsmUZ0Gqinr6CfdJ5w9vj0yhodmmvqYlI2kcHkwFOA/UQd+NwAyfqb8rF3
KMJZhOILivgfMabXTptVN82o9Sl8IbKCGk/bwO73FsoFasBR0t+3z2Sk1wQSae8e
sra/MVcKD7WComX8YR4tXH4KQ79ZGjNRFknMlidnN6wR73v99a+Q+OzC/9Eqapwx
Mi9M2O3Jg2IBrIia+c2Cc7Hb3Ds996uWFCM1O3PhNve6PO0pW8lJfN/RSKYFk0KE
gl3xpOqxb/cxcfqg3QTi
=xoJS
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
