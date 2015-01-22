From: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>
Subject: Re: i2c-tools: add compatibility for python2/3 to py-smbus
Date: Thu, 22 Jan 2015 14:28:10 +0100
Message-ID: <1421933290.21840.1@smtp.inria.fr>
References: <CA+TH9VkT1K2aqAuNOLsGiU407OA4NYcMVaUakEQgSWLpMBBg2A@mail.gmail.com>
	<20150119230327.0224d0ba@endymion.delvare>
	<1421917018.21840.0@smtp.inria.fr>
	<20150122114958.3178f5f6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122114958.3178f5f6-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks a lot!

It was a linking problem. I applied the patch and I it works for both=20
python2 and python3.

=46or those who are interested you can choose to the python version wit=
h=20
the PYTHON variable:
make install # use "python" so it depends on your system configuration
make install PYTHON=3Dpython2 # for python 2 explicitly
make install PYTHON=3Dpython3 # for python 3 explicitly


I have only tested read_i2c_block_data write_i2c_block_data for python=20
3.2 and python 2.7.

I think you can push these patchs upstream.

Thanks again,

Michael Mercier

Le jeu. 22 janv. 2015 =C3=A0 11:49, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> a=20
=C3=A9crit :
> Hi again Michael,
>=20
> On Thu, 22 Jan 2015 09:56:58 +0100, Michael Mercier wrote:
>>  I just tried you patch and I got an error when I try to import the
>>  smbus python package:
>>=20
>>  import smbus
>>=20
>>  ImportError:
>>  /usr/local/lib/python3.2/dist-packages/smbus.cpython-32mu.so:=20
>> undefined
>>  symbol: i2c_smbus_process_call
>>=20
>>  Any idea?
>=20
> Hmm, OK, I think I see what's going on here.
>=20
> There are two i2c-tools branches: the stable branch (3.1) and the
> development branch (SVN trunk.) The patch I sent was for the
> development branch.
>=20
> One important difference between the two branches is that, in the
> stable branch, the i2c API is implemented as a set of inline=20
> functions,
> while in the development branch it is a library. I don't think that
> py-smbus was properly ported so most likely it was already broken
> before my patch. I suppose you are using SVN trunk and this is why yo=
u
> have this linking problem?
>=20
> If that is the case, then maybe the following patch will do the trick=
:
>=20
> ---
>  py-smbus/Module.mk |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- i2c-tools.orig/py-smbus/Module.mk	2012-04-26 12:05:55.351086796=20
> +0200
> +++ i2c-tools/py-smbus/Module.mk	2015-01-22 11:47:06.524806243 +0100
> @@ -12,7 +12,7 @@ PY_SMBUS_DIR :=3D py-smbus
>  PYTHON ?=3D python
>  DISTUTILS :=3D \
>  	cd $(PY_SMBUS_DIR) && \
> -	CPPFLAGS=3D"$(CPPFLAGS) -I../include" $(PYTHON) setup.py
> +	CPPFLAGS=3D"$(CPPFLAGS) -I../include" LDFLAGS=3D"$(LDFLAGS) -Llib=20
> -li2c" $(PYTHON) setup.py
>=20
>  all-python: $(INCLUDE_DIR)/i2c/smbus.h
>  	$(DISTUTILS) build
>=20
> But please keep in mind that my python knowledge is non-existent so i=
t
> might be plain wrong. Hopefully Angelo can comment on this.
>=20
> --
> Jean Delvare
> SUSE L3 Support
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=20
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
