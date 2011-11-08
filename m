From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 08 Nov 2011 16:15:10 +0100
Message-ID: <4EB9477E.8070002@atmel.com>
References: <cover.1320753142.git.n.voss@weinmann.de> <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de> <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111108144115.GH20728-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/08/2011 03:41 PM, Felipe Balbi :

>> +	if (cpu_is_at91rm9200()) {			/* AT91RM9200 Errata #22 */
> 
> I don't think you should be using cpu_is_* on drivers.

It is a common pattern in at91 drivers and has worked for ages.
Do you think it is related to the need to be able to compile the
driver for any SoC in the case of multi-SoC zImage support?

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOuUd1AAoJEAf03oE53VmQs9UH/i+pKZlIN7lNb+sHvqHJhiUK
zqvPObtSo2Y78dODM4Qf/WrJP/jBW4FUAx60kBlEBzWAD2aef1D078POAOVhcVdH
Gj76Z+O5tF9H9YPcn/9HGyA42kL3NZu43ibywsvbUmX1O2LbtmX49bGOjArYSyXQ
sN4F8+QJnkMQfmMNjYgG0WfhMyWnp15W4QWq+frk2Kq0nXjiuozqr9goq8/LVRZc
aSToJUUJqsfk/bEGBAF6RmNxRIu2AMNpKQZS9a1gOZA/mAfSZrT9zQE6EZVXJDVr
VVck4KlhHBR3JU6AEh0CtoRgfZxsZyzS2RNUDyF7dq+8VsNiNpajSL8S2ILanZc=
=iqlm
-----END PGP SIGNATURE-----
