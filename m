From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] i2c: rk3x: fix bug that cause transfer fails in
 master receive mode
Date: Tue, 2 Sep 2014 13:01:59 +0200
Message-ID: <20140902110159.GF1266@katana>
References: <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
 <1408730452-3552-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1642549989427065302=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408730452-3552-1-git-send-email-addy.ke@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: huangtao@rock-chips.com, dmitry.torokhov@gmail.com, heiko@sntech.de, sergei.shtylyov@cogentembedded.com, yzq@rock-chips.com, zyw@rock-chips.com, max.schwarz@online.de, dianders@chromium.org, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org, xjq@rock-chips.com, linux-i2c@vger.kernel.org, caesar.wang@rock-chips.com, olof@lixom.net, cf@rock-chips.com, hj@rock-chips.com, zhengsq@rock-chips.com, linux-arm-kernel@lists.infradead.org, hl@rock-chips.com
List-Id: linux-i2c@vger.kernel.org


--===============1642549989427065302==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2014 at 02:00:52AM +0800, Addy Ke wrote:
> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
> must be less than or equal 32 bytes at a time.
>=20
> Tested on rk3288-pinky board, elan receive 158 bytes data.
>=20
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> Acked-by: Max Schwarz <max.schwarz@online.de>

Applied to for-current, thanks! Please don't send new versions of a
patch as reply-to of a previous version.


--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBaOnAAoJEBQN5MwUoCm2dMIQAIJTTUnFg+LST4rb9omcbLxI
gO+HC27P8x2AznVbqPHv8fEOeok2Sjvff58QKpjbQtc3c+86EBCnNAMgRa/QQ5/0
ZLRuGDYaCqFMqAXwMz3giDYJmeZrwVGKM3ME4Fm5UfnTg+aMKdSUB2V1V5WTYMPE
5vWVizuWGohhn5rq8OPHUt2c4WFJLn+cDzxwrzl3F/QaOARs7YkELPsYmr8xMpJi
I+1+y0y+hRcdcM7pnlys+wcQIpgTty6RR/E+2eF/9KsIFhpT57RsvCr0ZeT1tE2L
60zEwJLPPXUJEPqvcRMNia8LaL9wk1b9q4R8i0B2wKJhb3/T/A7WVmkhFBoynQqi
RR1rT6XrE7BKdojqaxBzcaMZwH2Kakhz75T/DhSL8gu1oXSVwp/QsqohWoC/X/IH
rsMi0sOKAJGluYxF3VBngGLZzAi7hhvx2sKhQOpkUNMfdsNZKzqYjJrxdUFvKUwr
M04ZQmwCAoqUF8ojmKx9KmXMx1rgroVD4wQn3gi64DpuytQ6in+m6caaBAALqxL3
0/5SEDSy74xOAxOstu868ax654ckonshCH/6smYy/ZJ0846buXJizLdbPEi29mkO
HZc02FIvww0f9q48HGfSYEJxnhFVOlThOroVPM7i3O5DEhsdOnExy6YEv316LylN
FFBlhiX4cO7G2c/+3TNx
=wiRz
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--


--===============1642549989427065302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1642549989427065302==--
