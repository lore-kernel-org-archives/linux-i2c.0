From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: iproc: Support larger TX transfer
Date: Fri, 12 Feb 2016 20:33:08 +0100
Message-ID: <20160212193308.GS1520@katana>
References: <1453940842-9658-1-git-send-email-rjui@broadcom.com>
 <1453940842-9658-4-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NAmHCRPXNp23hR9r"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:59338 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcBLTdM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 14:33:12 -0500
Content-Disposition: inline
In-Reply-To: <1453940842-9658-4-git-send-email-rjui@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>


--NAmHCRPXNp23hR9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> @@ -293,7 +360,7 @@ static const struct i2c_algorithm bcm_iproc_algo = {
>  static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
>  	/* need to reserve one byte in the FIFO for the slave address */
>  	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
> -	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
> +	.max_write_len = 65535,

You can simply remove this line because len is u16 in the i2c core anyhow.


--NAmHCRPXNp23hR9r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvjN0AAoJEBQN5MwUoCm23NoP/jhfVQztNC80MOpch2X3xgtw
j7V9duay7ifpY6iRN2RvNSMKOtuHNMv49dbPl57zSxqgZUrTFvCaeY+fHU1SDN0J
18EexSYBFxhWj91l0PLsxmey7uuVc8qOOJQwWsJhK6GLEt94CKASP7AAJR8jCGgA
BHQqMgDQoDb2iip1l3iG4k6jR82NyWdKWpsMbctemAoruDiqj+LlR8S4/Q0Jrwrf
NJ83xV0oJielNbKmxwTjAqqhHFKErLt9TzQaZFLl42i7+VhlezWuSEhDxGPHHu19
X+Q8gDYbjaPXQv93Pf5xY9KHjyaonQl5P0Ybxu1rgl/J+OW7u9JvjsWUv5Di4ta5
aGed7FU8Pr5ASaZJhPAmq3JldjvfmZ9LmrNr17omQ2uebkMbaT2KEzivWqdOFTRZ
50TQ5vsThxqHAbAyN+c31iQRJLT7onw58u3P/2sjTIqjUPVRWeSz5dE05myICzGS
7rm8G84Kv9zIk0/OQso9ni1NiJeiPhcUFGd5pM77/fSRYffVStpVd4Wi8ulftcKo
b/Zhu0zlBpgWxQ8yqPGxBeaaWfFXHxHeszIv1W5CSZGnKDYJBPn5w5ehZdoS5Jx3
wkNTyf5gudfgheNdbVmT6HqDHFRvD+mdIrMhSDbL/56cMFKLWeWVlLyc+GdivegQ
y4WSDzAS44agJ/lIwKYn
=NBcH
-----END PGP SIGNATURE-----

--NAmHCRPXNp23hR9r--
