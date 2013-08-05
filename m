From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Mon, 05 Aug 2013 13:11:09 +0200
Message-ID: <51FF884D.5080009@free-electrons.com>
References: <1375219237-9594-1-git-send-email-marex@denx.de> <1375219237-9594-2-git-send-email-marex@denx.de> <20130805103647.GB9694@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130805103647.GB9694@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 05/08/2013 12:36, Wolfram Sang wrote:
> On Tue, Jul 30, 2013 at 11:20:36PM +0200, Marek Vasut wrote:
>> Analyze and rework the PIO mode operation. The PIO mode operation
>> was unreliable on MX28, by analyzing the bus with LA, the checks
>> for when data were available or were to be sent were wrong.
>>
>> The PIO WRITE has to be completely reworked as it multiple problems.
>> The MX23 datasheet helped here, see comments in the code for details.
>> The problems boil down to:
>> - RUN bit in CTRL0 must be set after DATA register was written
>> - The PIO transfer must be 4 bytes long tops, otherwise use
>>   clock stretching.
>> Both of these fixes are implemented.
>>
>> The PIO READ operation can only be done for up to four bytes as
>> we are unable to read out the data from the DATA register fast
>> enough.
>>
>> This patch also tries to document the investigation within the
>> code.
>>
>> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>
> Thanks. I'd love to see Acked, Reviewed or Tested tags cause I know ppl
> have used these patches. Don't be shy :)
>
>

It was on my todo list until now.

Tested-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

- -- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJR/4hNAAoJEKbNnwlvZCyzv0gP/1/ED0u/HwbJFU6mxi3ALpLB
NJ/RYMlmU+u+4FlNzlAEYBPSIp/2IFhgmTLnf+t1E3VsvjZ0mchYZwp/3IH/Z4X5
HAx5X0/mJ19Nqlq7ARuQvKaF+i7IQxOY61GybxX8W7gvHOL2FXufZFdVh+KjRFDY
rOnxgugCF473iZ7YUA5p+qJo9H/uJKaUcHQO56yUJkA3BOM4MVWztMUI0wuICg9H
Khq4zKuL6/qXsL1fz3sT5L1pUUYUZFUt75pz1zIYvovEOg+Bk3kSHz2xRQPYHXJ2
UzTDANNnaIEkh9ZzuNoVywOb3Qme9QLufD/ju29QYmOZvVBuTo9oSgdxuZGZ8Wxl
u6y02wp3y1zWXhHc2nvOAyWOWYiYvIJrn7dkvMhLmiJbc941gyJdnOgutsKZlBnu
atPOVt1muj0sz0wTHe9UvpSqQf18T8kKdtjh+VyI8px5OWfjc7FmJVOPHTUwZ/UV
obzNskq/MAFoib/hd6hU3raDpRDQYBmgVet1HHyhWHObn2SC8hRLTwIoZ5YHo+pH
SZ62nGJmeVm1Bfk10jUrmWQ7NEMiDEJR0wnGiCmZm3x/fwXe4Gu8eiDKZxYeLCJO
zytXpNq3yW+2KuxMvwfsiVJ3kHx6GGHWVLtSLuCV1Nqmw4bpXdOuGGPdLLjgu7Nx
w8pZ+BZpzDDmXtZGPXNk
=3+JD
-----END PGP SIGNATURE-----
