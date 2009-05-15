From: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Fri, 15 May 2009 12:18:39 +0200
Message-ID: <d2b9ea600905150318s69b86b5ct3816b274bf343a79@mail.gmail.com>
References: <4A0BD1DB.4090305@doredevelopment.dk>
	 <20090514083453.GB3043@pengutronix.de>
	 <4A0BDAD6.5020005@doredevelopment.dk>
	 <OF9EE5E055.DDB954D2-ONC12575B6.003636EC-C12575B6.0036CB06@transmode.se>
	 <d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com>
	 <OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

Your patch (and the small addition to mpc_i2c_start) does not work for =
me.

[   35.765803] mpc_xfer()
[   35.785480] writeccr 0
[   35.785505] writeccr 80
[   35.785523] mpc_xfer: 1 bytes to 2c:W - 1 of 2 messages
[   35.798817] mpc_write addr=3D2c len=3D1 restart=3D0
[   35.815327] writeccr f0
[   35.815503] I2C: SR=3Da2
[   35.818675] I2C: SR=3Da6
[   35.821450] mpc_xfer: 1 bytes to 2c:R - 2 of 2 messages
[   35.827119] mpc_read addr=3D2c len=3D1 restart=3D1
[   35.837463] writeccr f4
[   35.837641] I2C: SR=3Da6
[   35.840011] writeccr e8
[   35.840133] I2C: SR=3Da3
[   35.843596] writeccr 80
[   35.843632] mpc_xfer()
[   35.855068] writeccr 0
[   35.855093] writeccr 80
[   35.855111] mpc_xfer: 1 bytes to 2c:W - 1 of 2 messages
[   35.865346] mpc_write addr=3D2c len=3D1 restart=3D0
[   35.870109] writeccr f0
[   35.870272] I2C: SR=3Da2
[   35.873372] I2C: SR=3Da6
[   35.875757] mpc_xfer: 1 bytes to 2c:R - 2 of 2 messages
[   35.881606] mpc_read addr=3D2c len=3D1 restart=3D1
[   35.886290] writeccr f4
[   35.886463] I2C: SR=3Da6
[   35.889425] writeccr e8
[   35.889575] I2C: SR=3Da7
[   35.891944] writeccr 80
[   35.961177] mpc_xfer()
[   35.972517] writeccr 0
[   35.972541] writeccr 80
[   35.972559] mpc_xfer: 1 bytes to 4e:W - 1 of 20 messages
[   35.982628] mpc_write addr=3D4e len=3D1 restart=3D0
[   35.987389] writeccr f0
[   35.987424] I2C: SR=3Db3
[   35.990386] I2C: MAL
[   35.992971] i2c_wait(address) error: -5
[   35.997215] writeccr 80
[   35.997241] Error: i2c_transfer failed: -5

I have now spent a few hours trying a lot of different paths to fix
this approach, but I simply cannot find a way to get i2c read to work
without a trailing STOP condition with this controller.

Is there a problem in applying my patch, as it should be "clean"
improvement over the current implementation, which uses STOP
condition, but does not work.

Until Isomeone finds a way to get it to work without STOP, we will
have a working driver, which I assume is what we want.

Best regards,
Esben Haabendal

--=20
Esben Haabendal, Senior Software Consultant
Dor=E9Development ApS, Ved Stranden 1, 9560 Hadsund, DK-Denmark
Phone: +45 51 92 53 93, E-mail: eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org
WWW: http://www.doredevelopment.dk
