From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create "channel-n" symlinks for child segments
Date: Sat, 8 Nov 2014 18:51:17 +0100
Message-ID: <20141108175117.GB4900@katana>
References: <1415363764-10821-1-git-send-email-wsa@the-dreams.de>
 <CAAVjN7dR0DYmuGOeMtVzsf-K7zsxXEY=jrGg_+V4XuyZhcyfiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAVjN7dR0DYmuGOeMtVzsf-K7zsxXEY=jrGg_+V4XuyZhcyfiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 07, 2014 at 11:47:37PM -0800, Danielle Costantino wrote:
> Just tested it and it work well for me. lsi2c (a tool I have been
> developing) was complacently unaffected, I will be releasing it as an
> open source app soon.

Thanks, can you check this patch ("[PATCH v2] i2c: mux: create proper
topology in sysfs"), too? I sent it out a second ago.


--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXlgVAAoJEBQN5MwUoCm2jQwP/0oB2Y5YFVy+/gkFs/YSLVhI
GuYfRJyVufqCieK84FYzAlF0tsVRiS5yCdF/7Ff+wMjhTZwOf5GSAYPpjIfa3elK
wirr5Gz7yRxt5ECX4j6J2EJV6yCDndglIHWQ6yxHlPGb6sf/5K1klfh4w4hPY4wQ
FiaxFKAcpK7mKge1QTZrCbyjkolLIHrY7pQQNNRhpKmFTri9grO0qapVAK1ZGlzK
93MnvQYq4xsLbHkjXQbh8KGPVCyeMD2mUyvHYIVDpacMwDnhKL3n82Za5/811EP8
7nW4/u2i/ZEvsn+807MWwU/VBh5ZKrJkpbBp382qepl8UzBrgBZ5g1N77IubCu7/
bC5sT1+WUC5keiVjC9QpjiVF2b89a4h1wMtnvImvdDV8krGoxrqre3rvCOVVFg1x
UBrwZQ4uHfuQ2+fNB8EiBOLgtZMPj9ut3E3ZLFUNTFTRLw7ZQpHTGpfzOEkwX7Ol
JC42bQZTF0GS0BGPpcCKAc11teAbxZGA/HBraQtsNSp8VA8PrANFLcUPjHL3m2LB
oYTOtY0TkL0y3wMFjOhZvurVH1RYr/FPMINQ5din64Z3uw0R4w7PQQqjyRV+wMMV
pLeMMMZJ1ekFOuvxLiWl85iY/vqbhihVeSNJIWan5MemUfVp66Y1I8bX1tDxTvk2
oz9T0gIsc2MfKlJfakSe
=nJ+k
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
