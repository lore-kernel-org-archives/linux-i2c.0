From: Michael Post <michael_post-S0/GAf8tV78@public.gmane.org>
Subject: Re: Driver-Support of I2C_M_RECV_LEN
Date: Fri, 04 Jul 2014 09:38:30 +0200
Message-ID: <53B659F6.4070005@web.de>
References: <53A42321.5020701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A42321.5020701-S0/GAf8tV78@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello together,

Am 20.06.14 14:03, schrieb Michael Post:
> Hello,
> 
> in the documentation i found at 
> http://ww2.cs.fsu.edu/~rosentha/linux/2.6.26.5/docs/DocBook/kernel-api/re1222.html
>
> 
the following sentence:
> 
> "Note that using this function requires that the client's adapter 
> support the I2C_FUNC_SMBUS_READ_BLOCK_DATA functionality. Not all 
> adapter drivers support this; its emulation through I2C messaging
> relies on a specific mechanism (I2C_M_RECV_LEN) which may not be
> implemented."
> 
> The second sentence says that the mechanism I2C_M_RECV_LEN is not
> all over implemented.
> 
> How i can figure out whether this mechanism will be provided of my
> driver? What is the alternative of using the function
> i2c_smbus_read_block_data?
> 

does nobody has any clue or hints for me?
Maybe there is an other mailinglist i can ask?

Thanks a lot,

Michael
-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.22 (Darwin)
Comment: GPGTools - http://gpgtools.org
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTtln2AAoJEFF6fE6T32A87NkH/3f2pslue7/oYiIiZ8PlKway
C9hOI02EEX0Z+sxB31ZTMyis2VxGFmZ3VGp4sSpiPv2iK9huMYmeVV0a2a+J0MLg
wmObCFRUZVN85lLqau+nEuqNMHSVYpYedHovC3Ui3rTHZNDM3pWJSDBy5dFG57d2
TE6Jae6Q31/hRn8gq106XmRdtYgKmzCfmfjRwYyBt0tYH2vQ43xhJQ3zGZCuKJ5O
xjY4em5jLWv+oiWi/HAkXFqfC4GskklBcn77K9TDEuw+oXkeF8Re4JPmvOBKxrQA
O+a246FVyyrKHs7VKXXAORX+Ty/q2QtP+dbFk9M0Uo0M0Xi17QhJ8TsUwQViFV4=
=gIOJ
-----END PGP SIGNATURE-----
