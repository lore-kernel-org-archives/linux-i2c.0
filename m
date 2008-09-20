From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: SMBus of Sis650/961 P4 system not recognised
Date: Sat, 20 Sep 2008 13:43:29 +0200
Message-ID: <20080920134329.5e1b2198@hyperion.delvare>
References: <1221391781.31885.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1221391781.31885.22.camel@localhost>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi person-with-no-name,

On Sun, 14 Sep 2008 12:29:41 +0100, subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org wrote:
> Problem: sensors-detect, revision 5249, doesn't detect any sensors.
> 
> System:
> A928 ECS Desknote
> HW: P4, SiS 650/961 motherboard
> SW: Debian Etch 40R1, Linux 2.6.18-6, lm-sensors 3.0.2
> 
> Analysis, yet without solution:
> Under Windows XP (FanSpeed programme) a Winbond W83L784R and two LM75
> are detected and temperatures properly represented.
> Linux loads the i2c-sis96x busses driver.
> The chipset presents itself with vendor ID 1039 and devices IDs 0008 and
> 0650 and 6325 (and 5513, 7012, 0001, 7012 but irrelevant here).
> 
> FanSpeed (WinXP on dual-boot system) reports:
> SiS650	SMBus at $0B80
> 	ISA Bus at $0290
> 		SuperIO Winbond W83L517D
> SiSx30	SMBus at $0B80
> 		Winbond W83L784R (ID=$51) @ $2D
> 		LM75 @ $48
> 		LM75 @ $49	
> 
> How can I make lm-sensors / sensors-detect, and/or Linux 2.6.18-6 to
> discover this SMBus @ $0B80 with the sensors on it ??

There are two separate issues here, which you are apparently mixing.

* The SiS south bridge itself doesn't include any sensors. It implements
an SMBus master. You need to get this one to work first. You say that
Linus loads the i2c-sis96x driver, which may or may not mean that it
works (SiS chips are very odd to identify, as can be seen with FanSpeed
too.) So, first of all, please do:

modprobe i2c-dev
i2cdetect -l

And see if there's an SMBus listed for the SiS chip. If it is, you can
additionally run i2cdetect on it to see if devices connected to the bus
are seen.

* The sensor chip itself is, in your case, connected to the SMBus. You
need a separate driver for it. This is not the right list to discuss
this though, please use the lm-sensors list instead.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
