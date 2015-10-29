From: Kevin Fenzi <kevin@scrye.com>
Subject: Issues with touchpad / touchscreen on yoga 900
Date: Thu, 29 Oct 2015 11:29:13 -0600
Message-ID: <20151029112913.1036f00b@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/PREgogt+uX+bnyEzXjCc2wT"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from scrye.com ([75.148.32.185]:53474 "EHLO mail.scrye.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbJ2Rhk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 29 Oct 2015 13:37:40 -0400
Received: from voldemort.scrye.com (voldemort [10.99.3.2])
	by mail.scrye.com (Postfix) with ESMTP id 60175658010
	for <linux-i2c@vger.kernel.org>; Thu, 29 Oct 2015 11:29:17 -0600 (MDT)
Received: from voldemort.scrye.com (localhost [127.0.0.1])
	by voldemort.scrye.com (Postfix) with ESMTP id 52FC921E56
	for <linux-i2c@vger.kernel.org>; Thu, 29 Oct 2015 11:29:17 -0600 (MDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

--Sig_/PREgogt+uX+bnyEzXjCc2wT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Greetings.=20

I'm having problems with a lenovo yoga 900 not seeing it's touchscreen
or touchpad.=20

Downstream bug:=20
https://bugzilla.redhat.com/show_bug.cgi?id=3D1275718

The problem parts of dmesg seem to be:=20

Oct 26 15:20:08 localhost kernel: i2c_designware i2c_designware.1: i2c_dw_h=
andle_tx_abort: lost arbitration
Oct 26 15:20:08 localhost kernel: i2c_hid i2c-SYNA2B29:00: hid_descr_cmd fa=
iled
Oct 26 15:20:08 localhost kernel: i2c_designware i2c_designware.2: i2c_dw_h=
andle_tx_abort: lost arbitration
Oct 26 15:20:08 localhost kernel: i2c_hid i2c-ELAN21EF:00:
hid_descr_cmd failed

This is with 4.3.0-0.rc7.git1.1.fc24.x86_64 (post rc7 4.3.0).

Happy to gather further info or try patches. ;)=20

Thanks!

kevin

--Sig_/PREgogt+uX+bnyEzXjCc2wT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJWMldpAAoJEEs3sNgP+7teLrMQALLKFB5DtnXro7YcRDQvzszD
63FDOMcRP+8Ogu508UDgLAP5FTShWyNpmFuYK1reWuhlSl/VCvowML0i9iydjRCB
yTKjTkXRQ1sLvzhGoPyHjhYi1C13fecvHSdpkgUoyvT5aj+L5AZXL5lEjBNh91bJ
IyCrTKDbq7bWKYAK90+dLZZbc40Q5ul58LoxDBUL7jj0E4gRgGpPPzk+VdkY5NnV
2h9UQ/cCI9kLVaen92FbEEAIV1cYZ9554ja4wARgxEqROFIxCq1MCfaRYbkQ3ywY
KurvtFpuBGfuqwlDYsv9qnYBKd+Km1qo1KtmnuHkEdSjz9Y/2C4+lOfB0Yuy98yM
t3vW5wO28Ux1C0Qyip4XIV5kQrbORbqm24Il9z4P6O/LnxsTO0jkqmMTV1SC00+T
AAaI31KJrzC73nQkfL86tZQt9Xcl1W1giUV06pJnrG2nA2Zn1Jx+e5LQ/MvydKZ2
4nIPvjQod4etQIoiHQc6mZnf0CtR+OM2qaxOyQHzF909gr/HSwSN2hlAF/b8EUlY
gH5C8kW4CX05rjbHbTwcyhtJmjIpE0TkHJTokro8mVu/ZyzeHHJn9bPq6wxhjz3O
0V7U4RUcvznR/RyzOu3llWiVjAJiWSNSFTpHYpf/GQUxKeZyfdV4+/XXaVBLK56T
bZOTPPl2rjBzRqCT2OIB
=fImT
-----END PGP SIGNATURE-----

--Sig_/PREgogt+uX+bnyEzXjCc2wT--
