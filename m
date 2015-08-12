From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Wed, 12 Aug 2015 10:43:52 +0200
Message-ID: <20150812084352.GA1524@katana>
References: <5582870B.7030304@nokia.com>
 <558288B0.1020706@ti.com>
 <5582F049.8070407@ti.com>
 <20150709195309.GI4744@katana>
 <559FEC8C.9030603@ti.com>
 <55A00E56.2020308@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A00E56.2020308-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 09:26:30PM +0300, Grygorii Strashko wrote:
> Hi,
> On 07/10/2015 07:02 PM, Sekhar Nori wrote:
> > On Friday 10 July 2015 01:23 AM, Wolfram Sang wrote:
> >> On Thu, Jun 18, 2015 at 12:22:33PM -0400, Murali Karicheri wrote:
> >>> On 06/18/2015 05:00 AM, Sekhar Nori wrote:
> >>>> On Thursday 18 June 2015 02:23 PM, Alexander Sverdlin wrote:
> >>>>> According to KeyStone Architecture I2C User Guide,
> >>>>>
> >>>>>                           module clock frequency
> >>>>> master clock frequency =3D ----------------------
> >>>>>                           (ICCL + 6) + (ICCH + 6)
> >>>>>
> >>>>> i.e. "d" in i2c_davinci_calc_clk_dividers() should be fixed and
> >>>>> not dependent from module clock prescaler PSC on these SoCs.
> >>>>>
> >>>>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> >>>>> ---
> >>>>>
> >>>>> RFC: If someone from TI has an idea how to improve the coverage of =
future Keystone
> >>>>> revisions -- hints/patches are welcome. The current ID check is bas=
ed on
> >>>>> Davinci/Keystone datasheets and is at least working on real Keyston=
e II.
> >>>>
> >>>> + Murali who works on Keystone devices in TI.
> >>>
> >>> + Grygorii
> >>>
> >>> + Grygorii has been involved in the Keystone related enhancement and
> >>> reviewing prior patches. Need to have his ack for this change
> >>
> >> Any news?
> >=20
> > Fixing Grygorii's e-mail id.
> >=20
> > Grygorii, let me know if you don't have the thread. I can forward.
>=20
> Thanks Sekhar.
>=20
> My opinion - it's time for compatible string :) "ti,keystone-i2c".=20
> Especially taking int account two things:
> 1) In Datasheet SPRS893B TCI6630K2L Multicore DSP+ARM KeyStone II System-=
on-Chip (SoC) (Rev. E)=20
>    values for those registers specified as:
>    0x0034 ICPID1 I2C Peripheral Identification Register 1 [value: 0x0000 =
0105]
>    0x0038 ICPID2 I2C Peripheral Identification Register 2 [value: 0x0000 =
0005]
>    (actually the same is in k2h, k2e Datasheets).
>=20
> 2) This is not the first time such discussion has been raised.
>=20
>=20
> >> > This is not really critical fix. Currently bus rate is lower than ex=
pected because of these
> >> > calculation errors. The fix maximizes the bus rate. So newer SoCs wi=
ll run little bit slower
> >> > until support is added to this part of the code. Not really critical=
=2E=20
>=20
> Regarding the patch itself:
> - Seems the "d" value is fixed to 6 as per User Guide SPRUGV3
>   "KeyStone Architecture 2 Inter-IC Control Bus (I2C)" and this change is=
 correct.=20
>   It would be nice to have ref on document in commit message as above.
>=20
> - I think, it will be very useful to have same real digits/calculation me=
ntioned in
>   commit message which can show how valuable is the improvement.=20

Alexander, any comments to this feedback?


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVywdIAAoJEBQN5MwUoCm2beEP/Rr8Y9WKnHRjngKhZa1tcACT
B6L3DiEzhb0K318tFl75EL+MIJ41nVdFq4x+Q2UEMuHGePH+y2oEuysosnGb6XN+
bn1yk+CvCVJ/fTRwp9YqjlnErKyAPH2SjsyN5bVLnSYih+/3hkqiCjZRNNAMgIfe
3M06AlDjV2S+10lgbe6VAxpT+kIhvdqQPP4lRIvVy2nLuskiVOqZxQlwXxOUturQ
nwOmswAR+T7oxaQYcIafGLenCC3XJddDSFYuSpbsAbzR5pZGs7jXaQPGnogCnSot
jh9ozrOcgHFJry+BE7IAFBaLGltv4i//y/kPkE78iUsKBBn3HjUVIDKXnanz61Y9
ESdJJkwz5PXq8EzVhclHk/4iJxVGu8n3BpSQ1bLcaYYKFTGouDG/cJTVD0HsgM1Y
4Iuhr2XulTHLH9YkBXKMKrDoJ9UiXsTH7SSQMBcr26MT5RuPkjqUlAa/m+Ge+E+T
mAhs1z/zk691rNSc80DFNeng04Jf6LtUy7Snz4QqKTfCHYVKgOX04x+QZD1Nbk5X
kld2+8IqMvWLcPytghcOKzWfm/EmXGFRH85oBoNMHVHVMSWsaPqbg66F9qBFVgFd
IukRJbFMSyVbWQK0dGldQ5oZW/dlA5nU6pIK3GQEuexTLYTqSEddMTOB7B5dhRvT
3yWuq0PJsAhCOAhD992q
=ZYuu
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
