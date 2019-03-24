From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: enable buses to save their clock frequency
 in adapter
Date: Sun, 24 Mar 2019 23:09:13 +0100
Message-ID: <20190324220913.GB6934@kunai>
References: <20181210084111.6938-1-tudor.ambarus@microchip.com>
 <20181210084111.6938-2-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0748313467624848221=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181210084111.6938-2-tudor.ambarus@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tudor.Ambarus@microchip.com
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============0748313467624848221==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tudor,

thanks for your patience! Now that the at91 refactoring for the I2C
slave support is merged, we can keep going forward with your patches. As
I told you personally, I am positive in general about this change.

> +	u32 bus_freq_hz;

Why not unsigned int?

I also think we should have accessor functions for this new member. They
will be very simple currently because we don't really support changing
the bus frequency at runtime. However, I can see that it could be added
somewhen on top of this change, and then we need to extend the accessor
functions with some locking.

For now, I think this can be solved with simple policy: The value has to
be set before calling i2c_add_adapter(). Also, we should define that '0'
means 'value not set'.

So far about my thoughts. Any more comments from the list are welcome!

Thanks,

   Wolfram


--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyYAAkACgkQFA3kzBSg
KbYFdQ/8D0r9Q2iDBaKL+JQ7rhQYIU5+/eyYfJq3PbUdnUhA4IyPZonMtzUvUnib
HfkKZdmB/DCE0mUlS5dB2T5NGMObGqfaMEGydzVI9h+h0pCrrQ7LQVj8DOA2lKEV
g5WVuo/mT/P8bwYMei5Oo/bUe3pLUcl4/rOhySVl5Ns8+QKsPjNWMi+asmP5AdHY
w2FsfuWzxnb7Pp59BVUk8Fv4nIHSu6s+xTxMm832MEPhO0l/gybXl/RbGnm5fyLo
4jr0FtDm5vpH90CcW0TzV5zBgMWxSMHn1VQx8t7lEGDe9noUZvOr8ttGZ1XaSf/4
BzcGRKQsaN+EfjQOQ8hFfTxVYaIgdCv64OlEyAxi4Wk5P/KywMEUtihAPznjfaWz
IAGw2GorsaH/izQq+WLHqmJBkUmiKduevUTo4SkCcz/RFH+EHqZDkRXAW7DxOF2W
z7y1+YEPLr1D1R5B95mI2xeZ545u2lpW1PImjTJcSwiKNq4maTTNOMOk1hB/nMfJ
Mu2WOrRmQosouuryU3Ma/1sNh5kJMAdd3nvKj2szVRAQM8kokXXswbih7q/LvWnv
/u9nwFiHUDibsB9mJeew42iHGqRRqV+sP/cQEOtWLqW2gM5k/0kiqbLobYmyX/2N
6o6DWMitZM5FYZjKYor+86fDEzRhrJ0VBBKNWORVeq1omSNS6go=
=MkdM
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--


--===============0748313467624848221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0748313467624848221==--
