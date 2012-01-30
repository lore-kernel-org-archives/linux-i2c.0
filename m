From: Roman Mamedov <rm@romanrm.ru>
Subject: Re: [2.6.37 -> 2.6.38 regression] "mv64xxx: I2C bus locked, block:
 1, time_left: 0" every few seconds
Date: Tue, 31 Jan 2012 02:44:29 +0600
Message-ID: <20120131024429.2affbd1c@natsu>
References: <20120101042401.4bef017e@natsu>
 <20120101073255.GA2402@elie.hsd1.il.comcast.net>
 <20120108004502.GA20549@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4013045066879140383=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120108004502.GA20549@ericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, linux-kernel@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>, Manuel Roeder <manuel_roeder@gmx.de>, Michael Ott <michael@king-coder.de>, Rodolfo Giometti <giometti@linux.it>, Mauro Barella <mbarella@vds-it.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--===============4013045066879140383==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/d_beU1UD.wwpuu792r=2Ei5"; protocol="application/pgp-signature"

--Sig_/d_beU1UD.wwpuu792r=2Ei5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Jan 2012 16:45:02 -0800
Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> >  - Michael Ott reported with Debian kernel 2.6.38-3 (which is closely
> >    based on stable v2.6.38.2):
> >=20
> > 	syslog tell me every few seconds:
> > 	i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> >=20
> >  - Manuel Roeder reported the same and found that upstream v2.6.38
> >    triggers the problem and v2.6.37.6 does not.
> >=20
> >  - Roman Mamedov finds the bug present in Debian 3.1.6-1 (which
> >    is closely based on stable v3.1.6) and Debian 2.6.37-2 (based on
> >    stable v2.6.37.2) but not Debian 2.6.37-1 (based on mainline
> >    v2.6.37).
> >=20
> > The regression range described above seems a little inconsistent to
> > me, so maybe there's something more going on.
> >=20
> Points to commit eda6bee6c7e67b5bd17bdbced0926f5687f686d5 (i2c-mv64xxx: s=
end repeated START
> between messages in xfer). Maybe you can back it out and see if it makes =
a difference.

Hello,

I have just confirmed that the problem still occurs in the current
3.2.2, and is indeed solved by rolling-back the referred commit.

Should be noted that beside the "I2C bus locked" messages in dmesg, the des=
cribed problem
manifested itself in the inability to read the temperature sensor value or =
adjust the fan
speed on the D-Link DNS-323. On all problematic kernels the built-in fan of=
 DNS-323 does not
rotate and this risks overheating the device and disks installed in it.

Thanks.

--=20
With respect,
Roman

~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Stallman had a printer,
with code he could not see.
So he began to tinker,
and set the software free."

--Sig_/d_beU1UD.wwpuu792r=2Ei5
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8nAS0ACgkQTLKSvz+PZwhrDwCaAgcdz1dzLFwBNTf39vPNNLIQ
NbcAn13HOhNfCAUqoL2HGNsRhOGieZSg
=GrIB
-----END PGP SIGNATURE-----

--Sig_/d_beU1UD.wwpuu792r=2Ei5--


--===============4013045066879140383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4013045066879140383==--
