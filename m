From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 01/18] i2c: guarantee that I2C_M_RD will be 0x0001 forever
Date: Mon, 11 Apr 2016 18:54:47 +0200
Message-ID: <20160411165447.GB1532@katana>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
 <1459709101-24462-2-git-send-email-wsa@the-dreams.de>
 <1459765571.2503.15.camel@linux.intel.com>
 <1459765801.2503.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59659 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbcDKQyy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 11 Apr 2016 12:54:54 -0400
Content-Disposition: inline
In-Reply-To: <1459765801.2503.17.camel@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Ah, overlooked it. Anyway, perhaps worth to mention under
> Documentation. What do you think?

Unsure. We can add it later, I'd say.


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC9bXAAoJEBQN5MwUoCm29rIQAJokItEJrJgIVMi5Hj/zcCy0
bYHyIUsXyfh7hXWXY8IPho+Zb4w4tXqNiOu5CnUP+kFjt+H0emICfq5qKKvqBCAZ
jCvjNEnxF+DWG+WqTiGcciMUewXutQO4OHbkTMz06JsB4x9haA5nLeHSd+v0HL0D
EmbFFfxJLUzrSrwcnfE3duPXWMyy43xs8kha/Izez3ign3AL24Jwh+KTKn82nx16
iQWAs7lDGPAXx1ZGnv1FLPkDPhOAZMLuZ53yhn3sktS2YOLR7ynavoGr9LPKvYoE
72nIxhdqVZDJdKvywQJy3iJb4MpR9YGFY39k4azEnYBEmHC204qQ/Exn40eDGtfX
adxsQhjDV1HSqBi/5Iz+g1F1OdrgjMl3g8BRXwK6bwKRy77E1iiKg+uCcUuVFZM+
7a/9IajTh+zqKUC6aSIvMNVFboEMNXIfeDpFd45bWI7l1GI+Zumv01tRlKy0eoEl
cwRBRlbE532PgMfVPcVuHcNwnpgt5MjcBLyw9v+Z9MRzYnHhuDoMgA4jmeh6UJzo
eeW3IqL5t5jQkTw5FPjo2wUkkmh+fYoQjy9k8gxrXzj76fyWIlI/uvCtWcwAd2Pt
3t2tVI83iw56KaaaX3VSNAvnI6PA7zlN5rQJjjvclhhJ0vuHexmQ9S6BeGdxB9xn
s6/AnrPfkULVNTmnLhkk
=7G0a
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
