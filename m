From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v11 3/4] i2c: aspeed: added driver for Aspeed I2C
Date: Wed, 28 Jun 2017 09:45:15 +0200
Message-ID: <20170628074515.GA1550@katana>
References: <20170620211516.13095-1-brendanhiggins@google.com>
 <20170620211516.13095-4-brendanhiggins@google.com>
 <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
 <CAFd5g45=O2_MgfZEkmbY-=ZZY+izxeWSuhZT+B2e08P=O+WEog@mail.gmail.com>
 <20170627090042.GA2408@katana>
 <CAFd5g449iu6DGvMuP8-n8C6GBbr62G6_ZYS6Lh9038EB0XO9YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFd5g449iu6DGvMuP8-n8C6GBbr62G6_ZYS6Lh9038EB0XO9YA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> the struct i2c_bus_recovery_info. Is i2c_generic_scl_recovery supposed
> to be part of the user interface, or is it just intended to help put the
> main recovery function together?

Sorry, I don't understand the question. What do you mean?


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllTXocACgkQFA3kzBSg
Kbaeeg//SPK9le+UeP5TF7ffb7my1IPiug4r8BHGZncLLQyS/FLmCp8yai5KpYWV
oGFWrBnfnc/9kaHkrBXeyooCdyHKxIvYVarWiIoQsidM0Q9j4AD5J7edB9T31rGh
2PJvhLt5tKKK3G/W73rWa2a+SR2fRPbMKGnJffJjJaUXoVMtzO/b/gBrkuWJTTie
0UUlYm8TRDSW8IqtAJSxM10gU7a4lV5z9GGPrW+TmPm8/ezcqNjCZ483S+5+5izQ
vEtPJXIbeAxZcOGb0NhLmJVE6SQnh7aYBIMGpgbXzSuTEQzL20e+RuBUEJUOI9vP
C5kekSZzZHq7bTXg4pd1znCAnwTTvRb/OasqaeUZyj14N9LNWsDdZku3apLMauPU
nnsfdmihimfbcECcaaxXMkSTVzP00Biw7Pn+Wtu6H8ESnuswy0YrSq+16C0SR1E9
L5Wwvy5yyGGk2QCMpqgFfiCoRCgLhuHwN86qx1XTBBTe62PNqBiQIvn44pPykLQU
Uoj5azB2xM956j0bzTxN8AXcWUDPTRABe9HkG027KsEqgqisgOq7dmEG2rBcx2jE
cW2yCb+LawJQiR2XcSB6wen1dpYCOeQesDx8fSd3WLyy8Ln8aB1ftPT++Y3qmJG2
KkskjrjWfpEDa6fi3xBbrcQ+F95pBZNv2PDS0bCAZ81rCtq01i4=
=yvxZ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
