From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: virtual i2c adapter support
Date: Mon, 27 Oct 2008 09:20:25 +0100
Message-ID: <20081027082025.GC11339@tekkaman>
References: <4904E6F3.50609@embedded-sol.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3081598306543837060=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4904E6F3.50609-L1vi/lXTdtvUXIAPrk8Z/A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Felix Radensky <felix-L1vi/lXTdtvUXIAPrk8Z/A@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============3081598306543837060==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2008 at 11:53:55PM +0200, Felix Radensky wrote:
> Hi, Rodolfo
>
> I've tried your patches with linux-2.6.27 kernel running
> on custom board with 460EX PowerPC. This board has
> two i2c buses and pca9548 switch on bus 0.

Please, consider thay my patch has been *not* accepted into main line
due a mutex problem... :'(

> My question is: how can I register board i2c devices behind
> the mux in board init code, and make them properly identified
> when relevant drivers are loaded.

I have just defined the i2c devices behind the mux as connected to the
new virtual adapters:

static int wr1100_adap_ids[] =3D {
        2, 3,
};

static struct pca954x_platform_data wr1100_i2cmux_adap_ids =3D {
        .adap_ids       =3D wr1100_adap_ids,
        .len            =3D ARRAY_SIZE(wr1100_adap_ids),
};

static struct i2c_board_info __initdata wr1100_i2c_devices[] =3D {
        {
                I2C_BOARD_INFO("pca9540", 0x70),
                .platform_data =3D &wr1100_i2cmux_adap_ids,
        },
};

static struct i2c_board_info __initdata wr1100_i2c_mux_devices[] =3D {
        {
                I2C_BOARD_INFO("bq27200", 0x55),
        },
};

Then into machine startup code:

        i2c_register_board_info(0, wr1100_i2c_devices,
                                        ARRAY_SIZE(wr1100_i2c_devices));
        i2c_register_board_info(2, wr1100_i2c_mux_devices,
                                        ARRAY_SIZE(wr1100_i2c_mux_devices));
        i2c_register_board_info(3, wr1100_i2c_mux_devices,
                                        ARRAY_SIZE(wr1100_i2c_mux_devices));

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJBXnJQaTCYNJaVjMRAkKqAJ9UF7PcH22nmqVJe4Ff+ANGyjTAQgCfT3XC
n4r6vNe96CKa5eXKYTtJ4yk=
=UKYe
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--


--===============3081598306543837060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3081598306543837060==--
