From: "subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org" <subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org>
Subject: SMBus of Sis650/961 P4 system not recognised
Date: Sun, 14 Sep 2008 12:29:41 +0100
Message-ID: <1221391781.31885.22.camel@localhost>
Reply-To: subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Problem: sensors-detect, revision 5249, doesn't detect any sensors.

System:
A928 ECS Desknote
HW: P4, SiS 650/961 motherboard
SW: Debian Etch 40R1, Linux 2.6.18-6, lm-sensors 3.0.2

Analysis, yet without solution:
Under Windows XP (FanSpeed programme) a Winbond W83L784R and two LM75
are detected and temperatures properly represented.
Linux loads the i2c-sis96x busses driver.
The chipset presents itself with vendor ID 1039 and devices IDs 0008 and
0650 and 6325 (and 5513, 7012, 0001, 7012 but irrelevant here).

FanSpeed (WinXP on dual-boot system) reports:
SiS650	SMBus at $0B80
	ISA Bus at $0290
		SuperIO Winbond W83L517D
SiSx30	SMBus at $0B80
		Winbond W83L784R (ID=$51) @ $2D
		LM75 @ $48
		LM75 @ $49	

How can I make lm-sensors / sensors-detect, and/or Linux 2.6.18-6 to
discover this SMBus @ $0B80 with the sensors on it ??


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
