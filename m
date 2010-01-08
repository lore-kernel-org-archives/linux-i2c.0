From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 08 Jan 2010 15:06:06 +0100
Message-ID: <4B473BCE.8060803@scram.de>
References: <20100108020253.GJ3388@radix50.net> <4B471647.8050806@scram.de> <20100108121723.GD4004@radix50.net> <20100108135222.49d7b834@hyperion.delvare> <20100108140111.GF4004@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100108140111.GF4004-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Baurzhan,

>> One method not described in this document is listing the device in a
>> dts. It should probably be added, unfortunately I don't know enough
>> about this myself to do it. Any volunteer?
> 
> I would gladly contribute that as soon as I learn how to do that :) .

just add your ds2482 as child node to the i2c controller like this:


	I2C0: i2c@860 {
		compatible = "fsl,mpc823-i2c",
			     "fsl,cpm1-i2c";
		reg = <0x860 0x20 0x3c80 0x30>;
		interrupts = <16>;
		interrupt-parent = <&CPM_PIC>;
		fsl,cpm-command = <0x10>;
		bus-frequency = <100000>;

		w1@aa {
			reg = <0xaa>;
			compatible = "dallas,ds2482";
		};
	};


Of course you'll have to replace "aa" with the real i2c address of the device.

Thanks,
Jochen
