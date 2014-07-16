From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: autoload i2c-dev module when needed
Date: Wed, 16 Jul 2014 19:14:57 +0200
Message-ID: <20140716171457.GC2759@katana>
References: <5390279D.4030404@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5390279D.4030404-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal =?utf-8?B?TWluw6HFmQ==?= <miminar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Adding Jean Delvare who maintains i2c-tools to CC...

On Thu, Jun 05, 2014 at 10:17:33AM +0200, Michal Min=C3=A1=C5=99 wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hello,
>=20
> we've got following request (viz [1]):
>=20
> i2cdetect requires the i2c-dev module be loaded so the appropriate
> /dev entries are created. This is not done automatically, so when
> i2cdetect is initially run it gives the false impression that no
> buses/devices exist:
>=20
> # i2cdetect -l
> # modprobe i2c-dev
> # i2cdetect -l
> i2c-0	i2c       	i915 gmbus ssc                  	I2C adapter
> i2c-1	i2c       	i915 gmbus vga                  	I2C adapter
> i2c-2	i2c       	i915 gmbus panel                	I2C adapter
> i2c-3	i2c       	i915 gmbus dpc                  	I2C adapter
> i2c-4	i2c       	i915 gmbus dpb                  	I2C adapter
> i2c-5	i2c       	i915 gmbus dpd                  	I2C adapter
> i2c-6	i2c       	DPDDC-C                         	I2C adapter
> i2c-7	i2c       	DPDDC-D                         	I2C adapter
>=20
>=20
> Attached is a patch that autoloads i2c-dev module when neccessary. If
> you like it and have commit rights, push it please instead of me. If
> you don't like it, don't hold back and tell me.
>=20
> Best regards,
> Michal Minar
>=20
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D913203
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>=20
> iQEcBAEBAgAGBQJTkCedAAoJEPezUylxRFUDExAIAJzpGhv0O0U4zFCkzz9wH1cM
> mJOzW6Pu/Xnxk/x9e5f5RVG3BIrieJueRbzU/nh+KHqWbvEV/8DOtQ6KVV3c4Sau
> Deocg/QqdpMH1UasVIio2iUyuBJS/RvhclJOzo05cDhLfyo5bSp7ixLBwwcjlY4c
> UeXcTq7OPID5B4bpZzs2R7T2M81FG3wdI8GcqTNthQahLnCa0XbxEbyGZn2XaiVD
> 51AeADzmD5OTCPfQFmYq87MW/S101O+GEJJwXb/DngHh2mIVnur0JiDnABdB+Pl4
> ysgqooMOMol2blcUQmkwwLzkJ3ArE3MGvjGVtqFBOsI5VSpWsapGa6TdFeYm0UY=3D
> =3D4tFG
> -----END PGP SIGNATURE-----

