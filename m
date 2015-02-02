From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
Date: Tue, 3 Feb 2015 00:16:57 +0100
Message-ID: <20150202231657.GA14881@katana>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
 <1412726809-7525-5-git-send-email-fkan@apm.com>
 <1894616.4yY7dajl4R@wuerfel>
 <CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw@mail.gmail.com>
 <20150130061118.GA995@katana>
 <CAL85gmD+0cJfZoWo8ujmjwy9yaKjNPjJaUm00Vrv5o9kcg-ozA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL85gmD+0cJfZoWo8ujmjwy9yaKjNPjJaUm00Vrv5o9kcg-ozA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 02:15:44PM -0800, Feng Kan wrote:
> On Thu, Jan 29, 2015 at 10:11 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >
> >> > ctx->dev is probably the wrong device here. The i2c controller is not
> >> > DMA capable itself, you need to have a pointer to the device that actually
> >> > performs the DMA here.
> >>
> >> Arnd, I do agree this may not be the best identification. There is no
> >> representation for this on the Linux side. I could put it as NULL. However,
> >> there are other i2c bus drivers that seem to do the same thing. Please
> >> let me know what you think.
> >
> > For completeness: Those drivers need fixing!
> I have some doubts. I could hack up a dts node for the helper
> processor that is doing the dma. However, the dma master could be
> anything for that matter. I am not sure how I can write this in a
> generic manner.

All I wanted to say is that, to the best of my knowledge, currently all
DMA capable i2c bus drivers which do not pass the DMA capable device
when mapping, need a fix like 8cfcae9f0595. So, the argument "other
drivers do it, too" is invalid IMO. You might have other, better, more
technical arguments for your case. Like above, that could be fine, I'd
say. But I leave this to the DMA experts...


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0AVpAAoJEBQN5MwUoCm29tEQAJjpiq+tFCrYqmYVq96TKDyK
mXHcwzc+VS4Y2n42ROiEwK9Z+By3qVPj2iddE1uK1FMXhWAvrlTFQfss0dE+8AP3
kl+dccyQ+YKD5wrACEfVaRF5zIcoieYqj7n0IAFp7oVOKMqf2L0juU9XeIMkFFrq
C8fpUP+r7sQ0raQ0O22E6HQ2VvaYIfVL2fipspkzaWJXq+I9dcWzWp+go8A6M6ab
WPPvg+2vCoSGeKvXUPSCvZh+QHIJWDWP/dtpgvW1rO/w0G4F3BmQX6vraCoedpsA
/rcmeq+qgck4VBwNDjPS9q+f5vR4ZW6LRg12VFWMiFNA9gbU8RF4V6hvnez/fRAZ
oHTYeVVTUAN3/VEMxn+mvJvQTZNMS3T2KeNwP5HCYgDurXZQ/Hq3sHItyQ/8J8TE
Fz9F7XzjIm9gsV1k94kequfl0u7vVcKe4SYKSQB99PwiiIkuHz276yu/ppfYEStq
AALGDyucPRv75kWozbljhaifuxgCTRkuv8U7S9+0IMsS7/TPkNWn2NvptEy71RZo
W/eBdln0AsBhY2lphxg+zJz/nmoSjF2H5E1WVN0l4Q96b4IbvXhO3eAXQ4wbxU6c
hBKosT+jifXJEoWMF7b8QZGwYH1ZurHBQ8ZhWQmdnl0W3kTuXcAGcNZcYdkZ6myV
Y+QjoQCKrdrLB5IgowMR
=bvLf
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
