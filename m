From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 3/3] i2c: xilinx: Use devm_* functions
Date: Fri, 4 Oct 2013 14:04:06 +0200
Message-ID: <9b5a6672-2fd9-4900-b018-f044dee60646@VA3EHSMHS021.ehs.local>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1380550490.git.michal.simek@xilinx.com> <83ec9558211389896f21d9682e9824cd7979466c.1380550490.git.michal.simek@xilinx.com> <20131004053323.GB3194@katana> <524E8764.4030704@monstr.eu> <20131004115840.GB2994@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hoEOJgBKvn1SWB1wqjvd0xDJq7UWwe4U4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131004115840.GB2994@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--hoEOJgBKvn1SWB1wqjvd0xDJq7UWwe4U4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/04/2013 01:58 PM, Wolfram Sang wrote:
> On Fri, Oct 04, 2013 at 11:16:20AM +0200, Michal Simek wrote:
>> On 10/04/2013 07:33 AM, Wolfram Sang wrote:
>>>
>>>> +	i2c->base =3D devm_ioremap_resource(&pdev->dev, res);
>>>> +	if (IS_ERR(i2c->base)) {
>>>> +		dev_err(&pdev->dev, "Could not allocate iomem\n");
>>>
>>> devm_ioremap_resource already prints error messages.
>>
>> you are right.
>>
>>>
>>>> +	ret =3D devm_request_irq(&pdev->dev, irq, xiic_isr, 0, pdev->name, i=
2c);
>>>
>>> This is too early. Can you find out why?
>>
>> Why do you think that it is too early?
> =

> The ISR uses spinlocks which are not initialized by then.

And waitqueue too.  Ok I will keep that request irq in current location
and I will add xiic_reinit() below this code.

>> I am looking at origin code again and I think that the code
>> is also problematic because in xiic_reinit() interrupts are enabled
>> but they are requested later.
>> Shouldn't be there a logic that interrupts should be enabled when
>> interrupts are registered by the kernel?
> =

> First register the handler, then activate interrupts. You are right,
> this needs to be fixed, too.

Do you want me to create separate patch just about moving request irq in fr=
ont of
xiic_reinit()? And then devm_ conversion?

Thanks,
Michal


--hoEOJgBKvn1SWB1wqjvd0xDJq7UWwe4U4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJOrrcACgkQykllyylKDCEpCgCfQx6rbawV6CipaHhOJ4Dm/mQW
qwwAn3IpG6Gm+tuEG6XgZSlsTNMy8iII
=Htag
-----END PGP SIGNATURE-----


--hoEOJgBKvn1SWB1wqjvd0xDJq7UWwe4U4--
