From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: add board_info to pdata
Date: Wed, 22 Apr 2015 11:42:05 +0300
Message-ID: <55375EDD.6050405@codethink.co.uk>
References: <1426594495-31844-1-git-send-email-ben.dooks@codethink.co.uk> <20150327154831.GE27238@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150327154831.GE27238@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 27/03/15 17:48, Wolfram Sang wrote:
> On Tue, Mar 17, 2015 at 12:14:55PM +0000, Ben Dooks wrote:
>> Add board_info so that the i2c-gpio driver can probe devices on
>> probe so that i2c_register_board_info() does not need to be used.
>> This is preferable for devices that get hotplugged as otherwise
>> we need to do i2c_unregister_board_info() which would be more
>> code.
>> 
>> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> 
> Why can't you use static bus numbers? Or instantiating from
> userspace?

the static bus numbers where a pain on a system with dynamically
added i2c busses such as the i2c-mux instatiations.


- -- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN17dAAoJEMuhVOkVU3uz/GoIANcu1JAbx0OEDzyhXCLkkS/3
60E/S6n6bitIRBWtxLGbCeKcPGzavSPHUQHxF/9C9m1Ekr4HIkihsTdmTwnOYgh6
HzBbxlx0nJCGE8gBvKeCZ9UVosazPSMELsU/+MlkZh9waTIQ7bTF84USj5LPr0Y6
XuOt1XOtrTNiJGLyoN2SHVfDdwWd2SKfN3zlRGZMaC6OJ5g3zzaelE0UA7jj+2/N
e6vMnDCfcD/99lGnzKVqNEN3zhGy0zRjgft4deLCY6in6bKIUi+NFw2Nky/aUJWT
yKjf3ltvmj/5SbL+AF3l6ONv+NvVBLEHJlDgxLzKmbKFp7EoclhpP1RiL919Ej8=
=7Geh
-----END PGP SIGNATURE-----
