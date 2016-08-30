From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: designware: save the preset value of
 DW_IC_SDA_HOLD
Date: Tue, 30 Aug 2016 22:59:40 +0200
Message-ID: <20160830205939.GF3645@katana>
References: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41651 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbcH3U7x (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 30 Aug 2016 16:59:53 -0400
Content-Disposition: inline
In-Reply-To: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Zhuo-hao Lee <zhuo-hao.lee@intel.com>
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 27, 2016 at 03:39:30PM +0800, Zhuo-hao Lee wrote:
> There are several ways to set the SDA hold time for i2c controller,
> including: Device Tree, built-in device properties and ACPI. However,
> if the SDA hold time is not specified by above method, we should
> read the value, where it is preset by firmware, and save it to
> sda_hold_time. This is needed because when i2c controller enters
> runtime suspend, the DW_IC_SDA_HOLD value will be reset to chipset
> default value. And during runtime resume, i2c_dw_init will be called
> to reconfigure i2c controller. If sda_hold_time is zero, the chipset
> default hold time will be used, that will be too short for some
> platforms. Therefore, to have a better tolerance, the DW_IC_SDA_HOLD
> value should be kept by sda_hold_time.
>=20
> Signed-off-by: Zhuo-hao Lee <zhuo-hao.lee@intel.com>

Looks good. But is it a bugfix? Looks more like for-next material to me,
but not sure...


--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXxfO7AAoJEBQN5MwUoCm2lN4P/R2w8U5NAhEMccMGWaWTpesO
XH24cJ8ZfKtUYVJmU9SF+lQT6/B4FhqBe2XHEC2I1wpLHCXmAkAtDx8pEdIW/Hi7
X0LXlk665u50FaTfWazB8LtW+GEgVWDvAisR3PxgxhT/8+7g5S0SRtGAT5NDRLS0
+LBWlpMUI0X9yaUevhEYlVBIDANtXa2/ZKcgiRErYKHhL1orSmEj+gexTF92zOLn
pTU4Tr4mT3jdFp7qBc7ZmpyzP2A8qx9vf/PeF0ZL9ncWa2nG4TOTTzilpMHpnuMV
G7abg5F/IHuc5QAyp1d0aG9nzMbmPj62UtVpXyLl5b9CI3vm3//46bSS777RcbO6
ccME1mHQ+6FAOK3OdOxftw4P4ZZCSWBcorTtpPyRhjlXt9Kx71rznXQOL72/eBsS
avpaGb0TDyC+p3ZHBxkwP/w3XM6K259sIo3TBJRcLkFqsVCSFWdgr4zOlXvi+Ya4
NzTxtCj3vXnlLCWjXD0+G6Ehe+Q2GCpfZ1yN0CWmWVT7P0Vq2fFCaYI/DGbLIqs2
rURNwtKRqvPkxaWfuBtUCaeqq65aEztKanSLNpYmZVEItnsbCLXTuDxy7sn5jYEk
/F+gT4440BdGcWDEiptf3PrwFjq5kterLgTPW0r25ac4WIeNaSqMibLC7g+hnCU2
1CbBvi86bgjQiuyn/2DR
=WcG1
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
