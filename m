From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] i2c: bcm2835: Set up the rising/falling edge delays
Date: Wed, 21 Feb 2018 14:03:28 -0800
Message-ID: <87h8qayp8v.fsf@anholt.net>
References: <20180208135405.25446-1-boris.brezillon@bootlin.com>
 <20180221084259.o6754bfe4k2hcwhj@ninjato>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1185528046222770871=="
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180221084259.o6754bfe4k2hcwhj@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============1185528046222770871==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:

> [ Unknown signature status ]
> On Thu, Feb 08, 2018 at 02:54:05PM +0100, Boris Brezillon wrote:
>> From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>=20
>> We were leaving them in the power on state (or the state the firmware
>> had set up for some client, if we were taking over from them).  The
>> boot state was 30 core clocks, when we actually want to sample some
>> time after (to make sure that the new input bit has actually arrived).
>>=20
>> Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>> Signed-off-by: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>> Cc: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>> Hello,
>>=20
>> I'm reviving this patch that has been posted a while ago by Gerd.
>> It fixes EDID retrieval on some (broken?) HDMI displays, but I'm pretty
>> sure it will fix other I2C setup.
>>=20
>> Note that I also tested the change with a regular I2C device and it
>> worked just fine.
>
> Applied to for-current, thanks!
>
> Could you provide a Fixes tag if you think this should go to stable?

It would be a fix back to the start of the driver, but should apply
cleanly back to:

Fixes: 9446f62e8e18 ("i2c: bcm2835: Add support for dynamic clock")

and over a year ago seems like plenty of backport.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqN7LAACgkQtdYpNtH8
nui3TA//fP4/RRo/zSMmUCIZchiRfqEAGWKnAGTltlkcHG/D9HNUGi89idnINYNK
pO2it3sOIdIOpJp2SL9S41p7nEuIlYKkN3nm2SoL3Ms379PTuWhibOm78ZkAeb5S
8ZaGYXlObhUJdPznNnbh4MdfCCwtIKuZMNR/iFZ4tSsqUe6In3RoHUEREFvxrnKB
wBPQTOhpLy5d/t5dot8k/3+VaabO2q0ZVihxK1Y1ZQVAzL6xOudRHLgFPsGir0fC
9Rgb9tdGKuXY6BAwuAqHn4g/gg+/2B/yn3AjsXXhEgs4M00CHI9JzN50gk+N1nuh
Lpd3L5g9Xitua7+XODTbf/WtcWvH0K/ma8OxizPAML/jfL6TIcQ4riSSgAcs8wTq
mVjka8+AjJPB1AHpPZeLlRfNiM31EiLa9rvYWYRCHwD2jj/s/opfphQQjVpJlKzu
DjmPPUXVzW7pABEhlXUQ79aL383MX3oIw2r8WlmQPAYbmA+NRy4Vxh51WM3shj72
bTbrsoBN6oSAF8QWkcnHO8sUWbZtgu1D3nJUGPTugIYgwd6eBWB7y2DFDejOKYB6
fhCZoqhHEDhUP9kE4U3UrrHlEUUM557uL5mj9sDOmAb1W69QjLQdd8g4xoVl+3dS
xJhnBPjste4H1XTUSsj8mKU+mnYhIDlWhiFvmJGCfgqyweepBcM=
=Fx5C
-----END PGP SIGNATURE-----
--=-=-=--


--===============1185528046222770871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============1185528046222770871==--
