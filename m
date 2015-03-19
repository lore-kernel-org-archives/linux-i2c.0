From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: driver for the Conexant Digicolor I2C
 controller
Date: Thu, 19 Mar 2015 12:00:02 +0100
Message-ID: <20150319110002.GD914@katana>
References: <844001df525b3073e50cbd95f357c0eb9912a394.1426758858.git.baruch@tkos.co.il>
 <866aada336ddbeec18749a1c301ab9b365baadde.1426758858.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <866aada336ddbeec18749a1c301ab9b365baadde.1426758858.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 11:54:18AM +0200, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> ---
> v2:
>    * Address the comment of Wolfram Sang:
>     - Advertise the I2C_FUNC_NOSTART capability
>     - Rebase on v4.0-rc1

Please fix:

Applying: i2c: driver for the Conexant Digicolor I2C controller
    CHECKPATCH
...

ERROR: code indent should use tabs where possible
#119: FILE: drivers/i2c/busses/i2c-digicolor.c:68:
+        STATE_IDLE,$

WARNING: please, no spaces at the start of a line
#119: FILE: drivers/i2c/busses/i2c-digicolor.c:68:
+        STATE_IDLE,$

ERROR: code indent should use tabs where possible
#120: FILE: drivers/i2c/busses/i2c-digicolor.c:69:
+        STATE_START,$

WARNING: please, no spaces at the start of a line
#120: FILE: drivers/i2c/busses/i2c-digicolor.c:69:
+        STATE_START,$

ERROR: code indent should use tabs where possible
#121: FILE: drivers/i2c/busses/i2c-digicolor.c:70:
+        STATE_ADDR,$

WARNING: please, no spaces at the start of a line
#121: FILE: drivers/i2c/busses/i2c-digicolor.c:70:
+        STATE_ADDR,$

ERROR: code indent should use tabs where possible
#122: FILE: drivers/i2c/busses/i2c-digicolor.c:71:
+        STATE_WRITE,$

WARNING: please, no spaces at the start of a line
#122: FILE: drivers/i2c/busses/i2c-digicolor.c:71:
+        STATE_WRITE,$

ERROR: code indent should use tabs where possible
#123: FILE: drivers/i2c/busses/i2c-digicolor.c:72:
+        STATE_READ,$

WARNING: please, no spaces at the start of a line
#123: FILE: drivers/i2c/busses/i2c-digicolor.c:72:
+        STATE_READ,$

ERROR: code indent should use tabs where possible
#124: FILE: drivers/i2c/busses/i2c-digicolor.c:73:
+        STATE_STOP,$

WARNING: please, no spaces at the start of a line
#124: FILE: drivers/i2c/busses/i2c-digicolor.c:73:
+        STATE_STOP,$

CHECK: spaces preferred around that '+' (ctx:VxV)
#160: FILE: drivers/i2c/busses/i2c-digicolor.c:109:
+	bool last = (i2c->msgbuf_ptr+1 == i2c->msg->len);
 	                            ^

WARNING: Missing a blank line after declarations
#161: FILE: drivers/i2c/busses/i2c-digicolor.c:110:
+	bool last = (i2c->msgbuf_ptr+1 == i2c->msg->len);
+	dc_i2c_cmd(i2c, last ? II_CMD_GET_NOACK : II_CMD_GET_ACK);

CHECK: Logical continuations should be on the previous line
#226: FILE: drivers/i2c/busses/i2c-digicolor.c:175:
+	if (cmd_status == II_CMD_STATUS_ACK_BAD
+	    || cmd_status == II_CMD_STATUS_ABORT) {

CHECK: spaces preferred around that '-' (ctx:VxV)
#329: FILE: drivers/i2c/busses/i2c-digicolor.c:278:
+	writeb_relaxed(clocktime-1, i2c->regs + II_CLOCKTIME);
 	                        ^

There are more checkpatch warnings I don't care about much.
You can decide about them.


--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCqwyAAoJEBQN5MwUoCm2gKQP/35P0OsokMIRwSP3qmIe16Ci
yEg2Lc5OHSMewXDb8zyJeXUstlQUc7zJT4eIwcvtkFeJdD+FOq7feIocZ9FxCwxe
TOI7+TCGIxA7D0MlQdiZQQsUJPiP2RQuk55g544AukFxb5ScT6MTsM6NKS8N8Frp
LJrr8NTasUt5tMlZnM0PknQFabVizXE95pyCv1yi8Gr71F5MvdvHtILLRsRs1DhI
ogUKNX/IUFBKgRSp/Oy+GMvqz4ce+ozcaZ/CIN2mmW41AtDS5SgHzGF3moa8Hlqg
B8O5lTtXsrh3v7vWFJz6I8M0RcJGYbHY5C2Rmt+mXMHgXVpcnmHBfXm0QtxhDpW2
XOp4+4XWpU7t6An3dGbmcSVKl5bNLHyWG7mFBTVzGpiSLp6wHnhLfk1Ikvr+Z1bu
KUPuSTHGd6onqRn5r3r4QIvHs1by+Oq7IvnQoK9hJKlpT4wUPY/i4YN5Hr/4Ycs+
2LcBazkQKrepwYJusnod8yA4d4nLIuUInQgRaXFQ2Sh5fh332ZOPYogOB5CsVkYF
HOyM850WYrifYqeZUU6Y+7+L8bstVPOQ/feRY6c7aL6r+6Zh0TXduxQBvrJv8o5I
zWvFze/AyAkZYkdPyf9rgg5PgwijCnwJXGGnrLYNCJWh5DyZYgPwHaUsJmnivKJ2
4EAYHkRDvcm1OnMox4ql
=R6K0
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
