From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-cros-ec-tunnel: Reduce logging noise
Date: Mon, 25 Jul 2016 22:45:16 +0200
Message-ID: <20160725204516.GB1698@katana>
References: <1469477464-28735-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54896 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbcGYUpW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jul 2016 16:45:22 -0400
Content-Disposition: inline
In-Reply-To: <1469477464-28735-1-git-send-email-linux@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: dianders@chromium.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> -	else if (resp->i2c_status & EC_I2C_STATUS_ERROR)
> +	else if (resp->i2c_status & EC_I2C_STATUS_NAK)
> +		return -ENXIO;
> +	else if (resp->i2c_status)
>  		return -EREMOTEIO;

Since you mentioned Documentation/i2c/fault-codes already: -EIO?

> =20
>  	/* Other side could send us back fewer messages, but not more */
> @@ -223,7 +225,7 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, stru=
ct i2c_msg i2c_msgs[],
> =20
>  	result =3D ec_i2c_parse_response(msg->data, i2c_msgs, &num);
>  	if (result < 0) {
> -		dev_err(dev, "Error parsing EC i2c message %d\n", result);
> +		dev_dbg(dev, "Error parsing EC i2c message %d\n", result);

For me, this message can go entirely, but I'll leave this up to you.


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlnpcAAoJEBQN5MwUoCm2IiYP/RJLmLV6qpxZs1VUvpbxfMdD
OxFWLyTW/r7g37QuB0OZZ+U8TgtpdqZQY3eUF0KY6sdkM7sDcd0giUceXwSyljvx
g+QDy9wiuX1is3fqjdmGkfjaK0Sz1LwD74yolmt7wkvpLvtMr1dkNiby+FdqHwV7
aWa4vSe37sG4ZvkWanQ6nfaRbYGBIeXO3Msku9EiJ2tX4lRhUkCwgz1HBCXNIujH
v8Yv7yo3SXvB2H0I8Pgo2X98Qt/gVz65hCOHIKBHe25qvSPRKfcGOeYIpC+4uZbi
JdQv3y8YNzNx4SH8eSr8FtFwBC0aOr49wYZC2RKUz/8RcKR2fQXdKXPYCfE+K/t+
BYVLrwnRZ6a44WaxRYxrw4h5Nwq2vtnGtExGntTclN/+AC14+jqsKh7FfFGAYLJr
4zIVD3T5U6YS6lhDFS36Z/lv/PutmqTXCFoy2QgYz/KLl1yjgITYUZWzJmq4V0XS
PaWFb+zMyarnOa9BQvgVa9GcvUiUcMh2rT/7cZI1h5CtdHVlIU1RChjJoheovqBR
+Q10ttgCeuJyZ1F96yBikPKafAhzvSckbyKptAX9+AKbjh7EBjWiopcNfoN20cdz
4aJ/0LDwMz55JzwdL1HDr9tSrcNdQ+Cfy50hMebBpxnMcWZY3rTktAuVBPOlK/AR
MKDcRN/EYUzqdjUD1WTe
=X8fa
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
