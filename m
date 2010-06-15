From: Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org
Subject: Re: [PATCH 4/8]drivers:tmp.c Fix warning: variable 'rc' set but not used
Date: Mon, 14 Jun 2010 23:49:49 -0400
Message-ID: <9275.1276573789@localhost>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-5-git-send-email-justinmattock@gmail.com> <21331.1276560832@localhost>
            <4C16E18F.9050901@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1276573789_4860P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Your message of "Mon, 14 Jun 2010 19:12:31 PDT."
             <4C16E18F.9050901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--==_Exmh_1276573789_4860P
Content-Type: text/plain; charset=us-ascii

On Mon, 14 Jun 2010 19:12:31 PDT, "Justin P. Mattock" said:

> what I tried was this:
> 
> if (!rc)
> 	printk("test........"\n")
> 
> and everything looked good,
> but as a soon as I changed
> 
> rc = transmit_cmd(chip,&tpm_cmd, TPM_INTERNAL_RESULT_SIZE,
>     			"attempting to determine the timeouts");
> 
> to this:
> 
> rc = transmit_cmd(chip,&tpm_cmd, TPM_INTERNAL_RESULT_SIZE);
> 
> if (!rc)
> 	printk("attempting to determine the timeouts\n");

*baffled* Why did you think that would work? transmit_cmd()s signature
has 4 parameters.

--==_Exmh_1276573789_4860P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMFvhdcC3lWbTT17ARAoaDAJsFnmHjFcoQL0nTEuY8H8yGQYdpqQCglYgf
HqrVXnNW5QE2b8CWdDVStzE=
=d/C0
-----END PGP SIGNATURE-----

--==_Exmh_1276573789_4860P--
