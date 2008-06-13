From: "=?UTF-8?Q?Petr_Jake=C5=A1?=" <petr.jakes-VOAeGBCOg48@public.gmane.org>
Subject: Re: parport (i2c bus) maximum speed
Date: Fri, 13 Jun 2008 20:04:02 +0200
Message-ID: <c193ec310806131104wcbba767g602db89266492f31@mail.gmail.com>
References: <c193ec310806130644p22c1e466g9cd6e6711d4b691b@mail.gmail.com>
	<20080613160205.60b719c3@hyperion.delvare>
	<c193ec310806130855s2227f429pd151466a88539c90@mail.gmail.com>
	<20080613191707.13731136@hyperion.delvare>
Reply-To: petr.jakes-VOAeGBCOg48@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8266414946145940995=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080613191707.13731136-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============8266414946145940995==
Content-Type: multipart/alternative;
	boundary="----=_Part_28520_3048641.1213380242360"

------=_Part_28520_3048641.1213380242360
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > Now we do SMBus communication through dme1737 (we have compatilbe chip on
> > the motherboard). I guess it is not possible to change the bus speed
> because
> > the master (DME1737) is generating the clock frequency of the SMBus.
>
> I don't think the DME1737 can act as an SMBus master, or can it? As far
> as I know the DME1737 is an SMBus slave and multiplexer, but not a
> master. If I am correct then what matters is the actual SMBus master on
> the motherboard.

Maybe I was not specific enough. Actually there is an SCH3114 chip on our
motherboard (http://www.smsc.com/main/catalog/sch311x.html ) and lm-sensors
need dme1737 module for this chip.
This chip acts as a SMBus master.

>
> > Just for your information we have PIC 16F887 connected to the bus as a
> slave
> > (which was really pain and a lot of SW hacking on the PIC side - it looks
> > like Microchip I2C HW/SW implementation does not work properly
> "sometimes").
> >
> > The good thing is we have slaves connected directly to the system SMBus
> and
> > we are doing MISSIVE communication on the bus (motors control, keyboard,
> LCD
> > display, I/O) and we have not observed any single problem (we are using
> > py-smbus binding for the communication).
> >
> > Are there some other ways (HW interfaces etc.) to get lm-sensors work on
> the
> > higher speed?
>
> I'm confused now. How is I2C/SMBus speed related to lm-sensors at all?


I am confused as well :-)
My feeling was lm-sensors are here to:

   1. enable SMBus/I2C communication (mainly using HW masters presented on
   the motherboards)  to communicate with SMBus slaves (mainly presented on the
   PC motherboards, ie clock, temperature, fans ....).
   2. enable SMBus/I2C communication with some other chips which one can
   connect to the bus

Because of above mentioned we have done some development and we are able,
using lm-sensors, to communicate with PIC microcontrolers (they are acting
as I2C slaves) on the VIA and Unicorn motherboards. From our test it looks
like we are communicating close to the 100kbps.

I was just wondering if it is possible to set the lm-sensors to communicate
faser, so I posted my question to this discussion group.


> Most SMBus controllers on PC motherboards run at low speeds (from 10 to
> 64 kbps), mainly because there's no need for speed when you only have a
> hardware monitoring chip and a couple SPD EEPROMs on the bus. So If you
> want high-speed you'll have to use an additional controller, but I
> don't know of any (except for parallel port or USB do-it-yourself
> adapters, but that's not much faster.)


OK, thanks for this info

Petr Jakes

------=_Part_28520_3048641.1213380242360
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">&gt; Now we do SMBus communication through dme1737 (we have compatilbe chip on<br>

&gt; the motherboard). I guess it is not possible to change the bus speed because<br>
&gt; the master (DME1737) is generating the clock frequency of the SMBus.<br>
<br>
</div>I don&#39;t think the DME1737 can act as an SMBus master, or can it? As far<br>
as I know the DME1737 is an SMBus slave and multiplexer, but not a<br>
master. If I am correct then what matters is the actual SMBus master on<br>
the motherboard.</blockquote><div>Maybe I was not specific enough. Actually there is an SCH3114 chip on our motherboard (<a href="http://www.smsc.com/main/catalog/sch311x.html">http://www.smsc.com/main/catalog/sch311x.html</a> ) and lm-sensors need dme1737 module for this chip.<br>
This chip acts as a SMBus master.<br> 
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d"><br>
&gt; Just for your information we have PIC 16F887 connected to the bus as a slave<br>
&gt; (which was really pain and a lot of SW hacking on the PIC side - it looks<br>
&gt; like Microchip I2C HW/SW implementation does not work properly &quot;sometimes&quot;).<br>
&gt;<br>
&gt; The good thing is we have slaves connected directly to the system SMBus and<br>
&gt; we are doing MISSIVE communication on the bus (motors control, keyboard, LCD<br>
&gt; display, I/O) and we have not observed any single problem (we are using<br>
&gt; py-smbus binding for the communication).<br>
&gt;<br>
&gt; Are there some other ways (HW interfaces etc.) to get lm-sensors work on the<br>
&gt; higher speed?<br>
<br>
</div>I&#39;m confused now. How is I2C/SMBus speed related to lm-sensors at all?</blockquote><div><br>I am confused as well :-) <br>My feeling was lm-sensors are here to:<br><ol><li>enable SMBus/I2C communication (mainly using HW masters presented on the motherboards)&nbsp; to communicate with SMBus slaves (mainly presented on the PC motherboards, ie clock, temperature, fans ....).&nbsp;&nbsp; </li>
<li>enable SMBus/I2C communication with some other chips which one can connect to the bus</li></ol>Because of above mentioned we have done some development and we are able, using lm-sensors, to communicate with PIC microcontrolers (they are acting as I2C slaves) on the VIA and Unicorn motherboards. From our test it looks like we are communicating close to the 100kbps. <br>
<br>I was just wondering if it is possible to set the lm-sensors to communicate faser, so I posted my question to this discussion group.<br></div><div>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Most SMBus controllers on PC motherboards run at low speeds (from 10 to<br>
64 kbps), mainly because there&#39;s no need for speed when you only have a<br>
hardware monitoring chip and a couple SPD EEPROMs on the bus. So If you<br>
want high-speed you&#39;ll have to use an additional controller, but I<br>
don&#39;t know of any (except for parallel port or USB do-it-yourself<br>
adapters, but that&#39;s not much faster.)</blockquote><div>&nbsp;</div><div>OK, thanks for this info<br><br>Petr Jakes<br> </div></div><br>

------=_Part_28520_3048641.1213380242360--


--===============8266414946145940995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8266414946145940995==--
