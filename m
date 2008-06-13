From: "=?UTF-8?Q?Petr_Jake=C5=A1?=" <petr.jakes-VOAeGBCOg48@public.gmane.org>
Subject: Re: parport (i2c bus) maximum speed
Date: Fri, 13 Jun 2008 17:55:22 +0200
Message-ID: <c193ec310806130855s2227f429pd151466a88539c90@mail.gmail.com>
References: <c193ec310806130644p22c1e466g9cd6e6711d4b691b@mail.gmail.com>
	<20080613160205.60b719c3@hyperion.delvare>
Reply-To: petr.jakes-VOAeGBCOg48@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3928035163561549115=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080613160205.60b719c3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

--===============3928035163561549115==
Content-Type: multipart/alternative;
	boundary="----=_Part_205_1505551.1213372522505"

------=_Part_205_1505551.1213372522505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jean, thanks for prompt reply

>
> Our current i2c-algo-bit implementation can't go faster than 250 kbps
> by design. I think I remember trying it and it was working fine. But if
> memory serves the actual speed ended up being significantly less than
> 250 kpbs, maybe 160 kbps. Just like you don't actually get 100 kbps
> when you ask for 100 kbps. I guess that there's latency in switching
> the parport pins, which becomes visible as the speed increases.
>
> If you plan on doing fast I2C over parport, then I think you want to
> give up on bit-banging and instead control an I2C master beyond the
> parallel port. That way you take benefit of the parallel aspect of
> parport and you should be able to reach 400 kbps. Using a chip we
> already have abstracted support for (PCF8584 or PCA9564) this shouldn't
> be too difficult.


Now we do SMBus communication through dme1737 (we have compatilbe chip on
the motherboard). I guess it is not possible to change the bus speed because
the master (DME1737) is generating the clock frequency of the SMBus.

Just for your information we have PIC 16F887 connected to the bus as a slave
(which was really pain and a lot of SW hacking on the PIC side - it looks
like Microchip I2C HW/SW implementation does not work properly "sometimes").

The good thing is we have slaves connected directly to the system SMBus and
we are doing MISSIVE communication on the bus (motors control, keyboard, LCD
display, I/O) and we have not observed any single problem (we are using
py-smbus binding for the communication).

Are there some other ways (HW interfaces etc.) to get lm-sensors work on the
higher speed?

Regards
Petr

------=_Part_205_1505551.1213372522505
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><div>Jean, thanks for prompt reply<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div>
<br>
</div></div>Our current i2c-algo-bit implementation can&#39;t go faster than 250 kbps<br>
by design. I think I remember trying it and it was working fine. But if<br>
memory serves the actual speed ended up being significantly less than<br>
250 kpbs, maybe 160 kbps. Just like you don&#39;t actually get 100 kbps<br>
when you ask for 100 kbps. I guess that there&#39;s latency in switching<br>
the parport pins, which becomes visible as the speed increases.<br>
<br>
If you plan on doing fast I2C over parport, then I think you want to<br>
give up on bit-banging and instead control an I2C master beyond the<br>
parallel port. That way you take benefit of the parallel aspect of<br>
parport and you should be able to reach 400 kbps. Using a chip we<br>
already have abstracted support for (PCF8584 or PCA9564) this shouldn&#39;t<br>
be too difficult.</blockquote></div><br><span style="color: rgb(0, 0, 0);">Now w<font color="#0000ff"><font color="#000000"><font size="2"><font face="Arial">e do </font></font></font></font></span><span><font color="#0000ff" face="Arial" size="2"><span style="color: rgb(0, 0, 0);">SMBus communication</span></font></span><span style="color: rgb(0, 0, 0);"><font color="#0000ff"><font size="2"><font face="Arial"> <span style="color: rgb(0, 0, 0);">through </span></font></font></font></span><span><font color="#0000ff" face="Arial" size="2"><span style="color: rgb(0, 0, 0);">dme1737 (we have compatilbe chip on the motherboard). I guess it is not possible to change the bus speed because the master (DME1737) is generating the clock frequency of the SMBus.<br>
<br>Just for your information we have PIC </span></font></span>16F887 <span><font color="#0000ff" face="Arial" size="2"><span style="color: rgb(0, 0, 0);">connected </span></font></span>to the bus as a slave (which was really pain and a lot of SW hacking on the PIC side - it looks like Microchip I2C HW/SW implementation does not work properly &quot;sometimes&quot;).<br>
<br>The good thing is we have slaves <span><font color="#0000ff" face="Arial" size="2"><span style="color: rgb(0, 0, 0);"> connected directly to the system SMBus and we are doing MISSIVE communication on the bus (motors control, keyboard, LCD display, I/O) and we have not observed any single </span></font></span><span><font color="#0000ff" face="Arial" size="2"><span style="color: rgb(0, 0, 0);"></span></font></span><span><font color="#0000ff" face="Arial" size="2"><span style="color: rgb(0, 0, 0);">problem (we are using py-smbus binding for the communication).</span></font></span><br>
<br>Are there some other ways (HW interfaces etc.) to get lm-sensors work on the higher speed?<br><br>Regards<br>Petr<br>

------=_Part_205_1505551.1213372522505--


--===============3928035163561549115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3928035163561549115==--
