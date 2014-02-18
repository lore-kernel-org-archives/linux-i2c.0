From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add message transfer tracepoints for SMBUS
Date: Tue, 18 Feb 2014 21:54:18 +0100
Message-ID: <20140218205418.GH18768@katana>
References: <20140109214954.25590.73057.stgit@warthog.procyon.org.uk>
 <20140109215002.25590.51609.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140109215002.25590.51609.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	TP_printk("i2c-%d a=%02x f=%02x c=%x %s l=%u [%*phN]",

Although SMBus has no 10-bit addresses, we probably should also use %03x
there for consistency reasons?

Also, the I2C tracing has first 'f' then 'a', that should be consistent,
too.

'flags' should be %04x again and I'd prefer %*ph (or %*phD) for the buffer.


> +		  __print_symbolic(__entry->protocol,
> +				   { I2C_SMBUS_QUICK,		"QUICK"	},
> +				   { I2C_SMBUS_BYTE,		"BYTE"	},
> +				   { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
> +				   { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
> +				   { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
> +				   { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
> +				   { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
> +				   { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
> +				   { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" }),

Can we have something like this for 'flags'?


--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTA8h6AAoJEBQN5MwUoCm2SyYP+gNwnURGdvvxBjg8CCKGd3bQ
E8I8WI38dha8WabEfEDY1dqdWhFMoziFHmZf3ZCV380+CSsF1f8xPW1VEF0WCJvO
Ot37VdfStMqGZHYA/G08nm3I1Oi8VoJmlo+9EHXSSswntfbqkK2rsHjOeHc08CVb
aiMgkmdcEt4nYRgbbtwRK6XCFFitAEB7wHkgDz2Lt759ZL/XLfk1smRaUlsVTWsr
FcknrjjFcZExsRF8Fj6YrUipMtXRkPusoh9sXOUvYMenRjgjWX2sIKtFqKgaZIcb
GbFXD0GrWNRmmvq3SAEDLvVA+eAzBxjVm4paVgPlE0agtdY8fHmt2Kt2QhWEFQuz
S5ZrKyX07xXH+azkEzUmVxCVQWs94SpKOsLqLHS401aOcqHk2V8QVB7GXuR38Uih
1rhd5Z4EkiOl5ps+Tsl30Tlrh9hAzJWqEH7hMGAmoVaWUtMFOzsOhX18xLwEuGLJ
wzV3EpPfkRSC/pPcdOaZ9830R2a6DKVJQ9dlfh6jg+wIvvJVidfhBGbk7Y8Yyml5
6j+RyhZIYhhf3eHqm9Vkw3LCwYZDvONIkDH9oB8jjmHfbQySN4ixy8LttiITdp35
j/QSLSNQe16sNgNBDTjYvAry/f37Ly5HvljYfk9bVSP4LgnSD8Ui3pMNyXk2gBMM
SWVx9PK4WjmkzQM+nWUb
=waza
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--