> Index: i2c-tools-3.1.0/tools/i2cbusses.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- i2c-tools-3.1.0.orig/tools/i2cbusses.c
> +++ i2c-tools-3.1.0/tools/i2cbusses.c
> @@ -37,9 +37,15 @@
>  #include <dirent.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#ifdef USE_LIBKMOD
> +	#include <libkmod.h>
> +#endif
>  #include "i2cbusses.h"
>  #include <linux/i2c-dev.h>
> =20
> +#define BUFLEN 512
> +#define I2C_DEV_MOD_NAME "i2c_dev"
> +
>  enum adt { adt_dummy, adt_isa, adt_i2c, adt_smbus, adt_unknown };
> =20
>  struct adap_type {
> @@ -60,6 +66,70 @@ static struct adap_type adap_types[5] =3D
>  	  .algo		=3D "N/A", },
>  };
> =20
> +/**
> + * Try to load i2c_dev kernel mode. Do nothing, if module is already loa=
ded.
> + * Returns 1 on success, 0 otherwise.
> + */
> +static int try_load_i2c_dev_mod(void) {
> +	int err =3D 0, loaded =3D 0;
> +	char errbuf[BUFLEN] =3D { 0 };
> +#ifdef USE_LIBKMOD
> +	int flags =3D 0;
> +	struct kmod_ctx *ctx;
> +	struct kmod_list *l, *list =3D NULL;
> +
> +	ctx =3D kmod_new(NULL, NULL);
> +	if (!ctx) {
> +		snprintf(errbuf, BUFLEN, "kmod_new() failed!");
> +		goto done;
> +	}
> +	if (kmod_module_new_from_lookup(ctx, I2C_DEV_MOD_NAME, &list) < 0 || li=
st =3D=3D NULL) {
> +		snprintf(errbuf, BUFLEN, I2C_DEV_MOD_NAME " module lookup failed");
> +		goto ctx_unref;
> +	}
> +
> +	flags |=3D KMOD_PROBE_APPLY_BLACKLIST_ALIAS_ONLY;
> +	kmod_list_foreach(l, list) {
> +		struct kmod_module *mod =3D kmod_module_get_module(l);
> +		err =3D kmod_module_probe_insert_module(mod, flags, NULL, NULL, NULL, =
NULL);
> +		if (err =3D=3D -ENOENT) {
> +			snprintf(errbuf, BUFLEN,
> +					"unknown symbol in module \"%s\", or unknown parameter (see dmesg)",
> +					kmod_module_get_name(mod));
> +		} else if (err < 0) {
> +			snprintf(errbuf, BUFLEN, "(module %s): %s",
> +					kmod_module_get_name(mod), strerror(-err));
> +		} else {
> +			kmod_module_unref(mod);
> +			++loaded;
> +			break;
> +		}
> +		kmod_module_unref(mod);
> +	}
> +
> +list_unref:
> +	kmod_module_unref_list(list);
> +ctx_unref:
> +	kmod_unref(ctx);
> +#else
> +	err =3D system("modprobe " I2C_DEV_MOD_NAME);
> +	if (err < 0) {
> +		snprintf(errbuf, BUFLEN, "failed to execute modprobe command");
> +	} else if (err > 0) {
> +		snprintf(errbuf, BUFLEN, "modprobe command exited with code %d",
> +				WEXITSTATUS(err));
> +	} else {
> +		++loaded;
> +		goto done;
> +	}
> +#endif
> +	if (errbuf[0])
> +		fprintf(stderr, "Failed to load required " I2C_DEV_MOD_NAME
> +			   	" kernel module: %s\n", errbuf);
> +done:
> +	return loaded;
> +}
> +
>  static enum adt i2c_get_funcs(int i2cbus)
>  {
>  	unsigned long funcs;
> @@ -206,8 +276,12 @@ struct i2c_adap *gather_i2c_busses(void)
>  	   i2c-dev and what we really care about are the i2c-dev numbers.
>  	   Unfortunately the names are harder to get in i2c-dev */
>  	strcat(sysfs, "/class/i2c-dev");
> -	if(!(dir =3D opendir(sysfs)))
> -		goto done;
> +	if(!(dir =3D opendir(sysfs))) {
> +		if (!try_load_i2c_dev_mod())
> +			goto done;
> +		if ((!(dir =3D opendir(sysfs))))
> +			goto done;
> +	}
>  	/* go through the busses */
>  	while ((de =3D readdir(dir)) !=3D NULL) {
>  		if (!strcmp(de->d_name, "."))
> Index: i2c-tools-3.1.0/tools/Module.mk
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- i2c-tools-3.1.0.orig/tools/Module.mk
> +++ i2c-tools-3.1.0/tools/Module.mk
> @@ -15,6 +15,11 @@ TOOLS_CFLAGS	:=3D -Wstrict-prototypes -Wsh
> =20
>  TOOLS_TARGETS	:=3D i2cdetect i2cdump i2cset i2cget
> =20
> +ifeq ($(shell pkg-config --exists libkmod && echo 1), 1)
> +    TOOLS_CFLAGS  +=3D $(shell pkg-config --cflags libkmod) -DUSE_LIBKMOD
> +    LDFLAGS +=3D $(shell pkg-config --libs libkmod)
> +endif
> +
>  #
>  # Programs
>  #



--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxrMRAAoJEBQN5MwUoCm2VkMP/0wQ0CVX2Jtfj6vu/dov1hD6
nYV/IH/spQxj6OiMSU/tWmrr39/sxGzvDC9HUBqSPMF1i7GF57LT2EGe794tPeX1
hovqoc2js6E956XPtsbGAOBYXVLuaO/sAG7i1ZQ6eJ9dQIPD8LiSAljlR4+cnx3w
G7G8wqLdchkJDgp/cM+zlefGURFn8qiisD9ntz1tx+d6sba6JzFeTru9hVgIqsc5
wn1YrjDjvKMKAu3szHsELVZxGZ1mTCVbnDIwYdSPIGdp1+UMOSzzUMVcqK/VwOw0
V2YP1duXiCYZO32TTpdArP5ghPy5j0cE/QjYGF24LAAoMOow4+dHx3H9a1697M73
rgaWDzqHi1Kw5Bm6hkSc9cvK+Fjyp3nidg84O9ErAYZI60J7/cUnyythsl212eik
npYCCLttUbtrQchd4Pd9PaJ4wnAuWMObmNF7UJHvZMUk8attOZWgKrQOBh2cU0YO
G4Z3wQvGDTS9SEWggvQ9ATvyOmly/6pMITlr+Azu9G6G2/n/phrPeQOrZUsbm1eq
LTcacVRSZ5ssBT8qpYKQjbkisS2aoFNpMD7ZXNJLLcyP2pz26eLW96JLE4OqgZMh
L6TdKpRHF+1KTGL60G+p5oRo7WnZvddCyBuBoOgvw9c2tJxYwbtOyLOOg42BEUI9
Z679JFisLSmlIUzpdJIG
=l0os
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
