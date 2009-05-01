From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: OF support for tsc2007
Date: Fri, 1 May 2009 11:43:39 -0400
Message-ID: <9e4733910905010843u13c03eb5q9daef91842c1f08a@mail.gmail.com>
References: <49FB0FAE.3080609@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49FB0FAE.3080609-kIKI1E8EpGZWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gary Thomas <gary-kIKI1E8EpGZWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, May 1, 2009 at 11:05 AM, Gary Thomas <gary-kIKI1E8EpGZWk0Htik3J/w@public.gmane.org> wrote:
> I'm trying to use the TSC2007 (actually TSC2003) on a PowerPC
> based platform. =A0Sadly, the current driver (as of .30-rc4)
> does not seem to be OF aware.
>
> Jon Smirl on the PPC list suggested I ask here.

I thought you said it was an old-style driver that hadn't been
converted to new style?

i2c drivers don't need to be OF aware.  The code in
drivers/of/of_i2c.c set things up for you.
You need a driver tree entry like this:

		i2c@3d40 {
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
			cell-index =3D <1>;
			reg =3D <0x3d40 0x40>;
			interrupts =3D <0x2 0x10 0x0>;
			interrupt-parent =3D <&mpc5200_pic>;
			fsl5200-clocking;

			rtc@51 {
				device_type =3D "rtc";
				compatible =3D "epson,rtc8564";
				reg =3D <0x51>;
			};
			eeprom@52 {
				compatible =3D "atmel,24c32", "eeprom";
				reg =3D <0x52>;
			};
		};




>
> Any help or ideas?
>
> n.b. at the moment, I'm not subscribed to this list, so please
> CC me on any replies.
>
> Thanks
>
> --
> ------------------------------------------------------------
> Gary Thomas =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0Consulting for the
> MLB Associates =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0Embedded world
> ------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
