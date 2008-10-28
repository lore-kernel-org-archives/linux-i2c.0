From: Michelle Konzack <linux4michelle-qCYv2r+mE47ltxMxsNcu6w@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Tue, 28 Oct 2008 21:27:31 +0100
Message-ID: <20081028202731.GC4653@tamay-dogan.net>
References: <48F2A270.8060307@leipzig.freifunk.net>
	<20081013092548.3d58a320@hyperion.delvare>
	<gd3fe5$11e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2604858685782415745=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <gd3fe5$11e$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============2604858685782415745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Andreas und Hello *,

Am 2008-10-15 03:01:56, schrieb Andreas Seidler:
> I only want to monitor some voltages in my wind-/solarpower system and dr=
aw some
> nice charts - nothing spezial.

Why not use a much more cheaper

    Dallas 1-Wire chip DS2450
        Quad A/D Converter
        with user programmable input range (2.56V/5.12V)
        resolution  (1 to 16 bits) and alarm

I use it on my Solar-Power-Plant in Morocco with 1300 modules of  130 Wp
too...

And of course you can use the Kernel Bitbanging-Interface if your Micro-
controller does not have a 1-Wire port.

Note: I was ongoing to use only I=B2C but now I am using  a  mix  between
      SPI, I=B2C and 1-Wire since I have realized that it is definitively
      impossibel to get the needed =B5Chips form one system  and  in  the
      same time cheap...

Thanks, Greetings and nice Day/Evening
    Michelle Konzack
    Systemadministrator
    24V Electronic Engineer
    Tamay Dogan Network
    Debian GNU/Linux Consultant


--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/
##################### Debian GNU/Linux Consultant #####################
Michelle Konzack   Apt. 917                  ICQ #328449886
+49/177/9351947    50, rue de Soultz         MSN LinuxMichi
+33/6/61925193     67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFJB3WzC0FPBMSS+BIRAntiAKCVYyFYA0JUOccHSCdgromrWAL1AQCeOp9w
TPAtfnfSpogEYU1diHatQso=
=E6mE
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--



--===============2604858685782415745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2604858685782415745==--
