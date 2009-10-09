From: Krishna Kothapalli <krishna_sunitha-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Looking for ICH SMBUS "Process call" support in i2c-i801 bus
 driver
Date: Fri, 9 Oct 2009 19:54:11 -0400
Message-ID: <COL117-W52FEEADBC012C39EE0485188CB0@phx.gbl>
References: <COL117-W70326CE4BD5366E7F94C688CC0@phx.gbl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091009083519.2659a79a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


 <20091009083519.2659a79a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0


Hi Jean=2C


Thanks much for your response.=20

1) Thanks for correcting: ADM1066 as you mentioned does not require process=
 call.

2) From eeprom AT24C64 sheets: It support  Sequential Random Read. After th=
e micro controller receives a data word=2C it responds with an acknowledge.=
 As long as the EEPROM receives an acknowledge=2C it will continue to incre=
ment the data word address and serially clock out sequential data words... =
The sequential read operation is terminated when the micro controller does =
not respond with a zero but does generate a following stop condition".

The above seems to map to SMBUS Process Call Cycle with I2C_EN=3D1b.

Pls suggest.


Thanks=2C
Krishna



----------------------------------------
> Date: Fri=2C 9 Oct 2009 08:35:19 +0200
> From: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
> To: krishna_sunitha-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org
> CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: Looking for ICH SMBUS "Process call" support in i2c-i801 bus=
 driver
>
> Hi Krishna=2C
>
> On Thu=2C 8 Oct 2009 19:09:27 -0400=2C Krishna Kothapalli wrote:
>> I have a couple of devices EEDPROM and Power Sequencer(ADM1066) that nee=
d "Sequential Random Read" which has 2 byte address requirements.
>> Currently Process call is not implemented in code drivers/i2c/busses/i2c=
-i801.c.
>
> This is correct. Adding process call support to the i2c-i801 driver
> would be easy=2C I even think some developers have done it already but
> omitted to send the changes upstream.
>
> However=2C beware that SMBus process call is _not_ 2-byte addressing. It
> is single-byte addressing=2C followed by two bytes from master to slave=
=2C
> followed by two bytes from slave to master. Are you certain you need
> SMBus process call for the ADM1066? The datasheet doesn't mention it.
> All the SMBus transactions mentioned in the ADM1066 datasheet are
> already supported by the i2c-i801 driver.
>
>> Appreciate any suggestions for alternative implementations.
>
> Please make sure you know what your needs are=2C first.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
 		 	   		  =0A=
_________________________________________________________________=0A=
Hotmail: Powerful Free email with security by Microsoft.=0A=
http://clk.atdmt.com/GBL/go/171222986/direct/01/=
