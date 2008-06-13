From: "=?UTF-8?Q?Petr_Jake=C5=A1?=" <petr.jakes-VOAeGBCOg48@public.gmane.org>
Subject: Re: parport (i2c bus) maximum speed
Date: Sat, 14 Jun 2008 00:32:38 +0200
Message-ID: <c193ec310806131532o1e7a8bdasc4856aa09b90e9ae@mail.gmail.com>
References: <c193ec310806130644p22c1e466g9cd6e6711d4b691b@mail.gmail.com>
	<20080613160205.60b719c3@hyperion.delvare>
	<c193ec310806130855s2227f429pd151466a88539c90@mail.gmail.com>
	<20080613191707.13731136@hyperion.delvare>
	<c193ec310806131104wcbba767g602db89266492f31@mail.gmail.com>
	<20080613225624.11ad3ece@hyperion.delvare>
Reply-To: petr.jakes-VOAeGBCOg48@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5464950115044124295=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080613225624.11ad3ece-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

--===============5464950115044124295==
Content-Type: multipart/alternative;
	boundary="----=_Part_1901_5432697.1213396359613"

------=_Part_1901_5432697.1213396359613
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> I seriously doubt it. I have the SCH311x datasheet under the eyes and
> it doesn't even mention SMBus. Neither as a slave nor as a master.
> Unless you are using GPIO pins to implement a bit-banged I2C bus using
> a custom kernel driver...
>
> The dme1737 driver supports the hardware monitoring block of the
> SCH311x. This functionality is accessed over the LPC bus, not the SMBus.
>

Yes, you are right, I was writing my mail and I did not re-check our
installation and my memory did not work properly. Sorry for that mistake.
Now, after checking it I see we are using scx200_acb and i2c-dev modules for
the I2C communication (using i2cdetect, i2cdump, i2cget commands for the
basic recognition of devices on the bus and the py-smbus binding for the
main communication on the bus) and the dme1737 to read the voltage and
temperature from the SCH311x chip


> Today, lm-sensors is a library and a set of tools to let users monitor
> their hardware, i.e. watch the temperatures, voltages and fans. These
> monitoring devices can either be on the SMBus, or on the LPC bus. In
> the former case, an additional driver is needed, but that's an
> implementation detail. The I2C (SMBus) bus drivers are provided by the
> kernel, and so are the hwmon drivers. I would be tempted to say that
> the hwmon drivers no longer belong to "lm-sensors", but if you want to
> think of them as belonging to lm-sensors, why not.
>
> In the past, the lm-sensors package has included i2c bus drivers,
> because they were not yet merged in the kernel and we needed them. But
> that was years ago. Thinking of the i2c bus drivers as being part of
> lm-sensors today is no good, because then you forget that many hardware
> monitoring chips don't need I2C/SMBus at all, and that many I2C/SMBus
> devices are not hardware monitoring chips.
>
> The i2c mailing list and the i2c-tools SVN repository are hosted on
> lm-sensors.org for historical reasons only. They are completely
> independent from the lm-sensors project.


I feel terribly bad I did not study the details on the web before asking
"basic" questions and wasting your time... thanks for your patience...

>
> You are not using lm-sensors for that. You are using the kernel's i2c
> bus drivers. lm-sensors is for hardware monitoring only.


Anyway, if I understand it properly, there is not the way how the set up the
speed of the i2c bus.

Petr Jakes

------=_Part_1901_5432697.1213396359613
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I seriously doubt it. I have the SCH311x datasheet under the eyes and<br>

it doesn&#39;t even mention SMBus. Neither as a slave nor as a master.<br>
Unless you are using GPIO pins to implement a bit-banged I2C bus using<br>
a custom kernel driver...<br>
<br>
The dme1737 driver supports the hardware monitoring block of the<br>
SCH311x. This functionality is accessed over the LPC bus, not the SMBus.<br>
<div class="Ih2E3d"></div></blockquote><div><br>Yes, you are right, I was writing my mail and I did not re-check our installation and my memory did not work properly. Sorry for that mistake. Now, after checking it I see we are using scx200_acb and i2c-dev modules for the I2C communication (using i2cdetect, i2cdump, i2cget commands for the basic recognition of devices on the
bus and the py-smbus binding for the main communication on the bus) and the dme1737 to read the voltage and temperature from the SCH311x chip<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Today, lm-sensors is a library and a set of tools to let users monitor<br>
their hardware, i.e. watch the temperatures, voltages and fans. These<br>
monitoring devices can either be on the SMBus, or on the LPC bus. In<br>
the former case, an additional driver is needed, but that&#39;s an<br>
implementation detail. The I2C (SMBus) bus drivers are provided by the <br>
kernel, and so are the hwmon drivers. I would be tempted to say that<br>
the hwmon drivers no longer belong to &quot;lm-sensors&quot;, but if you want to<br>
think of them as belonging to lm-sensors, why not.<br>
<br>
In the past, the lm-sensors package has included i2c bus drivers,<br>
because they were not yet merged in the kernel and we needed them. But<br>
that was years ago. Thinking of the i2c bus drivers as being part of<br>
lm-sensors today is no good, because then you forget that many hardware<br>
monitoring chips don&#39;t need I2C/SMBus at all, and that many I2C/SMBus<br>
devices are not hardware monitoring chips.<br>
<br>
The i2c mailing list and the i2c-tools SVN repository are hosted on<br>
<a href="http://lm-sensors.org" target="_blank">lm-sensors.org</a> for historical reasons only. They are completely<br>
independent from the lm-sensors project.</blockquote><div><br>I feel terribly bad I did not study the details on the web before asking&nbsp; &quot;basic&quot; questions and wasting your time... thanks for your patience...<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
You are not using lm-sensors for that. You are using the kernel&#39;s i2c<br>
bus drivers. lm-sensors is for hardware monitoring only.</blockquote><div><br>Anyway, if I understand it properly, there is not the way how the set up the speed of the i2c bus.<br><br>Petr Jakes <br><br></div></div>

------=_Part_1901_5432697.1213396359613--


--===============5464950115044124295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5464950115044124295==--
